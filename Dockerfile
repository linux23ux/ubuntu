# Sử dụng phiên bản Ubuntu chính thức làm nền tảng
FROM --platform=linux/amd64 ubuntu:22.04

# Thiết lập môi trường không tương tác (tránh bị dừng khi cài đặt gói)
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật hệ thống và cài đặt môi trường máy tính để bàn Xfce (Xubuntu) cùng các công cụ bổ trợ
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    git \
    python3 \
    python3-pip \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/lists/*

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Cấu hình môi trường và độ phân giải màn hình ảo
ENV DISPLAY=:1

# Render cấp cổng dịch vụ động qua biến môi trường PORT (mặc định chọn 10000 nếu không có)
ENV PORT=10000
EXPOSE 10000

# Khởi chạy Xvfb, Xfce4, x11vnc và định tuyến qua noVNC
CMD Xvfb :1 -screen 0 $RESOLUTION & \
    sleep 2 && \
    xfce4-session & \
    x11vnc -display :1 -nopw -listen localhost -forever -shared & \
    websockify --web=/usr/share/novnc 10000 localhost:5901
