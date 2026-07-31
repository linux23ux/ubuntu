# Sử dụng Ubuntu mới nhất làm gốc
FROM ubuntu:latest

# Bỏ qua các câu hỏi tương tác khi cài đặt gói
ENV DEBIAN_FRONTEND=noninteractive

# 1. Cài đặt các công cụ nền tảng: Node.js, Tmux, Curl và các gói bổ trợ
RUN apt-get update && apt-get install -y \
    curl \
    git \
    tmux \
    sudo \
    && curl -fsSL https://nodesource.com | bash - \
    && apt-get install -y nodejs \
    && rm -rf /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get clean

# 2. Cài đặt Wetty để chuyển Terminal lên trình duyệt Web
RUN npm install -g wetty

# 3. Tạo một tài khoản người dùng (User) thông thường để bảo mật
RUN useradd -d /home/ubuntuuser -m -s /bin/bash ubuntuuser && \
    echo 'ubuntuuser:password123' | chpasswd && \
    adduser ubuntuuser sudo

# Cho phép user này chạy lệnh sudo mà không cần nhập mật khẩu cho tiện dev
RUN echo 'ubuntuuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/ubuntuuser
USER ubuntuuser

# 4. ĐỊNH CẤU HÌNH GIAO DIỆN NHIỀU TAB CHO TMUX (Hiển thị ngay trên Web)
# Cho phép dùng chuột để click chọn Tab, cuộn màn hình, co giãn Tab
RUN echo "set -g mouse on" >> ~/.tmux.conf && \
    # Đổi phím tắt chuyển Tab từ Ctrl+B sang Ctrl+A cho giống trình duyệt hoặc giữ mặc định
    echo "set -g prefix C-b" >> ~/.tmux.conf && \
    # Đổi màu thanh trạng thái (Thanh Tab) phía dưới sang màu xanh đen trực quan
    echo "set -g status-bg black" >> ~/.tmux.conf && \
    echo "set -g status-fg white" >> ~/.tmux.conf && \
    # Định dạng hiển thị tên các Tab ở thanh dưới cùng
    echo "set -g window-status-current-style bg=blue,fg=white,bold" >> ~/.tmux.conf && \
    echo "set -g window-status-format '#I:#W'" >> ~/.tmux.conf && \
    echo "set -g window-status-current-format '#I:#W*'" >> ~/.tmux.conf && \
    # Tự động đánh số lại các Tab khi có 1 Tab bị tắt
    echo "set -g renumber-windows on" >> ~/.tmux.conf

# 5. Đóng gói lệnh khởi chạy giúp KHÔNG BỊ TẮT / MẤT DỮ LIỆU KHI F5
# Tiến trình sẽ tự động kiểm tra xem có phiên làm việc 'render_session' cũ chưa. 
# Nếu có (do F5), nó kết nối lại ngay lập tức. Nếu chưa (lần đầu mở), nó sẽ tự động tạo mới 3 Tab Ubuntu sẵn.
CMD ["wetty", "--host", "0.0.0.0", "--port", "10000", "--command", "tmux attach-session -t render_session || (tmux new-session -d -s render_session -n 'Tab_1' && tmux new-window -t render_session:2 -n 'Tab_2' && tmux new-window -t render_session:3 -n 'Tab_3' && tmux attach-session -t render_session)"]

# Render sử dụng cổng kết nối này công khai ra ngoài
EXPOSE 10000
