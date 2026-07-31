FROM accetto/ubuntu-vnc-xfce-g3:latest

# Mở cổng 6901 (Cổng chạy giao diện web noVNC mặc định của image này)
EXPOSE 6901

# Đặt mật khẩu truy cập bắt buộc để bảo mật
ENV VNC_PW=36356
