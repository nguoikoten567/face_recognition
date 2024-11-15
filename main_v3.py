import sys
import os
import cv2
import numpy as np
import tkinter as tk
from tkinter import messagebox
from PIL import Image, ImageTk
import threading
from insightface.app import FaceAnalysis
import pickle
import torch
import warnings
warnings.simplefilter("ignore", FutureWarning)
# import logging

# # Chỉ hiển thị thông báo lỗi từ YOLOv5
# logging.getLogger('yolov5').setLevel(logging.ERROR)
# logging.getLogger('insightface').setLevel(logging.ERROR)



# Đảm bảo đường dẫn đúng cho yolov5 và insightface
yolov5_path = os.path.join(os.getcwd(), 'yolov5')  
if yolov5_path not in sys.path:
    sys.path.append(yolov5_path)

insightface_path = os.path.join(os.getcwd(), 'insightface')  
if insightface_path not in sys.path:
    sys.path.append(insightface_path)
    
yolo_model = torch.hub.load(yolov5_path, 'yolov5s', source='local')  # Tải từ thư mục đã tải xuống

# Kiểm tra xem mô hình có tải thành công không
# print(yolo_model)

# Khởi tạo ứng dụng nhận diện khuôn mặt InsightFace
face_recognition_app = FaceAnalysis()
face_recognition_app.prepare(ctx_id=0)

# Khai báo các biến toàn cục
cap = None
camera_active = False
frame = None  # Lưu frame hiện tại từ camera
face_data = {}  # Dữ liệu khuôn mặt đã lưu (tên và embedding)

# Tạo cửa sổ chính
root = tk.Tk()
root.title("Ứng Dụng Nhận Diện Khuôn Mặt")
root.geometry("640x800")

# Tạo khung hiển thị camera
camera_frame = tk.Label(root)
camera_frame.place(x=0, y=0, width=640, height=480)

# Hàm nhận diện khuôn mặt
def detect_face(frame):
    global yolo_model
    # Chuyển đổi hình ảnh từ BGR sang RGB (YOLOv5 yêu cầu định dạng RGB)
    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    
    # Sử dụng YOLOv5 để phát hiện khuôn mặt
    results = yolo_model(frame_rgb)
    
    # Lấy kết quả nhận diện (bounding boxes của khuôn mặt)
    faces = results.xywh[0]  # Kết quả nhận diện, mỗi khuôn mặt sẽ có một bounding box
    if len(faces) > 0:
        for *box, conf, cls in faces:  # box chứa thông tin bounding box, conf là độ tin cậy
            x1, y1, w, h = map(int, box)  # Lấy tọa độ bounding box
            
            # Vẽ khung vuông quanh khuôn mặt
            cv2.rectangle(frame, (x1, y1), (x1 + w, y1 + h), (255, 0, 0), 2)
            
            # Sử dụng InsightFace để nhận diện và lấy đặc trưng khuôn mặt
            face_img = frame[y1:y1 + h, x1:x1 + w]
            face_embedding = None
            faces_insight = face_recognition_app.get(face_img)
            if len(faces_insight) > 0:
                face_embedding = faces_insight[0].embedding
            if face_embedding is not None:
                return face_embedding, (x1, y1, w, h)
    
    return None, None  # Không tìm thấy khuôn mặt

# Hàm khởi động camera
def start_camera():
    global cap, camera_active
    if camera_active:
        messagebox.showinfo("Thông báo", "Camera đã bật rồi!")
        return
    
    # Thông báo khi bắt đầu mở camera
    dialog = tk.Toplevel(root)
    dialog.title("Thông báo")
    dialog.geometry("300x150")
    message = tk.Label(dialog, text="Camera đang khởi động, vui lòng chờ...")
    message.pack(pady=20)
    center_window(dialog)
    ok_button = tk.Button(dialog, text="OK", command=dialog.destroy, width=10)
    ok_button.pack(pady=10)
    
    # Đóng cửa sổ thông báo sau 2 giây
    dialog.after(2000, dialog.destroy)
    threading.Thread(target=open_camera_thread, daemon=True).start()

# Hàm mở camera trong thread riêng
def open_camera_thread():
    global cap, camera_active
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        messagebox.showerror("Lỗi", "Không tìm thấy camera!")
        return

    camera_active = True
    update_camera()

# Cập nhật khung hình camera
def update_camera():
    global cap, camera_active, frame
    if camera_active:
        ret, frame = cap.read()
        if not ret:
            messagebox.showerror("Lỗi", "Không thể đọc từ camera!")
            stop_camera()
            return
        frame = cv2.flip(frame, 1)
        frame = cv2.resize(frame, (640, 480))
        
        # Gọi hàm nhận diện khuôn mặt từ YOLOv5
        face_embedding, bbox = detect_face(frame)
        
        if face_embedding is not None:
            # Kiểm tra sự tương đồng với dữ liệu đã lưu
            match_name = "Unknown"
            for name, stored_embedding in face_data.items():
                similarity = np.dot(face_embedding, stored_embedding)  # Tính độ tương đồng
                if similarity > 0.8:  # Nếu độ tương đồng trên 80%
                    match_name = name
                    break
            
            # Hiển thị tên người nhận diện cùng với khung vuông
            if bbox:
                x1, y1, w, h = bbox
                cv2.putText(frame, match_name, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (255, 0, 0), 2)
        
        img = ImageTk.PhotoImage(image=Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)))
        camera_frame.imgtk = img
        camera_frame.config(image=img)
        
        camera_frame.after(10, update_camera)

# Hàm dừng camera
def stop_camera():
    global cap, camera_active
    if cap is not None:
        cap.release()
    camera_active = False

# Thêm khuôn mặt mới vào dữ liệu
def add_new_face():
    global face_data
    dialog = tk.Toplevel(root)
    dialog.title("Thêm Khuôn Mặt Mới")
    dialog.geometry("300x150")
    
    name_label = tk.Label(dialog, text="Nhập tên:")
    name_label.pack(pady=5)
    name_entry = tk.Entry(dialog)
    name_entry.pack(pady=5)

    def save_face():
        name = name_entry.get()  # Lấy tên từ ô nhập liệu
        if name:
            face_embedding = detect_face(frame)  # Nhận diện khuôn mặt và lấy đặc trưng khuôn mặt
            if face_embedding is not None:
                # Kiểm tra nếu tệp face_data.pkl đã tồn tại và tải dữ liệu nếu có
                try:
                    with open('face_data.pkl', 'rb') as f:
                        face_data = pickle.load(f)
                except FileNotFoundError:
                    face_data = {}  # Nếu tệp không tồn tại, khởi tạo dữ liệu mới
                
                # Lưu dữ liệu khuôn mặt vào face_data
                face_data[name] = face_embedding
                
                # Ghi lại dữ liệu vào tệp face_data.pkl
                with open('face_data.pkl', 'wb') as f:
                    pickle.dump(face_data, f)
                
                messagebox.showinfo("Thông báo", f"Khuôn mặt {name} đã được lưu!")
                dialog.destroy()
            else:
                messagebox.showerror("Lỗi", "Không phát hiện khuôn mặt!")
        else:
            messagebox.showerror("Lỗi", "Vui lòng nhập tên!")

    save_button = tk.Button(dialog, text="Lưu", command=save_face)
    save_button.pack(pady=10)
    cancel_button = tk.Button(dialog, text="Hủy", command=dialog.destroy)
    cancel_button.pack(pady=5)

# Hàm điểm danh
def attendance():
    global face_data
    dialog = tk.Toplevel(root)
    dialog.title("Điểm Danh")
    dialog.geometry("300x150")
    
    # Mở và đọc dữ liệu từ file face_data.pkl
    try:
        with open('face_data.pkl', 'rb') as f:
            face_data = pickle.load(f)
    except FileNotFoundError:
        messagebox.showerror("Lỗi", "Không tìm thấy dữ liệu khuôn mặt!")
        return
    
    # Nhận diện khuôn mặt từ camera
    face_embedding = detect_face(frame)
    if face_embedding is not None:
        # Kiểm tra độ tương đồng giữa khuôn mặt hiện tại và các khuôn mặt đã lưu
        for name, stored_embedding in face_data.items():
            similarity = np.dot(face_embedding, stored_embedding)  # Tính độ tương đồng giữa embeddings
            if similarity > 0.9:
                messagebox.showinfo("Thông báo", f"Điểm danh thành công: {name}")
                dialog.destroy()
                return
        
        # Nếu không có khuôn mặt nào khớp
        messagebox.showerror("Lỗi", "Không khớp với dữ liệu khuôn mặt!")
    else:
        messagebox.showerror("Lỗi", "Không phát hiện khuôn mặt!")

# Hàm căn chỉnh cửa sổ giữa màn hình
def center_window(window):
    window.update_idletasks()
    width = window.winfo_width()
    height = window.winfo_height()
    screen_width = window.winfo_screenwidth()
    screen_height = window.winfo_screenheight()
    position_top = int(screen_height / 2 - height / 2)
    position_right = int(screen_width / 2 - width / 2)
    window.geometry(f'{width}x{height}+{position_right}+{position_top}')

# Khung chứa các nút
button_frame = tk.Frame(root, bg="lightblue")
button_frame.place(x=0, y=710, width=640, height=90)

camera_button = tk.Button(button_frame, text="Bật Camera", command=start_camera, font=("Arial", 12), width=15)
camera_button.grid(row=0, column=0, padx=30, pady=30)

attendance_button = tk.Button(button_frame, text="Điểm danh", command=attendance, font=("Arial", 12), width=15)
attendance_button.grid(row=0, column=1, padx=30, pady=30)

add_face_button = tk.Button(button_frame, text="Thêm Khuôn Mặt", command=add_new_face, font=("Arial", 12), width=15)
add_face_button.grid(row=0, column=2, padx=30, pady=30)

# exit_button = tk.Button(button_frame, text="Thoát", command=root.quit, font=("Arial", 12), width=15)
# exit_button.grid(row=0, column=3, padx=30, pady=30)

# Chạy giao diện
root.mainloop()
