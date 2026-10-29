require('dotenv').config();
const express = require('express');
const path = require('path');
const methodOverride = require('method-override');
const flash = require('connect-flash');
const sessionConfig = require('./src/config/session');
const formatCurrency = require('./src/utils/formatCurrency');
const appConfig = require('./src/config/app.config');

const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(methodOverride('_method'));
app.use(express.static(path.join(__dirname, 'src/public')));
app.use(sessionConfig);
app.use(flash());

app.use(require('./src/middlewares/cartCount.middleware'));
app.use(require('./src/middlewares/navData.middleware'));

// CSRF token placeholder (không dùng cho demo)
app.use((req, res, next) => { res.locals.csrfToken = ''; next(); });

const STATUS_VI = {
  // Đơn hàng
  pending: 'Chờ xử lý', confirmed: 'Đã xác nhận',
  shipping: 'Đang giao', delivered: 'Đã giao', cancelled: 'Đã hủy',
  // Thanh toán
  unpaid: 'Chưa thanh toán', paid: 'Đã thanh toán',
  // Vai trò
  admin: 'Quản trị viên', staff: 'Nhân viên',
  shipper: 'Nhân viên vận chuyển', customer: 'Khách hàng',
  // Vận chuyển
  picked_up: 'Đã lấy hàng', in_transit: 'Đang vận chuyển',
  out_for_delivery: 'Đang giao', failed: 'Giao thất bại', returned: 'Hoàn hàng',
};

app.use((req, res, next) => {
  res.locals.appName = appConfig.appName;
  res.locals.user = req.session?.user || null;
  res.locals.success = req.flash('success');
  res.locals.error = req.flash('error');
  res.locals.formatCurrency = formatCurrency;
  res.locals.currentPath = req.path;
  res.locals.adminBase = req.path.startsWith('/staff')
    ? '/staff'
    : req.path.startsWith('/shipper')
      ? '/shipper'
      : '/admin';
  res.locals.statusVI = (key) => STATUS_VI[key] || key;
  next();
});

app.use(require('./src/routes'));

// Xử lý lỗi CSRF (phải đặt trước error middleware chung)
app.use((err, req, res, next) => {
  if (err.code === 'EBADCSRFTOKEN') {
    if (req.xhr || req.headers.accept?.includes('application/json')) {
      return res.status(403).json({ error: 'Phiên đã hết hạn. Vui lòng tải lại trang.' });
    }
    req.flash('error', 'Phiên đã hết hạn. Vui lòng tải lại trang và thử lại.');
    return res.redirect('back');
  }
  next(err);
});

app.use(require('./src/middlewares/error.middleware'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`${appConfig.appName} — http://localhost:${PORT}`);
});
