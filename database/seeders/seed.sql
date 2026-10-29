-- =====================================================================
-- SPORTSHOP — Seed Data (Dữ liệu mẫu)
-- Bước 2: Chạy file này SAU khi đã chạy schema.sql
-- Mật khẩu tất cả tài khoản: Password123!
-- =====================================================================

USE sportshop;

-- ─── USERS ───────────────────────────────────────────────────────────
INSERT INTO users (FullName, Email, PasswordHash, Phone, Address, Role) VALUES
('Admin SportShop',  'admin@sportshop.vn', '$2a$10$aKuOFgrYqtqcx0YXLCrLvu2QCe6FMkejpLRc/atP.UcpaBSIBgYKy', '0901234567', '123 Nguyễn Huệ, Q1, TP.HCM',         'admin'),
('Nguyễn Văn Staff', 'staff@sportshop.vn', '$2a$10$aKuOFgrYqtqcx0YXLCrLvu2QCe6FMkejpLRc/atP.UcpaBSIBgYKy', '0912345678', '456 Lê Lợi, Q1, TP.HCM',             'staff'),
('Trần Thị An',      'an@gmail.com',        '$2a$10$aKuOFgrYqtqcx0YXLCrLvu2QCe6FMkejpLRc/atP.UcpaBSIBgYKy', '0933445566', '789 Điện Biên Phủ, Bình Thạnh, HCM', 'customer'),
('Lê Văn Bình',      'binh@gmail.com',      '$2a$10$aKuOFgrYqtqcx0YXLCrLvu2QCe6FMkejpLRc/atP.UcpaBSIBgYKy', '0944556677', '12 Cộng Hòa, Tân Bình, HCM',         'customer'),
('Phạm Thị Cúc',     'cuc@gmail.com',       '$2a$10$aKuOFgrYqtqcx0YXLCrLvu2QCe6FMkejpLRc/atP.UcpaBSIBgYKy', '0955667788', '34 Hoàng Văn Thụ, Phú Nhuận, HCM',   'customer'),
('Nguyễn Shipper',   'shipper@sportshop.vn','$2a$10$aKuOFgrYqtqcx0YXLCrLvu2QCe6FMkejpLRc/atP.UcpaBSIBgYKy', '0966778899', '56 Nguyễn Trãi, Q5, TP.HCM',          'shipper');

-- ─── CATEGORIES ──────────────────────────────────────────────────────
INSERT INTO categories (CategoryName, Slug, Description) VALUES
('Giày Thể Thao', 'giay-the-thao', 'Giày chạy bộ, giày bóng đá, giày tennis và nhiều loại giày thể thao khác từ các thương hiệu hàng đầu'),
('Quần Áo',       'quan-ao',       'Áo thun, quần short, áo khoác, legging thể thao với chất liệu cao cấp, thoáng khí'),
('Phụ Kiện',      'phu-kien',      'Balo, túi thể thao, nón, băng đô, vớ và phụ kiện thể thao đa dạng'),
('Thiết Bị Gym',  'thiet-bi-gym',  'Tạ tay, dây nhảy, thảm tập yoga, dụng cụ tập luyện tại nhà và phòng gym'),
('Bóng Đá',       'bong-da',       'Bóng đá chính hãng, giày bóng đá, găng tay thủ môn và phụ kiện bóng đá'),
('Bơi Lội',       'boi-loi',       'Đồ bơi, kính bơi, mũ bơi, dụng cụ tập bơi chuyên nghiệp');

-- ─── BRANDS ──────────────────────────────────────────────────────────
INSERT INTO brands (BrandName, Slug, Description) VALUES
('Nike',         'nike',         'Thương hiệu thể thao số 1 thế giới với slogan Just Do It — tiên phong công nghệ Air, Zoom và Flyknit'),
('Adidas',       'adidas',       'Thương hiệu thể thao Đức hơn 70 năm lịch sử với công nghệ Boost và thiết kế 3 sọc biểu tượng'),
('Puma',         'puma',         'Thương hiệu thể thao năng động từ Đức, nổi tiếng với thiết kế phá cách và hiệu suất cao'),
('New Balance',  'new-balance',  'Thương hiệu giày Mỹ chú trọng vào sự thoải mái và hỗ trợ bàn chân với công nghệ Fresh Foam và ENCAP'),
('Under Armour', 'under-armour', 'Thương hiệu trang phục hiệu năng từ Mỹ với công nghệ HeatGear, ColdGear giúp tối ưu hóa hiệu suất'),
('Mizuno',       'mizuno',       'Thương hiệu dụng cụ thể thao Nhật Bản 120 năm tuổi, nổi tiếng với giày chạy công nghệ Wave');

-- ─── SUPPLIERS ───────────────────────────────────────────────────────
INSERT INTO suppliers (SupplierName, ContactName, Phone, Email, Address, Note) VALUES
('Nike Vietnam Distribution', 'Nguyễn Minh Tuấn', '02838123456', 'nike.vn@dist.com',    'Khu CN Tân Bình, TP.HCM',     'Nhà phân phối chính hãng Nike tại VN'),
('Adidas Southeast Asia',     'Lê Thanh Hà',      '02836789012', 'adidas.sea@dist.com', 'Khu CN Bình Dương',            'Phân phối Adidas toàn Đông Nam Á'),
('Sport Supply Co.',          'Trần Văn Dũng',    '02899345678', 'sport@supply.vn',     '123 Lý Thường Kiệt, Q10, HCM', 'Nhà cung cấp đồ thể thao tổng hợp'),
('Pro Athlete Vietnam',       'Phạm Thị Mai',     '02888901234', 'pro@athlete.vn',      '456 Phan Xích Long, PN, HCM',  'Thiết bị thi đấu chuyên nghiệp');

-- ─── PRODUCTS ────────────────────────────────────────────────────────
INSERT INTO products (SKU, ProductName, Slug, Description, Price, SalePrice, StockQuantity, ImageURL, IsFeatured, IsActive, CategoryID, BrandID) VALUES

-- 1. Nike Air Max 270
('NK-AIR-001', 'Nike Air Max 270', 'nike-air-max-270',
'Nike Air Max 270 là đỉnh cao của dòng giày Air Max với đơn vị đệm khí lớn nhất từ trước đến nay — cao 32mm, bao phủ toàn bộ phần gót chân. Phần upper làm từ lưới kỹ thuật số thoáng khí kết hợp với lớp neopren ôm sát bàn chân, mang lại cảm giác nhẹ nhàng như đi trên mây. Thiết kế lấy cảm hứng từ Air Max 93, phù hợp cả đi bộ hàng ngày lẫn tập luyện nhẹ. Đế ngoài cao su chống mài mòn với họa tiết tổ ong độc đáo, đảm bảo độ bám tốt trên nhiều bề mặt.',
2990000, 2490000, 52,
'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600', 1, 1, 1, 1),

-- 2. Nike ZoomX Invincible Run
('NK-ZM-002', 'Nike ZoomX Invincible Run FK 3', 'nike-zoomx-invincible-run',
'Nike ZoomX Invincible Run FK 3 được thiết kế cho những runner nghiêm túc với mục tiêu chinh phục đường dài. Đế ZoomX — loại foam nhẹ nhất và có khả năng hoàn nguyên năng lượng cao nhất của Nike — mang lại cảm giác nảy bật kỳ diệu sau mỗi bước chạy. Phần upper Flyknit thế hệ mới ôm sát chân, thoáng khí và linh hoạt. Độ cao đế 40mm cùng cấu trúc rocker giúp chuyển tiếp bước chạy mượt mà, giảm thiểu chấn thương khi chạy dài. Lý tưởng cho marathon và các buổi chạy tempo.',
3850000, NULL, 36,
'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600', 1, 1, 1, 1),

-- 3. Nike Dri-FIT Academy
('NK-DRI-003', 'Nike Dri-FIT Academy Jersey', 'nike-dri-fit-academy',
'Áo thi đấu Nike Dri-FIT Academy được thiết kế theo chuẩn mực của các CLB bóng đá chuyên nghiệp. Công nghệ Dri-FIT tiên tiến giúp thấm hút mồ hôi tốc độ cao, kéo ẩm từ da ra bề mặt vải để bay hơi nhanh, giữ cơ thể luôn khô thoáng suốt 90 phút trên sân. Chất liệu polyester 100% nhẹ và bền, cổ tròn thoải mái với form fit vừa vặn không gây cản trở khi chuyền bóng và sút. In lưới thoáng khí ở nách và lưng tăng cường thông gió. Phù hợp cho đội bóng phong trào đến chuyên nghiệp.',
650000, 520000, 95,
'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600', 0, 1, 2, 1),

-- 4. Adidas Ultraboost 22
('AD-UB-001', 'Adidas Ultraboost 22', 'adidas-ultraboost-22',
'Adidas Ultraboost 22 kế thừa và nâng cấp từ dòng Ultraboost huyền thoại với nhiều cải tiến đáng kể. Công nghệ BOOST mới — tổ hợp của hàng nghìn viên foam TPU năng lượng cao — trả lại 80% năng lượng sau mỗi bước chạy, cho cảm giác êm ái và bền bỉ suốt buổi chạy dài. Upper Primeknit+ thế hệ mới mỏng hơn, nhẹ hơn và ôm bàn chân tự nhiên hơn. Hệ thống Torsion Spring tăng cường độ cứng giữa bàn chân, đế Continental Rubber cho độ bám xuất sắc dù trong điều kiện ẩm ướt. Phù hợp chạy bộ, gym hoặc streetwear.',
3200000, 2750000, 42,
'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600', 1, 1, 1, 2),

-- 5. Adidas Samba OG
('AD-SAM-002', 'Adidas Samba OG', 'adidas-samba-og',
'Adidas Samba OG là biểu tượng thời trang thể thao không bao giờ lỗi mốt. Ra đời năm 1950 như một đôi giày bóng đá trong nhà, Samba OG đã trở thành một trong những mẫu giày cổ điển được yêu thích nhất thế giới. Upper da bò thật với chi tiết T-toe đặc trưng, lớp lót da lộn mềm mại bên trong và đế gum ngoài màu kem tạo nên vẻ đẹp vintage độc đáo. Ba sọc Adidas nổi bật trên mũi giày là điểm nhận diện không thể nhầm lẫn. Phù hợp mix&match với mọi trang phục từ casual đến sporty.',
1890000, NULL, 55,
'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600', 1, 1, 1, 2),

-- 6. Adidas Tiro Training Short
('AD-TRF-003', 'Adidas Tiro 23 Training Short', 'adidas-tiro-training-short',
'Quần short Adidas Tiro 23 là lựa chọn hàng đầu của các cầu thủ bóng đá và VĐV tập luyện cường độ cao. Chất liệu polyester tái chế AEROREADY giúp thấm hút mồ hôi nhanh chóng và duy trì cảm giác khô thoáng liên tục. Thiết kế slim fit ôm sát chân không gây cản trở chuyển động, lon hồi co giãn 4 chiều. Phần túi sâu hai bên tiện dụng, viền ống chân đặc trưng phong cách Tiro. Logo Adidas thêu nổi bật. Phù hợp cả thi đấu lẫn đi dạo phố.',
480000, 380000, 115,
'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?w=600', 0, 1, 2, 2),

-- 7. Puma RS-X Reinvention
('PU-RS-001', 'Puma RS-X Reinvention', 'puma-rs-x-reinvention',
'Puma RS-X Reinvention được hồi sinh từ hệ thống RS (Running System) của Puma vào cuối thập niên 1980 với diện mạo hoàn toàn mới theo phong cách chunky sneaker đang thịnh hành. Phần upper kết hợp nhiều loại vật liệu: lưới kỹ thuật số, da lộn giả và da PU cao cấp tạo nên kết cấu phong phú và hiện đại. Đế RS cao su có công nghệ đệm Running System với các ô khí nhỏ li ti, vừa mang lại sự thoải mái vừa tạo điểm nhấn thẩm mỹ độc đáo. Màu sắc nổi bật, lý tưởng cho streetwear và lifestyle.',
1750000, 1490000, 45,
'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600', 0, 1, 1, 3),

-- 8. Puma Evostripe Pants
('PU-EVO-002', 'Puma Evostripe Core Sweatpants', 'puma-evostripe-pants',
'Quần jogger Puma Evostripe Core là sự kết hợp hoàn hảo giữa phong cách và tính năng thể thao. Chất liệu cotton French Terry dày dặn, mềm mại, giữ ấm tốt cho những ngày se lạnh. Phần co giãn 4 chiều thoải mái với mọi chuyển động từ yoga, chạy bộ đến ngồi thiền. Dải sọc Puma dọc hai bên ống chân tạo dáng thon dài, cạp thun cao kèm dây rút điều chỉnh vòng eo. Túi hông rộng và túi sau có khóa zip tiện dụng. Gấu ống có bo chun gọn gàng. Phong cách athleisure đúng nghĩa.',
890000, NULL, 65,
'https://images.unsplash.com/photo-1516478177764-9fe5bd7e9717?w=600', 0, 1, 2, 3),

-- 9. New Balance 574
('NB-574-001', 'New Balance 574 Core', 'new-balance-574',
'New Balance 574 là một trong những mẫu giày iconic nhất lịch sử New Balance, ra đời năm 1988 và đến nay vẫn giữ nguyên sức hút. Phần upper da lộn và lưới tổng hợp chắc chắn, thoáng khí với nhiều lớp gia công tỉ mỉ. Công nghệ ENCAP — lõi polyurethane bao bọc đế foam EVA — cung cấp sự hỗ trợ vượt trội và độ bền cao. Logo "N" nổi bật thêu tay trên hai bên giày. Đế gum ở phần gót chống trơn trượt hiệu quả. Phù hợp đi bộ cả ngày, vừa thời trang vừa cực kỳ thoải mái.',
2150000, NULL, 30,
'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600', 0, 1, 1, 4),

-- 10. Under Armour HeatGear
('UA-HG-001', 'Under Armour HeatGear Armour Tee', 'under-armour-heatgear-tee',
'Under Armour HeatGear Armour Tee là lựa chọn số 1 cho các buổi tập trong thời tiết nóng. Công nghệ HeatGear thế hệ mới với chất liệu microfiber siêu mỏng — mỏng hơn cotton nhưng bền gấp đôi — kéo ẩm ra khỏi da tức thời và bay hơi nhanh, giữ cơ thể mát mẻ và khô ráo. Cổ áo tròn có phần gia cố chống chảy xệ. Đường may phẳng Anti-odour chống mùi suốt buổi tập dài. Form fit ôm sát người, tôn lên cơ bắp mà không gây bí bách. Sợi 4-way stretch cho tự do chuyển động tối đa.',
720000, 580000, 95,
'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600', 0, 1, 2, 5),

-- 11. Under Armour Hustle 5.0
('UA-BAG-001', 'Under Armour Hustle 5.0 Backpack', 'under-armour-hustle-5',
'Under Armour Hustle 5.0 Backpack là người bạn đồng hành lý tưởng cho dân thể thao và học sinh sinh viên năng động. Chất liệu 600D polyester phủ lớp chống nước UA Storm, ngăn ẩm xâm nhập hiệu quả trong mưa nhẹ. Dung tích 30L với ngăn chính rộng chứa được quần áo tập, giày và đồ dùng cá nhân. Ngăn phụ có dây kéo tổ chức đồ điện tử và phụ kiện nhỏ. Túi bên ngoài chứa chai nước 1L. Dây đeo có phần đệm foam dày, giảm áp lực vai. Khung lưng thoáng khí chống đổ mồ hôi. Chốt khoá chắc chắn.',
1350000, NULL, 25,
'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600', 0, 1, 3, 5),

-- 12. Mizuno Wave Rider 26
('MZ-WV-001', 'Mizuno Wave Rider 26', 'mizuno-wave-rider-26',
'Mizuno Wave Rider 26 là thế hệ mới nhất của dòng giày chạy lâu đời nhất Mizuno với hơn 25 năm phát triển liên tục. Công nghệ Wave đặc trưng — tấm nhựa PEBAX hình sóng chèn vào giữa các lớp đế — tạo nên sự kết hợp hoàn hảo giữa đệm êm và hỗ trợ ổn định, khác hoàn toàn với foam thuần túy. Đế X10 Carbon Rubber siêu bền ở phần gót, đế Blown Rubber nhẹ và bám chắc ở phần mũi. Upper Engineered Woven Mesh thoáng khí tối đa, hỗ trợ bàn chân tự nhiên. Độ offset 12mm lý tưởng cho người chạy heel-strike. Chứng nhận từ các tổ chức chạy bộ quốc tế.',
2850000, 2350000, 32,
'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600', 1, 1, 1, 6),

-- 13. New Balance Fresh Foam X
('NB-FR-002', 'New Balance Fresh Foam X 1080v13', 'new-balance-fresh-foam-x',
'New Balance Fresh Foam X 1080v13 là đỉnh cao của dòng giày chạy high-cushion từ New Balance, lý tưởng cho các buổi chạy hồi phục và easy run dài. Fresh Foam X — công nghệ foam đúc một khối được thiết kế bằng AI dựa trên phân tích hàng triệu điểm dữ liệu từ runner — mang lại cảm giác êm ái đồng đều và nhất quán từ km đầu đến km cuối. Upper Hypoknit ôm nhẹ nhàng, thoáng khí và có độ co giãn vừa phải. Đế ngoài FullGround cao su rộng, tăng độ tiếp xúc mặt đất và bám đường tốt. Trọng lượng chỉ 280g cho size 42.',
2490000, 1990000, 38,
'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600', 0, 1, 1, 4);

-- ─── PRODUCT VARIANTS ────────────────────────────────────────────────

-- 1. Nike Air Max 270
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(1,'39','Trắng/Đen', 'NK-AIR-001-39-WB', 0,     8,  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(1,'40','Trắng/Đen', 'NK-AIR-001-40-WB', 0,     10, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(1,'41','Trắng/Đen', 'NK-AIR-001-41-WB', 0,     9,  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(1,'42','Trắng/Đen', 'NK-AIR-001-42-WB', 0,     8,  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(1,'43','Đen/Trắng', 'NK-AIR-001-43-BW', 0,     5,  'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(1,'44','Đen/Trắng', 'NK-AIR-001-44-BW', 0,     5,  'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(1,'40','Đỏ/Đen',    'NK-AIR-001-40-RD', 50000, 7,  'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600'),
(1,'41','Đỏ/Đen',    'NK-AIR-001-41-RD', 50000, 7,  'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600'),
(1,'42','Đỏ/Đen',    'NK-AIR-001-42-RD', 50000, 4,  'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600');

-- 2. Nike ZoomX Invincible Run
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(2,'40','Đen',   'NK-ZM-002-40-BK', 0, 6, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(2,'41','Đen',   'NK-ZM-002-41-BK', 0, 8, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(2,'42','Đen',   'NK-ZM-002-42-BK', 0, 8, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(2,'43','Đen',   'NK-ZM-002-43-BK', 0, 5, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(2,'41','Xanh',  'NK-ZM-002-41-BL', 0, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(2,'42','Xanh',  'NK-ZM-002-42-BL', 0, 5, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(2,'41','Trắng', 'NK-ZM-002-41-WH', 0, 3, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(2,'42','Trắng', 'NK-ZM-002-42-WH', 0, 4, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600');

-- 3. Nike Dri-FIT
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(3,'S', 'Đen',   'NK-DRI-003-S-BK',  0, 20, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(3,'M', 'Đen',   'NK-DRI-003-M-BK',  0, 25, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(3,'L', 'Đen',   'NK-DRI-003-L-BK',  0, 20, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(3,'XL','Đen',   'NK-DRI-003-XL-BK', 0, 15, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(3,'S', 'Trắng', 'NK-DRI-003-S-WH',  0, 15, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600'),
(3,'M', 'Trắng', 'NK-DRI-003-M-WH',  0, 20, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600'),
(3,'L', 'Trắng', 'NK-DRI-003-L-WH',  0, 12, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600'),
(3,'S', 'Đỏ',    'NK-DRI-003-S-RD',  0, 10, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600'),
(3,'M', 'Đỏ',    'NK-DRI-003-M-RD',  0, 12, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600'),
(3,'L', 'Đỏ',    'NK-DRI-003-L-RD',  0, 8,  'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600');

-- 4. Adidas Ultraboost 22
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(4,'39','Đen',       'AD-UB-001-39-BK', 0,      5, 'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600'),
(4,'40','Đen',       'AD-UB-001-40-BK', 0,      7, 'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600'),
(4,'41','Đen',       'AD-UB-001-41-BK', 0,      8, 'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600'),
(4,'42','Trắng',     'AD-UB-001-42-WH', 0,      7, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(4,'43','Trắng',     'AD-UB-001-43-WH', 0,      5, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(4,'44','Xanh Navy', 'AD-UB-001-44-NV', 100000, 3, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(4,'40','Xanh Navy', 'AD-UB-001-40-NV', 100000, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(4,'41','Xanh Navy', 'AD-UB-001-41-NV', 100000, 5, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600');

-- 5. Adidas Samba OG
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(5,'38','Trắng/Đen', 'AD-SAM-002-38-WB', 0, 8,  'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(5,'39','Trắng/Đen', 'AD-SAM-002-39-WB', 0, 10, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(5,'40','Trắng/Đen', 'AD-SAM-002-40-WB', 0, 12, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(5,'41','Trắng/Đen', 'AD-SAM-002-41-WB', 0, 10, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(5,'42','Trắng/Đen', 'AD-SAM-002-42-WB', 0, 8,  'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(5,'39','Đen/Trắng', 'AD-SAM-002-39-BW', 0, 6,  'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(5,'40','Đen/Trắng', 'AD-SAM-002-40-BW', 0, 7,  'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(5,'41','Đen/Trắng', 'AD-SAM-002-41-BW', 0, 6,  'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600');

-- 6. Adidas Tiro Short
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(6,'S', 'Đen',       'AD-TRF-003-S-BK',  0, 25, 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?w=600'),
(6,'M', 'Đen',       'AD-TRF-003-M-BK',  0, 30, 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?w=600'),
(6,'L', 'Đen',       'AD-TRF-003-L-BK',  0, 25, 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?w=600'),
(6,'XL','Đen',       'AD-TRF-003-XL-BK', 0, 20, 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?w=600'),
(6,'S', 'Xanh Navy', 'AD-TRF-003-S-NV',  0, 15, 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600'),
(6,'M', 'Xanh Navy', 'AD-TRF-003-M-NV',  0, 18, 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600'),
(6,'L', 'Xanh Navy', 'AD-TRF-003-L-NV',  0, 12, 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600'),
(6,'M', 'Đỏ',        'AD-TRF-003-M-RD',  0, 10, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(6,'L', 'Đỏ',        'AD-TRF-003-L-RD',  0, 8,  'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600');

-- 7. Puma RS-X
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(7,'39','Trắng/Đỏ',   'PU-RS-001-39-WR', 0, 7, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(7,'40','Trắng/Đỏ',   'PU-RS-001-40-WR', 0, 9, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(7,'41','Trắng/Đỏ',   'PU-RS-001-41-WR', 0, 8, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(7,'42','Trắng/Đỏ',   'PU-RS-001-42-WR', 0, 7, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(7,'40','Đen/Vàng',   'PU-RS-001-40-BY', 0, 5, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(7,'41','Đen/Vàng',   'PU-RS-001-41-BY', 0, 6, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(7,'42','Đen/Vàng',   'PU-RS-001-42-BY', 0, 5, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(7,'40','Xanh/Trắng', 'PU-RS-001-40-BW', 0, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(7,'41','Xanh/Trắng', 'PU-RS-001-41-BW', 0, 5, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600');

-- 8. Puma Evostripe Pants
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(8,'S', 'Đen',  'PU-EVO-002-S-BK',  0, 15, 'https://images.unsplash.com/photo-1516478177764-9fe5bd7e9717?w=600'),
(8,'M', 'Đen',  'PU-EVO-002-M-BK',  0, 18, 'https://images.unsplash.com/photo-1516478177764-9fe5bd7e9717?w=600'),
(8,'L', 'Đen',  'PU-EVO-002-L-BK',  0, 15, 'https://images.unsplash.com/photo-1516478177764-9fe5bd7e9717?w=600'),
(8,'XL','Đen',  'PU-EVO-002-XL-BK', 0, 10, 'https://images.unsplash.com/photo-1516478177764-9fe5bd7e9717?w=600'),
(8,'S', 'Xám',  'PU-EVO-002-S-GY',  0, 10, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(8,'M', 'Xám',  'PU-EVO-002-M-GY',  0, 12, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(8,'L', 'Xám',  'PU-EVO-002-L-GY',  0, 10, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(8,'M', 'Tím',  'PU-EVO-002-M-PU',  0, 5,  'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600'),
(8,'L', 'Tím',  'PU-EVO-002-L-PU',  0, 5,  'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600');

-- 9. New Balance 574
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(9,'38','Xám/Trắng',  'NB-574-001-38-GW', 0, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(9,'39','Xám/Trắng',  'NB-574-001-39-GW', 0, 5, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(9,'40','Xám/Trắng',  'NB-574-001-40-GW', 0, 6, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(9,'41','Xám/Trắng',  'NB-574-001-41-GW', 0, 5, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(9,'42','Xám/Trắng',  'NB-574-001-42-GW', 0, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(9,'39','Navy/Trắng', 'NB-574-001-39-NW', 0, 4, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(9,'40','Navy/Trắng', 'NB-574-001-40-NW', 0, 5, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(9,'41','Navy/Trắng', 'NB-574-001-41-NW', 0, 4, 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(9,'40','Đen/Vàng',   'NB-574-001-40-BY', 0, 4, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(9,'41','Đen/Vàng',   'NB-574-001-41-BY', 0, 3, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600');

-- 10. Under Armour HeatGear
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(10,'S', 'Đen',   'UA-HG-001-S-BK',  0, 20, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600'),
(10,'M', 'Đen',   'UA-HG-001-M-BK',  0, 25, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600'),
(10,'L', 'Đen',   'UA-HG-001-L-BK',  0, 22, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600'),
(10,'XL','Đen',   'UA-HG-001-XL-BK', 0, 15, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600'),
(10,'S', 'Trắng', 'UA-HG-001-S-WH',  0, 12, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600'),
(10,'M', 'Trắng', 'UA-HG-001-M-WH',  0, 15, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600'),
(10,'L', 'Trắng', 'UA-HG-001-L-WH',  0, 10, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600'),
(10,'M', 'Xám',   'UA-HG-001-M-GY',  0, 15, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(10,'L', 'Xám',   'UA-HG-001-L-GY',  0, 10, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50c?w=600'),
(10,'M', 'Đỏ',    'UA-HG-001-M-RD',  0, 8,  'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600'),
(10,'L', 'Đỏ',    'UA-HG-001-L-RD',  0, 6,  'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=600');

-- 11. UA Hustle Backpack
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(11,'One Size','Đen',       'UA-BAG-001-OS-BK', 0,     10, 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600'),
(11,'One Size','Xám',       'UA-BAG-001-OS-GY', 0,     8,  'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600'),
(11,'One Size','Xanh Navy', 'UA-BAG-001-OS-NV', 0,     5,  'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=600'),
(11,'One Size','Đỏ',        'UA-BAG-001-OS-RD', 50000, 3,  'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600');

-- 12. Mizuno Wave Rider 26
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(12,'39','Đen/Bạc',   'MZ-WV-001-39-BS', 0, 5, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(12,'40','Đen/Bạc',   'MZ-WV-001-40-BS', 0, 6, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(12,'41','Đen/Bạc',   'MZ-WV-001-41-BS', 0, 7, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(12,'42','Đen/Bạc',   'MZ-WV-001-42-BS', 0, 6, 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600'),
(12,'40','Trắng/Xanh','MZ-WV-001-40-WB', 0, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(12,'41','Trắng/Xanh','MZ-WV-001-41-WB', 0, 5, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(12,'42','Trắng/Xanh','MZ-WV-001-42-WB', 0, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(12,'40','Đỏ/Đen',    'MZ-WV-001-40-RB', 0, 3, 'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600'),
(12,'41','Đỏ/Đen',    'MZ-WV-001-41-RB', 0, 4, 'https://images.unsplash.com/photo-1608231387042-66d1773d3028?w=600');

-- 13. New Balance Fresh Foam X
INSERT INTO product_variants (ProductID, Size, Color, VariantSKU, ExtraPrice, Stock, ImageURL) VALUES
(13,'39','Trắng',      'NB-FR-002-39-WH', 0,      6, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(13,'40','Trắng',      'NB-FR-002-40-WH', 0,      8, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(13,'41','Trắng',      'NB-FR-002-41-WH', 0,      8, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(13,'42','Trắng',      'NB-FR-002-42-WH', 0,      7, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=600'),
(13,'40','Đen/Xám',    'NB-FR-002-40-BG', 0,      5, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(13,'41','Đen/Xám',    'NB-FR-002-41-BG', 0,      6, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(13,'42','Đen/Xám',    'NB-FR-002-42-BG', 0,      5, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
(13,'40','Xanh/Trắng', 'NB-FR-002-40-BW', 100000, 3, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600'),
(13,'41','Xanh/Trắng', 'NB-FR-002-41-BW', 100000, 4, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600');

-- ─── PROMOTIONS ──────────────────────────────────────────────────────
INSERT INTO promotions (Title, Description, DiscountPercent, StartDate, EndDate, IsActive) VALUES
('Mùa Hè Bùng Cháy',     'Giảm giá lên đến 20% cho giày thể thao Nike và Adidas nhân dịp hè 2026.', 20, '2026-06-01', '2026-08-31', 1),
('Flash Sale Cuối Tuần',  'Khuyến mãi đặc biệt mỗi cuối tuần — số lượng có hạn, nhanh tay kẻo lỡ.', 15, '2026-06-01', '2026-12-31', 1),
('Khách Hàng Thân Thiết', 'Ưu đãi dành riêng cho khách hàng mua từ lần thứ 3 trở đi.',              10, '2026-01-01', '2026-12-31', 1);

INSERT INTO promotion_products (PromotionID, ProductID) VALUES
(1,1),(1,2),(1,4),(1,5),
(2,3),(2,6),(2,7),(2,10),
(3,8),(3,9),(3,11),(3,12);

-- ─── IMPORT RECEIPTS ─────────────────────────────────────────────────
INSERT INTO import_receipts (ReceiptCode, SupplierID, StaffID, Note, TotalAmount) VALUES
('IMP-20260603-001', 1, 2, 'Nhập giày Nike đầu tháng 6/2026',   45000000),
('IMP-20260603-002', 2, 2, 'Nhập giày Adidas tháng 6/2026',     38500000),
('IMP-20260603-003', 3, 2, 'Nhập phụ kiện và quần áo tổng hợp', 22000000);

INSERT INTO import_receipt_items (ImportReceiptID, ProductID, Quantity, ImportPrice) VALUES
(1,1,20,1500000),(1,2,10,2100000),(1,3,30,320000),
(2,4,15,1600000),(2,5,20,950000), (2,6,40,240000),
(3,8,20,550000), (3,10,30,420000),(3,11,10,800000);

-- ─── ORDERS ──────────────────────────────────────────────────────────
INSERT INTO orders (UserID, OrderCode, TotalAmount, Status, PaymentStatus, ShippingAddress, Phone, Note) VALUES
(3,'ORD-20260603-001',4980000,'delivered','paid',   'Người nhận: Trần Thị An - 789 Điện Biên Phủ, Bình Thạnh, HCM','0933445566',NULL),
(4,'ORD-20260603-002',3130000,'shipping', 'unpaid', 'Người nhận: Lê Văn Bình - 12 Cộng Hòa, Tân Bình, HCM',        '0944556677','Giao buổi chiều'),
(5,'ORD-20260603-003',2490000,'confirmed','unpaid', 'Người nhận: Phạm Thị Cúc - 34 Hoàng Văn Thụ, Phú Nhuận, HCM','0955667788',NULL),
(3,'ORD-20260603-004',1480000,'pending',  'unpaid', 'Người nhận: Trần Thị An - 789 Điện Biên Phủ, Bình Thạnh, HCM','0933445566','Tặng bạn bè');

INSERT INTO order_items (OrderID, ProductID, ProductName, Price, Quantity) VALUES
(1,1,'Nike Air Max 270',2490000,1),(1,4,'Adidas Ultraboost 22',2490000,1),
(2,4,'Adidas Ultraboost 22',2750000,1),(2,6,'Adidas Tiro Training Short',380000,1),
(3,1,'Nike Air Max 270',2490000,1),
(4,3,'Nike Dri-FIT Academy',520000,1),(4,6,'Adidas Tiro Training Short',380000,1),(4,10,'Under Armour HeatGear Tee',580000,1);

INSERT INTO invoices (OrderID, InvoiceCode, TotalAmount) VALUES
(1,'INV-20260603-001',4980000);

-- ─── REVIEWS ─────────────────────────────────────────────────────────
INSERT INTO reviews (UserID, ProductID, Rating, Comment) VALUES
(3,1,5,'Giày cực kỳ êm, đi cả ngày không mỏi. Đệm khí Air Max 270 thật sự tuyệt vời, cảm giác như đi trên mây. Thiết kế đẹp, rất đáng tiền!'),
(4,4,4,'Adidas Boost thật sự rất tốt, nhẹ và đệm êm. Trừ 1 sao vì size hơi rộng hơn bình thường, mọi người nên order xuống 1 size.'),
(5,1,5,'Mua lần 2 rồi, Nike Air Max 270 là lựa chọn yêu thích của mình. Màu Trắng/Đen rất dễ phối đồ.'),
(3,4,4,'Adidas Ultraboost chạy rất tốt, nhưng giá hơi cao. Tuy nhiên so với chất lượng thì vẫn xứng đáng.'),
(4,3,5,'Áo mặc thoáng lắm, chất vải co giãn tốt. Đi đá bóng 2 tiếng mà không cảm thấy nóng bức gì.');

-- ─── CONTACTS ────────────────────────────────────────────────────────
INSERT INTO contacts (FullName, Email, Subject, Message) VALUES
('Nguyễn Văn Test','test@gmail.com','Hỏi về chính sách đổi trả',
 'Tôi muốn biết thêm về chính sách đổi trả giày, cụ thể là thời hạn và điều kiện.');

-- ─── COUPONS ─────────────────────────────────────────────────────────
INSERT INTO coupons (Code, Description, DiscountType, DiscountValue, MinOrderAmount, MaxUsage, IsActive, StartDate, EndDate) VALUES
('WELCOME10',  'Giảm 10% cho đơn đầu tiên',      'percent', 10,   0,        100, 1, NULL, '2027-12-31'),
('SUMMER20',   'Giảm 20% mùa hè',                'percent', 20,   500000,    50, 1, '2026-06-01', '2026-08-31'),
('SAVE100K',   'Giảm 100.000đ cho đơn từ 800k',  'fixed',   100000, 800000,  0,  1, NULL, NULL),
('FLASH50',    'Flash sale giảm 50%',             'percent', 50,   200000,    20, 0, NULL, '2026-05-31');

SELECT 'Seed data hoàn tất!' AS result;
