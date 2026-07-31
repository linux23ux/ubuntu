FROM accetto/ubuntu-vnc-xfce-g3:latest

USER root

# Cài đặt thêm các công cụ nếu cần
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER 1001

# Đặt mật khẩu truy cập (Thay đổi theo ý bạn)
ENV VNC_PW=render_password

# MẸO CHO RENDER: Ép noVNC chạy trên cổng do Render cấp phát
CMD ["/bin/bash", "-c", "/dockerstartup/vnc_startup.sh --vnc-port 5901 --novnc-port $PORT"]
