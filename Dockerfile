FROM ubuntu:24.04

# Cài đặt các gói cơ bản và python3 để tạo máy chủ HTTP giả lập
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Tạo user và cấu hình thư mục SSH bắt buộc theo tiêu chuẩn Render
RUN useradd -m -s /bin/bash ubuntuuser && \
    echo "ubuntuuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntuuser
WORKDIR /home/ubuntuuser

RUN mkdir -p /home/ubuntuuser/.ssh && chmod 0700 /home/ubuntuuser/.ssh

# Thay vì dùng lệnh tail -f, ta khởi chạy một HTTP server đơn giản bằng Python ở port 10000
CMD ["python3", "-m", "http.server", "10000"]
