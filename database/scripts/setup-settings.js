require('dotenv').config();
const db = require('../src/config/db');

(async () => {
  await db.query(`
    CREATE TABLE IF NOT EXISTS store_settings (
      \`key\`   VARCHAR(60)  NOT NULL PRIMARY KEY,
      value    TEXT         DEFAULT NULL,
      label    VARCHAR(120) NOT NULL,
      \`group\` VARCHAR(60)  NOT NULL DEFAULT 'general'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  `);

  const rows = [
    ['store_name',    'SportShop',                          'Tên cửa hàng',      'general'],
    ['store_tagline', 'Đồ thể thao chính hãng',             'Slogan',            'general'],
    ['store_address', '123 Đường Thể Thao, TP.HCM',         'Địa chỉ',           'contact'],
    ['store_phone',   '1900 1234',                          'Số điện thoại',     'contact'],
    ['store_email',   'support@sportshop.vn',               'Email hỗ trợ',      'contact'],
    ['store_hours',   'T2–T6: 8:00–17:00 | T7: 8:00–12:00','Giờ làm việc',      'contact'],
    ['facebook_url',  '',                                   'Facebook URL',      'social'],
    ['zalo_url',      '',                                   'Zalo URL',          'social'],
    ['instagram_url', '',                                   'Instagram URL',     'social'],
  ];

  for (const [key, value, label, group] of rows) {
    await db.query(
      'INSERT INTO store_settings (`key`, value, label, `group`) VALUES (?,?,?,?) ON DUPLICATE KEY UPDATE label=label',
      [key, value, label, group]
    );
  }
  console.log('store_settings created OK');
  process.exit(0);
})().catch(e => { console.error(e.message); process.exit(1); });
