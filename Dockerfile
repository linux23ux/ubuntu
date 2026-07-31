FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt các gói cần thiết nếu có
RUN apt-get update && apt-get install -y curl wget git

# Lệnh giữ container luôn hoạt động (không bị thoát)
CMD ["tail", "-f", "/dev/null"]
