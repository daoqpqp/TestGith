IF OBJECT_ID(CRUD_DongSanPham) 
DROP PROC CRUD_DongSanPham
GO
CREATE PROC CRUD_DongSanPham
(@idDSP INTEGER,
@maDSP NVARCHAR(100),
@tenDSP NVARCHAR(100),
@WebDSP NVARCHAR(200),
@TypeDSP NVARCHAR(20)
)
AS
IF @maDSP is NULL OR @tenDSP is NULL OR @WebDSP IS NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE
BEGIN
    IF (@TypeDSP = 'INSERT')
    BEGIN
        INSERT INTO dongsanpham(MaDongSanPham,TenDongSanPham,WebsiteDongSanPham)
        VALUES (@maDSP, @tenDSP, @WebDSP)
    END
    IF (@TypeDSP = 'SELECT')
    BEGIN
        SELECT * FROM dongsanpham
    END
END

IF OBJECT_ID('CRUD_KhachHanggg') IS NOT NULL
DROP PROC CRUD_KhachHanggg
GO
CREATE PROC CRUD_KhachHanggg
(
    @IDKH integer,
    @MaKH NVARCHAR(100),
    @TenHoKH NVARCHAR(100),
    @TenDemKH NVARCHAR(100),
    @TenKH NVARCHAR(100),
    @NgaySinh date,
    @SodienThoai NVARCHAR(100),
    @DiaChi1 NVARCHAR(100),
    @DiaChi2 NVARCHAR(100),
    @GioiTinh NVARCHAR(100),
    @ThanhPho NVARCHAR(100),
    @TypeKH VARCHAR(100)
)
AS 
IF @MaKH IS NULL OR @MaKH IS NULL OR @TenHoKH IS NULL OR @TenDemKH IS NULL OR @TenKH IS NULL OR @NgaySinh IS NULL OR
@SodienThoai IS NULL OR @DiaChi1 IS NULL OR @GioiTinh IS NULL OR @ThanhPho IS NULL
PRINT N'Vui lòng nhập đủ dữ liệu'
ELSE
BEGIN
    IF(@TypeKH = 'INSERT')
    BEGIN 
        INSERT INTO khachhang(MaKhachHang, TenHoKH, TenDemKH, TenKH, NgaySinh, SoDienThoai, DiaChi1, DiaChi2, GioiTinh, ThanhPho)
        VALUES (@MaKH, @TenHoKH, @TenDemKH, @TenKH, @NgaySinh, @SodienThoai, @DiaChi1, @DiaChi2, @GioiTinh, @ThanhPho)
    END
    IF(@TypeKH = 'SELECT')
    BEGIN
        SELECT * FROM khachhang
    END
END

EXEC CRUD_KhachHang @IDKH = '0', @MaKH = null, @TenHoKH = N'Nguyễn', @TenDemKH = N'Văn', @TenKH = N'Đạo', 
@NgaySinh = '2000-9-09', @SodienThoai = '0962609301',
@DiaChi1 = N'Tuyên Quang', @DiaChi2 = N'Hà Nội', @GioiTinh = 'Nam', @ThanhPho = 'Hà Nội', @TypeKH = 'INSERT'













-- Câu 1 ( 3 điểm): Chèn thông tin vào các bảng
-- Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp.
-- SP thứ hai thực hiện chèn dữ liệu vào bảng DongSanPham.
-- SP thứ ba thực hiện chèn dữ liệu vào bảng KhachHang.
-- Yêu cầu mỗi SP phải kiểm tra tham số đầu vào. Đối với bảng KhachHang phải check 
-- [MaKhachHang] ,[TenHoKH] ,[TenDemKH] ,[TenKH]    ,[NgaySinh] ,[SoDienThoai] ,[DiaChi1] ,[DiaChi2] ,
-- [GioiTinh]    ,[ThanhPho] khác null. Bảng DongSanPham Check [MaDongSanPham] và [TenDongSanPham] khác null.
-- Với mỗi SP viết 2 lời gọi thành công.
