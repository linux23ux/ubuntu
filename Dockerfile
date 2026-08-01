# Sử dụng trực tiếp bản build sẵn từ Docker Hub của tác giả accetto
FROM accetto/ubuntu-vnc-xfce:latest

# Render yêu cầu quyền root để cấu hình định tuyến cổng mạng dịch vụ
USER root

# Đồng bộ cổng hiển thị Web (NO_VNC_PORT) với cổng cấp động từ Render ($PORT)
# Mặc định Render dùng cổng 10000 nếu không thiết lập khác
ENV PORT=10000
ENV NO_VNC_PORT=${PORT}
EXPOSE ${PORT}

# Đặt thư mục làm việc mặc định về kịch bản khởi động của hệ thống
WORKDIR ${STARTUPDIR}

# Giữ nguyên lệnh khởi chạy mặc định của tác giả
ENTRYPOINT ["./vnc_startup.sh"]
CMD [ "--wait" ]
