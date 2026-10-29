-- Migration: Thêm bảng quản lý vận chuyển
USE sportshop;

CREATE TABLE IF NOT EXISTS shipments (
  ShipmentID    INT           NOT NULL AUTO_INCREMENT,
  OrderID       INT           NOT NULL,
  ShippingCode  VARCHAR(60)   DEFAULT NULL,
  Carrier       VARCHAR(80)   DEFAULT NULL,
  Status        VARCHAR(20)   NOT NULL DEFAULT 'pending',
  EstimatedDate DATE          DEFAULT NULL,
  Note          TEXT          DEFAULT NULL,
  DeliveredAt   DATETIME      DEFAULT NULL,
  CreatedAt     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (ShipmentID),
  UNIQUE KEY uq_shipment_order (OrderID),
  CONSTRAINT fk_ship_order FOREIGN KEY (OrderID) REFERENCES orders (OrderID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'Migration: shipments table created' AS result;
