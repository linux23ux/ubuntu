FROM accetto/ubuntu-vnc-xfce-g3:latest

USER root

# Ghi đè cổng mặc định 6901 bằng biến $PORT của Render khi khởi chạy
ENTRYPOINT ["/bin/bash", "-c", "sed -i \"s/6901/${PORT}/g\" /usr/share/usr/local/share/noVNCdim/index.html || true; exec /dockerstartup/vnc_startup.sh --wait"]
