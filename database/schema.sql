-- =====================================================================
-- SPORTSHOP — Schema (Cấu trúc database)
-- Bước 1: Chạy file này trước để tạo database và các bảng
-- Tự động XÓA và TẠO LẠI toàn bộ database
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS sportshop;
CREATE DATABASE sportshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sportshop;

-- ─── 1. users ────────────────────────────────────────────────────────
CREATE TABLE users (
  UserID       INT          NOT NULL AUTO_INCREMENT,
  FullName     VARCHAR(120) NOT NULL,
  Email        VARCHAR(120) NOT NULL,
  PasswordHash VARCHAR(255) NOT NULL,
  Phone        VARCHAR(20)  DEFAULT NULL,
  Address      TEXT         DEFAULT NULL,
  Role         VARCHAR(10)  NOT NULL DEFAULT 'customer',
  IsActive     TINYINT(1)   NOT NULL DEFAULT 1,
  CreatedAt    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (UserID),
  UNIQUE KEY uq_users_email (Email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 2. categories ───────────────────────────────────────────────────
CREATE TABLE categories (
  CategoryID   INT          NOT NULL AUTO_INCREMENT,
  CategoryName VARCHAR(100) NOT NULL,
  Slug         VARCHAR(120) NOT NULL,
  Description  TEXT         DEFAULT NULL,
  IsActive     TINYINT(1)   NOT NULL DEFAULT 1,
  CreatedAt    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CategoryID),
  UNIQUE KEY uq_categories_slug (Slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 3. brands ───────────────────────────────────────────────────────
CREATE TABLE brands (
  BrandID     INT          NOT NULL AUTO_INCREMENT,
  BrandName   VARCHAR(100) NOT NULL,
  Slug        VARCHAR(120) NOT NULL,
  Description TEXT         DEFAULT NULL,
  LogoURL     VARCHAR(255) DEFAULT NULL,
  IsActive    TINYINT(1)   NOT NULL DEFAULT 1,
  CreatedAt   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (BrandID),
  UNIQUE KEY uq_brands_slug (Slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 4. products ─────────────────────────────────────────────────────
CREATE TABLE products (
  ProductID     INT            NOT NULL AUTO_INCREMENT,
  SKU           VARCHAR(60)    NOT NULL,
  ProductName   VARCHAR(200)   NOT NULL,
  Slug          VARCHAR(220)   NOT NULL,
  Description   TEXT           DEFAULT NULL,
  Price         DECIMAL(12,0)  NOT NULL DEFAULT 0,
  SalePrice     DECIMAL(12,0)  DEFAULT NULL,
  StockQuantity INT            NOT NULL DEFAULT 0,
  ImageURL      VARCHAR(255)   DEFAULT NULL,
  IsFeatured    TINYINT(1)     NOT NULL DEFAULT 0,
  IsActive      TINYINT(1)     NOT NULL DEFAULT 1,
  CategoryID    INT            DEFAULT NULL,
  BrandID       INT            DEFAULT NULL,
  CreatedAt     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (ProductID),
  UNIQUE KEY uq_sku  (SKU),
  UNIQUE KEY uq_slug (Slug),
  KEY idx_cat    (CategoryID),
  KEY idx_brand  (BrandID),
  KEY idx_active (IsActive, IsFeatured),
  CONSTRAINT fk_prod_cat   FOREIGN KEY (CategoryID) REFERENCES categories (CategoryID) ON DELETE SET NULL,
  CONSTRAINT fk_prod_brand FOREIGN KEY (BrandID)    REFERENCES brands     (BrandID)    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 5. product_variants (ImageURL để đổi ảnh theo màu) ──────────────
CREATE TABLE product_variants (
  VariantID    INT            NOT NULL AUTO_INCREMENT,
  ProductID    INT            NOT NULL,
  Size         VARCHAR(30)    DEFAULT NULL,
  Color        VARCHAR(50)    DEFAULT NULL,
  VariantSKU   VARCHAR(80)    NOT NULL,
  ExtraPrice   DECIMAL(12,0)  NOT NULL DEFAULT 0,
  Stock        INT            NOT NULL DEFAULT 0,
  ImageURL     VARCHAR(255)   DEFAULT NULL,
  IsActive     TINYINT(1)     NOT NULL DEFAULT 1,
  CreatedAt    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (VariantID),
  UNIQUE KEY uq_variant_sku (VariantSKU),
  KEY idx_var_prod (ProductID),
  CONSTRAINT fk_var_prod FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 6. product_images ───────────────────────────────────────────────
CREATE TABLE product_images (
  ImageID   INT          NOT NULL AUTO_INCREMENT,
  ProductID INT          NOT NULL,
  VariantID INT          DEFAULT NULL,
  ImageURL  VARCHAR(255) NOT NULL,
  Color     VARCHAR(50)  DEFAULT NULL,
  SortOrder INT          NOT NULL DEFAULT 0,
  CreatedAt DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ImageID),
  CONSTRAINT fk_pimg_prod FOREIGN KEY (ProductID) REFERENCES products         (ProductID) ON DELETE CASCADE,
  CONSTRAINT fk_pimg_var  FOREIGN KEY (VariantID) REFERENCES product_variants (VariantID) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 7. suppliers ────────────────────────────────────────────────────
CREATE TABLE suppliers (
  SupplierID   INT          NOT NULL AUTO_INCREMENT,
  SupplierName VARCHAR(120) NOT NULL,
  ContactName  VARCHAR(100) DEFAULT NULL,
  Phone        VARCHAR(20)  DEFAULT NULL,
  Email        VARCHAR(120) DEFAULT NULL,
  Address      TEXT         DEFAULT NULL,
  Note         TEXT         DEFAULT NULL,
  IsActive     TINYINT(1)   NOT NULL DEFAULT 1,
  CreatedAt    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (SupplierID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 8. import_receipts ──────────────────────────────────────────────
CREATE TABLE import_receipts (
  ImportReceiptID INT           NOT NULL AUTO_INCREMENT,
  ReceiptCode     VARCHAR(30)   NOT NULL,
  SupplierID      INT           DEFAULT NULL,
  StaffID         INT           DEFAULT NULL,
  Note            TEXT          DEFAULT NULL,
  TotalAmount     DECIMAL(14,0) NOT NULL DEFAULT 0,
  IsDeleted       TINYINT(1)    NOT NULL DEFAULT 0,
  CreatedAt       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ImportReceiptID),
  UNIQUE KEY uq_receipt_code (ReceiptCode),
  CONSTRAINT fk_ir_sup   FOREIGN KEY (SupplierID) REFERENCES suppliers (SupplierID) ON DELETE SET NULL,
  CONSTRAINT fk_ir_staff FOREIGN KEY (StaffID)    REFERENCES users      (UserID)     ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 9. import_receipt_items ─────────────────────────────────────────
CREATE TABLE import_receipt_items (
  ItemID          INT           NOT NULL AUTO_INCREMENT,
  ImportReceiptID INT           NOT NULL,
  ProductID       INT           NOT NULL,
  VariantID       INT           DEFAULT NULL,
  Quantity        INT           NOT NULL DEFAULT 1,
  ImportPrice     DECIMAL(12,0) NOT NULL DEFAULT 0,
  PRIMARY KEY (ItemID),
  CONSTRAINT fk_iri_rec  FOREIGN KEY (ImportReceiptID) REFERENCES import_receipts  (ImportReceiptID) ON DELETE CASCADE,
  CONSTRAINT fk_iri_prod FOREIGN KEY (ProductID)       REFERENCES products          (ProductID)       ON DELETE CASCADE,
  CONSTRAINT fk_iri_var  FOREIGN KEY (VariantID)       REFERENCES product_variants  (VariantID)       ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 10. carts ───────────────────────────────────────────────────────
CREATE TABLE carts (
  CartID    INT      NOT NULL AUTO_INCREMENT,
  UserID    INT      NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CartID),
  UNIQUE KEY uq_cart_user (UserID),
  CONSTRAINT fk_cart_user FOREIGN KEY (UserID) REFERENCES users (UserID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 11. cart_items ──────────────────────────────────────────────────
CREATE TABLE cart_items (
  CartItemID INT      NOT NULL AUTO_INCREMENT,
  CartID     INT      NOT NULL,
  ProductID  INT      NOT NULL,
  VariantID  INT      DEFAULT NULL,
  Quantity   INT      NOT NULL DEFAULT 1,
  CreatedAt  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CartItemID),
  KEY idx_ci_cart (CartID),
  CONSTRAINT fk_ci_cart FOREIGN KEY (CartID)    REFERENCES carts            (CartID)    ON DELETE CASCADE,
  CONSTRAINT fk_ci_prod FOREIGN KEY (ProductID) REFERENCES products         (ProductID) ON DELETE CASCADE,
  CONSTRAINT fk_ci_var  FOREIGN KEY (VariantID) REFERENCES product_variants (VariantID) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 12. orders ──────────────────────────────────────────────────────
CREATE TABLE orders (
  OrderID         INT            NOT NULL AUTO_INCREMENT,
  UserID          INT            NOT NULL,
  OrderCode       VARCHAR(30)    NOT NULL,
  TotalAmount     DECIMAL(14,0)  NOT NULL DEFAULT 0,
  Status          VARCHAR(20)    NOT NULL DEFAULT 'pending',
  PaymentStatus   VARCHAR(10)    NOT NULL DEFAULT 'unpaid',
  ShippingAddress TEXT           NOT NULL,
  Phone           VARCHAR(20)    NOT NULL,
  Note            TEXT           DEFAULT NULL,
  CouponCode      VARCHAR(30)    DEFAULT NULL,
  DiscountAmount  DECIMAL(14,0)  NOT NULL DEFAULT 0,
  CreatedAt       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (OrderID),
  UNIQUE KEY uq_order_code (OrderCode),
  KEY idx_orders_user   (UserID),
  KEY idx_orders_status (Status),
  CONSTRAINT fk_order_user FOREIGN KEY (UserID) REFERENCES users (UserID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 13. order_items ─────────────────────────────────────────────────
CREATE TABLE order_items (
  OrderItemID  INT            NOT NULL AUTO_INCREMENT,
  OrderID      INT            NOT NULL,
  ProductID    INT            DEFAULT NULL,
  VariantID    INT            DEFAULT NULL,
  ProductName  VARCHAR(200)   NOT NULL,
  VariantLabel VARCHAR(80)    DEFAULT NULL,
  Price        DECIMAL(12,0)  NOT NULL DEFAULT 0,
  Quantity     INT            NOT NULL DEFAULT 1,
  PRIMARY KEY (OrderItemID),
  KEY idx_oi_order (OrderID),
  CONSTRAINT fk_oi_order FOREIGN KEY (OrderID)   REFERENCES orders           (OrderID)   ON DELETE CASCADE,
  CONSTRAINT fk_oi_prod  FOREIGN KEY (ProductID) REFERENCES products         (ProductID) ON DELETE SET NULL,
  CONSTRAINT fk_oi_var   FOREIGN KEY (VariantID) REFERENCES product_variants (VariantID) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 14. invoices ────────────────────────────────────────────────────
CREATE TABLE invoices (
  InvoiceID   INT            NOT NULL AUTO_INCREMENT,
  OrderID     INT            NOT NULL,
  InvoiceCode VARCHAR(30)    NOT NULL,
  TotalAmount DECIMAL(14,0)  NOT NULL DEFAULT 0,
  IssuedAt    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (InvoiceID),
  UNIQUE KEY uq_inv_order (OrderID),
  UNIQUE KEY uq_inv_code  (InvoiceCode),
  CONSTRAINT fk_inv_order FOREIGN KEY (OrderID) REFERENCES orders (OrderID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 15. promotions ──────────────────────────────────────────────────
CREATE TABLE promotions (
  PromotionID     INT                    NOT NULL AUTO_INCREMENT,
  Title           VARCHAR(160)           NOT NULL,
  DiscountType    ENUM('percent','fixed') NOT NULL DEFAULT 'percent',
  Description     TEXT                   DEFAULT NULL,
  DiscountPercent TINYINT                NOT NULL DEFAULT 0,
  DiscountAmount  DECIMAL(12,0)          NOT NULL DEFAULT 0,
  StartDate       DATE                   DEFAULT NULL,
  EndDate         DATE                   DEFAULT NULL,
  IsActive        TINYINT(1)             NOT NULL DEFAULT 1,
  CreatedAt       DATETIME               NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt       DATETIME               NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (PromotionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 16. promotion_products ──────────────────────────────────────────
CREATE TABLE promotion_products (
  PromotionID INT NOT NULL,
  ProductID   INT NOT NULL,
  PRIMARY KEY (PromotionID, ProductID),
  CONSTRAINT fk_pp_promo FOREIGN KEY (PromotionID) REFERENCES promotions (PromotionID) ON DELETE CASCADE,
  CONSTRAINT fk_pp_prod  FOREIGN KEY (ProductID)   REFERENCES products   (ProductID)   ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 17. coupons ─────────────────────────────────────────────────────
CREATE TABLE coupons (
  CouponID       INT                    NOT NULL AUTO_INCREMENT,
  Code           VARCHAR(30)            NOT NULL,
  Description    VARCHAR(255)           DEFAULT NULL,
  DiscountType   ENUM('percent','fixed') NOT NULL DEFAULT 'percent',
  DiscountValue  DECIMAL(12,2)          NOT NULL DEFAULT 0,
  MinOrderAmount DECIMAL(14,0)          NOT NULL DEFAULT 0,
  MaxUsage       INT                    NOT NULL DEFAULT 0,
  UsedCount      INT                    NOT NULL DEFAULT 0,
  IsActive       TINYINT(1)             NOT NULL DEFAULT 1,
  StartDate      DATE                   DEFAULT NULL,
  EndDate        DATE                   DEFAULT NULL,
  CreatedAt      DATETIME               NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt      DATETIME               NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (CouponID),
  UNIQUE KEY uq_coupon_code (Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 18. coupon_usages ───────────────────────────────────────────────
CREATE TABLE coupon_usages (
  UsageID        INT           NOT NULL AUTO_INCREMENT,
  CouponID       INT           NOT NULL,
  UserID         INT           NOT NULL,
  OrderID        INT           DEFAULT NULL,
  DiscountAmount DECIMAL(14,0) NOT NULL DEFAULT 0,
  CreatedAt      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UsageID),
  KEY idx_cu_coupon (CouponID),
  KEY idx_cu_user   (UserID),
  CONSTRAINT fk_cu_coupon FOREIGN KEY (CouponID) REFERENCES coupons (CouponID) ON DELETE CASCADE,
  CONSTRAINT fk_cu_user   FOREIGN KEY (UserID)   REFERENCES users   (UserID)   ON DELETE CASCADE,
  CONSTRAINT fk_cu_order  FOREIGN KEY (OrderID)  REFERENCES orders  (OrderID)  ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 19. reviews ─────────────────────────────────────────────────────
CREATE TABLE reviews (
  ReviewID  INT        NOT NULL AUTO_INCREMENT,
  UserID    INT        NOT NULL,
  ProductID INT        NOT NULL,
  Rating    TINYINT    NOT NULL DEFAULT 5,
  Comment   TEXT       DEFAULT NULL,
  IsVisible TINYINT(1) NOT NULL DEFAULT 1,
  CreatedAt DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ReviewID),
  UNIQUE KEY uq_review (UserID, ProductID),
  KEY idx_rev_prod (ProductID),
  CONSTRAINT fk_rev_user FOREIGN KEY (UserID)    REFERENCES users    (UserID)    ON DELETE CASCADE,
  CONSTRAINT fk_rev_prod FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 18. payments ────────────────────────────────────────────────────────
CREATE TABLE payments (
  PaymentID     INT            NOT NULL AUTO_INCREMENT,
  OrderID       INT            NOT NULL,
  TransactionID VARCHAR(255)   NOT NULL,
  Amount        DECIMAL(12,2)  NOT NULL,
  PaymentMethod VARCHAR(50)    DEFAULT NULL,
  PaymentStatus ENUM('pending','completed','failed','refunded') NOT NULL DEFAULT 'pending',
  CreatedAt     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (PaymentID),
  UNIQUE KEY uq_pay_order (OrderID),
  CONSTRAINT fk_pay_order FOREIGN KEY (OrderID) REFERENCES orders (OrderID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 19. shipments ───────────────────────────────────────────────────────
CREATE TABLE shipments (
  ShipmentID    INT           NOT NULL AUTO_INCREMENT,
  OrderID       INT           NOT NULL,
  ShippingCode  VARCHAR(60)   DEFAULT NULL,
  Carrier       VARCHAR(80)   DEFAULT NULL,
  Status        VARCHAR(20)   NOT NULL DEFAULT 'pending',
  EstimatedDate DATE          DEFAULT NULL,
  Note              TEXT          DEFAULT NULL,
  DeliveredAt       DATETIME      DEFAULT NULL,
  AssignedShipperID INT           DEFAULT NULL,
  CreatedAt         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (ShipmentID),
  UNIQUE KEY uq_shipment_order (OrderID),
  CONSTRAINT fk_ship_order   FOREIGN KEY (OrderID)           REFERENCES orders (OrderID) ON DELETE CASCADE,
  CONSTRAINT fk_ship_shipper FOREIGN KEY (AssignedShipperID) REFERENCES users  (UserID)  ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── 20. contacts ────────────────────────────────────────────────────
CREATE TABLE contacts (
  ContactID INT          NOT NULL AUTO_INCREMENT,
  FullName  VARCHAR(120) NOT NULL,
  Email     VARCHAR(120) NOT NULL,
  Subject   VARCHAR(200) DEFAULT NULL,
  Message   TEXT         NOT NULL,
  IsRead    TINYINT(1)   NOT NULL DEFAULT 0,
  CreatedAt DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ContactID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── stock_adjustments — lịch sử điều chỉnh tồn kho thủ công ────────
CREATE TABLE stock_adjustments (
  AdjID       INT           NOT NULL AUTO_INCREMENT,
  VariantID   INT           NOT NULL,
  ProductID   INT           NOT NULL,
  Delta       INT           NOT NULL,
  StockBefore INT           NOT NULL,
  StockAfter  INT           NOT NULL,
  Reason      VARCHAR(300)  NOT NULL,
  CreatedBy   INT           DEFAULT NULL,
  CreatedAt   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (AdjID),
  CONSTRAINT fk_sa_variant FOREIGN KEY (VariantID) REFERENCES product_variants (VariantID) ON DELETE CASCADE,
  CONSTRAINT fk_sa_product FOREIGN KEY (ProductID) REFERENCES products         (ProductID) ON DELETE CASCADE,
  CONSTRAINT fk_sa_user    FOREIGN KEY (CreatedBy) REFERENCES users            (UserID)    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── wishlists — danh sách yêu thích của user ───────────────────────
CREATE TABLE wishlists (
  WishlistID INT      NOT NULL AUTO_INCREMENT,
  UserID     INT      NOT NULL,
  ProductID  INT      NOT NULL,
  CreatedAt  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (WishlistID),
  UNIQUE KEY uq_wishlist (UserID, ProductID),
  CONSTRAINT fk_wl_user FOREIGN KEY (UserID)    REFERENCES users    (UserID)    ON DELETE CASCADE,
  CONSTRAINT fk_wl_prod FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

SELECT CONCAT('Tạo thành công ', COUNT(*), ' bảng') AS result
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'sportshop';
