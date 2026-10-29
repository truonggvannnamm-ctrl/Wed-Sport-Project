require('dotenv').config();
const db = require('../src/config/db');

(async () => {
  await db.query(`
    CREATE TABLE IF NOT EXISTS product_images (
      ImageID   INT          NOT NULL AUTO_INCREMENT,
      ProductID INT          NOT NULL,
      ImageURL  VARCHAR(500) NOT NULL,
      SortOrder INT          NOT NULL DEFAULT 0,
      PRIMARY KEY (ImageID),
      KEY idx_pi_product (ProductID),
      CONSTRAINT fk_pi_product FOREIGN KEY (ProductID)
        REFERENCES products (ProductID) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  `);
  console.log('product_images table created OK');
  process.exit(0);
})().catch(e => { console.error(e.message); process.exit(1); });
