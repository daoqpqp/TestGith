-- Câu 1: Stored Procedure (SP)
--  SP1 Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp có thể thực hiện
-- CRUD được bảng SanPham:
--  SP2 Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp có thể thực hiện
-- CRUD được bảng KhachHang:
-- Yêu cầu mỗi SP khi thêm vào phải kiểm tra tham số đầu vào và đẩy ra lỗi nếu không
-- thỏa mãn.
-- Đối với bảng KhachHang phải check [MaKhachHang] ,[TenHoKH] ,[TenDemKH]
-- ,[TenKH] ,[NgaySinh] ,[SoDienThoai] ,[DiaChi1] ,[DiaChi2] ,[GioiTinh],
-- [ThanhPho] khác null. Check thêm [TenHoKH] ,[TenDemKH] ,[TenKH] phải từ 5
-- ký tự trở lên.
-- Bảng SanPham Check [MaSanPham] và [TenSanPham] khác null.
GO 
ALTER PROC CRUD_SanPham
(@ID integer,
@MaSP NVARCHAR(100),
@TenSP NVARCHAR(100),
@NamBH numeric,
@TrongLuong FLOAT,
@MoTaSP NVARCHAR(100),
@SPton INTEGER,
@giaNhap DECIMAL, 
@GiaBan DECIMAL,
@ID_DSP INTEGER,
@TypeSP VARCHAR(100)
)
AS 
BEGIN
    IF(@TypeSP = 'SELECT')
    BEGIN
        SELECT * FROM sanpham
    END

    IF(@TypeSP = 'INSERT')
    BEGIN
        INSERT INTO sanpham(MaSanPHam, TenSP, NamBaoHanh, TrongLuongSP, MoTaSP, SoLuongSanPhamTon, GiaNhapSP, GiaBanSP, IdDongSanPham)
        VALUES (@MaSP, @TenSP, @NamBH, @TrongLuong, @MoTaSP, @SPton, @giaNhap, @GiaBan, @ID_DSP)
    END

    IF(@TypeSP = 'UPDATE')
    BEGIN
        UPDATE sanpham
        SET MaSanPHam = @MaSP, TenSP = @TenSP, NamBaoHanh = @NamBH, TrongLuongSP = @TrongLuong, MoTaSP = @MoTaSP,
        SoLuongSanPhamTon = @SPton, GiaNhapSP = @giaNhap, GiaBanSP = @GiaBan, IdDongSanPham = @ID_DSP
        WHERE IdSanPham = @ID
    END

    IF(@TypeSP = 'DELETE')
    BEGIN
        DELETE FROM sanpham WHERE MaSanPHam = @MaSP
    END
END


EXEC CRUD_SanPham @ID = 0, @MaSP = '', @TenSP = '', @NamBH = 0, @TrongLuong = 0, @MoTaSP = '', 
@SPton = 0, @giaNhap = 0, @GiaBan = 0, @ID_DSP = 0, @TypeSP = 'SELECT'

EXEC CRUD_SanPham @ID = 0, @MaSP = 'PH18705', @TenSP = N'Đạo', @NamBH = 2035, @TrongLuong = 2.5, @MoTaSP = "3000GB", 
@SPton = 20, @giaNhap = 50000000, @GiaBan = 60000000, @ID_DSP = 5, @TypeSP = 'INSERT'

EXEC CRUD_SanPham @ID = 1, @MaSP = 'H0001', @TenSP = "Đạo", @NamBH = 2025, @TrongLuong = 2.5, @MoTaSP = "3000GB", 
@SPton = 20, @giaNhap = 50000000, @GiaBan = 60000000, @ID_DSP = 1, @TypeSP = 'UPDATE'

EXEC CRUD_SanPham @ID = 9999, @MaSP = 'H0001', @TenSP = '', @NamBH = 0, @TrongLuong = 0, @MoTaSP = '', 
@SPton = 0, @giaNhap = 0, @GiaBan = 0, @ID_DSP = 0, @TypeSP = 'DELETE'

--TRIGGER sản phẩm
GO
ALTER TRIGGER TG_CheckInsert_SP ON sanpham
FOR INSERT
AS 
BEGIN
    IF(SELECT MaSanPHam FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập Mã sản phẩm'
    END
    IF(SELECT TenSP FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập Tên sản phẩm'
    END
    ROLLBACK TRANSACTION
END

EXEC CRUD_SanPham @ID = 0, @MaSP = null, @TenSP = null, @NamBH = 2035, @TrongLuong = 2.5, @MoTaSP = "3000GB", 
@SPton = 20, @giaNhap = 50000000, @GiaBan = 60000000, @ID_DSP = 5, @TypeSP = 'INSERT'
create PROCEDURE
--=====================================================================================================================================
GO 
ALTER PROC CRUD_KhachHang
(@IDKH integer,
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
BEGIN
    IF(@TypeKH = 'SELECT')
    BEGIN
        SELECT * FROM khachhang
    END

    IF(@TypeKH = 'INSERT')
    BEGIN
        INSERT INTO khachhang(MaKhachHang, TenHoKH, TenDemKH, TenKH, NgaySinh, SoDienThoai, DiaChi1, DiaChi2, GioiTinh, ThanhPho)
        VALUES (@MaKH, @TenHoKH, @TenDemKH, @TenKH, @NgaySinh, @SodienThoai, @DiaChi1, @DiaChi2, @GioiTinh, @ThanhPho)
    END
    IF(@TypeKH = 'UPDATE')
    BEGIN
        UPDATE khachhang
        SET MaKhachHang = @MaKH, TenHoKH = @TenHoKH, TenDemKH = TenDemKH, TenKH = @TenKH, NgaySinh = @NgaySinh, SoDienThoai = @SodienThoai,
        DiaChi1 = DiaChi1, DiaChi2 = DiaChi2, GioiTinh = GioiTinh, ThanhPho = @ThanhPho
        WHERE MaKhachHang = @MaKH
    END

    IF(@TypeKH = 'DELETE')
    BEGIN
        DELETE FROM khachhang WHERE MaKhachHang = @MaKH
    END
END

EXEC CRUD_KhachHang @IDKH = '0', @MaKH = '0', @TenHoKH = '', @TenDemKH = '', @TenKH = '', 
@NgaySinh = '', @SodienThoai = '',
@DiaChi1 = '', @DiaChi2 = '', @GioiTinh = '', @ThanhPho = '', @TypeKH = 'SELECT'

EXEC CRUD_KhachHang @IDKH = '0', @MaKH = 'PH18705', @TenHoKH = N'Nguyễn', @TenDemKH = N'Văn', @TenKH = N'Đạo', 
@NgaySinh = '2000-9-09', @SodienThoai = '0962609301',
@DiaChi1 = N'Tuyên Quang', @DiaChi2 = N'Hà Nội', @GioiTinh = 'Nam', @ThanhPho = 'Hà Nội', @TypeKH = 'INSERT'

EXEC CRUD_KhachHang @IDKH = '0', @MaKH = 'PH18705', @TenHoKH = N'Hoàng', @TenDemKH = N'Mạnh', @TenKH = N'Quang', 
@NgaySinh = '2001-9-15', @SodienThoai = '0962609302',
@DiaChi1 = N'Tuyên Quang', @DiaChi2 = N'Hà Nội', @GioiTinh = 'Nam', @ThanhPho = 'Hà Nội', @TypeKH = 'UPDATE'

EXEC CRUD_KhachHang @IDKH = '0', @MaKH = 'PH18705', @TenHoKH = '', @TenDemKH = '', @TenKH = '', 
@NgaySinh = '', @SodienThoai = '',
@DiaChi1 = '', @DiaChi2 = '', @GioiTinh = '', @ThanhPho = '', @TypeKH = 'DELETE'

--Trigger khách hàng
GO
ALTER TRIGGER TG_CheckInsert_khachHang ON khachhang
FOR INSERT
AS 
BEGIN
    IF(SELECT MaKhachHang FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập Mã khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT TenHoKH FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập tên họ khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT TenDemKH FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập tên đệm khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT TenKH FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập tên khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT NgaySinh FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập ngày sinh khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT SoDienThoai FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập số điện thoại khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT DiaChi1 FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập địa chỉ 1 khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT DiaChi2 FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập địa chỉ 2 khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT GioiTinh FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập giới tính khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT ThanhPho FROM inserted) IS NULL
    BEGIN
        PRINT N'Phải nhập thành phố khách hàng'
        ROLLBACK TRANSACTION
    END
    IF(SELECT LEN(TenHoKH) FROM inserted) < 5
    BEGIN
        PRINT N'Tên họ khách hàng phải từ 5 ký tự trở lên'
        ROLLBACK TRANSACTION
    END
    IF(SELECT LEN(TenDemKH) FROM inserted) < 5
    BEGIN
        PRINT N'Tên đệm khách hàng phải từ 5 ký tự trở lên'
        ROLLBACK TRANSACTION
    END
     IF(SELECT LEN(TenKH) FROM inserted) < 5
    BEGIN
        PRINT N'Tên khách hàng phải từ 5 ký tự trở lên'
        ROLLBACK TRANSACTION
    END
END


--========================================================================================================================================================
-- Câu 2 : Trigger
--  TD1 Tạo 1 Trigger Insert &amp; Update cho bảng sản phẩm số lượng tồn không được &lt; 0
-- và trong lượng &lt; 0 và Năm Bảo hành phải lớn hơn năm hiện tại.
--  TD2 Tạo 1 Trigger Delete cho bảng nhân viên cho phép xóa nhân viên kể cả khi nhân
-- viên đó đang có liên kết khóa phụ với bảng khác.
GO
ALTER TRIGGER Trigger_Insert_SP on sanpham
FOR INSERT, UPDATE
AS
BEGIN
    IF(SELECT SoLuongSanPhamTon FROM inserted) < 0
        BEGIN
            PRINT N'Số lượng sản phẩm tồn không được nhỏ hơn 0'
        END
    IF(SELECT TrongLuongSP FROM inserted) < 0
        BEGIN
            PRINT N'Trọng lượng lượng sản phẩm tồn không được nhỏ hơn 0'
        END 
    IF(SELECT NamBaoHanh FROM inserted) < 2022
        BEGIN
            PRINT N'Năm bảo hành phải lớn hơn năm hiện tại'
        END 
    ROLLBACK TRANSACTION    
END
INSERT INTO sanpham(MaSanPHam,TenSP,NamBaoHanh,TrongLuongSP,MoTaSP,SoLuongSanPhamTon,GiaNhapSP,GiaBanSP,IdDongSanPham)
            VALUES('PH6576','Fpoly',2020,-2,'Polytechnic', -8, 20000000, 25000000,1)

        UPDATE sanpham SET SoLuongSanPhamTon = -8 WHERE MaSanPHam = 'H0001'
        UPDATE sanpham SET TrongLuongSP = -7 WHERE MaSanPHam = 'H0001'
        UPDATE sanpham SET NamBaoHanh = 2019 WHERE MaSanPHam = 'H0001'


GO
ALTER TRIGGER Trigger_Delete_NV on nhanvien
INSTEAD OF DELETE
AS 
BEGIN
    DELETE hoadon WHERE IdNhanVien in (SELECT IdNhanVien from deleted)
    DELETE nhanvien WHERE IdNhanVien in (SELECT IdNhanVien from deleted)
    -- DELETE hoadon WHERE IdHoaDon in (SELECT IdHoaDon from deleted)
    -- DELETE hoadonchitiet WHERE IdHoaDon IN (SELECT IdHoaDon from deleted)
END
GO

DELETE FROM nhanvien WHERE IdNhanVien = 2
SELECT * FROM nhanvien


--==================================================================================================================================================
-- Câu 4 : Hàm
--  Hàm 1 tính tuổi:
-- Viết hàm tính tuổi tuyệt đối với tham số đầu vào là date. Hãy viết hàm tính tuổi như ví dụ
-- dưới đây:
-- Ngày Hiện Tại: 28/06/2020 trừ đi 03/011/1989 = 30 tuổi
-- Ngày Hiện Tại: 03/11/2020 trừ đi 03/011/1989 = 31 tuổi
--  Viết hàm tính số lượng nhân viên theo giới tính là tham số truyền vào của hàm. Kết
-- quả hàm trả ra số lượng nhân viên tương ứng với giới tính đó.
-- In kết quả ra màn hình như sau:
-- “Tổng số lượng nhân viên xxx + số lượng nhân viên theo hàm ở trên đã viết ra.”

GO
ALTER FUNCTION Function_TinhTuoiTD(@date date)
RETURNS int
AS
BEGIN
    DECLARE @tuoi INT   
    IF(MONTH(@date) < MONTH(GETDATE()))
            BEGIN
                set @tuoi = 2022 - YEAR(@date) - 1
            END
    IF(MONTH(@date) > MONTH(GETDATE()))
            BEGIN
                set @tuoi = 2022 - YEAR(@date)
            END
    IF(MONTH(@date) = MONTH(GETDATE()))
            BEGIN
                IF(DAY(@date) >= DAY(GETDATE()))
                BEGIN
                    set @tuoi = 2022 - YEAR(@date)
                END
                IF(DAY(@date) < DAY(GETDATE()))
                BEGIN
                    set @tuoi = 2022 - YEAR(@date) - 1
                END   
            END       
    RETURN @tuoi
END
GO
PRINT N'Tuổi của bạn là: ' + CONVERT(NVARCHAR, dbo.Function_TinhTuoiTD('2000/02/19'))

--Hàm đếm nhân viên
GO 
ALTER FUNCTION Function_TongNhanVien(@Gioitinh NVARCHAR(20))
RETURNS int
AS
BEGIN
    RETURN (SELECT COUNT(IdNhanVien) FROM nhanvien WHERE GioiTinh = @Gioitinh)
END
go
PRINT N'Tổng số lượng nhân viên là:' + CONVERT(NVARCHAR, dbo.Function_TongNhanVien(N'Nữ') + dbo.Function_TongNhanVien(N'Nam'))
PRINT N'Tổng số lượng nhân viên Nữ là: ' + CONVERT(NVARCHAR, dbo.Function_TongNhanVien(N'Nữ'))
PRINT N'Tổng số lượng nhân viên Nam là: ' + CONVERT(NVARCHAR, dbo.Function_TongNhanVien(N'Nam'))

-- Câu 5: View

--  View1 giúp quản lý các khách hàng thân thiết đối với cửa hàng như sau:
-- [MaKhachHanh][Họ Tên Đầy Đủ Khách Hàng] [Ngày Sinh][Số Điện Thoại][Địa
-- Chỉ][Giới Tính] [Thành Phố] [Số Lượng Hàng Đã Đặt Hàng][Tổng Tiền Đã Chi Tiêu]
GO
ALTER VIEW View_QuanLyKhachHangThan
AS
SELECT 
khachhang.MaKhachHang AS N'Mã khách hàng',
khachhang.TenHoKH + ' ' + TenDemKH + ' ' + TenKH AS N'Họ Tên Đầy Đủ Khách Hàng',
khachhang.NgaySinh AS 'Ngày Sinh',
khachhang.SoDienThoai AS 'Số Điện Thoại',
khachhang.DiaChi1 AS 'Địa Chỉ',
khachhang.GioiTinh AS 'Giới Tính',
khachhang.ThanhPho AS 'Thành Phố',
hoadonchitiet.SoLuongDatHang AS 'Số Lượng Hàng Đã Đặt Hàng',
SUM(hoadonchitiet.SoLuongDatHang) * SUM(hoadonchitiet.Gia1SanPham) AS 'Tổng Tiền Đã Chi Tiêu'
FROM khachhang
INNER JOIN hoadon 
ON hoadon.IdKhachHang = khachhang.IdKhachHang
INNER JOIN hoadonchitiet 
ON hoadonchitiet.IdHoaDon = hoadon.IdHoaDon
GROUP BY khachhang.MaKhachHang,
khachhang.TenHoKH + ' ' + TenDemKH + ' ' + TenKH ,
khachhang.NgaySinh,
khachhang.SoDienThoai,
khachhang.DiaChi1,
khachhang.GioiTinh,
khachhang.ThanhPho ,
hoadonchitiet.SoLuongDatHang
GO
SELECT * FROM View_QuanLyKhachHangThan
--  View2 giúp chủ cửa hàng quản lý nhân viên:
-- [MaNhanVien][Họ Tên Đầy Đủ Nhân Viên] [Ngày Sinh][Số Tuổi của nhân viên sử dụng
-- hàm tính tuổi ở trên][Số Điện Thoại][Địa Chỉ][Giới Tính] [Tên Chức Vụ] [Số lượng sản
-- phẩm đã bán][Số tiền hàng đã bán]
GO
ALTER VIEW View_QuanLyNV
AS
SELECT 
nhanvien.MaNhanVien as 'Mã nhân viên',
nhanvien.TenHoNV + ' ' + TenDemNV + ' ' + TenNV AS 'Họ Tên Đầy Đủ Nhân Viên',
nhanvien.NgaySinh AS 'Ngày Sinh',
dbo.Function_TinhTuoiTD(NgaySinh) as 'Tuổi của nhân viên',
nhanvien.SoDienThoai AS 'Số Điện Thoại',
nhanvien.DiaChi AS 'Địa Chỉ',
nhanvien.GioiTinh AS 'Giới Tính',
chucvu.TenChucVu 'Tên Chức Vụ',
hoadonchitiet.SoLuongDatHang AS 'Số lượng sản phẩm đã bán',
hoadonchitiet.SoLuongDatHang * Gia1SanPham AS 'Số tiền hàng đã bán'
FROM nhanvien
INNER JOIN chucvu
ON chucvu.IdChucVu = nhanvien.IdChucVu
INNER JOIN hoadon
ON hoadon.IdNhanVien = nhanvien.IdNhanVien
INNER JOIN hoadonchitiet 
ON hoadonchitiet.IdHoaDon = hoadon.IdHoaDon
GO
SELECT * FROM View_QuanLyNV
--  View3 báo cáo tình trạng các hóa đơn còn chậm chưa giao cho khách và hiển thị ra
-- cột số ngày chậm so với ngày dự kiến và gồm các cột sau:
-- [ID Hóa Đơn] [Mã Nhân Viên] [Tên Nhân Viên] [Ngày Lập Hóa Đơn] [Ngày Giao Hàng]
-- [Số Ngày Chậm] [Tên Khách Hàng] [Số ĐT Khách Hàng][Tên Cửa Hàng]

GO
ALTER VIEW View_BaoCaoTinhTrangHoaDon
AS
SELECT
hoadon.IdHoaDon as 'ID Hóa Đơn',
nhanvien.MaNhanVien as 'Mã Nhân Viên',
nhanvien.TenNV as 'Tên Nhân Viên',
hoadon.NgayTaoHoaDon 'Ngày Lập Hóa Đơn',
NgayShipHang 'Ngày Giao Hàng',
DAY(hoadon.NgayShipHang) - DAY(hoadon.NgayTaoHoaDon) as 'Số Ngày Chậm',
khachhang.TenKH 'Tên Khách Hàng', 
khachhang.SoDienThoai 'Số ĐT Khách Hàng',
cuahang_fpt.TenCH AS 'Tên Cửa Hàng'
from hoadon
INNER JOIN nhanvien
ON hoadon.IdNhanVien = nhanvien.IdNhanVien
INNER JOIN khachhang
ON khachhang.IdKhachHang = hoadon.IdKhachHang
INNER JOIN cuahang_fpt
ON nhanvien.IdCuaHang = cuahang_fpt.IdCuaHang
GO
SELECT * FROM View_BaoCaoTinhTrangHoaDon
