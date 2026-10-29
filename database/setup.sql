-- =====================================================
-- SportShop — Quick Setup Script
-- Chạy lệnh này để khởi tạo toàn bộ DB + data mẫu
-- mysql -u root -p < database/setup.sql
-- =====================================================

SOURCE database/schema.sql;
SOURCE database/seeders/seed.sql;

SELECT 'SportShop database đã được khởi tạo thành công!' AS result;
SELECT CONCAT('  • ', TABLE_NAME, ': ', TABLE_ROWS, ' rows') AS summary
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'sportshop'
ORDER BY TABLE_NAME;
