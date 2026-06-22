-- ============================================================
--   Smart Emergency Alert System — Database Schema  v2.0
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS emergency_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE emergency_db;

-- ── emergency contacts ────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS contacts (
    id    INT          AUTO_INCREMENT PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    phone VARCHAR(30)  NOT NULL COMMENT 'Include country code e.g. +919876543210',
    email VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── alert history log ─────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS alert_logs (
    id         INT        AUTO_INCREMENT PRIMARY KEY,
    alert_time TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
    status     VARCHAR(50) NOT NULL  COMMENT 'SUCCESS | FAILED | PARTIAL',
    message    TEXT        NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── user / app settings ───────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS settings (
    setting_key   VARCHAR(100) PRIMARY KEY,
    setting_value TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed default settings (will not overwrite existing values)
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES
    ('user_name',       'Emergency User'),
    ('sender_email',    ''),
    ('sender_password', '');

-- ── Optional sample contact ────────────────────────────────────────────────────
-- Uncomment the lines below to insert a test contact:
-- INSERT IGNORE INTO contacts (id, name, phone, email)
-- VALUES (1, 'Test Contact', '+911234567890', 'test@example.com');
