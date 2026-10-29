-- Thêm UserID (liên kết khách đăng nhập), Reply, RepliedAt, RepliedBy vào contacts
ALTER TABLE contacts
  ADD COLUMN UserID     INT          DEFAULT NULL AFTER IsRead,
  ADD COLUMN Reply      TEXT         DEFAULT NULL,
  ADD COLUMN RepliedAt  DATETIME     DEFAULT NULL,
  ADD COLUMN RepliedBy  INT          DEFAULT NULL,
  ADD CONSTRAINT fk_contact_user     FOREIGN KEY (UserID)    REFERENCES users (UserID) ON DELETE SET NULL,
  ADD CONSTRAINT fk_contact_replier  FOREIGN KEY (RepliedBy) REFERENCES users (UserID) ON DELETE SET NULL;
