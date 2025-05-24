use master
if exists (select * from sysdatabases where name ='VDCURSOR')
    drop database VDCURSOR
GO
create database VDCURSOR
GO
use VDCURSOR

create TABLE NHANVIEN(
    MaNV char(4) primary key,
    HoTen NVARCHAR(30),
    NgaySinh DATE,
    Luong INT
)
INSERT INTO NHANVIEN
VALUES 
    ('NV01', N'Nguyễn Văn An', '19950101', 500000),
    ('NV02', N'Lê Thị Thuý', '19980202', 700000),
    ('NV03', N'Trần Thế Danh', '19970905', 900000)


--Bước 1: Khai báo con trỏ 
DECLARE cr_NHANVIEN CURSOR SCROLL STATIC READ_ONLY 
FOR SELECT MaNV, HoTen FROM NHANVIEN
--Bước 2: Mở con trỏ
OPEN cr_NHANVIEN
--Bước 3: Xử lý từng dòng
DECLARE @manv char(4)
DECLARE @hoten nvarchar(30)
FETCH FIRST FROM cr_NHANVIEN into @manv, @hoten
WHILE @@FETCH_STATUS = 0
BEGIN
    print @manv
    print @hoten
    FETCH NEXT FROM cr_NHANVIEN into @manv, @hoten 
END
--Bước 4: Đóng và huỷ con trỏ
CLOSE cr_NHANVIEN
DEALLOCATE cr_NHANVIEN

