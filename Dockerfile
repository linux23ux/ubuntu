FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root

# 1. Cập nhật hệ thống và cài đặt tất cả các công cụ bạn yêu cầu cùng môi trường đồ họa
RUN apt update && \
    apt install -y \
    xfce4 \
    xfce4-goodies \
    tigervnc-standalone-server \
    websockify \
    novnc \
    dbus-x11 \
    python3 \
    git \
    sudo \
    curl \
    wget \
    nano \
    onboard \
    software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Cấu hình trang mặc định cho noVNC
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# 3. Khai báo cổng 10000 theo quy định bắt buộc của Render
EXPOSE 10000

# 4. Dọn dẹp bộ nhớ đệm hiển thị cũ, kích hoạt giao diện đồ họa và giữ luồng bằng websockify
CMD ["/bin/bash", "-c", "rm -rf /tmp/.X11-unix/X1 /tmp/.X*-lock && vncserver -SecurityTypes None -xstartup /usr/bin/startxfce4 :1 && websockify --web=/usr/share/novnc/ 10000 localhost:5901"]
