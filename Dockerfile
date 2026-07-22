FROM ubuntu:latest

ENV USER=root

# 1. Cài đặt môi trường đồ họa GNOME (Ubuntu), VNC Server, noVNC và các công cụ bổ trợ
# Đưa DEBIAN_FRONTEND vào trước lệnh chạy để không lưu biến môi trường Debian vào Container sau khi build
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    ubuntu-desktop-minimal \
    gnome-shell \
    gnome-session \
    gnome-terminal \
    dbus-x11 \
    x11-xserver-utils \
    tigervnc-standalone-server \
    novnc \
    websockify \
    python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo liên kết cho trang chủ noVNC
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# 2. Tạo file cấu hình xstartup tùy chỉnh cho GNOME (Sửa lỗi crash và ép chạy đồ họa 2D)
RUN mkdir -p /root/.vnc && \
    echo '#!/bin/sh\n\
test x"$SHELL" = x"" && SHELL=/bin/bash\n\
test x"$1" = x"" && set -- default\n\
\n\
# Sửa lỗi sập kết nối bằng cách xóa biến môi trường cũ\n\
unset SESSION_MANAGER\n\
unset DBUS_SESSION_BUS_ADDRESS\n\
unset XDG_RUNTIME_DIR\n\
\n\
# Ép GNOME chạy ở chế độ đồ họa X11 2D trong Container\n\
export XDG_SESSION_TYPE=x11\n\
export GNOME_SHELL_SESSION_MODE=ubuntu\n\
export XDG_CURRENT_DESKTOP="GNOME"\n\
\n\
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources\n\
vncconfig -iconic &\n\
\n\
# Khởi chạy phiên làm việc GNOME bằng DBUS độc lập\n\
dbus-launch --exit-with-session gnome-session --session=ubuntu &' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

# Khai báo cổng noVNC để hệ thống Deployments nhận diện mạng
EXPOSE 6080

# 3. Chạy chuỗi lệnh dọn dẹp, kích hoạt VNC (sử dụng file xstartup vừa tạo) và Websockify
CMD ["/bin/bash", "-c", "rm -rf /tmp/.X11-unix/X1 /tmp/.X*-lock && vncserver -SecurityTypes None :1 && sleep 3 && websockify --web=/usr/share/novnc/ 6080 0.0.0.0:5901"]
