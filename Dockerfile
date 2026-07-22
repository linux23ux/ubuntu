FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root

# Cài đặt môi trường đồ họa GNOME (bản rút gọn để tối ưu dung lượng), VNC và noVNC
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ubuntu-desktop-minimal \
    gnome-shell \
    gnome-session \
    gnome-terminal \
    tigervnc-standalone-server \
    websockify \
    novnc \
    dbus-x11 \
    python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Cấu hình file mặc định cho noVNC
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# BẮT BUỘC: Khai báo cổng để hệ thống Deployments nhận diện mạng
EXPOSE 6080

# Chạy chuỗi lệnh khởi tạo cơ chế D-Bus, xóa lock cũ, kích hoạt VNC với GNOME và Websockify
CMD ["/bin/bash", "-c", "\
    rm -rf /tmp/.X11-unix/X1 /tmp/.X*-lock && \
    export $(dbus-launch) && \
    vncserver -SecurityTypes None -xstartup /usr/bin/gnome-session :1 && \
    sleep 3 && \
    websockify --web=/usr/share/novnc/ 6080 0.0.0.0:5901 \
"]
