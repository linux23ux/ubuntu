FROM ubuntu:24.04

# Cài đặt các gói cơ bản cần thiết (Tùy chọn)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Tạo một user không phải root (Render khuyến khích bảo mật)
RUN useradd -m -s /bin/bash ubuntuuser && \
    echo "ubuntuuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntuuser
WORKDIR /home/ubuntuuser

# CẤU HÌNH BẮT BUỘC CHO RENDER SSH
# Tạo thư mục .ssh và phân quyền chính xác (chmod 0700)
RUN mkdir -p /home/ubuntuuser/.ssh && chmod 0700 /home/ubuntuuser/.ssh

# Lệnh giữ cho container luôn chạy (Vì bạn chỉ cần môi trường SSH)
CMD ["tail", "-f", "/dev/null"]
