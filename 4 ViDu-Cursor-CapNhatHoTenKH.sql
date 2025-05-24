use master
if exists (select * from sysdatabases where name ='VDCURSOR')
    drop database VDCURSOR
GO
create database VDCURSOR
GO
use VDCURSOR

create TABLE KHACHHANG(
    MaKH char(5) primary key,
    HoTen NVARCHAR(30),
    DiaChi nVarChar(50),
    SDT char(10),
    Email varchar(20), 
    GioiTinh nchar(3)
)

create table HOADON(
    MaHD char(4) primary key,
    HoTenKH nvarchar(30),
    TenSP nvarchar(30),
    SoLuong int,
    DonGia int,
    MaKH char(5) foreign key references KHACHHANG (MaKH)
)
INSERT INTO KHACHHANG
VALUES 
    ('KH001', N'Nguyễn Văn An', N'33 Lạc Long Quân', '0987555444', 'an@gmail.com', 'Nam'),
    ('KH002', N'Nguyễn Công Bình', N'45 Hồ Tùng Mậu', '0987666333', 'binh@gmail.com', N'Nữ'),
    ('KH003', N'Đào Thế Chánh', N'765 Lê Lai', '0934666777', 'chanh@gmail.com', 'Nam')

INSERT INTO HOADON
VALUES
    ('HD01', N'Lê Công Minh', N'Sting Dâu', 240, 7000, NULL),
    ('HD02', N'Nguyễn Thái Bình', N'Pepsi', 500, 5000, 'KH002'),
    ('HD03', N'Đào Thế Chánh', N'Mirinda Cam', 450, 6000, 'KH003')

select * from khachhang
select * from hoadon

DECLARE cr_KHACHHANG CURSOR SCROLL STATIC READ_ONLY
FOR SELECT MaKH, HoTen FROM KHACHHANG

OPEN cr_KHACHHANG

DECLARE @makh char(5)
DECLARE @hoten nvarchar(30)
FETCH FIRST FROM cr_KHACHHANG into @makh, @hoten

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE HOADON
    SET HoTenKH = @hoten
    WHERE MaKH = @makh 
    FETCH NEXT FROM cr_KHACHHANG into @makh, @hoten
END
CLOSE cr_KHACHHANG
DEALLOCATE cr_KHACHHANG

select * from khachhang
select * from hoadon