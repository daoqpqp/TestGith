-- View 1: Tạo ra 1 View báo cáo doanh số sản phẩm bao gồm các cột thông tin sau để báo cáo cho giám đốc 
--     của đại lý sấp xếp giảm dần theo Số lượng đã bán:
--     [Mã Sản Phẩm] [Tên Sản Phẩm] [Mã Dòng Sản phẩm] [Tên Dòng Sản phẩm] [Số Lượng Tồn Kho] [Số Lượng Đã Bán]
--     [Số tiền lãi] 


SELECT sanpham.MaSanPHam, TenSP, DongSanPham.MaDongSanPham, TenDongSanPham, SanPham.SoLuongSanPhamTon, 
SUM(hoadonchitiet.SoLuongDatHang), SUM(sanpham.GiaBanSP - sanpham.GiaNhapSP) * SUM(hoadonchitiet.SoLuongDatHang) AS SoTienLai
FROM sanpham
INNER JOIN DongSanPham
ON sanpham.IdDongSanPham = DongSanPham.IdDongSanPham
INNER JOIN hoadonchitiet 
ON hoadonchitiet.IdSanPham = sanpham.IdSanPham
-- ORDER BY hoadonchitiet.SoLuongDatHang DESC
GROUP BY sanpham.MaSanPHam, TenSP, DongSanPham.MaDongSanPham, TenDongSanPham, SanPham.SoLuongSanPhamTon


GO
ALTER VIEW View_BaoCaoSP
AS
SELECT sanpham.MaSanPHam, TenSP, DongSanPham.MaDongSanPham, TenDongSanPham, SanPham.SoLuongSanPhamTon, 
SUM(hoadonchitiet.SoLuongDatHang), SUM(sanpham.GiaBanSP - sanpham.GiaNhapSP) * SUM(hoadonchitiet.SoLuongDatHang) AS SoTienLai
FROM sanpham
INNER JOIN DongSanPham
ON sanpham.IdDongSanPham = DongSanPham.IdDongSanPham
INNER JOIN hoadonchitiet 
ON hoadonchitiet.IdSanPham = sanpham.IdSanPham
-- ORDER BY hoadonchitiet.SoLuongDatHang DESC
GROUP BY sanpham.MaSanPHam, TenSP, DongSanPham.MaDongSanPham, TenDongSanPham, SanPham.SoLuongSanPhamTon
GO

SELECT * FROM View_BaoCaoSP
ORDER BY SoLuongDatHang DESC

--  View 2:  Tạo ra 1 View báo cáo cho thanh tra của tập đoàn xuống kiểm tra gồm những cột sau và sắp 
--     xếp theo tổng số lượng sản phẩm đã bán của nhân viên đó
--     [Tên Cửa Hàng][Thành Phố][Địa Chỉ 1][Quốc Gia][Mã Nhân Viên] [Tên Nhân Viên] [Số điện thoại] 
--     [Lương] [Mã Người Báo Cáo] [Tên người Báo Cáo][Chức danh người báo cáo]
--     [Tổng số lượng sản phẩm đã bán của nhân viên đó]

SELECT TenCH, ThanhPho, DiaChi1, QuocGia, nhanvien.MaNhanVien, TenNV, SoDienThoai,
LuongNV, nhanvien.IdNhanVien as MaNguoiBaoCao, nhanvien.TenNV AS TenNguoiBaoCao, 
chucvu.TenChucVu as ChucDanhNguoiBaoCao, 
SUM(SoLuongDatHang) as TongSoLuonDaBan
FROM cuahang_fpt
INNER JOIN nhanvien
ON nhanvien.IdCuaHang = cuahang_fpt.IdCuaHang
INNER JOIN hoadon
ON hoadon.IdNhanVien = nhanvien.IdNhanVien
INNER JOIN chucvu 
ON chucvu.IdChucVu = nhanvien.IdChucVu
INNER JOIN hoadonchitiet 
ON hoadonchitiet.IdHoaDon = hoadon.IdHoaDon
GROUP BY TenCH, ThanhPho, DiaChi1, QuocGia, nhanvien.MaNhanVien, TenNV, SoDienThoai,
LuongNV, nhanvien.IdNhanVien, nhanvien.TenNV, 
chucvu.TenChucVu
ORDER BY SUM(SoLuongDatHang) DESC

GO
ALTER VIEW View_BaoCaoThanhTra1
AS
SELECT TenCH, ThanhPho, DiaChi1, QuocGia, nhanvien.MaNhanVien, TenNV, SoDienThoai,
LuongNV, nhanvien.IdNhanVien as MaNguoiBaoCao, nhanvien.TenNV AS TenNguoiBaoCao, 
chucvu.TenChucVu as ChucDanhNguoiBaoCao, 
SUM(SoLuongDatHang) as TongSoLuonDaBan
FROM cuahang_fpt
INNER JOIN nhanvien
ON nhanvien.IdCuaHang = cuahang_fpt.IdCuaHang
INNER JOIN hoadon
ON hoadon.IdNhanVien = nhanvien.IdNhanVien
INNER JOIN chucvu 
ON chucvu.IdChucVu = nhanvien.IdChucVu
INNER JOIN hoadonchitiet 
ON hoadonchitiet.IdHoaDon = hoadon.IdHoaDon
GROUP BY TenCH, ThanhPho, DiaChi1, QuocGia, nhanvien.MaNhanVien, TenNV, SoDienThoai,
LuongNV, nhanvien.IdNhanVien, nhanvien.TenNV, 
chucvu.TenChucVu

GO

SELECT * FROM View_BaoCaoThanhTra1
ORDER BY TongSoLuonDaBan DESC


-- View 3: Sắp tới 30/4 mùng 1/5 đang có chương trình tặng quà cho những khách hàng từng mua hàng 
--     tổng đơn hàng từ 15 triệu trở lên. Hãy tạo 1 View hiển thị những khách hàng nằm trong diện được 
--     thưởng bao gồm các cột và sắp xếp theo tổng số tiền đã mua
--     [Id Khách Hàng] [Họ và Tên Khách Hàng] [Số điện thoại] [Địa Chỉ 1] [Thành phố] 
--     [Tổng số lượng hà đã mua] [Tổng số tiền đã mua]

SELECT khachhang.IdKhachHang, TenHoKH, SoDienThoai, DiaChi1, ThanhPho, 
hoadonchitiet.SoLuongDatHang, Gia1SanPham * SoLuongDatHang AS TongSoTienDaMua
FROM khachhang
INNER JOIN hoadon
ON khachhang.IdKhachHang = hoadon.IdKhachHang
INNER JOIN hoadonchitiet 
ON hoadon.IdHoaDon = hoadonchitiet.IdHoaDon
WHERE (Gia1SanPham * SoLuongDatHang) > 15000000

GO
ALTER VIEW View_ChuongTrinhTangQua
AS
SELECT khachhang.IdKhachHang, TenHoKH, SoDienThoai, DiaChi1, ThanhPho, 
hoadonchitiet.SoLuongDatHang, Gia1SanPham * SoLuongDatHang AS TongSoTienDaMua
FROM khachhang
INNER JOIN hoadon
ON khachhang.IdKhachHang = hoadon.IdKhachHang
INNER JOIN hoadonchitiet 
ON hoadon.IdHoaDon = hoadonchitiet.IdHoaDon
WHERE (Gia1SanPham * SoLuongDatHang) > 15000000
GO

SELECT * FROM View_ChuongTrinhTangQua

-- View 4: Hiển thị ra 1 View báo cáo Các hóa đơn có tình trạng chưa ship hàng cho khách được và để các trưởng phòng họp bắt các nhân viên giải trình hiển thị ra các cột như sau và sắp xếp giảm dần theo số lượng:
--     [ID Hóa Đơn] [Mã Nhân Viên] [Tên Nhân Viên] [Ngày Lập Hóa Đơn] [Ngày Giao Hàng] [Tên Khách Hàng] 
--     [Số ĐT Khách Hàng] [Quận] [Trạng Thái Hóa ĐƠn] [Số Lượng trên đơn]*/
SELECT IdHoaDon, nhanvien.MaNhanVien as 'Ma Nhan Vien', nhanvien.TenNV, NgayTaoHoaDon, NgayShipHang,
khachhang.TenKH, khachhang.SoDienThoai,  TinhTrangHoaDon =
    CASE
    WHEN TinhTrangHoaDon = 1 THEN N'Đã Giao'
    ELSE N'Chưa Giao'
    END
FROM hoadon 
INNER JOIN nhanvien 
ON hoadon.IdNhanVien = nhanvien.IdNhanVien
INNER JOIN khachhang 
ON khachhang.IdKhachHang = hoadon.IdKhachHang

GO
ALTER VIEW View_BaoCaoHoaDon
AS
SELECT IdHoaDon, nhanvien.MaNhanVien, nhanvien.TenNV, NgayTaoHoaDon, NgayShipHang,
khachhang.TenKH, khachhang.SoDienThoai,  TinhTrangHoaDon =
    CASE
    WHEN NgayShipHang is null THEN N'Chưa Giao'
    ELSE N'Đã giao'
    END,
    hoadon.IdKhachHang AS SoLuongTrenDon
FROM hoadon 
INNER JOIN nhanvien 
ON hoadon.IdNhanVien = nhanvien.IdNhanVien
INNER JOIN khachhang 
ON khachhang.IdKhachHang = hoadon.IdKhachHang
-- GROUP BY IdHoaDon, nhanvien.MaNhanVien, nhanvien.TenNV, NgayTaoHoaDon, NgayShipHang,
-- khachhang.TenKH, khachhang.SoDienThoai,  TinhTrangHoaDon
GO

SELECT * FROM View_BaoCaoHoaDon

GROUP BY *