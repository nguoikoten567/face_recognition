import pickle

# Đọc dữ liệu từ file face_data.pkl
try:
    with open("face_data.pkl", "rb") as f:
        face_data = pickle.load(f)
except FileNotFoundError:
    face_data = {}  # Nếu không tìm thấy file, khởi tạo face_data là một dictionary rỗng

# Tạo danh sách chứa UserID và Name
user_info = {}
for user_id, user_data in face_data.items():
    user_info[user_id] = user_data['name']

# In ra thông tin user_id và name
for user_id, name in user_info.items():
    print(f"UserID: {user_id}, Name: {name}")
    

# import pickle

# # Đọc dữ liệu từ file face_data.pkl
# with open("face_data.pkl", "rb") as file:
#     face_data = pickle.load(file)

# # Kiểm tra và xóa data của userid=2 nếu có
# userid_to_delete = 2
# face_data = {k: v for k, v in face_data.items() if v['userid'] != userid_to_delete}

# # Ghi lại dữ liệu sau khi đã xóa vào file face_data.pkl
# with open("face_data.pkl", "wb") as file:
#     pickle.dump(face_data, file)

# print(f"Dữ liệu của userid={userid_to_delete} đã được xóa.")

