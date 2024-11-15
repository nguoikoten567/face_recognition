import tkinter as tk
from tkinter import Label
import cv2
import torch
from PIL import Image, ImageTk
import sys
import numpy as np

# Đảm bảo YOLOv5 được tải từ thư mục cục bộ
sys.path.insert(0, './yolov5')  # Đường dẫn đến thư mục yolov5 của bạn
from models.common import DetectMultiBackend

# Tải mô hình YOLOv5 từ tệp .pt (chẳng hạn như yolov5s.pt)
model = DetectMultiBackend('./yolov5/yolov5s.pt')  # Điều chỉnh nếu tệp mô hình ở vị trí khác
model.eval()

# Khởi tạo camera
cap = cv2.VideoCapture(0)

def detect_face():
    # Đọc một khung hình từ camera
    ret, frame = cap.read()
    if not ret:
        return

    # Chuyển đổi khung hình thành định dạng tensor để YOLOv5 sử dụng
    img = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    img = torch.from_numpy(img).to(torch.float32)
    img = img.permute(2, 0, 1).unsqueeze(0)  # Định dạng thành (1, C, H, W)

    # Dự đoán đối tượng trong khung hình
    results = model(img)

    # Kiểm tra và lấy các bounding box phát hiện được
    if isinstance(results, list):
        detections = results[0]  # Trường hợp kết quả trả về là list
    else:
        detections = results.pred[0]  # Trường hợp kết quả là object (yêu cầu YOLOv5 >= 6.0)

    # Kiểm tra nếu không có phát hiện nào
    if detections is None or len(detections) == 0:
        print("No detections")
        return

    # Duyệt qua tất cả các phát hiện
    for det in detections:
        # Lấy các giá trị bounding box và độ tin cậy
        x1, y1, x2, y2, conf, cls = det[:6]

        # Chuyển đổi cls về số nguyên
        cls = cls.item() if cls.ndimension() == 0 else cls[0].item()

        # Kiểm tra lớp (class) và chỉ vẽ cho class 'person' (class 0)
        if cls == 0:  # class 0 là 'person' trong YOLOv5
            # In ra thông báo khi phát hiện người
            print("Đã phát hiện người")
            
            # Chuyển đổi các giá trị tọa độ thành scalar
            x1, y1, x2, y2 = x1.item(), y1.item(), x2.item(), y2.item()

            # Vẽ bounding box trên khung hình
            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
            cv2.putText(frame, "Person", (int(x1), int(y1)-10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 255, 0), 2)

    # Hiển thị hình ảnh lên Tkinter
    img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    img_pil = Image.fromarray(img_rgb)
    imgtk = ImageTk.PhotoImage(image=img_pil)
    video_label.imgtk = imgtk
    video_label.configure(image=imgtk)
    video_label.after(10, detect_face)

# Khởi tạo GUI Tkinter
root = tk.Tk()
root.title("Face Detection using YOLOv5")

# Tạo nhãn video để hiển thị
video_label = Label(root)
video_label.pack()

# Bắt đầu nhận diện và hiển thị
detect_face()

# Chạy GUI
root.mainloop()

# Giải phóng camera sau khi ứng dụng kết thúc
cap.release()
cv2.destroyAllWindows()
