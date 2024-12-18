USE [master]
GO
/****** Object:  Database [face_recognition]    Script Date: 25/11/2024 11:51:22 AM ******/
CREATE DATABASE [face_recognition]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'face_recognition', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\face_recognition.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'face_recognition_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\face_recognition_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [face_recognition] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [face_recognition].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [face_recognition] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [face_recognition] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [face_recognition] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [face_recognition] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [face_recognition] SET ARITHABORT OFF 
GO
ALTER DATABASE [face_recognition] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [face_recognition] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [face_recognition] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [face_recognition] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [face_recognition] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [face_recognition] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [face_recognition] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [face_recognition] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [face_recognition] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [face_recognition] SET  DISABLE_BROKER 
GO
ALTER DATABASE [face_recognition] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [face_recognition] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [face_recognition] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [face_recognition] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [face_recognition] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [face_recognition] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [face_recognition] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [face_recognition] SET RECOVERY FULL 
GO
ALTER DATABASE [face_recognition] SET  MULTI_USER 
GO
ALTER DATABASE [face_recognition] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [face_recognition] SET DB_CHAINING OFF 
GO
ALTER DATABASE [face_recognition] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [face_recognition] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [face_recognition] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [face_recognition] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [face_recognition] SET QUERY_STORE = OFF
GO
USE [face_recognition]
GO
/****** Object:  Table [dbo].[attention_manager]    Script Date: 25/11/2024 11:51:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attention_manager](
	[AttentionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[AttentionDate] [date] NOT NULL,
	[CheckInTime] [time](7) NULL,
	[CheckOutTime] [time](7) NULL,
	[Status] [nvarchar](50) NULL,
	[job_position] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AttentionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_position]    Script Date: 25/11/2024 11:51:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_position](
	[idJob] [int] NOT NULL,
	[job_position] [nvarchar](255) NOT NULL,
	[timestart] [time](7) NULL,
	[timeend] [time](7) NULL,
	[note] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[idJob] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_manager]    Script Date: 25/11/2024 11:51:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_manager](
	[UserID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](255) NULL,
	[Email] [nvarchar](100) NULL,
	[Note] [nvarchar](255) NULL,
	[job_position] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[attention_manager] ON 

INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1, 1, N'ADMIN SYSTEM', CAST(N'2024-11-01' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Da diem danh', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (2, 1, N'ADMIN SYSTEM', CAST(N'2024-11-02' AS Date), CAST(N'08:05:00' AS Time), CAST(N'17:05:00' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (3, 2, N'Giảng viên Demo', CAST(N'2024-11-01' AS Date), CAST(N'08:10:00' AS Time), CAST(N'17:10:00' AS Time), N'Da diem danh', N'Giảng viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (4, 2, N'Giảng viên Demo', CAST(N'2024-11-02' AS Date), CAST(N'08:15:00' AS Time), CAST(N'17:15:00' AS Time), N'Da diem danh', N'Giảng viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (5, 3, N'Sinh viên Demo', CAST(N'2024-11-01' AS Date), CAST(N'08:20:00' AS Time), CAST(N'17:20:00' AS Time), N'Muon', N'Sinh viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (6, 3, N'Sinh viên Demo', CAST(N'2024-11-02' AS Date), CAST(N'08:25:00' AS Time), CAST(N'17:25:00' AS Time), N'Da diem danh', N'Sinh viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (11, 1, N'ADMIN SYSTEM', CAST(N'2024-08-01' AS Date), CAST(N'08:30:00' AS Time), CAST(N'17:00:00' AS Time), N'Da diem danh', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (12, 1, N'ADMIN SYSTEM', CAST(N'2024-08-15' AS Date), CAST(N'08:35:00' AS Time), CAST(N'17:05:00' AS Time), N'Da diem danh', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (13, 2, N'Giảng viên Demo', CAST(N'2024-08-02' AS Date), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Da diem danh', N'Giảng viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (14, 2, N'Giảng viên Demo', CAST(N'2024-08-16' AS Date), CAST(N'09:10:00' AS Time), CAST(N'17:10:00' AS Time), N'Da diem danh', N'Giảng viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (15, 3, N'Sinh viên Demo', CAST(N'2024-08-03' AS Date), CAST(N'08:45:00' AS Time), CAST(N'17:00:00' AS Time), N'Da diem danh', N'Sinh viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1002, 1, N'ADMIN SYSTEM', CAST(N'2024-11-05' AS Date), CAST(N'10:22:18.6366667' AS Time), CAST(N'10:27:18.6366667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1003, 1, N'ADMIN SYSTEM', CAST(N'2024-11-05' AS Date), CAST(N'10:23:08.3533333' AS Time), CAST(N'10:28:08.3533333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1004, 4, N'Bảo vệ demo', CAST(N'2024-11-08' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), N'Muon', N'Bảo vệ')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1005, 4, N'Bảo vệ demo', CAST(N'2024-11-09' AS Date), CAST(N'08:15:00' AS Time), CAST(N'16:15:00' AS Time), N'Muon', N'Bảo vệ')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1006, 4, N'Bảo vệ demo', CAST(N'2024-11-10' AS Date), CAST(N'08:30:00' AS Time), CAST(N'16:30:00' AS Time), N'Muon', N'Bảo vệ')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1007, 4, N'Bảo vệ demo', CAST(N'2024-11-11' AS Date), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Muon', N'Bảo vệ')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1008, 4, N'Bảo vệ demo', CAST(N'2024-11-12' AS Date), CAST(N'08:45:00' AS Time), CAST(N'16:45:00' AS Time), N'Muon', N'Bảo vệ')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1036, 1, N'ADMIN SYSTEM', CAST(N'2024-11-14' AS Date), CAST(N'07:47:49.5133333' AS Time), CAST(N'07:52:49.5133333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1037, 1, N'ADMIN SYSTEM', CAST(N'2024-11-14' AS Date), CAST(N'09:21:45.2300000' AS Time), CAST(N'09:26:45.2300000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1038, 1, N'ADMIN SYSTEM', CAST(N'2024-11-14' AS Date), CAST(N'20:55:50.1600000' AS Time), CAST(N'21:00:50.1600000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1039, 1, N'ADMIN SYSTEM', CAST(N'2024-11-14' AS Date), CAST(N'21:23:56.1666667' AS Time), CAST(N'21:28:56.1666667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1040, 2, N'Giảng viên Demo', CAST(N'2024-11-14' AS Date), CAST(N'23:18:21.5233333' AS Time), CAST(N'23:23:21.5233333' AS Time), N'Muon', N'Giảng viên')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1041, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'02:20:11.4100000' AS Time), CAST(N'02:25:11.4100000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1042, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'02:20:18.6100000' AS Time), CAST(N'02:25:18.6100000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1043, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'02:27:13.2533333' AS Time), CAST(N'02:32:13.2533333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1044, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'03:15:09.5600000' AS Time), CAST(N'03:20:09.5600000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1045, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'03:15:16.4566667' AS Time), CAST(N'03:20:16.4566667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1046, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'03:15:29.7233333' AS Time), CAST(N'03:20:29.7233333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1047, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'03:16:48.6800000' AS Time), CAST(N'03:21:48.6800000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1048, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'03:16:56.2566667' AS Time), CAST(N'03:21:56.2566667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1049, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'04:46:26.2633333' AS Time), CAST(N'04:51:26.2633333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1050, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'07:32:04.9666667' AS Time), CAST(N'07:37:04.9666667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1051, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'07:46:04.2633333' AS Time), CAST(N'07:51:04.2633333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1052, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'08:03:22.3833333' AS Time), CAST(N'08:08:22.3833333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1053, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'08:10:25.3666667' AS Time), CAST(N'08:15:25.3666667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1054, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'10:02:45.1833333' AS Time), CAST(N'10:07:45.1833333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1055, 1, N'ADMIN SYSTEM', CAST(N'2024-11-15' AS Date), CAST(N'10:04:16.5033333' AS Time), CAST(N'10:09:16.5033333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1056, 1, N'ADMIN SYSTEM', CAST(N'2024-11-16' AS Date), CAST(N'15:38:00.9933333' AS Time), CAST(N'15:43:00.9933333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1058, 1, N'ADMIN SYSTEM', CAST(N'2024-11-19' AS Date), CAST(N'09:53:13.8366667' AS Time), CAST(N'09:58:13.8366667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1064, 1, N'ADMIN SYSTEM', CAST(N'2024-11-19' AS Date), CAST(N'10:00:13.0400000' AS Time), CAST(N'10:05:13.0400000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1065, 1, N'ADMIN SYSTEM', CAST(N'2024-11-19' AS Date), CAST(N'10:01:11.4666667' AS Time), CAST(N'10:06:11.4666667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1066, 1, N'ADMIN SYSTEM', CAST(N'2024-11-19' AS Date), CAST(N'10:01:32.9600000' AS Time), CAST(N'10:06:32.9600000' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1067, 1, N'ADMIN SYSTEM', CAST(N'2024-11-19' AS Date), CAST(N'10:19:27.1466667' AS Time), CAST(N'10:24:27.1466667' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1068, 1, N'ADMIN SYSTEM', CAST(N'2024-11-21' AS Date), CAST(N'21:01:58.4933333' AS Time), CAST(N'21:06:58.4933333' AS Time), N'Muon', N'ADMIN')
INSERT [dbo].[attention_manager] ([AttentionID], [UserID], [Name], [AttentionDate], [CheckInTime], [CheckOutTime], [Status], [job_position]) VALUES (1069, 1, N'ADMIN SYSTEM', CAST(N'2024-11-21' AS Date), CAST(N'21:06:01.0666667' AS Time), CAST(N'21:11:01.0666667' AS Time), N'Muon', N'ADMIN')
SET IDENTITY_INSERT [dbo].[attention_manager] OFF
GO
INSERT [dbo].[job_position] ([idJob], [job_position], [timestart], [timeend], [note]) VALUES (1, N'ADMIN', CAST(N'00:00:00' AS Time), CAST(N'23:59:00' AS Time), N'ADMIN SYSTEM')
INSERT [dbo].[job_position] ([idJob], [job_position], [timestart], [timeend], [note]) VALUES (2, N'Giảng viên', CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), N'')
INSERT [dbo].[job_position] ([idJob], [job_position], [timestart], [timeend], [note]) VALUES (3, N'Sinh viên', CAST(N'08:00:00' AS Time), CAST(N'17:30:00' AS Time), N'')
INSERT [dbo].[job_position] ([idJob], [job_position], [timestart], [timeend], [note]) VALUES (4, N'Bảo vệ ', CAST(N'06:00:00' AS Time), CAST(N'18:00:00' AS Time), N'')
INSERT [dbo].[job_position] ([idJob], [job_position], [timestart], [timeend], [note]) VALUES (5, N'duc', CAST(N'07:00:00' AS Time), CAST(N'10:00:00' AS Time), N'123')
GO
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (1, N'ADMIN SYSTEM', N'admin', N'admin1', N'$2b$12$8un4MJ2yrRysaLUMkRwc8uaeE8FgcCJ/ahtUlFMLY0xB.IESt4ZXG', N'ductm201@gmail.com', N'admin sieu cap vip pro', N'ADMIN')
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (2, N'Giảng viên Demo', N'admin', N'admin2', N'$2b$12$LhtwxAlA6C2RhUOjwZHSt.VRAgrX.Cbpn3IKCW7BCxMHL1RyZslAC', N'ducpctn@gmail.com', N'Giảng viên demo', N'Giảng viên')
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (3, N'Sinh viên demo', N'user', NULL, NULL, N'sinhviendemo@gmail.com', N'sinh vien demo', N'Sinh viên')
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (4, N'Bảo vệ demo', N'user', NULL, NULL, N'baovedemo@gmail.com', N'bảo vệ demo', N'Bảo vệ')
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (5, N'duc', N'user', NULL, NULL, N'', N'ducdeptraivcl', N'duc')
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (6, N'thaitran', N'admin', N'thaitran', N'$2b$12$ONsBBO6OharplxA.vbjCN.SdtVhL/ZxtInCBWbMjdiKC9bEVer7Yu', N'tranthai30102002@gmail.com', N'thai gay', N'Bảo vệ ')
INSERT [dbo].[user_manager] ([UserID], [Name], [Role], [Username], [Password], [Email], [Note], [job_position]) VALUES (7, N'vst', N'admin', N'vst', N'$2b$12$GgDFbOGUKEj9LQAn3tP3kewGXDJvGgLCsMhstXhhX6aojflNAoPli', N'vst.hau@gmail.com', N'', N'ADMIN')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [uq_job_position]    Script Date: 25/11/2024 11:51:22 AM ******/
ALTER TABLE [dbo].[job_position] ADD  CONSTRAINT [uq_job_position] UNIQUE NONCLUSTERED 
(
	[job_position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[attention_manager]  WITH CHECK ADD  CONSTRAINT [fk_attention_manager_userid] FOREIGN KEY([UserID])
REFERENCES [dbo].[user_manager] ([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[attention_manager] CHECK CONSTRAINT [fk_attention_manager_userid]
GO
ALTER TABLE [dbo].[user_manager]  WITH CHECK ADD  CONSTRAINT [fk_user_manager_job_position] FOREIGN KEY([job_position])
REFERENCES [dbo].[job_position] ([job_position])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[user_manager] CHECK CONSTRAINT [fk_user_manager_job_position]
GO
USE [master]
GO
ALTER DATABASE [face_recognition] SET  READ_WRITE 
GO
