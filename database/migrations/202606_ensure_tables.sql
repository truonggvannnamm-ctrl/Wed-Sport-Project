-- =====================================================
-- Migration: đảm bảo tất cả bảng tồn tại
-- Chạy file này nếu bạn đang dùng DB cũ chưa có
-- bảng product_variants, reviews, contacts, wishlists
-- =====================================================
USE sportshop;

-- product_variants (nếu chưa có)
CREATE TABLE IF NOT EXISTS product_variants (
  VariantID    INT            AUTO_INCREMENT PRIMARY KEY,
  ProductID    INT            NOT NULL,
  Size         VARCHAR(30)    DEFAULT NULL,
  Color        VARCHAR(50)    DEFAULT NULL,
  VariantSKU   VARCHAR(80)    NOT NULL UNIQUE,
  ExtraPrice   DECIMAL(12,0)  NOT NULL DEFAULT 0,
  Stock        INT            NOT NULL DEFAULT 0,
  ImageURL     VARCHAR(255)   DEFAULT NULL,
  IsActive     TINYINT(1)     NOT NULL DEFAULT 1,
  CreatedAt    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_variant_product FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE
);

-- Thêm ImageURL vào product_variants nếu đang dùng DB cũ (bỏ qua lỗi nếu đã có)
ALTER TABLE product_variants ADD COLUMN IF NOT EXISTS ImageURL VARCHAR(255) DEFAULT NULL;

-- product_images (nếu chưa có)
CREATE TABLE IF NOT EXISTS product_images (
  ImageID      INT            AUTO_INCREMENT PRIMARY KEY,
  ProductID    INT            NOT NULL,
  VariantID    INT            DEFAULT NULL,
  ImageURL     VARCHAR(255)   NOT NULL,
  SortOrder    INT            NOT NULL DEFAULT 0,
  CreatedAt    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pimg_product FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE
);

-- suppliers (nếu chưa có)
CREATE TABLE IF NOT EXISTS suppliers (
  SupplierID   INT            AUTO_INCREMENT PRIMARY KEY,
  SupplierName VARCHAR(120)   NOT NULL,
  ContactName  VARCHAR(100)   DEFAULT NULL,
  Phone        VARCHAR(20)    DEFAULT NULL,
  Email        VARCHAR(120)   DEFAULT NULL,
  Address      TEXT           DEFAULT NULL,
  Note         TEXT           DEFAULT NULL,
  IsActive     TINYINT(1)     NOT NULL DEFAULT 1,
  CreatedAt    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Thêm cột SupplierID vào import_receipts nếu chưa có
-- (Chạy từng lệnh riêng, bỏ qua lỗi nếu cột đã tồn tại)
ALTER TABLE import_receipts ADD COLUMN SupplierID INT DEFAULT NULL;
ALTER TABLE import_receipts ADD CONSTRAINT fk_ir_supplier_m FOREIGN KEY (SupplierID) REFERENCES suppliers (SupplierID) ON DELETE SET NULL;

-- reviews (nếu chưa có)
CREATE TABLE IF NOT EXISTS reviews (
  ReviewID   INT          AUTO_INCREMENT PRIMARY KEY,
  UserID     INT          NOT NULL,
  ProductID  INT          NOT NULL,
  Rating     TINYINT      NOT NULL,
  Comment    TEXT         DEFAULT NULL,
  IsVisible  TINYINT(1)   NOT NULL DEFAULT 1,
  CreatedAt  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_review (UserID, ProductID),
  CONSTRAINT chk_rating CHECK (Rating BETWEEN 1 AND 5),
  CONSTRAINT fk_rev_user    FOREIGN KEY (UserID)    REFERENCES users    (UserID)    ON DELETE CASCADE,
  CONSTRAINT fk_rev_product FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE
);

-- contacts (nếu chưa có)
CREATE TABLE IF NOT EXISTS contacts (
  ContactID INT          AUTO_INCREMENT PRIMARY KEY,
  FullName  VARCHAR(120) NOT NULL,
  Email     VARCHAR(120) NOT NULL,
  Subject   VARCHAR(200) DEFAULT NULL,
  Message   TEXT         NOT NULL,
  IsRead    TINYINT(1)   NOT NULL DEFAULT 0,
  CreatedAt DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- promotion_products (nếu chưa có)
CREATE TABLE IF NOT EXISTS promotion_products (
  PromotionID INT NOT NULL,
  ProductID   INT NOT NULL,
  PRIMARY KEY (PromotionID, ProductID),
  CONSTRAINT fk_pp_promo_m   FOREIGN KEY (PromotionID) REFERENCES promotions (PromotionID) ON DELETE CASCADE,
  CONSTRAINT fk_pp_product_m FOREIGN KEY (ProductID)   REFERENCES products   (ProductID)   ON DELETE CASCADE
);

SELECT 'Migration hoàn tất!' AS result;
