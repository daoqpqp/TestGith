CREATE DATABASE QuanLyNhanSu;
go
use QuanLyNhanSu;
GO

CREATE TABLE PhongBan(
    maPB int PRIMARY KEY IDENTITY,
    TenPB NVARCHAR(100)
);

CREATE table NhanVien
(
    MaNV int PRIMARY KEY IDENTITY,
    HoTen NVARCHAR(100) NOT null,
    GioiTinh NVARCHAR(100) NOT null,
    Luong FLOAT not NULL,
    maPB INT NOT NULL
);
CREATE table ChamCong(
    MaCong int PRIMARY KEY IDENTITY,
    MaNV int NOT NULL,
    Thang int not NULL,
    soNgayLV INT NOT NULL,
    NgayPhep INT NOT NULL,
    NGKphep INT NOT NULL
);

ALTER TABLE NhanVien
add CONSTRAINT MaPB_PK
FOREIGN KEY (maPB)
REFERENCES PhongBan(maPB)

ALTER TABLE ChamCong
add CONSTRAINT MaNV_PK
FOREIGN KEY (MaNV)
REFERENCES NhanVien(MaNV)


IF OBJECT_ID('CRUD_PhongBan') is NOT NULL
DROP PROC CRUD_PhongBan
GO 
CREATE PROC CRUD_PhongBan
(@maPB INTEGER,
@tenPB NVARCHAR(100)
)as
IF @tenPB is NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE
BEGIN
    INSERT INTO PhongBan
    VALUES (@tenPB)
END

EXEC CRUD_PhongBan @maPB = '0',@tenPB = N'Hòa Phú'
EXEC CRUD_PhongBan @maPB = '0',@tenPB = N'Chiêm hóa'
EXEC CRUD_PhongBan @maPB = '0',@tenPB = N'Tuyên Quang'
EXEC CRUD_PhongBan @maPB = '0',@tenPB = N'Hà Nội'
select * FROM PhongBan


IF OBJECT_ID('CRUD_NhanVien') is NOT NULL
DROP PROC CRUD_NhanVien
GO 
CREATE PROC CRUD_NhanVien
(@maNV INTEGER,
@tenNV NVARCHAR(100),
@gioiTinh NVARCHAR(100),
@Luong FLOAT,
@maPB INTEGER
)as
IF @maNV is NULL OR @tenNV IS NULL OR @gioiTinh IS NULL OR @Luong IS NULL OR @maPB IS NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE
BEGIN
    INSERT INTO NhanVien
    VALUES (@tenNV, @gioiTinh, @Luong,@maPB)
END

EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'Đạo',@gioiTinh = N'Nam', @Luong = '4000000', @maPB = '1'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'Trường',@gioiTinh = N'Nam', @Luong = '5000000', @maPB = '2'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'Toàn',@gioiTinh = N'Nam', @Luong = '4005000', @maPB = '3'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'Hà',@gioiTinh = N'Nữ', @Luong = '6000000', @maPB = '4'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'NgọcA',@gioiTinh = N'Nữ', @Luong = '3000000', @maPB = '1'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'ĐạoB',@gioiTinh = N'Nam', @Luong = '4000000', @maPB = '1'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'TrườngC',@gioiTinh = N'Nam', @Luong = '5000000', @maPB = '2'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'ToànD',@gioiTinh = N'Nam', @Luong = '4005000', @maPB = '3'
EXEC CRUD_NhanVien @maNV = '0', @tenNV = N'HàE',@gioiTinh = N'Nữ', @Luong = '6000000', @maPB = '4'
select * FROM NhanVien

IF OBJECT_ID('CRUD_ChamCong') is NOT NULL
DROP PROC CRUD_ChamCong
GO 
CREATE PROC CRUD_ChamCong
(@maCong INTEGER,
@maNV INTEGER,
@Thang INTEGER,
@SoNgayLV INTEGER,
@NgayPhep INTEGER,
@NGKphep INTEGER
)as
IF @maCong is NULL OR @maNV IS NULL OR @Thang IS NULL OR @SoNgayLV IS NULL OR @NgayPhep IS NULL OR @NGKphep IS NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE
BEGIN
    INSERT INTO ChamCong
    VALUES (@maNV, @Thang, @SoNgayLV, @NgayPhep, @NGKphep)
END

EXEC CRUD_ChamCong @maCong = '0', @maNV = '1', @Thang = '7', @SoNgayLV = '225', @NgayPhep = '20', @NGKphep = '12'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '2', @Thang = '8', @SoNgayLV = '325', @NgayPhep = '12', @NGKphep = '10'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '3', @Thang = '10', @SoNgayLV = '225', @NgayPhep = '22', @NGKphep = '4'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '4', @Thang = '11', @SoNgayLV = '525', @NgayPhep = '12', @NGKphep = '4'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '5', @Thang = '2', @SoNgayLV = '625', @NgayPhep = '18', @NGKphep = '9'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '6', @Thang = '4', @SoNgayLV = '225', @NgayPhep = '12', @NGKphep = '4'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '7', @Thang = '6', @SoNgayLV = '125', @NgayPhep = '24', @NGKphep = '8'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '8', @Thang = '3', @SoNgayLV = '825', @NgayPhep = '12', @NGKphep = '7'
EXEC CRUD_ChamCong @maCong = '0', @maNV = '9', @Thang = '1', @SoNgayLV = '25', @NgayPhep = '15', @NGKphep = '6'

Go
create FUNCTION FNNV(@maNV int)
RETURNS TABLE
as RETURN (SELECT * FROM NhanVien WHERE @maNV = MaNV);
go
SELECT * FROM dbo.FNNV(1)

GO
ALTER PROC XoaMaNV
@tenNV NVARCHAR(100)
as 
BEGIN TRY
    BEGIN TRAN
        DELETE NhanVien WHERE HoTen in(select HoTen from NhanVien WHERE @tenNV = HoTen)
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
END CATCH

EXEC XoaMaNV @tenNV = N'Ngọc'
select * FROM NhanVien