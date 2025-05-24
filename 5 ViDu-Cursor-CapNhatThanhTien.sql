use master
if exists (select * from sysdatabases where name ='VDCAPNHATTHANHTIEN')
    drop database VDCAPNHATTHANHTIEN
GO
create database VDCAPNHATTHANHTIEN
GO
use VDCAPNHATTHANHTIEN

create TABLE MATHANG(
    MaMH char(5) primary key,
    TenMH NVARCHAR(30),
    DVT nVarChar(10)
)
create table PHIEUNHAP(
    MaPN char(5) primary key,
    NgayNhap Date,
    ThanhTien money
)
create table CTPHIEUNHAP(
    MaMH char(5) foreign key references MATHANG(MaMH),
    MaPN char(5) foreign key references PHIEUNHAP(MaPN),
    SLNhap int,
    DonGia int,
    primary key (MaMH, MaPN)
)
INSERT INTO MATHANG
VALUES 
    ('MH001', N'Bút bi', N'Cây'),
    ('MH002', N'Tủ lạnh', N'Cái'),
    ('MH003', N'Tập học sinh', N'Cuốn')
INSERT INTO PHIEUNHAP
VALUES
    ('PN001', '20230330', NULL),
    ('PN002', '20230410', NULL),
    ('PN003', '20230513', NULL)
INSERT INTO CTPHIEUNHAP
VALUES
    ('MH001', 'PN001', 200, 10000),
    ('MH002', 'PN002', 5, 10000000),
    ('MH003', 'PN003', 10, 15000),
    ('MH001', 'PN003', 20, 10000)
select * from PHIEUNHAP
select * from CTPHIEUNHAP

DECLARE cr_PHIEUNHAP CURSOR FORWARD_ONLY
FOR SELECT MaPN FROM PHIEUNHAP

OPEN cr_PHIEUNHAP

DECLARE @mapn char(5)
DECLARE @tongtien money
FETCH NEXT FROM cr_PHIEUNHAP into @mapn

WHILE @@FETCH_STATUS = 0
BEGIN
    select @tongtien = sum(slnhap*dongia)
    from CTPHIEUNHAP
    where MaPN = @mapn

    UPDATE PHIEUNHAP
    SET ThanhTien = @tongtien
    WHERE MaPN = @mapn 
    FETCH NEXT FROM cr_PHIEUNHAP into @mapn
END
CLOSE cr_PHIEUNHAP
DEALLOCATE cr_PHIEUNHAP

select * from PHIEUNHAP