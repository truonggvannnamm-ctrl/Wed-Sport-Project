# ERD — SportShop Database

## Sơ đồ quan hệ thực thể (Entity Relationship Diagram)

```
┌──────────────┐        ┌──────────────────┐        ┌─────────────┐
│    users     │        │    categories    │        │   brands    │
├──────────────┤        ├──────────────────┤        ├─────────────┤
│ UserID (PK)  │        │ CategoryID (PK)  │        │ BrandID(PK) │
│ FullName     │        │ CategoryName     │        │ BrandName   │
│ Email        │        │ Slug             │        │ Slug        │
│ PasswordHash │        │ Description      │        │ Description │
│ Phone        │        │ IsActive         │        │ LogoURL     │
│ Address      │        └────────┬─────────┘        │ IsActive    │
│ Role         │                 │                   └──────┬──────┘
│ IsActive     │                 │ 1:N                      │ 1:N
└───┬──────────┘                 │                          │
    │ 1                          ▼                          ▼
    ├──────────────────► ┌──────────────────────────────────────────┐
    │                    │              products                    │
    │                    ├──────────────────────────────────────────┤
    │                    │ ProductID (PK)                           │
    │                    │ SKU (UNIQUE)                             │
    │                    │ ProductName                              │
    │                    │ Slug (UNIQUE)                            │
    │                    │ Description                              │
    │                    │ Price                                    │
    │                    │ SalePrice                                │
    │                    │ StockQuantity                            │
    │                    │ ImageURL                                 │
    │                    │ IsFeatured                               │
    │                    │ IsActive                                 │
    │                    │ CategoryID (FK → categories)             │
    │                    │ BrandID    (FK → brands)                 │
    │                    └───┬──────────────────────────────────────┘
    │                        │ 1:N
    │              ┌─────────┴────────────────────────────────┐
    │              ▼                                          ▼
    │   ┌──────────────────────┐             ┌──────────────────────┐
    │   │   product_variants   │             │   product_images     │
    │   ├──────────────────────┤             ├──────────────────────┤
    │   │ VariantID (PK)       │◄────────────│ ImageID (PK)         │
    │   │ ProductID (FK)       │             │ ProductID (FK)       │
    │   │ Size                 │             │ VariantID (FK, opt.) │
    │   │ Color                │             │ ImageURL             │
    │   │ VariantSKU (UNIQUE)  │             │ SortOrder            │
    │   │ ExtraPrice           │             └──────────────────────┘
    │   │ Stock                │
    │   │ IsActive             │
    │   └──────────────────────┘
    │
    │   ┌──────────────┐        ┌──────────────────────┐
    │   │  suppliers   │        │   import_receipts    │
    │   ├──────────────┤        ├──────────────────────┤
    │   │ SupplierID   │◄───────│ ImportReceiptID (PK) │
    │   │ SupplierName │  N:1   │ ReceiptCode (UNIQUE) │
    │   │ ContactName  │        │ SupplierID (FK)      │
    │   │ Phone        │        │ StaffID (FK→users)   │◄─── users.UserID
    │   │ Email        │        │ Note                 │
    │   │ Address      │        │ TotalAmount          │
    │   │ Note         │        │ IsDeleted            │
    │   │ IsActive     │        └───────┬──────────────┘
    │   └──────────────┘                │ 1:N
    │                                   ▼
    │                       ┌──────────────────────────┐
    │                       │  import_receipt_items    │
    │                       ├──────────────────────────┤
    │                       │ ItemID (PK)              │
    │                       │ ImportReceiptID (FK)     │
    │                       │ ProductID (FK→products)  │
    │                       │ VariantID (FK, opt.)     │
    │                       │ Quantity                 │
    │                       │ ImportPrice              │
    │                       └──────────────────────────┘
    │
    │ 1:1 (per user)
    ▼
┌──────────┐        ┌─────────────────────┐
│  carts   │        │    cart_items       │
├──────────┤        ├─────────────────────┤
│ CartID   │◄───────│ CartItemID (PK)     │
│ UserID   │  1:N   │ CartID (FK)         │
└──────────┘        │ ProductID (FK)      │
                    │ VariantID (FK, opt.)│
                    │ Quantity            │
                    └─────────────────────┘

    │ 1:N
    ▼
┌─────────────────────────────────────────┐
│                  orders                 │
├─────────────────────────────────────────┤
│ OrderID (PK)                            │
│ UserID (FK → users)                     │
│ OrderCode (UNIQUE)                      │
│ TotalAmount                             │
│ Status: pending/confirmed/shipping/     │
│         delivered/cancelled             │
│ PaymentStatus: unpaid/paid              │
│ ShippingAddress                         │
│ Phone                                   │
│ Note                                    │
└───────────────┬─────────────────────────┘
                │ 1:N                  │ 1:1
                ▼                     ▼
┌─────────────────────┐    ┌──────────────────────┐
│    order_items      │    │      invoices        │
├─────────────────────┤    ├──────────────────────┤
│ OrderItemID (PK)    │    │ InvoiceID (PK)       │
│ OrderID (FK)        │    │ OrderID (FK, UNIQUE) │
│ ProductID (FK,opt.) │    │ InvoiceCode (UNIQUE) │
│ VariantID (FK,opt.) │    │ TotalAmount          │
│ ProductName         │    │ IssuedAt             │
│ VariantLabel        │    └──────────────────────┘
│ Price               │
│ Quantity            │
└─────────────────────┘

┌──────────────────────────────┐
│          promotions          │
├──────────────────────────────┤
│ PromotionID (PK)             │
│ Title                        │
│ Description                  │
│ DiscountPercent              │
│ StartDate                    │
│ EndDate                      │
│ IsActive                     │
└──────────────┬───────────────┘
               │ M:N
               ▼
┌─────────────────────────┐
│   promotion_products    │  ← junction table
├─────────────────────────┤
│ PromotionID (FK)        │
│ ProductID (FK)          │
└─────────────────────────┘

┌──────────────────────────────┐
│           reviews            │
├──────────────────────────────┤
│ ReviewID (PK)                │
│ UserID (FK → users)          │
│ ProductID (FK → products)    │
│ Rating (1–5)                 │
│ Comment                      │
│ IsVisible                    │
│ CreatedAt                    │
│ UNIQUE(UserID, ProductID)    │
└──────────────────────────────┘

┌──────────────────────────────┐
│           contacts           │
├──────────────────────────────┤
│ ContactID (PK)               │
│ FullName                     │
│ Email                        │
│ Subject                      │
│ Message                      │
│ IsRead                       │
│ CreatedAt                    │
└──────────────────────────────┘
```

## Chuẩn hóa 3NF

| Bảng | 1NF | 2NF | 3NF | Ghi chú |
|------|-----|-----|-----|---------|
| users | ✓ | ✓ | ✓ | Không có phụ thuộc bắc cầu |
| categories | ✓ | ✓ | ✓ | Slug phụ thuộc vào CategoryName |
| brands | ✓ | ✓ | ✓ | |
| products | ✓ | ✓ | ✓ | CategoryID, BrandID là FK, không lưu tên |
| product_variants | ✓ | ✓ | ✓ | ExtraPrice phụ thuộc vào VariantID |
| product_images | ✓ | ✓ | ✓ | |
| suppliers | ✓ | ✓ | ✓ | |
| import_receipts | ✓ | ✓ | ✓ | TotalAmount = sum(import_receipt_items) |
| import_receipt_items | ✓ | ✓ | ✓ | |
| carts | ✓ | ✓ | ✓ | |
| cart_items | ✓ | ✓ | ✓ | |
| orders | ✓ | ✓ | ✓ | ShippingAddress/Phone snapshot tại thời điểm đặt |
| order_items | ✓ | ✓ | ✓ | ProductName snapshot tại thời điểm đặt |
| invoices | ✓ | ✓ | ✓ | |
| promotions | ✓ | ✓ | ✓ | |
| promotion_products | ✓ | ✓ | ✓ | Junction table, PK hợp thành |
| reviews | ✓ | ✓ | ✓ | UNIQUE(UserID, ProductID) — 1 review/sản phẩm |
| contacts | ✓ | ✓ | ✓ | |

## Quan hệ tóm tắt

- **users** `1:1` carts (mỗi user 1 giỏ hàng)
- **users** `1:N` orders (mỗi user nhiều đơn)
- **users** `1:N` reviews
- **users** `1:N` import_receipts (staff tạo phiếu)
- **categories** `1:N` products
- **brands** `1:N` products
- **products** `1:N` product_variants
- **products** `1:N` product_images
- **products** `M:N` promotions (qua promotion_products)
- **products** `1:N` reviews
- **suppliers** `1:N` import_receipts
- **import_receipts** `1:N` import_receipt_items
- **carts** `1:N` cart_items
- **orders** `1:N` order_items
- **orders** `1:1` invoices
