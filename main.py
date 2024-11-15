import tkinter as tk
from time import strftime, time
from PIL import Image, ImageTk
import cv2
from attention import show_success_dialog, show_fail_dialog
from admin_login import create_login_dialog
import pyodbc
from datetime import datetime, timedelta
from tkinter import messagebox
import threading

def admin_login():
    create_login_dialog()
    


def get_current_time():
    return datetime.now().strftime("%H:%M:%S")


#define_attention_success
def attention_success():
    current_time = strftime('%H:%M:%S %p')
    show_success_dialog(root, current_time)
    
#define_attention_fail
def attention_fail():
    show_fail_dialog(root)

#dong chuong trinh


#can giua
def center_window(window):
    window.update_idletasks()  # Cập nhật các tác vụ chờ
    x = (window.winfo_screenwidth() // 2) - (window.winfo_width() // 2)
    y = (window.winfo_screenheight() // 2) - (window.winfo_height() // 2)
    window.geometry(f"+{x}+{y}")  # Đặt vị trí cửa sổ


# Bien toan cuc de luu thoi gian truoc do
last_time = time()

# Ham cap nhat thoi gian, ngay va FPS
def update_time():
    global last_time
    current_time = strftime('%H:%M:%S %p')  # Lay gio hien tai
    current_date = strftime('%d-%m-%Y')     # Lay ngay hien tai

    # Tinh FPS
    current_frame_time = time()
    delta_time = current_frame_time - last_time
    fps = 1 / delta_time if delta_time > 0 else 0
    last_time = current_frame_time
    
    # Cap nhat cac nhan
    label_time.config(text=current_time)
    label_date.config(text=current_date)
    # label_fps.config(text=f"FPS: {fps:.2f}")
    
    # Cap nhat sau moi 1000ms (1 giay)
    label_time.after(1000, update_time)

# Tao cua so chinh
root = tk.Tk()
root.title("PHAN MEM DIEM DANH BANG KHUON MAT")
root.geometry("1000x800")
center_window(root)
root.resizable(False, False)

background_image = Image.open("bg/background.jpg")  # Đường dẫn đến hình ảnh JPEG
background_image = background_image.resize((1000, 800), Image.LANCZOS)  # Thay đổi kích thước hình ảnh
background_photo = ImageTk.PhotoImage(background_image)


#icon_dialog_main
# icon_image2 = Image.open("icon/face_icon.png")  # Đường dẫn đến icon mới
icon_image2 = Image.open("logo/hau3.png") 
icon = ImageTk.PhotoImage(icon_image2)
root.iconphoto(False, icon)  # Đặt icon cho dialog

# Tạo nhãn để hiển thị hình ảnh nền
background_label = tk.Label(root, image=background_photo)
background_label.place(relwidth=1, relheight=1)

#frame_fps

# fps_frame = tk.Frame(root, bd=5, bg="blue")  # Khung với viền
# fps_frame.grid(row=0, column=0, padx=35, pady=10, sticky='w')


#frame time
time_frame = tk.Frame(root, bg="lightgray", bd=5, relief="sunken")  # Tạo khung với viền
time_frame.place(x=667, y=60, width=300, height=250)  # Đặt khung tại vị trí 


#frame_btn_adminlogin
button_frame = tk.Frame(root)
button_frame.place(x=667, y=360, width=300, height=100)

#icon_btn_adminlogin
icon_image = Image.open("icon/admin.png") 
icon_image = icon_image.resize((50, 50), Image.LANCZOS)  # Thay đổi kích thước biểu tượng nếu cần
icon = ImageTk.PhotoImage(icon_image)

#tao nut adminlogin
admin_button = tk.Button(button_frame, text="ADMIN ĐĂNG NHÂP", image=icon, compound=tk.LEFT, command=admin_login,font=('calibri', 18), padx=10 )
admin_button.pack(expand=True, fill=tk.BOTH)


#frame_btn_attention
button2_frame = tk.Frame(root)
button2_frame.place(x=667, y=510, width=300, height=260)


#icon_btn_attention
icon2_image = Image.open("icon/face.png") 
icon2_image = icon2_image.resize((60, 60), Image.LANCZOS)  # Thay đổi kích thước biểu tượng nếu cần
icon2 = ImageTk.PhotoImage(icon2_image)






# label_fps = tk.Label(fps_frame, font=('calibri', 20), background='blue', foreground='yellow')
# label_fps.pack(padx=5, pady=5)


# Tao nhan de hien thi gio
label_time = tk.Label(time_frame, font=('calibri',35, 'bold'), background='purple', foreground='white')
#label_time.pack(expand=True)

label_time.grid(row=1, column=0, padx=(20,20), pady=(50,10),sticky='nsew')  # Dat gio o hang 1, cot 0, duong dan sang trai

# Tao nhan de hien thi ngay
label_date = tk.Label(time_frame, font=('calibri', 30), background='purple', foreground='white')
#label_time.pack(expand=True)

label_date.grid(row=2, column=0, padx=(10,10), pady=(20,30),sticky='nsew')  # Dat ngay o hang 2, cot 0, duong dan sang trai

# Goi ham cap nhat thoi gian, ngay va FPS
update_time()

def load_db_config():  # sourcery skip: use-contextlib-suppress
    try:
        with open("db_config.txt", "r") as config_file:
            lines = config_file.readlines()
            if len(lines) >= 2:
                return lines[0].strip(), lines[1].strip()
    except FileNotFoundError:
        pass
    return None, None

def attention():
    
    user_id = 1  # ID người dùng
    name = "Nguyen Van A"  # Thay thế bằng tên thực tế
    status = "Muon"  # Trạng thái
    attention_date = datetime.now()  # Ngày hiện tại
    checkin_time = datetime.now()  # Thời gian check-in
    checkout_time = checkin_time + timedelta(minutes=5)  # Thời gian check-out
    # Kết nối đến cơ sở dữ liệu SQL Server
    server_name, database_name = load_db_config()
    if server_name and database_name:
        try:
            connection = pyodbc.connect(
                'DRIVER={SQL Server};' +
                f'Server={server_name};' +
                f'Database={database_name};' +
                'Trusted_Connection=True'
            )
            print("Ket noi thanh cong!")
            cursor = connection.cursor()

        # Câu lệnh SQL để thêm bản ghi mới vào bảng attention_manager
            sql_insert = """
            INSERT INTO attention_manager (UserID, Name, AttentionDate, CheckInTime, CheckOutTime,Status)
            VALUES (?, ?, ?, ?, ?, ?)
            """
            
            # Thực thi câu lệnh
            cursor.execute(sql_insert, (user_id, name, attention_date, checkin_time, checkout_time,status))
            
            # Lưu thay đổi
            connection.commit()
            print("Điểm danh thành công!")
    

        except Exception as ex:
            print("Đã xảy ra lỗi khi điểm danh:", ex)
        
        finally:
            # Đóng kết nối
            cursor.close()
            connection.close()


#tao nut attention

att_button = tk.Button(button2_frame, text="ĐIỂM DANH", image=icon2, compound=tk.LEFT, command=lambda:(attention(),attention_success()),font=('calibri', 30), padx=10 )
# att_button = tk.Button(button2_frame, text="ĐIỂM DANH", image=icon2, compound=tk.LEFT, command=lambda: random_dialog(root, get_current_time()),font=('calibri', 30), padx=10 )
# att_button.pack(expand=True, pady=20)
att_button.pack(expand=True, fill=tk.BOTH)

#camera


default_background = Image.open("bg/waiting.jpg")
default_background = default_background.resize((600, 600))
default_img = ImageTk.PhotoImage(default_background)

camera_frame = tk.Label(root, image=default_img, anchor="n")
camera_frame.place(x=35, y=60, width=600, height=600)
camera_frame.imgtk = default_img  # Giữ tham chiếu đến ảnh

# Biến lưu trạng thái camera
cap = None
camera_active = False

def start_camera():
    global cap, camera_active
    # Kiểm tra nếu camera đã bật
    if camera_active:
        messagebox.showinfo("Thông báo", "Camera đang bật!")
        return

    # Hiển thị thông báo ngay lập tức
    dialog = tk.Toplevel(root)
    dialog.title("Thông báo")
    dialog.geometry("300x150")
    message = tk.Label(dialog, text="Camera đang khởi động, vui lòng chờ từ 5-10s")
    message.pack(pady=20)
    center_window(dialog)
    ok_button = tk.Button(dialog, text="OK", command=dialog.destroy,width=10)
    ok_button.pack(pady=10)
    
    # Đóng dialog sau 2 giây nếu không bấm OK
    dialog.after(2000, dialog.destroy)
    threading.Thread(target=open_camera_thread, daemon=True).start()

    # Khởi động camera
def open_camera_thread():
    global cap, camera_active
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        messagebox.showerror("Lỗi", "Không tìm thấy camera! Vui lòng kiểm tra lại!")
        return

    camera_active = True
    update_camera()


def update_camera():
    global cap, camera_active
    if camera_active:
        ret, frame = cap.read()
        if not ret:
            messagebox.showerror("Lỗi", "Không thể đọc từ camera. Vui lòng kiểm tra lại!")
            stop_camera()
            return
        
        frame = cv2.resize(frame, (600, 640))
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

        # Đảo ngược hình ảnh theo chiều ngang
        frame = cv2.flip(frame, 1)

        img = ImageTk.PhotoImage(image=Image.fromarray(frame))
        
        camera_frame.imgtk = img
        camera_frame.config(image=img)
        
        # Lặp lại hàm sau 30ms
        camera_frame.after(30, update_camera)

def stop_camera():
    global cap, camera_active
    if cap is not None:
        cap.release()
    camera_active = False
    camera_frame.config(image=default_img)

def show_help():
    help_message = "Nếu bạn cần trợ giúp, liên hệ với chúng tôi!\nMr. Đức\nSĐT: 01234896811\nEmail: ducpctn@gmail.com"
    messagebox.showinfo("Trợ giúp", help_message)

button_frame = tk.Frame(root, bg="lightblue")
button_frame.place(x=35, y=680, width=600, height=90)

camera_button = tk.Button(button_frame, text="Bật Camera", command=start_camera, font=("Arial", 12), width=15)
camera_button.grid(row=0, column=0, padx=(25, 30), pady=30)

stop_button = tk.Button(button_frame, text="Tắt Camera", command=stop_camera, font=("Arial", 12), width=15)
stop_button.grid(row=0, column=1, padx=30, pady=30)

help_button = tk.Button(button_frame, text="Trợ giúp", command=show_help, font=("Arial", 12), width=15)
help_button.grid(row=0, column=2, padx=30, pady=30)

def on_closing():
    stop_camera()
    root.destroy()

root.protocol("WM_DELETE_WINDOW", on_closing)
root.mainloop()


# Bat dau vong lap su kien
# root.mainloop()
# cap.release()
# cv2.destroyAllWindows()