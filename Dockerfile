# Sử dụng bản build sẵn Ubuntu + Xfce thế hệ mới ổn định
FROM accetto/ubuntu-vnc-xfce-g3:latest

# Chuyển sang quyền root để cấu hình cổng mạng cho Render
USER root

# Đồng bộ cổng hiển thị noVNC với cổng cấp động từ Render
ENV PORT=10000
ENV NO_VNC_PORT=${PORT}
EXPOSE ${PORT}

# Chạy trực tiếp bằng kịch bản khởi động nội bộ của Image
WORKDIR ${STARTUPDIR}
ENTRYPOINT ["./vnc_startup.sh"]
CMD [ "--wait" ]
