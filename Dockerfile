# Sử dụng image chứa sẵn trình mô phỏng KVM và Windows của Dockur
FROM qemux/qemu

# Cấu hình phiên bản Windows muốn cài (ở đây là Windows 10)
ENV VERSION="ubuntu"

# Cấu hình cấu hình phần cứng ảo (Mặc định Railway gói thấp RAM sẽ rất yếu)
ENV RAM_SIZE="2G"
ENV CPU_CORES="2"

# Mở port 8006 để truy cập giao diện Windows qua trình duyệt Web
EXPOSE 8006
