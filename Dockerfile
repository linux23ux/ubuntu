# Sử dụng bản build sẵn Ubuntu + giao diện Xfce đầy đủ chính thức
FROM dorowu/ubuntu-desktop-lxde-vnc:focal-xfce

# Chuyển sang quyền root để cấu hình cổng mạng cho Render
USER root

# Cấu hình biến môi trường để hệ thống tự nhận diện cổng cấp bởi Render
# Render sử dụng biến $PORT (thường là 10000)
ENV PORT=10000
EXPOSE 10000

# Ghi đè cấu hình cổng mặc định (80) của image sang cổng của Render
RUN sed -i 's/listen 80 default_server;/listen [::]:10000 default_server;\n    listen 10000 default_server;/g' /etc/nginx/sites-enabled/default

# Tắt tính năng yêu cầu mật khẩu để dễ dàng truy cập ngay từ trình duyệt
ENV HTTP_PASSWORD=""
