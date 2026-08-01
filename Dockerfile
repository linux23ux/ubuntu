FROM --platform=linux/amd64 accetto/ubuntu-vnc-xfce-g3:24.04

# Ép Render chạy container dưới quyền root để tránh lỗi sinh user động
USER root

# Định nghĩa các biến môi trường cấu hình cổng và mật khẩu
ENV VNC_PORT=6901
ENV NO_VNC_PORT=6901
ENV VNC_PW=my_secure_password_2026

# Mở cổng noVNC mặc định của image
EXPOSE 6901

# Chạy lệnh khởi động trực tiếp bằng quyền root
CMD ["/dockerstartup/vnc_startup.sh", "--wait"]
