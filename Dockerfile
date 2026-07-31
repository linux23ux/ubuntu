# Sử dụng phiên bản gọn nhẹ chạy quyền thường của accetto
FROM accetto/ubuntu-vnc-xfce-g3:latest

# Đổi cổng sang 8080 (Cổng Render ưa thích và tự động nhận diện tốt nhất)
EXPOSE 8080

# Thiết lập các biến môi trường cấu hình tĩnh (Tránh chạy script tạo pass động gây lỗi Sudo)
ENV VNC_PW=234567
ENV VNC_PORT=8080

# Ép hệ thống chạy bằng User thường có sẵn để không bị lỗi "Permission denied"
USER 1001

# Lệnh khởi chạy gốc không dùng script cài đặt đặc quyền
CMD ["/dockerstartup/vnc_startup.sh", "--wait"]
