-- Add phone column
ALTER TABLE users
ADD COLUMN phone VARCHAR(20) AFTER email;

-- Add status column with default value
ALTER TABLE users
ADD COLUMN status VARCHAR(20) DEFAULT 'active' AFTER phone;
