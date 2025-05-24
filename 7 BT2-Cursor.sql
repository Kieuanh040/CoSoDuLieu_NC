use master
if exists (select * from sysdatabases where name ='BTSTOREPROCEDURE2')
    drop database BTSTOREPROCEDURE2
GO
create database BTSTOREPROCEDURE2
GO
use BTSTOREPROCEDURE2

create TABLE KHACHHANG(
    MaKH char(5) primary key,
    HoTen NVARCHAR(30),
    LoaiKH nvarchar(20)
)
create TABLE MUAHANG(
    MaKH char(5) foreign key references KHACHHANG(MaKH),
    MASP char(3),
	SoLuong int,
    DonGia money,
	primary key (MAKH, MASP)
)

INSERT INTO KHACHHANG
VALUES 
    ('KH01', N'Lý Minh Thanh', NULL),
    ('KH02', N'Nguyễn Minh Tính', NULL)
INSERT INTO MUAHANG
VALUES 
    ('KH01', 'SP1', 10, 5000),
    ('KH02', 'SP2', 10, 6000),
	('KH02', 'SP1', 10, 9000)

select * from khachhang
select * from MUAHANG

DECLARE cr_KHACHHANG CURSOR FORWARD_ONLY SCROLL_LOCKS
FOR SELECT makh FROM KHACHHANG
DECLARE @makh char(5)
DECLARE @tongtien money
DECLARE @loaikh nvarchar(20)

OPEN cr_KHACHHANG
FETCH NEXT FROM cr_KHACHHANG into @makh
WHILE @@FETCH_STATUS = 0
BEGIN
    select @tongtien = sum(soluong*dongia)
    from MUAHANG
    where makh=@makh 
    if @tongtien>90000
        set @loaikh = N'VIP'
    else
        set @loaikh = N'Thành viên'
    UPDATE KHACHHANG
    Set LoaiKH = @loaikh
    where makh=@makh
    FETCH NEXT FROM cr_KHACHHANG into @makh
END
CLOSE cr_KHACHHANG
DEALLOCATE cr_KHACHHANG

select * from khachhang