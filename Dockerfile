FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Mở cổng 80 (Cổng mặc định bên trong Image này để chạy noVNC web)
EXPOSE 80

# Thiết lập biến môi trường (Tùy chọn: chỉnh độ phân giải màn hình)

# Khởi chạy hệ thống
CMD ["/startup.sh"]
