FROM ubuntu:24.04

# Cài đặt SSH server, sudo và python3 (để tạo cổng HTTP giữ container sống)
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Cấu hình SSH Server chạy không cần quyền root hệ thống phức tạp
RUN mkdir /var/run/sshd

# Tạo một user mới tên là 'ubuntuuser' và đặt mật khẩu là '123456'
RUN useradd -m -s /bin/bash ubuntuuser && \
    echo "ubuntuuser:123456" | chpasswd && \
    echo "ubuntuuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cho phép đăng nhập SSH bằng mật khẩu
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Mở cổng 22 cho SSH nội bộ và cổng 8000 cho HTTP Bypass
EXPOSE 22
EXPOSE 8000

# Chạy song song cả dịch vụ SSH Server và Python HTTP Server để treo 24/24
CMD service ssh start && python3 -m http.server 8000
