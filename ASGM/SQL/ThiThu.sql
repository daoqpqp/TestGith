-- Câu 1 (1.5 điểm): Tạo cơ sở dữ liệu DATHANG gồm 3 bảng. 
-- MATHANG (MaH, TenH, LoaiH, SLHangTon)
-- DONHANG (SoDH, NgayDH, NgayGH)


CREATE DATABASE DATHANG;
go
use DATHANG;
go

CREATE TABLE MATHANG
(
    MaH int PRIMARY KEY IDENTITY,
    TenH NVARCHAR(100) not null,
    LoaiH NVARCHAR(100) NOT null,
    SLHangTon NVARCHAR(100) not NULL
);

CREATE TABLE DONHANG
(
    SoDH int PRIMARY KEY IDENTITY,
    NgayDH date,
    NgayGH date,
);
-- CTDH (SoDH, MaH, SoLuong, DonGia)
CREATE TABLE CTDH
(
    SoDH int NOT null,
    MaH int NOT null,
    SoLuong int NOT null,
    DonGia FLOAT not NULL
);

ALTER TABLE CTDH
ADD CONSTRAINT SoDH_PK
FOREIGN KEY (SoDH)
REFERENCES DONHANG(SoDH)

ALTER TABLE CTDH
ADD CONSTRAINT MaH_PK
FOREIGN KEY (MaH)
REFERENCES MATHANG(MaH)

-- Câu 2 (3 điểm): Chèn thông tin vào các bảng
-- Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp.
-- SP thứ nhất thực hiện chèn dữ liệu vào bảng MATHANG.
-- SP thứ hai thực hiện chèn dữ liệu vào bảng DONHANG.
-- SP thứ ba thực hiện chèn dữ liệu vào bảng CTDH.
-- Yêu cầu mỗi SP phải kiểm tra tham số đầu vào. Với các 
-- cột không chấp nhận thuộc tính Null.
-- Với mỗi SP viết 3 lời gọi thành công.
IF OBJECT_ID('CRUD_MATHANG') IS NOT NULL
DROP PROC CRUD_MATHANG
GO
CREATE PROC CRUD_MATHANG
(
    @MaH INTEGER,
    @tenH NVARCHAR(100),
    @loaiH NVARCHAR(100),
    @SLhangTon NVARCHAR(100),
    @TypeMH NVARCHAR(50)
)
AS
IF @tenH IS NULL OR @loaiH IS NULL OR @SLhangTon IS NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE 
BEGIN 
    IF(@TypeMH = 'INSERT')
    BEGIN
        INSERT INTO MATHANG(TenH, LoaiH, SLHangTon)
        VALUES (@tenH, @loaiH, @SLhangTon)
    END
    IF(@TypeMH = 'SELECT')
    BEGIN
        INSERT INTO MATHANG(TenH, LoaiH, SLHangTon)
        VALUES (@tenH, @loaiH, @SLhangTon)
    END
END

EXEC CRUD_MATHANG @MaH = '0', @tenH = N'LapTop', @loaiH = 'A', @SLhangTon = '4', @TypeMH = 'INSERT'
EXEC CRUD_MATHANG @MaH = '0', @tenH = N'Quạt', @loaiH = 'B', @SLhangTon = '6', @TypeMH = 'INSERT'
EXEC CRUD_MATHANG @MaH = '0', @tenH = N'Iphone', @loaiH = 'C', @SLhangTon = '7', @TypeMH = 'INSERT'

select * FROM MATHANG
DELETE from MATHANG WHERE MaH = 6


IF OBJECT_ID('CRUD_DONHANG') IS NOT NULL
DROP PROC CRUD_DONHANG
GO
CREATE PROC CRUD_DONHANG
(
    @soDH INTEGER,
    @ngayDH date,
    @ngayGH date,
    @TypeDH NVARCHAR(50)
)
AS
IF @ngayDH IS NULL OR @ngayGH IS NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE 
BEGIN 
    IF(@TypeDH = 'INSERT')
    BEGIN
        INSERT INTO DONHANG(NgayDH, NgayGH)
        VALUES (@ngayDH, @ngayGH)
    END
END

EXEC CRUD_DONHANG @soDH = '0', @ngayDH = '2022-2-20', @ngayGH = '2022-2-25', @TypeDH = 'INSERT'
EXEC CRUD_DONHANG @soDH = '0', @ngayDH = '2022-2-25', @ngayGH = '2022-2-28', @TypeDH = 'INSERT'
EXEC CRUD_DONHANG @soDH = '0', @ngayDH = '2022-3-10', @ngayGH = '2022-3-15', @TypeDH = 'INSERT'

select * FROM DONHANG

IF OBJECT_ID('CRUD_CTDH') IS NOT NULL
DROP PROC CRUD_CTDH
GO
CREATE PROC CRUD_CTDH
(
    @soDH INTEGER,
    @MaH INTEGER,
    @soluong INTEGER,
    @donGia FLOAT,
    @TypeCTDH NVARCHAR(50)
)
AS
IF @soDH IS NULL OR @MaH IS NULL OR @soluong IS NULL OR @donGia is NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE 
BEGIN 
    IF(@TypeCTDH = 'INSERT')
    BEGIN
        INSERT INTO CTDH(SoDH, MaH, SoLuong, DonGia)
        VALUES (@soDH, @MaH, @soluong, @donGia)
    END
END

EXEC CRUD_CTDH @soDH = 1, @MaH = 1, @soluong = 6 , @donGia = 1000000 , @TypeCTDH = 'INSERT'
EXEC CRUD_CTDH @soDH = 3, @MaH = 3, @soluong = 6 , @donGia = 6000000 , @TypeCTDH = 'INSERT'
EXEC CRUD_CTDH @soDH = 1, @MaH = 1, @soluong = 5 , @donGia = 4000000 , @TypeCTDH = 'INSERT'
EXEC CRUD_CTDH @soDH = 1, @MaH = 7, @soluong = 3 , @donGia = 2000000 , @TypeCTDH = 'INSERT'
EXEC CRUD_CTDH @soDH = 3, @MaH = 8, @soluong = 8 , @donGia = 3000000 , @TypeCTDH = 'INSERT'
EXEC CRUD_CTDH @soDH = 2, @MaH = 7, @soluong = 4 , @donGia = 5000000 , @TypeCTDH = 'INSERT'


select * FROM CTDH

-- Câu 4 (1.5 điểm): Tạo View 
-- Tạo View lưu thông tin của TOP 2 có giá trị đơn hàng lớn nhất, 
-- gồm các thông tin sau: SoDH, NgayDH, NgayGH, “Tổng giá trị đơn hàng”,” 
-- Tổng số lượng mặt hàng trong đơn” 
GO
create VIEW VIEW_GiaTriDonHang
AS
SELECT TOP 2 DONHANG.SoDH, 
DONHANG.NgayDH,
DONHANG.NgayGH,
SUM(CTDH.SoLuong) * SUM(CTDH.DonGia) AS N'Tổng giá trị đơn hàng',
SUM(CTDH.SoLuong) AS N'Tổng số lượng mặt hàng trong đơn'
FROM CTDH
INNER JOIN DONHANG 
ON DONHANG.SoDH = CTDH.SoDH
INNER JOIN MATHANG
ON MATHANG.MaH = CTDH .MaH
GROUP BY DONHANG.SoDH, DONHANG.NgayDH, DONHANG.NgayGH
ORDER BY SUM(CTDH.SoLuong) * SUM(CTDH.DonGia) DESC
GO

SELECT * FROM VIEW_GiaTriDonHang

-- Viết một SP nhận một tham số đầu vào là SLHangTon. 
-- SP này thực hiện thao tác sửa thông tất cả số lượng hàng tồn tương ứng thành số lượng nhập vào.
GO
ALTER PROC CRUD_SLHangTon
@SLHangTon INTEGER
AS
UPDATE MATHANG SET TenH = N'Tủ lạnh' WHERE @SLHangTon
GO

EXEC CRUD_SLHangTon  = 4


-- Viết một hàm kiểm tra số lượng hàng tồn với đầu vào là MaH, 
-- Nếu 0 đến  <5 thì trả về “Sắp hết hàng” và từ 5 đến 20 là “Còn Nhiều Hàng” 
-- và các trường hợp còn laị là “ FPOLY”
GO 
CREATE FUNCTION FUNCTION_KiemTra (@MaH int)
RETURNS INT
as
BEGIN
    IF soLuo
END