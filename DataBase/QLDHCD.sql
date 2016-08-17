use master
if exists (SELECT *
			FROM sys.databases
			WHERE name = 'QLDHCD')
	DROP DATABASE QLDHCD
go
Create database QLDHCD
go
use QLDHCD
go
SET DATEFORMAT dmy;  

----TAO BANG--------------------------------------------------------------------
Create table DHCD (
	MADH NVARCHAR(10) PRIMARY KEY,
	TenDH nvarchar(100),
	nQKin int DEFAULT 0,
	nQBefore int DEFAULT 0,
	nDeCuHDQT int DEFAULT 0,
	nUngCuHDQT int DEFAULT 0,
	nDeCuBKS int DEFAULT 0,
	nUngCuBKS int DEFAULT 0,
	thoiGian Date,
	ACTIVE INT DEFAULT 0,
	TONGSOPHIEU INT DEFAULT 0,
	CONSTRAINT CHK_DHCD_ACTIVE CHECK (ACTIVE IN (0,1)),
	CONSTRAINT chk_DHCD CHECK (nQKin>=0 and nQBefore >=0 and nDeCuHDQT >=0 and nUngCuHDQT>=0 and nDeCuBKS>=0 and nUngCuBKS>=0 AND TONGSOPHIEU >=0)
)
go

create table CODONG (
	MACD int IDENTITY(1,1) PRIMARY KEY,
	HoTen nvarchar(100),
	CMND int,
	NgayCap nvarchar(25),
	NoiCap nvarchar(100),
	DiaChi nvarchar(100),
	QuocTich nvarchar(50)  ,
	ChucVu nvarchar(50),
	Email nvarchar(100),
	SDT nvarchar(20),
	TrinhDoVanHoa NVARCHAR(100),
	TrinhDoChuyenMon NVARCHAR(100),
	ANHCD NVARCHAR(255)
)
GO
CREATE TABLE CT_DHCD(
	MADH NVARCHAR(10) NOT NULL,
	MACD INT NOT NULL,
	SLCP INT DEFAULT 0,
	SLDAUQ INT DEFAULT 0,
	SLDCUQ INT DEFAULT 0,
	HTDK NVARCHAR(50),
	SLCPSAUCUNG INT DEFAULT 0,
	QUYENBAUCU INT DEFAULT 0,
	CONSTRAINT PK_DH_CD PRIMARY KEY (MADH,MACD),
	CONSTRAINT CK_DH_CD CHECK (SLCP>=0 AND SLDAUQ>=0 AND SLDCUQ>=0 AND SLCPSAUCUNG>=0 AND QUYENBAUCU IN (0,1))
)
GO

CREATE TABLE UYQUYEN(
	MAUQ INT IDENTITY(1,1) PRIMARY KEY, 
	MADH NVARCHAR(10) NOT NULL,
	MANGCHUYEN INT NOT NULL,
	MANGNHAN INT NOT NULL,
	SLUQ INT DEFAULT 0,
	THOIGIAN DATE DEFAULT GETDATE(),
	CONSTRAINT CK_CTUQ CHECK (SLUQ >=0)
)

GO
CREATE TABLE	BANGBAUHDQT
(
	MADH NVARCHAR(10) NOT NULL,
	MACD INT NOT NULL,
	HINHTHUCBAU NVARCHAR(20),
	SLPHIEUBAU INT DEFAULT 0,
	
	CONSTRAINT CHK_BANGBAUHDQT CHECK (SLPHIEUBAU>=0),
	CONSTRAINT PK_BANGBAUHDQT PRIMARY KEY (MADH,MACD)
)
GO
CREATE TABLE CT_BAUHDQT
(
	MACT INT IDENTITY(1,1) PRIMARY KEY,
	MADH NVARCHAR(10),
	MANGDUOCBAU INT,
	MANGDIBAU INT,
	SLPHIEUBAU INT DEFAULT 0,
	HINHTHUCBAU NVARCHAR(50),
	THOIGIANBAU DATETIME DEFAULT GETDATE(),
	CONSTRAINT CHK_CT_BAUHDQT CHECK (SLPHIEUBAU >=0)
)
GO
CREATE TABLE BANGBAUBKS
(
	MADH NVARCHAR(10) NOT NULL,
	MACD INT NOT NULL,
	HINHTHUCBAU NVARCHAR(20),
	SLPHIEUBAU INT DEFAULT 0,
	
	CONSTRAINT CHK_BANGBAUBKS CHECK (SLPHIEUBAU >=0),
	CONSTRAINT PK_BANGBAUBKS PRIMARY KEY (MADH,MACD)
)
GO
CREATE TABLE CT_BAUBKS
(
	MACT INT IDENTITY(1,1) PRIMARY KEY,
	MADH NVARCHAR(10),
	MANGDUOCBAU INT,
	MANGDIBAU INT,
	SLPHIEUBAU INT DEFAULT 0,
	HINHTHUCBAU NVARCHAR(50),
	THOIGIANBAU DATETIME DEFAULT GETDATE(),
	
	CONSTRAINT CK_CT_BAUBKS CHECK (SLPHIEUBAU >=0)
)
GO
CREATE TABLE BANGYKIEN
(
	MAYK INT IDENTITY(1,1) PRIMARY KEY,
	MADH NVARCHAR(10),
	NOIDUNG NVARCHAR(500),
	SLDONGY INT DEFAULT 0,
	SLKHONGDONGY INT DEFAULT 0,
	SLYKKHAC INT DEFAULT 0,
	
	CONSTRAINT CHK_BANGYKIEN CHECK (SLDONGY >=0 AND SLKHONGDONGY >=0 AND SLYKKHAC >=0)
)

GO
CREATE TABLE CTBQYKIEN
(
	MAYK INT NOT NULL,
	MADH NVARCHAR(10),
	MACD INT NOT NULL,
	LUACHON INT DEFAULT 0,
	SLPHIEUBAU int default 0,
	NOIDUNGYKKHAC NVARCHAR(500),
	THOIGIANBAU DATETIME DEFAULT GETDATE(),
	
	CONSTRAINT CHK_CTBQYKIEN CHECK ( LUACHON IN (-1,0,1) and SLPHIEUBAU >=0),
	CONSTRAINT PK_CTBQYKIEN PRIMARY KEY (MAYK,MACD)
)
GO

 	
	
	
------KHOA NGOAI-----------------------------------------------------------------

ALTER TABLE CT_DHCD ADD CONSTRAINT FK_DH_CD1 FOREIGN KEY (MADH) REFERENCES DHCD(MADH);
ALTER TABLE CT_DHCD ADD CONSTRAINT FK_DH_CD2 FOREIGN KEY (MACD) REFERENCES CODONG(MACD);

ALTER TABLE UYQUYEN ADD CONSTRAINT FK_CTUQ1 FOREIGN KEY (MADH,MANGCHUYEN) REFERENCES CT_DHCD(MADH,MACD);
ALTER TABLE UYQUYEN ADD CONSTRAINT FK_CTUQ2 FOREIGN KEY (MADH,MANGNHAN) REFERENCES CT_DHCD(MADH,MACD);


ALTER TABLE BANGBAUHDQT ADD CONSTRAINT FK_BBHDQT_CTDHCD FOREIGN KEY (MADH,MACD) REFERENCES CT_DHCD(MADH,MACD);

ALTER TABLE BANGBAUBKS ADD CONSTRAINT FK_BBBKS_CTDHCD FOREIGN KEY(MADH,MACD) REFERENCES CT_DHCD (MADH,MACD);

ALTER TABLE CT_BAUHDQT ADD CONSTRAINT FK_CTBHDQT_BBHDQT FOREIGN KEY (MADH,MANGDUOCBAU) REFERENCES BANGBAUHDQT(MADH,MACD);
ALTER TABLE CT_BAUHDQT ADD CONSTRAINT FK_CTBHDQT_CTDHCD FOREIGN KEY (MADH,MANGDIBAU) REFERENCES CT_DHCD(MADH,MACD);

ALTER TABLE CT_BAUBKS ADD CONSTRAINT FK_CTBBKS_BBBKS FOREIGN KEY (MADH,MANGDUOCBAU) REFERENCES BANGBAUBKS(MADH,MACD);
ALTER TABLE CT_BAUBKS ADD CONSTRAINT FK_CTBBKS_CTDHCD FOREIGN KEY (MADH,MANGDIBAU) REFERENCES CT_DHCD(MADH,MACD);

ALTER TABLE BANGYKIEN ADD CONSTRAINT FK_BYKIEN_DHCD FOREIGN KEY (MADH) REFERENCES DHCD(MADH);

ALTER TABLE CTBQYKIEN ADD CONSTRAINT FK_CTYK_BYKIEN FOREIGN KEY (MAYK) REFERENCES BANGYKIEN(MAYK);
ALTER TABLE CTBQYKIEN ADD CONSTRAINT FK_CTYK_CTDHCD FOREIGN KEY (MADH,MACD) REFERENCES CT_DHCD(MADH,MACD);

GO

-------INSERT VALUE-------------------------------------------------------------

INSERT [dbo].[DHCD] ([MADH], [TenDH], [nQKin], [nQBefore], [nDeCuHDQT], [nUngCuHDQT], [nDeCuBKS], [nUngCuBKS], [thoiGian], [ACTIVE], [TONGSOPHIEU]) VALUES (N'DHCD20161', N'Đại hội cổ đông lần 1 năm 2015', 0, 0, 0, 0, 0, 0, CAST(0xDB3A0B00 AS Date), 0, 0)
INSERT [dbo].[DHCD] ([MADH], [TenDH], [nQKin], [nQBefore], [nDeCuHDQT], [nUngCuHDQT], [nDeCuBKS], [nUngCuBKS], [thoiGian], [ACTIVE], [TONGSOPHIEU]) VALUES (N'DHCD20162', N'Đại hội cổ đông lần 2 năm 2016', 0, 0, 0, 0, 0, 0, CAST(0x363B0B00 AS Date), 0, 0)
INSERT [dbo].[DHCD] ([MADH], [TenDH], [nQKin], [nQBefore], [nDeCuHDQT], [nUngCuHDQT], [nDeCuBKS], [nUngCuBKS], [thoiGian], [ACTIVE], [TONGSOPHIEU]) VALUES (N'DHCD20163', N'Đại hội cổ đông lần 3 năm 2016', 0, 0, 0, 0, 0, 0, CAST(0x913B0B00 AS Date), 1, 0)
  
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật A', 1, N'2016-11-11', N'PY', N'PY', N'VN', N'Cổ đông', N'hnn257@gmail.com', N'111', N'Cử nhân', N'Good', N'https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/734750_1200823609935434_7336946501486872176_n.jpg?oh=0b272b774ed6bc9b9495e0ae8311b303&oe=5821D894')
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật B', 2, N'2016-11-11', N'PY', N'PY', N'VN', N'Cổ đông', N'hnn257@gmail.com', N'223', N'Cử nhân', N'Good', N'https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/11217679_1013769538730543_8388039602550140152_n.jpg?oh=3f8b0b84d91ffcbb793bd738c0114d25&oe=585665F8')
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật C', 4, N'2016-11-11', N'PY', N'PY', N'VN', N'Cổ đông', N'hnn257py@gmail.com', N'111', N'Cử nhân', N'Good', NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật D', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật E', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật F', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật G', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật H', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật I', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh Nhật K', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CODONG] (  [HoTen], [CMND], [NgayCap], [NoiCap], [DiaChi], [QuocTich], [ChucVu], [Email], [SDT], [TrinhDoVanHoa], [TrinhDoChuyenMon], [ANHCD]) VALUES ( N'Huỳnh AB', NULL, NULL, NULL, NULL, N'VN', NULL, NULL, NULL, NULL, NULL, NULL)

INSERT [dbo].[CT_DHCD] ([MADH], [MACD], [SLCP], [SLDAUQ], [SLDCUQ], [HTDK], [SLCPSAUCUNG], [QUYENBAUCU]) VALUES (N'DHCD20163', 1, 34000, 0, 0, N'Trực tiếp', 0, 1)
INSERT [dbo].[CT_DHCD] ([MADH], [MACD], [SLCP], [SLDAUQ], [SLDCUQ], [HTDK], [SLCPSAUCUNG], [QUYENBAUCU]) VALUES (N'DHCD20163', 3, 30000, 0, 0, N'Trực tiếp', 0, NULL)
INSERT [dbo].[CT_DHCD] ([MADH], [MACD], [SLCP], [SLDAUQ], [SLDCUQ], [HTDK], [SLCPSAUCUNG], [QUYENBAUCU]) VALUES (N'DHCD20163', 4, 35000, 0, 0, N'Trực tiếp', 0, 0)
INSERT [dbo].[CT_DHCD] ([MADH], [MACD], [SLCP], [SLDAUQ], [SLDCUQ], [HTDK], [SLCPSAUCUNG], [QUYENBAUCU]) VALUES (N'DHCD20163', 5, 2, 0, 0, N'Gian TIep', 0, 0)

INSERT [dbo].[UYQUYEN] ( [MADH], [MANGCHUYEN], [MANGNHAN], [SLUQ], [THOIGIAN]) VALUES ( N'DHCD20163', 1, 1, 5000, CAST(0xB83B0B00 AS Date))
INSERT [dbo].[UYQUYEN] ( [MADH], [MANGCHUYEN], [MANGNHAN], [SLUQ], [THOIGIAN]) VALUES ( N'DHCD20163', 3, 5, 3434, CAST(0xB83B0B00 AS Date))

INSERT [dbo].[BANGBAUHDQT] ([MADH], [MACD], [HINHTHUCBAU], [SLPHIEUBAU]) VALUES (N'DHCD20163', 1, N'Ứng cử', 0)
INSERT [dbo].[BANGBAUHDQT] ([MADH], [MACD], [HINHTHUCBAU], [SLPHIEUBAU]) VALUES (N'DHCD20163', 3, N'Ứng cử', 0)
INSERT [dbo].[BANGBAUHDQT] ([MADH], [MACD], [HINHTHUCBAU], [SLPHIEUBAU]) VALUES (N'DHCD20163', 4, N'Ứng cử', 0)
INSERT [dbo].[BANGBAUHDQT] ([MADH], [MACD], [HINHTHUCBAU], [SLPHIEUBAU]) VALUES (N'DHCD20163', 5, N'Ứng cử', 0)

INSERT [dbo].[BANGBAUBKS] ([MADH], [MACD], [HINHTHUCBAU], [SLPHIEUBAU]) VALUES (N'DHCD20163', 1, N'Ứng cử', 0)
INSERT [dbo].[BANGBAUBKS] ([MADH], [MACD], [HINHTHUCBAU], [SLPHIEUBAU]) VALUES (N'DHCD20163', 3, N'Gián tiếp', 0)

