FROM kasmweb/ubuntu-jammy-desktop:1.15.0

# Render yêu cầu chạy quyền user thường, kasmweb sử dụng user mã số 1000
USER 1000

# Cấu hình cổng kết nối mặc định mà kasmweb sử dụng cho VNC Web
EXPOSE 6901

# Đặt mật khẩu truy cập (Thay đổi theo ý bạn)
ENV VNC_PW=234556

# Thiết lập biến môi trường để bỏ qua các bước kiểm tra đặc quyền hệ thống
ENV START_XFCE4=1
