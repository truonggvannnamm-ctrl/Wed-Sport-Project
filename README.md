# SportShop — Website Bán Đồ Thể Thao

> Node.js · Express · MySQL · EJS · CSS3 thuần

## Tech Stack

| Layer | Công nghệ |
|-------|-----------|
| Runtime | Node.js (CommonJS) |
| Framework | Express 4 |
| Template Engine | EJS |
| Database | MySQL 8 (mysql2/promise) |
| Auth | express-session + bcryptjs |
| Upload | Multer |
| CSS | Viết tay (không framework) — DM Sans + Bebas Neue |

## Kiến trúc MVC

```
sportshop/
├── database/
│   ├── schema.sql          ← DDL chuẩn hóa 3NF (18 bảng)
│   ├── setup.sql           ← Khởi tạo nhanh (schema + seed)
│   ├── ERD.md              ← Sơ đồ quan hệ thực thể
│   └── seeders/
│       └── seed.sql        ← Dữ liệu mẫu
├── src/
│   ├── config/             ← db.js, session.js, app.config.js
│   ├── constants/          ← roles, orderStatus, messages
│   ├── controllers/
│   │   ├── admin/          ← brand, category, product, order, user,
│   │   │                      supplier, review, importReceipt,
│   │   │                      invoice, promotion, statistics, dashboard
│   │   ├── client/         ← auth, cart, checkout, order, product,
│   │   │                      profile, home, contact, promotion
│   │   └── staff/          ← dashboard, order, invoice, importReceipt
│   ├── middlewares/        ← auth, role, cartCount, upload, error, validate
│   ├── models/             ← user, product, category, brand, supplier,
│   │                          order, cart, importReceipt, invoice,
│   │                          promotion, review, contact, payment
│   ├── routes/
│   │   ├── admin/          ← Tất cả route admin
│   │   ├── client/         ← Tất cả route client
│   │   └── staff/          ← Tất cả route staff
│   ├── services/           ← Business logic layer
│   ├── utils/              ← formatCurrency, slugify, hash, pagination...
│   ├── validators/         ← Input validation
│   ├── public/
│   │   ├── css/            ← style.css (client), admin.css, staff.css
│   │   ├── js/             ← main.js, admin.js, chart.js
│   │   └── uploads/        ← Ảnh upload
│   └── views/
│       ├── admin/          ← Dashboard, Products, Categories, Brands,
│       │                      Orders, Users, Suppliers, Reviews,
│       │                      Imports, Invoices, Statistics, Promotions
│       ├── client/         ← Home, Products, Cart, Checkout, Orders,
│       │                      Profile, Auth, Contact, About, Promotions
│       ├── staff/          ← Dashboard, Orders, Imports, Invoices, Statistics
│       ├── layouts/        ← main.ejs, admin.ejs, staff.ejs
│       └── partials/       ← header, footer, navbar, admin-sidebar,
│                              flash-message, admin-layout-start/end
└── server.js
```

## Cài đặt

### 1. Clone và cài dependencies

```bash
npm install
```

### 2. Cấu hình môi trường

```bash
cp .env.example .env
```

Chỉnh `.env`:

```env
PORT=3000
DB_HOST=localhost
DB_PORT=3306
DB_NAME=sportshop
DB_USER=root
DB_PASSWORD=your_password
SESSION_SECRET=change_me_to_something_random
```

### 3. Khởi tạo Database

**Cách 1 — Từng file:**
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p sportshop < database/seeders/seed.sql
```

**Cách 2 — Script tổng (nếu dùng MySQL client trực tiếp):**
```sql
SOURCE database/schema.sql;
SOURCE database/seeders/seed.sql;
```

### 4. Chạy ứng dụng

```bash
# Development (nodemon, hot reload)
npm run dev

# Production
npm start
```

Truy cập: **http://localhost:3000**

## Tài khoản mặc định

| Vai trò | Email | Mật khẩu |
|---------|-------|-----------|
| Admin | admin@sportshop.vn | Password123! |
| Staff | staff@sportshop.vn | Password123! |
| Customer | an@gmail.com | Password123! |

## Các tính năng

### Vai trò
- **Admin** `/admin` — Toàn quyền quản trị
- **Staff** `/staff` — Xử lý đơn hàng, nhập kho
- **Customer** `/` — Mua sắm, đặt hàng, đánh giá

### Modules

| Module | Admin | Staff | Customer |
|--------|-------|-------|----------|
| Xác thực | ✓ | ✓ | ✓ |
| Danh mục | CRUD | — | Xem |
| Thương hiệu | CRUD | — | Xem |
| Sản phẩm | CRUD | — | Xem, Tìm kiếm |
| Biến thể SP | Schema | — | Xem |
| Nhà cung cấp | CRUD | — | — |
| Nhập kho | CRUD | CRUD | — |
| Giỏ hàng | — | — | ✓ |
| Đặt hàng (COD) | Xem/Xử lý | Xem/Xử lý | ✓ |
| Hóa đơn | ✓ | ✓ | — |
| Khuyến mãi | CRUD | — | Xem |
| Đánh giá | Kiểm duyệt | — | Viết/Sửa |
| Dashboard | ✓ Đầy đủ | ✓ Cơ bản | — |
| Thống kê | ✓ | ✓ | — |

## Database Schema

18 bảng chuẩn hóa 3NF:

```
users · categories · brands · products · product_variants ·
product_images · suppliers · import_receipts · import_receipt_items ·
carts · cart_items · orders · order_items · invoices ·
promotions · promotion_products · reviews · contacts
```

Chi tiết xem: [database/ERD.md](database/ERD.md)

## API Routes

### Client
```
GET  /                        Trang chủ
GET  /products                Danh sách sản phẩm (filter by category, brand, search)
GET  /products/:id            Chi tiết sản phẩm + đánh giá
POST /products/:id/review     Gửi đánh giá
POST /cart/add                Thêm vào giỏ
GET  /cart                    Xem giỏ hàng
POST /cart/update/:id         Cập nhật số lượng
POST /cart/remove/:id         Xóa khỏi giỏ
GET  /checkout                Form thanh toán COD
POST /checkout                Đặt hàng
GET  /orders                  Lịch sử đơn hàng
GET  /orders/:id              Chi tiết đơn
POST /orders/:id/cancel       Hủy đơn (chỉ pending)
GET  /auth/login              Đăng nhập
POST /auth/login
GET  /auth/register           Đăng ký
POST /auth/register
POST /auth/logout
GET  /profile                 Hồ sơ cá nhân
GET  /promotions              Khuyến mãi
GET  /contact                 Liên hệ
```

### Admin `/admin`
```
GET  /admin                            Dashboard + thống kê
GET  /admin/products                   Quản lý sản phẩm
GET  /admin/products/create
POST /admin/products/create
GET  /admin/products/edit/:id
POST /admin/products/edit/:id
POST /admin/products/delete/:id
POST /admin/products/toggle-status/:id
GET  /admin/categories                 Danh mục (CRUD tương tự)
GET  /admin/brands                     Thương hiệu (CRUD tương tự)
GET  /admin/suppliers                  Nhà cung cấp (CRUD)
POST /admin/suppliers/toggle/:id
GET  /admin/orders                     Quản lý đơn hàng
POST /admin/orders/update-status/:id   Cập nhật trạng thái
GET  /admin/imports                    Phiếu nhập kho
GET  /admin/imports/create
POST /admin/imports/create
GET  /admin/imports/:id                Chi tiết phiếu
GET  /admin/invoices                   Hóa đơn
GET  /admin/invoices/:id
GET  /admin/users                      Quản lý người dùng
GET  /admin/promotions                 Khuyến mãi (CRUD)
GET  /admin/reviews                    Đánh giá (kiểm duyệt)
POST /admin/reviews/toggle/:id         Ẩn/hiện đánh giá
POST /admin/reviews/delete/:id
GET  /admin/statistics                 Báo cáo thống kê
```

### Staff `/staff`
```
GET  /staff                  Dashboard
GET  /staff/orders           Xem & xử lý đơn hàng
POST /staff/orders/update-status/:id
GET  /staff/imports          Tạo phiếu nhập kho
POST /staff/imports/create
GET  /staff/invoices         Xem hóa đơn
GET  /staff/statistics       Thống kê cơ bản
```
