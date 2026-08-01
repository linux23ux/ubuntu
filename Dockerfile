FROM --platform=linux/amd64 accetto/ubuntu-vnc-xfce-g3:24.04

ENV VNC_PW=my_secure_password_2026

# Khai báo cho Render biết image này chạy cổng 6901
EXPOSE 6901
