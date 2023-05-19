-- 1 các phím tắt cơ bản 
-- crt + / comment code
-- f5 chạy code

-- bài 1 : tạo biến bằng lệnh Declare 
-- 1.1 để khai báo biến, sử dụng từ khóa Declare với cú pháp : 
-- chú ý dùng @ trước biến và "_"
DECLARE @YEAR AS INT

DECLARE @NAME AS NVARCHAR, 
        @YEAR_OF_BIRTH AS INT  --khai báo nhiều biến

SET @YEAR = 2022;
SELECT @YEAR;        
-- 1.2 : Truy xuất với select@<tên biến>
DECLARE @CHIEU_DAI INT, @CHIEU_RONG INT, @DIEN_TICH INT; --KHAI BÁO KO CẦN THIẾT CÓ "AS"
SET @CHIEU_DAI = 6;
SET @CHIEU_RONG = 2;
SET @DIEN_TICH = @CHIEU_DAI * @CHIEU_RONG;
SELECT @DIEN_TICH;

--1.3 : LƯU TRỮ CÂU TRUY VẤN VÀO BIẾN
DECLARE @KHOA_MAX INT 
SET @KHOA_MAX = (SELECT MAX(IdNhanVien) FROM nhanvien) --LẤY MAX TRONG CỘT ID NHÂN VIÊN CỦA BẢNG NHANVIEN
--SELECT @KHOA_MAX;
PRINT N'NHÂN VIÊN CO KHOA CHINH LON NHAT : ' + CONVERT(VARCHAR(5),@KHOA_MAX) --ĐÂY LÀ CÂU LỆNH IN THEO KIỂU MESS, CONVERT ĐỂ NỐI CHUỖI
--VÍ DỤ : LẤY RA SẢN PHẨM CÓ TRỌNG LƯỢNG BÉ NHẤT GÁN CHO 1 BIẾN VÀ IN RA
DECLARE @KG_MIN FLOAT
SET @KG_MIN = (SELECT MIN(TrongLuongSP) FROM sanpham)
SELECT @KG_MIN;

-- 1.4BIỄN BẢNG  
DECLARE @SP_TABLE TABLE (CODE NVARCHAR(20), TEN_SP NVARCHAR(50))  --TẠO BẢNG MỚI VỚI 2 CỘT LÀ CODE VÀ TEN_SP
--CHÈN DỮ LIỆU VÀO BIẾN BẢNG
INSERT INTO @SP_TABLE
SELECT MaSanPHam,TenSP -- CHỌN CÁC CỘT NÀY SAU
FROM sanpham  --LẤY Ở BẢNG NÀY TRƯỚC
WHERE TenSP LIKE 'Dell%' --DELL% TỨC LÀ BẮT ĐẦU BẰNG DELL
SELECT * FROM @SP_TABLE
SELECT TEN_SP FROM @SP_TABLE --TRUY CẬP ĐẾN TỪNG TRƯỜNG TRONG BIẾN BẢNG

-- 1.5CHÈN DỮ LIỆU VÀO BIẾN BẢNG CÁCH MỚI ****PRO****
DECLARE @SANPHAMFPOLY TABLE (ID INT, TENSP NVARCHAR(50), QUOC_GIA NVARCHAR(20))
--CHÈN DỮ LIỆU VÀO BẢNG
INSERT INTO @SANPHAMFPOLY VALUES (1, N'IPHONE 14', 'VN')
--LẤY DỮ LIỆU 
SELECT * FROM @SANPHAMFPOLY

--1.6 SỬA DỮ LIỆU 
DECLARE @SANPHAMFPOLY_UPDATE TABLE (ID INT, TENSP NVARCHAR(50), QUOC_GIA NVARCHAR(20))
INSERT INTO @SANPHAMFPOLY_UPDATE VALUES (1, N'IPHONE 14', 'VN')
SELECT * FROM @SANPHAMFPOLY_UPDATE
UPDATE @SANPHAMFPOLY_UPDATE 
SET QUOC_GIA = N'TQ'
WHERE ID = 1
SELECT * FROM @SANPHAMFPOLY_UPDATE

--1.7 begin và end 
BEGIN
     SELECT MaNhanVien, TenNV,LuongNV
     FROM nhanvien
     WHERE LuongNV > 1000000

     IF @@ROWCOUNT = 0
     PRINT N'KHÔNG CÓ NHÂN VIÊN NÀO CÓ MỨC LƯƠNG NÀY'
     ELSE
     PRINT N'CÓ DỮ LIỆU KHI TRUY VẤN'
END

--1.8 BEGIN VÀ END LỒNG NHAU
BEGIN
     DECLARE @TEN_DEM NVARCHAR(MAX)
     SELECT TOP 1 
     @TEN_DEM = TenDemNV
     FROM nhanvien
     WHERE TenDemNV = N'Minh'
     ORDER BY TenDemNV ASC ------------------------------ASC LÀ SẮP XẾP XUÔI, DSC LÀ NGƯỢC

     IF @@ROWCOUNT <> 0 
     BEGIN
        PRINT N'TÌM THẤY NG ĐẦU TIÊN CÓ TÊN : ' + @TEN_DEM
     END
     ELSE
     BEGIN
        PRINT N'KHÔNG TÌM THẤY NG NÀO CÓ TÊN ĐỆM NHƯ THẾ'
     END
END

-- 1.9 CAST EP KIỂU DỮ LIỆU 
SELECT CAST(42.15 AS INT ) -- = 42
SELECT CAST(13.5 AS float) 
SELECT CAST(13.5 AS varchar(5)) 
SELECT CAST('13.5' AS float) 
SELECT CAST('2022-04-15' AS datetime)

--2.0 CONVERT
SELECT CONVERT(INT, 15.6)  --KIỂU DỮ LIỆ TRƯỚC RỒI CÁI CẦN ÉP KIỂU SAU, NGƯỢC VỚI CAST
SELECT CONVERT(float,'9.9')
SELECT CONVERT(datetime, '2022-12-31')

-- CÁC THAM SỐ ĐỊNH DẠNG TRONG CONVERT 101, 102, ...........
SELECT CONVERT(varchar,'01/15/2022',101) -- ĐỊNH DẠNG MM/DD/YYYY
SELECT CONVERT(datetime,'01.15.2022',102)  -- YYY.MM.DD
SELECT CONVERT(datetime,'01/15/2022',103) --DD/MM/YY

--VÍ DỤ
SELECT NgaySinh,
CAST (NgaySinh AS varchar) AS 'NGÀY SINH1',
CONVERT(varchar,NgaySinh,101) AS 'NGÀY SINH2'
FROM nhanvien

--ABS() LẤY GIÁ TRỊ TUYỆ ĐỐI
SELECT ABS(-3)
--
SELECT CEILING(3.1) -- LẤY CẬN TRÊN
SELECT FLOOR(9.9)  -- LẤY CẬN DƯỚI
SELECT POWER(9,3) -- LẤY LŨY THỪA
SELECT ROUND(9.123456,2) --LÀM TRÒN 1 SỐ OR 1 BIỂU THỨC ĐẾN ĐỘ CHÍNH XÁC LÀ BAO NHIÊU, VÍ DỤ LÀ 5
SELECT SIGN(-99)   --LẤY DẤU CỦA SỐ HOẶC 1 BIỂU THỨC
SELECT SIGN(100-50)
SELECT SQRT(9) -- LẤY CĂN BẬC 2
SELECT SQRT(16-7)
SELECT SQUARE(5) --LẤY BÌNH PHƯƠNG
SELECT LOG(9) --LẤY LOGA
SELECT LOG(9) AS N'LOGA CO SO E CUA 9'
SELECT EXP(2) --TÍNH LŨY THỪA CƠ SỐ E CỦA 1 SỐ
SELECT PI() --SỐ PI
SELECT ASIN(1) AS [ASIN(1)],COS(1) AS [ACOS(1)],ATAN(1) AS [ATAN(1)];

--2.2CÁC HÀM SỬ LÝ CHUỖI
SELECT LEN(N'BÙI THE MANH Á') -- 12 KÍ TỰ BAO GỒM CẢ KHOẲNG TRẮNG
SELECT LTRIM(' BUI THE MANH ')  --LOẠI BỎ KHOẢNG TRẮNG BÊN TRÁI
SELECT RTRIM(' BUI THE MANH ')  --LOẠI BỎ KHOẢNG TRẮNG BÊN PHẢI
SELECT RTRIM(LTRIM(' BUI THE MANH '))
SELECT TRIM(' BUI THE MANH ') --LOẠI BỎ DẤU CÁCH 2 BÊN
SELECT LEFT('BUI THE MANH',3)
SELECT RIGHT('BUI THE MANH',5) -- CẮT CHUỖI

DECLARE @NAME_TABLE TABLE ( FULL_NAME NVARCHAR(20))
DECLARE @DEM_TEN NVARCHAR(50)

INSERT INTO @NAME_TABLE VALUES(N'NGUYỄN TIẾN HÙNG'),(N'NGUYỄN HỮU KHOA')

SELECT FULL_NAME,
LEFT(FULL_NAME, CHARINDEX(' ',FULL_NAME) - 1) AS N'HỌ',
RIGHT(FULL_NAME,LEN(FULL_NAME)- CHARINDEX(' ',FULL_NAME)) AS N'TÊN'
--SET @DEM_TEN = RIGHT(FULL_NAME,LEN(FULL_NAME)- CHARINDEX(' ',FULL_NAME))
FROM @NAME_TABLE



DECLARE @NAME_TABLE1 TABLE ( FULL_NAME1 NVARCHAR(20))

INSERT INTO @NAME_TABLE1 VALUES(N'BUI THE MANH'), (N'NGUYEN TRUONG Anh')

SELECT FULL_NAME1,
--CHARINDEX(' ', FULL_NAME1) AS N'DAU CACH THU NHAT',
--CHARINDEX(' ', FULL_NAME1, CHARINDEX(' ', FULL_NAME1) + 1) AS N'DAU CACH THU 2', 
LEFT(FULL_NAME1, CHARINDEX(' ',FULL_NAME1)- 1) AS N'HỌ',
SUBSTRING(FULL_NAME1, CHARINDEX(' ', FULL_NAME1) + 1,CHARINDEX(' ', FULL_NAME1, CHARINDEX(' ', FULL_NAME1) + 1) - CHARINDEX(' ', FULL_NAME1) -1  ) AS N'TÊN ĐỆM',
RIGHT(FULL_NAME1, LEN(FULL_NAME1)- CHARINDEX(' ', FULL_NAME1, CHARINDEX(' ', FULL_NAME1) + 1) ) AS N'TÊN'

FROM @NAME_TABLE1


DECLARE @TEN NVARCHAR(20)
SET @TEN = 'BUI THE MANHMAN'
SELECT 
RIGHT(@TEN, CHARINDEX(' ', @TEN))

--2.3 Charindex Trả về vị trí của 1 chuỗi
--CHARINDEX('chuỗi 1', 'chuỗi 2', start location) = 1 số nguyên
SELECT CHARINDEX('Poly', 'FPT Polytechnic') --vị trí của Poly từ vị trí thứ 5
SELECT CHARINDEX('Poly', 'FPT Polytechnic',5)

--2.4 cắt chuỗi từ vị trí bắt đầu với dộ dài muốn lấy
SELECT SUBSTRING('bui the manh', 5, LEN('bui the manh'))
SELECT SUBSTRING('bui the manh', 5, 8) -- bắt đầu từ vị trí thứ 5 và lấy 8 kí tự

-- 2.5 replace thay thế chuỗi theo giá trị cần thay thế
SELECT REPLACE('bui-the-manh','-',' ')  --thay thế '-' thành dáu cách ' '
SELECT REPLACE(N'Bùi Thế Mạnh',N'Thế',N'Anh')

--2.6 
SELECT LOWER('Bui the manh')  --viết thường hết
SELECT UPPER('Bui the Manh')  --viết hoa hết
SELECT REVERSE('BUITHEMANH')  --đảo ngược
SELECT N'Bùi' + SPACE(10) + N'Mạnh' --thêm khgoangr trắng cần truyền
  
  --HẾT SỬ LÝ CHUỖI--

  --2.7 CÁC HÀM NGÀY THÁNG NĂM
SELECT GETDATE() --NGÀY HIỆN TẠI
SELECT CONVERT(DATE,GETDATE())
SELECT CONVERT(TIME,GETDATE())

SELECT YEAR(GETDATE()) AS YEAR,
MONTH(GETDATE()) AS MONTH,
DAY(GETDATE()) AS DAY

--DATENAME 
SELECT DATENAME(YEAR,GETDATE()) AS YEAR,
DATENAME(MONTH,GETDATE()) AS MONTH,
DATENAME(DAY,GETDATE()) AS DAY,
DATENAME(WEEK,GETDATE()) AS WEEK,
DATENAME(DAYOFYEAR,GETDATE()) AS DAYOFYEAR,
DATENAME(WEEKDAY,GETDATE()) AS WEEKDAY

DECLARE @NGAYSINHCUATOI DATE
SET @NGAYSINHCUATOI = '1995/06/28'
SELECT DATENAME(YEAR,@NGAYSINHCUATOI) AS YEAR,
DATENAME(MONTH,@NGAYSINHCUATOI) AS MONTH,
DATENAME(DAY,@NGAYSINHCUATOI) AS DAY,
DATENAME(WEEK,@NGAYSINHCUATOI) AS WEEK,
DATENAME(DAYOFYEAR,@NGAYSINHCUATOI) AS DAYOFYEAR,
DATENAME(WEEKDAY,@NGAYSINHCUATOI) AS WEEKDAY

 --2.8 CÂU LỆNH ĐIÊU KIỆN IF ELSE

 IF 1 = 2
 BEGIN
      PRINT 'DUNG'
 END

 ELSE
 BEGIN
      PRINT 'SAI'
 END

 --VIẾT 1 CHƯƠNG TRÌNH TÍNH ĐIỂM QUA MÔN
 DECLARE @DIEM FLOAT
 SET @DIEM = 4.9
 IF @DIEM < 5 
      PRINT N'TẠCH MÔM RỒI BẸN ÊII'
 ELSE
      PRINT N'ĂN TẾT VUI VẺ'     


 DECLARE @DIEM1 FLOAT
 SET @DIEM1 = 7
IF @DIEM1 < 5 
 BEGIN
      PRINT N'TẠCH MÔM RỒI BẸN ÊII'
 END     
ELSE
 BEGIN
      PRINT N'ĂN TẾT VUI VẺ' 
        IF  @DIEM1 <8
        BEGIN
               PRINT N'KHÁ QUÁ NHỂ'
        END
        ELSE
        BEGIN
               PRINT N'GIỎI QUÁ NHỂ'
        END
  END    


  --2.9 IF EXIST 
  --HÃY KIỂM TRA BẢNG NHÂN VIÊN CÓ NHÂN VIÊN NÀO LƯƠNG LỚN HỚN 50TR KO

  IF EXISTS(
     SELECT *
     FROM nhanvien 
     WHERE LuongNV > 50000)
   BEGIN
     PRINT N'CÓ NHÂN VIÊN'
     SELECT * FROM nhanvien
     WHERE LuongNV >=50000
   END
  ELSE 
   BEGIN
   PRINT N'KHÔNG CÓ '
   END


-- 3.0 IIF () CHECK DUNG SAI 

SELECT IIF(10 > 9, 'DUNG', 'SAI' ) AS COT

SELECT MaNhanVien,TenNV,
IIF(IdCuaHang = 1, N'Nhân viên thuộc của hàng 1', N'Nhân viên ko thuộc cửa hàng 1')
--IIF(IdCuaHang = 1, N'Nhân viên thuộc của hàng 1',IIF(IdCuaHang = 2, N'Nhân viên ko thuộc cửa hàng 1','no'))
FROM nhanvien 

--3.1 case -- when --then -- end

SELECT TenNV =
CASE GioiTinh
WHEN 'Nam' THEN 'Mr ' + TenNV
WHEN N'Nữ' THEN 'Ms ' + TenNV
ELSE N'KHÔNG XÁC DDINGJ GIỚI TÍNH' + TenNV
END
FROM nhanvien

-- viết cách khác

SELECT TenNV = 
CASE 
WHEN GioiTinh =  'Nam' THEN 'Mr ' + TenNV
WHEN GioiTinh =  N'Nữ' THEN 'Ms ' + TenNV
ELSE N'KHÔNG XÁC ĐỊNH GIỚI TÍNH' + TenNV
END
FROM nhanvien

--TẠO RA 1 CỘT TÍNH THUẾ CHO NHÂN VIÊN Ở ĐẦU BÀI
--LƯƠNG > 300K THÙI THUẾ = A

DECLARE @TABLE TABLE (THUE INT);


SELECT MaNhanVien, TenNV, LuongNV , 'THUE' =
    CASE 
    WHEN LuongNV < 300000 THEN LuongNV*0.05 
    WHEN LuongNV > 300000 AND LuongNV < 600000 THEN LuongNV*0.08
    --WHEN LuongNV BETWEEN 300000 AND  600000 THEN LuongNV*0.08
    WHEN LuongNV > 6000000 AND LuongNV < 8000000 THEN LuongNV*0.1
    ELSE LuongNV*0.3 
    END
FROM nhanvien


--VÒNG LẶP WHILE (WHILE LOOP)
DECLARE @DEM INT = 0
WHILE @DEM < 5 
BEGIN 
     SET @DEM = @DEM +1
     PRINT N'MÔN NÀY QUAN TRỌNG PHẾT'     
     PRINT N'LẦN THỨ' +CONVERT(VARCHAR, @DEM, 1)
END
PRINT N'KHÔNG CÓ GÌ ĐÂU'
-- BREAK NGẮT VÒNG LẶP
--CONTINUE THỤC HIỆN BƯỚC LẶP TIẾP THEO 

DECLARE @DEM1 INT = 0
WHILE @DEM1 < 10 
BEGIN 
SET @DEM1 = @DEM1 +1
IF @DEM1 = 5
BEGIN
  --BREAK
  
  CONTINUE
END
     --SET @DEM1 = @DEM1 +1
     PRINT N'MÔN NÀY QUAN TRỌNG PHẾT'     
     PRINT N'LẦN THỨ' +CONVERT(VARCHAR, @DEM1, 1)
END
PRINT N'KHÔNG CÓ GÌ ĐÂU'

--3.2 TRY -CATCH
BEGIN TRY
     SELECT 1 + 'STRING'
END TRY
BEGIN CATCH
     SELECT 
     ERROR_NUMBER() AS N'TRẢ VỀ LỖI DẠNG SỐ',
     ERROR_MESSAGE() AS N'TRẢ VỀ DẠNG VĂN BẢN'
END CATCH

BEGIN TRY
     INSERT chucvu(IdChucVu, MaChucVu, TenChucVu)  --BỎ IDCHUCVU DI
     VALUES (1, 'AAA','BUI MANH') -- BỎ 1 ĐI LÀ INSERT ĐC
END TRY
BEGIN CATCH
     PRINT N'BẠN KO INSERT ĐC'
     PRINT 'THONG BAO : ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1)
     PRINT 'THONGBAO : ' + ERROR_MESSAGE()
END CATCH

--3.3 RAISERROR
 -- ERROR_NUMBER() : Trả về mã số của lỗi dưới dạng số
--ERROR_MESSAGE() Trả lại thông báo lỗi dưới hình thức văn bản 
--ERROR_SEVERITY() Trả lại mức độ nghiêm trọng của lỗi kiểu int
--ERROR_STATE() Trả lại trạng thái của lỗi dưới dạng số
--ERROR_LINE() : Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
--ERROR_PROCEDURE() Trả về tên thủ tục/Trigger gây ra lỗi

--CÁCH DÙNG RAISROF
BEGIN TRY
     INSERT chucvu(IdChucVu, MaChucVu, TenChucVu)  
     VALUES (1, 'AAA','BUI MANH') 
END TRY
BEGIN CATCH
     DECLARE @ER_ERROR_SEVERITY INT, @ER_ERROR_MESSAGE VARCHAR(MAX), @ER_ERROR_STATE INT
     SELECT 
     @ER_ERROR_SEVERITY = ERROR_SEVERITY(),
     @ER_ERROR_MESSAGE = ERROR_MESSAGE(),
     @ER_ERROR_STATE = ERROR_STATE()
     RAISERROR (@ER_ERROR_SEVERITY, @ER_ERROR_MESSAGE, @ER_ERROR_STATE)
     
END CATCH

--CÁCH KO DÙNG RAISFOR
BEGIN TRY
     INSERT chucvu(IdChucVu, MaChucVu, TenChucVu)  
     VALUES (1, 'AAA','BUI MANH') 
END TRY
BEGIN CATCH
DECLARE @ER_ERROR_SEVERITY1 INT, @ER_ERROR_MESSAGE1 VARCHAR(MAX), @ER_ERROR_STATE1 INT
     SELECT 
     @ER_ERROR_SEVERITY1 = ERROR_SEVERITY(),
     @ER_ERROR_MESSAGE1 = ERROR_MESSAGE(),
     @ER_ERROR_STATE1 = ERROR_STATE()
     PRINT N'THÔNG BÁO : ' + @ER_ERROR_MESSAGE1 + ' | ' + CONVERT(VARCHAR, @ER_ERROR_SEVERITY1,1) + ' | ' + CONVERT(VARCHAR, @ER_ERROR_STATE1,1)
     
END CATCH

-- 3.4 ý nghĩa của repicate
DECLARE @ten1234 NVARCHAR(50)
set @ten1234 = REPLICATE(N'á',5) --lặp lại số lần string truyền vào
PRINT @ten1234

-- ví dụ cơ bản
GO
ALTER PROCEDURE SP_LAYDANHSACHNHANVIEN  -- CREATE DÙNG BẰNG ALTER THÌ THÀNH CHỈNH SỬA CÂU LỆNH BÊN TRONG, CREATE LÀ ĐỂ TẠO MỚI
AS 
SELECT * FROM nhanvien WHERE LuongNV > 2000000

GO 
CREATE PROC SP_LAYDANHSACHNAMBAOHANH  -- CREATE DÙNG BẰNG ALTER THÌ THÀNH CHỈNH SỬA CÂU LỆNH BÊN TRONG, CREATE LÀ ĐỂ TẠO MỚI
AS 
SELECT * FROM sanpham WHERE NamBaoHanh = 2034 


--MUỐN THỰC THI THÌ DÙNG CÂU LỆNH EXCUTE
EXECUTE SP_LAYDANHSACHNHANVIEN
EXEC SP_LAYDANHSACHNAMBAOHANH

-- 3.5 TRIGGER
GO 
ALTER TRIGGER TG_INSERT_CHECKLLUONG ON nhanvien
FOR INSERT
AS 
BEGIN
     IF(SELECT LuongNV FROM inserted) < 50000
     BEGIN
     PRINT N'Tiền lương tối thiểu khi insert phải loén hơn 50K'
     ROLLBACK TRANSACTION
     END
END

INSERT INTO nhanvien
    (MaNhanVien,TenHoNV,TenDemNV,TenNV,GioiTinh,NgaySinh,DiaChi,
    LuongNV,SoDienThoai,Email,IdCuaHang,IdChucVu,IdGuiBaoCao)
VALUES('NV999', N'Nguyễn', N'Huy', N'Quyết', 'Nam', '1989-11-03', 'BG' , 100000,
        '0582905832', 'quyetnhph10608@fpt.edu.vn', 1, 1, 1)


GO 
CREATE TRIGGER TG_UPDATE_CHECKLLUONG ON nhanvien
FOR UPDATE
AS 
BEGIN
     IF(SELECT LuongNV FROM inserted) < 50000
     BEGIN
     PRINT N'Tiền lương tối thiểu khi insert phải loén hơn 50K'
     ROLLBACK TRANSACTION
     END
END

UPDATE nhanvien SET LuongNV = 400 WHERE MaNhanVien = 'NV01'

--ví dụ 1 : truyền tham số cho store Proc
GO
CREATE PROC SP_CHECKSP_BY_NBH_TRONGLUONG
(@NBH NUMERIC (4,0),
@T1 FLOAT)
AS 
SELECT * FROM sanpham 
WHERE NamBaoHanh = @NBH AND TrongLuongSP > @T1


--VÍ DỤ 2, THÊM SỬA XÓA CHO BẢNG
GO 
ALTER PROC SP_CRUD_DONGSP
(@id integer,
@maDSP NVARCHAR(100),
@tenDSP NVARCHAR(100),
@web NVARCHAR(200),
@SType varchar(30))
as 
BEGIN
     if(@SType = 'SELECT')
     BEGIN
          SELECT * FROM dongsanpham
          END
     if(@SType = 'INSERT')
     BEGIN
          INSERT INTO dongsanpham(MaDongSanPham,TenDongSanPham,WebsiteDongSanPham)
          VALUES(@maDSP,@tenDSP,@web)
     END
     IF(@SType = 'DELETE')
     BEGIN
          DELETE FROM dongsanpham
          WHERE MaDongSanPham = @maDSP
     END
     IF(@SType = 'UPDATE')
     BEGIN
          UPDATE dongsanpham
          set MaDongSanPham = @maDSP, TenDongSanPham = @tenDSP, WebsiteDongSanPham = @web 
          WHERE IdDongSanPham = @id

     END 
end
EXEC SP_CRUD_DONGSP @id = 0, @maDSP = 'FPOLY', @tenDSP = 'POLYTECHNIC', @web = 'MANH@GMAIL.COM', @SType = 'SELECT'
EXEC SP_CRUD_DONGSP @id = 111, @maDSP = 'MMAabc', @tenDSP = 'def', @web = 'aa@gmail.com', @SType = 'INSERT'
EXEC SP_CRUD_DONGSP @id = 0, @maDSP = 'MMAabc', @tenDSP = '', @web = '', @SType = 'DELETE'
EXEC SP_CRUD_DONGSP @id = 2, @maDSP = 'FPOLY', @tenDSP = 'POLYTECHNIC', @web = 'MANH@GMAIL.COM', @SType = 'UPDATE'

--bảng cửa hàng
go
alter proc SP_CUAHANG
(@id integer,
@maCH NVARCHAR(100),
@tenCH NVARCHAR(100),
@slNV int,
@dc1 NVARCHAR(200),
@dc2 NVARCHAR(200),
@tp NVARCHAR(200),
@qg NVARCHAR(200),
@NUT varchar(30)
)
as 
BEGIN
     if(@NUT = 'SELECT')
     BEGIN
          SELECT * FROM cuahang_fpt
          END
     if(@NUT = 'INSERT')
     BEGIN
          INSERT INTO cuahang_fpt(MaCH,TenCH,SoLuongNV, DiaChi1,DiaChi2,ThanhPho,QuocGia)
          VALUES(@maCH, @tenCH, @slNV,@dc1,@dc2,@tp,@qg)
     END
     IF(@NUT = 'DELETE')
     BEGIN
          DELETE FROM cuahang_fpt
          WHERE MaCH = @maCH
     END
     IF(@NUT = 'UPDATE')
     BEGIN
          UPDATE cuahang_fpt
          set  MaCH = @maCH,
          TenCH = @tenCH,
          SoLuongNV = @slNV,
           DiaChi1 = @dc1,
           DiaChi2 = @dc2,
           ThanhPho = @tp,
           QuocGia = @qg
          WHERE IdCuaHang = @id

     END
END


exec SP_CUAHANG @id = 0, @maCH = 'manhman1', @tenCH = 'bui the manh', @slNV = 10, @dc1 = 'ha noi', @dc2 = 'ha nam', @tp = 'hanoi', @qg = 'viet nam', @NUT = 'SELECT'
exec SP_CUAHANG @id = 1995, @maCH = 'Manh002', @tenCH = '', @slNV = 0, @dc1 = '', @dc2 = '', @tp = '', @qg = '', @NUT = 'INSERT'
exec SP_CUAHANG @id = 0, @maCH = 'Manh002', @tenCH = '', @slNV = 10, @dc1 = '', @dc2 = '', @tp = '', @qg = '', @NUT = 'DELETE'
exec SP_CUAHANG @id = 1, @maCH = 'manhman1', @tenCH = 'bui the manh', @slNV = 10, @dc1 = 'ha noi', @dc2 = 'ha nam', @tp = 'hanoi', @qg = 'viet nam', @NUT = 'UPDATE'

-- xóa ID hóa đơn

go 
ALTER TRIGGER delete_hoadon on hoadon
INSTEAD of DELETE
as
BEGIN
     DELETE from hoadonchitiet WHERE IdHoaDon in (select IdHoaDon from deleted)
     DELETE from hoadon WHERE IdHoaDon in (select IdHoaDon from deleted)
     
END

DELETE from hoadon WHERE IdHoaDon = 2;

-- hàm 
--viết hàm tính tuổi người dùng khi nhập năm sinh
go 
CREATE FUNCTION f_tinhtuoi( @nam_sinh int )
RETURNS int -- return có 's' để định nghĩa kiểu dữ liệu của hàm
AS
BEGIN
     RETURN YEAR(GETDATE()) - @nam_sinh
END
go 
PRINT dbo.f_tinhtuoi(2002)  --gọi lại hàm, dùng dbo.abcxyz

--ví dụ 2 : tạo 1    đếm số nhân viên có trong cty
go 
CREATE FUNCTION f_demNV()
RETURNS INT
AS
BEGIN
     RETURN (SELECT COUNT(IdNhanVien) from nhanvien)
END
go
PRINT dbo.f_demNV()
--tạo 1 hàm đếm số nhân viên theo giưới tính, giới tính là tham số truyền vào
GO 
CREATE FUNCTION F_DemNV_GioiTinh(@gt NVARCHAR(20))
RETURNS INT
as
BEGIN
     RETURN (select count(IdNhanVien) from nhanvien WHERE GioiTinh = @gt)
END
go
PRINT 'tong so nhan vien theo gioi tinh la : ' + CONVERT(NVARCHAR, dbo.F_DemNV_GioiTinh('Nam'))
PRINT dbo.F_DemNV_GioiTinh('Nam')
--PRINT dbo.F_DemNV_GioiTinh('Nam')
--select count(IdNhanVien) from nhanvien WHERE GioiTinh = 'Nam'

-- tạo 1 hàm trả về 1 bảng
GO
CREATE FUNCTION F_AllNV()
RETURNS TABLE
as
     RETURN (SELECT * FROM nhanvien)
GO
SELECT * FROM dbo.F_AllNV()

-- ví dụ 3 : hàm trả ra giá trị đa câu lệnh
go 
CREATE FUNCTION F_NV_ByGT(@gt NVARCHAR(20))
RETURNS @TBL_NhanVien TABLE(Ten_NV NVARCHAR(100), Ma_NV NVARCHAR(100),GT_NV NVARCHAR(100) )
as
BEGIN     
     if(@gt is null)
     BEGIN
          INSERT into @TBL_NhanVien(Ten_NV, Ma_NV, GT_NV)
          SELECT TenNV, MaNhanVien,GioiTinh 
          from nhanvien
     END
     ELSE
     BEGIN
          INSERT into @TBL_NhanVien(Ten_NV, Ma_NV, GT_NV)
          SELECT TenNV, MaNhanVien,GioiTinh 
          from nhanvien
          WHERE GioiTinh = @gt
     END
     RETURN
END
go
select * From dbo.F_NV_ByGT(null)
select * From dbo.F_NV_ByGT('Nam')
select * From dbo.F_NV_ByGT(N'Nữ')

--view
go 
CREATE VIEW view_DSNVnu
as
SELECT * from  nhanvien WHERE GioiTinh = N'Nữ'
go
--xem view thì như sau
select * from view_DSNVnu WHERE IdCuaHang = 1

--