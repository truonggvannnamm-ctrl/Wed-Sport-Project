-- ─── Extend promotions: support fixed-amount discount ────────────────────────
ALTER TABLE promotions
  ADD COLUMN DiscountType   ENUM('percent','fixed') NOT NULL DEFAULT 'percent' AFTER Title,
  ADD COLUMN DiscountAmount DECIMAL(12,0)           NOT NULL DEFAULT 0         AFTER DiscountPercent;

-- ─── coupons ─────────────────────────────────────────────────────────────────
CREATE TABLE coupons (
  CouponID       INT            NOT NULL AUTO_INCREMENT,
  Code           VARCHAR(30)    NOT NULL,
  Description    VARCHAR(255)   DEFAULT NULL,
  DiscountType   ENUM('percent','fixed') NOT NULL DEFAULT 'percent',
  DiscountValue  DECIMAL(12,2)  NOT NULL DEFAULT 0,
  MinOrderAmount DECIMAL(14,0)  NOT NULL DEFAULT 0,
  MaxUsage       INT            NOT NULL DEFAULT 0,   -- 0 = unlimited
  UsedCount      INT            NOT NULL DEFAULT 0,
  IsActive       TINYINT(1)     NOT NULL DEFAULT 1,
  StartDate      DATE           DEFAULT NULL,
  EndDate        DATE           DEFAULT NULL,
  CreatedAt      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (CouponID),
  UNIQUE KEY uq_coupon_code (Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── coupon_usages ────────────────────────────────────────────────────────────
CREATE TABLE coupon_usages (
  UsageID        INT            NOT NULL AUTO_INCREMENT,
  CouponID       INT            NOT NULL,
  UserID         INT            NOT NULL,
  OrderID        INT            DEFAULT NULL,
  DiscountAmount DECIMAL(14,0)  NOT NULL DEFAULT 0,
  CreatedAt      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UsageID),
  KEY idx_cu_coupon (CouponID),
  KEY idx_cu_user   (UserID),
  CONSTRAINT fk_cu_coupon FOREIGN KEY (CouponID) REFERENCES coupons (CouponID) ON DELETE CASCADE,
  CONSTRAINT fk_cu_user   FOREIGN KEY (UserID)   REFERENCES users   (UserID)   ON DELETE CASCADE,
  CONSTRAINT fk_cu_order  FOREIGN KEY (OrderID)  REFERENCES orders  (OrderID)  ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── Extend orders: record applied coupon ─────────────────────────────────────
ALTER TABLE orders
  ADD COLUMN CouponCode      VARCHAR(30)   DEFAULT NULL AFTER Note,
  ADD COLUMN DiscountAmount  DECIMAL(14,0) NOT NULL DEFAULT 0 AFTER CouponCode;
