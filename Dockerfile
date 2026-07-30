FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Cập nhật hệ thống, cài đặt các công cụ cơ bản và thêm kho PPA Firefox chính thức
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    gnupg \
    && add-apt-repository -y ppa:mozillateam/ppa \
    && apt-get update

# 2. SỬA LỖI: Cú pháp chuẩn để ghi cấu hình ưu tiên PPA Firefox (Xuống dòng thật)
RUN printf 'Package: firefox*\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n' > /etc/apt/preferences.d/mozilla-firefox

# 3. SỬA LỖI: Thêm dbus, xvfb và các thư viện cốt lõi bắt buộc để Firefox Headless có thể chạy ẩn ổn định
RUN apt-get install -y \
    firefox \
    python3 \
    dbus-x11 \
    xvfb \
    libegl1 \
    libgl1-mesa-glx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 4. Khai báo cổng 8080 theo yêu cầu mạng của Render/Railway
EXPOSE 10000

# 5. SỬA LỖI TIẾN TRÌNH: Đưa Web Server Python ra làm tiến trình chính (Foreground) đón traffic ở cuối cùng.
# Đẩy vòng lặp ép Firefox Headless ping link Replit chạy ngầm ở phía trước.
# LƯU Ý: Hãy thay thế cụm từ 'link_replit_cua_ban_o_day' bằng URL Replit thật của bạn (giữ nguyên cặp dấu nháy đơn).
CMD ["/bin/bash", "-c", "while true; do echo '=== Firefox is pinging Replit ==='; firefox --headless --reply 'https://9123e3c9-127a-40ad-86e9-2dc8fc49a69e-00-3bttcjsbnxxwl.pike.replit.dev/?autoconnect=true' > /dev/null 2>&1; sleep 300; done & python3 -m http.server 10000"]
