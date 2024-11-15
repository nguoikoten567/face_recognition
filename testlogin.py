import tkinter as tk
from tkinter import messagebox

# Biến toàn cục theo dõi trạng thái đăng nhập
userid = 0  # Mặc định là chưa đăng nhập

# Hàm kiểm tra đăng nhập (giả sử kiểm tra với username và password)
def login():
    global userid
    username = username_entry.get()
    password = password_entry.get()

    # Giả sử chúng ta có tài khoản mặc định là admin với mật khẩu password123
    if username == "admin" and password == "123":
        userid = 1  # Gán userid của người dùng đăng nhập (giả sử là 1)
        messagebox.showinfo("Đăng nhập thành công", "Chào mừng bạn đến với hệ thống!")
        login_frame.pack_forget()  # Ẩn giao diện đăng nhập
        show_admin_dashboard()     # Hiển thị nội dung quản trị viên
    else:
        messagebox.showerror("Lỗi", "Sai tài khoản hoặc mật khẩu!")

# Giao diện đăng nhập
def create_login_dialog():
    global username_entry, password_entry, login_frame

    login_dialog = tk.Tk()
    login_dialog.title("Đăng Nhập")

    # Tạo khung chứa đăng nhập
    login_frame = tk.Frame(login_dialog)
    login_frame.pack(pady=50)

    username_label = tk.Label(login_frame, text="Tài Khoản:")
    username_label.pack(pady=5)
    username_entry = tk.Entry(login_frame)
    username_entry.pack(pady=5)

    password_label = tk.Label(login_frame, text="Mật Khẩu:")
    password_label.pack(pady=5)
    password_entry = tk.Entry(login_frame, show="*")
    password_entry.pack(pady=5)

    login_button = tk.Button(login_frame, text="Đăng Nhập", command=login)
    login_button.pack(pady=10)

    login_dialog.mainloop()

# Hiển thị nội dung quản trị viên (Admin Dashboard)
def show_admin_dashboard():
    if userid == 0:
        # Nếu chưa đăng nhập, yêu cầu đăng nhập
        create_login_dialog()
        return

    admin_dashboard = tk.Tk()
    admin_dashboard.title("Quản Trị Viên")

    welcome_label = tk.Label(admin_dashboard, text="Chào mừng bạn đến với trang quản trị!", font=("Arial", 16))
    welcome_label.pack(pady=20)

    logout_button = tk.Button(admin_dashboard, text="Đăng Xuất", command=logout)
    logout_button.pack(pady=10)

    admin_dashboard.mainloop()

# Hàm đăng xuất
def logout():
    global userid
    logout_confirm = messagebox.askyesno("Đăng Xuất", "Bạn có chắc chắn muốn đăng xuất?")
    if logout_confirm:
        userid = 0  # Đặt lại userid về 0 khi đăng xuất
        messagebox.showinfo("Đăng Xuất", "Bạn đã đăng xuất thành công!")
        create_login_dialog()  # Quay lại giao diện đăng nhập

# Kiểm tra trạng thái khi bắt đầu
if userid == 0:
    create_login_dialog()  # Nếu chưa đăng nhập, gọi giao diện đăng nhập
else:
    show_admin_dashboard()  # Nếu đã đăng nhập, hiển thị bảng điều khiển admin
