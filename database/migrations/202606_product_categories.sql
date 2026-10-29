-- Tạo bảng junction product_categories
CREATE TABLE IF NOT EXISTS product_categories (
  ProductID  INT NOT NULL,
  CategoryID INT NOT NULL,
  PRIMARY KEY (ProductID, CategoryID),
  CONSTRAINT fk_pc_product  FOREIGN KEY (ProductID)  REFERENCES products   (ProductID) ON DELETE CASCADE,
  CONSTRAINT fk_pc_category FOREIGN KEY (CategoryID) REFERENCES categories (CategoryID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Migrate dữ liệu cũ từ products.CategoryID
INSERT IGNORE INTO product_categories (ProductID, CategoryID)
SELECT ProductID, CategoryID FROM products WHERE CategoryID IS NOT NULL;
