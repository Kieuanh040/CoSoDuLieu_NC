use master
if exists (select * from sysdatabases where name ='BTSTOREPROCEDURE1')
    drop database BTSTOREPROCEDURE1
GO
create database BTSTOREPROCEDURE1
GO
use BTSTOREPROCEDURE1

create TABLE NHANVIEN(
    MaNV char(5) primary key,
    HoTen NVARCHAR(30),
    SoGio int,
    Thuong nvarchar(20)
)
INSERT INTO NHANVIEN
VALUES 
    ('NV01', N'Lý Minh Thanh', 60, NULL),
    ('NV02', N'Nguyễn Minh Tính', 30, NULL),
    ('NV03', N'Lê Đại Nguyên', 45, NULL)

select * from NHANVIEN
--Cập nhật cột Thưởng là "Có thưởng" nếu số giờ làm việc trên 50 
--còn lại thì cập nhật là "Không có thưởng" sử dụng con trỏ
DECLARE cr_NHANVIEN CURSOR FORWARD_ONLY
FOR SELECT MANV, SOGIO FROM NHANVIEN

DECLARE @manv char(5)
DECLARE @sogio int
DECLARE @thuong nvarchar(20)
OPEN cr_NHANVIEN
FETCH NEXT FROM cr_NHANVIEN into @manv, @sogio
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @sogio>50
        set @thuong=N'Có thưởng'
    ELSE
        set @thuong=N'Không thưởng'
    UPDATE NHANVIEN SET thuong = @thuong WHERE manv=@manv
    FETCH NEXT FROM cr_NHANVIEN into @manv, @sogio
END
CLOSE cr_NHANVIEN
DEALLOCATE cr_NHANVIEN
select * from NHANVIEN




