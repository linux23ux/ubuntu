FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Cập nhật hệ thống, cài đặt các công cụ cơ bản và thêm kho PPA Firefox chính thức
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    gnupg \
    && add-apt-repository -y ppa:mozillateam/ppa \
    && apt-get update

# 2. Thiết lập độ ưu tiên cấu hình để ép hệ thống cài Firefox từ PPA thay vì bản Snap
RUN echo 'Package: firefox*\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001' > /etc/apt/preferences.d/mozilla-firefox

# 3. Cài đặt các thư viện hệ thống, Python3 và trình duyệt Firefox (Tuyệt đối không cài XFCE/VNC)
RUN apt-get install -y \
    firefox \
    python3 \
    libvpx7 \
    libevent-2.1-7 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 4. Khai báo cổng 8080 bắt buộc để đáp ứng điều kiện mạng của Railway
EXPOSE 8080

# 5. CHẠY ẨN 24/7: Bật web server mồi trên cổng 8080 bằng Python,
# kết hợp vòng lặp vô hạn ép Firefox headless ping link Replit của bạn cứ sau mỗi 5 phút (300 giây)
CMD ["/bin/bash", "-c", "python3 -m http.server 8080 & while true; do echo '=== Firefox is pinging Replit ==='; firefox --headless --no-sandbox --disable-gpu 'https://fba5992e-d6a9-4bb8-b1e4-a0d8865189f3-00-1oppfn5x3k01l.pike.replit.dev/?autoconnect=true'; sleep 300; done"]
