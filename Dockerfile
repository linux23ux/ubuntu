# Ép nền tảng cấu trúc để Render không bị lỗi tương thích (Bắt buộc)
FROM --platform=linux/amd64 accetto/ubuntu-vnc-xfce-g3:24.04

# Định nghĩa lại cổng kết nối noVNC (Render mặc định dùng cổng 10000)
ENV VNC_PORT=10000
ENV NO_VNC_PORT=10000

# Đặt mật khẩu đăng nhập VNC (Thay đổi theo ý bạn)
ENV VNC_PW=my_secure_password_2026

# Render yêu cầu ứng dụng phải lắng nghe cổng này
EXPOSE 10000

# Giữ nguyên lệnh chạy mặc định của image gốc
CMD ["/dockerstartup/vnc_startup.sh", "--wait"]
