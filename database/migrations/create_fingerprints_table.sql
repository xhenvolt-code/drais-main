CREATE TABLE IF NOT EXISTS fingerprints (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT NOT NULL,
    method VARCHAR(50) NOT NULL COMMENT 'phone, biometric, external',
    credential TEXT NOT NULL COMMENT 'Encrypted fingerprint template data',
    device_info JSON NULL COMMENT 'Device information for debugging',
    quality_score INT DEFAULT 0 COMMENT 'Fingerprint quality score 0-100',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_method (student_id, method),
    INDEX idx_student_id (student_id),
    INDEX idx_method (method),
    INDEX idx_quality (quality_score),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='Real fingerprint biometric data storage';

-- Create audit logs table if it doesn't exist
CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id VARCHAR(100) NOT NULL,
    user_id BIGINT NOT NULL DEFAULT 1,
    old_values JSON NULL,
    new_values JSON NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_table_record (table_name, record_id),
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='Audit trail for all system operations';

-- Create temporary fingerprint capture log for demo/testing
CREATE TABLE IF NOT EXISTS fingerprint_capture_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT NOT NULL,
    method VARCHAR(50) NOT NULL,
    capture_result ENUM('success', 'failed', 'timeout') NOT NULL,
    error_message TEXT NULL,
    device_info JSON NULL,
    template_size INT NULL COMMENT 'Size of captured template in bytes',
    quality_score INT NULL COMMENT 'Capture quality 0-100',
    capture_duration INT NULL COMMENT 'Time taken to capture in milliseconds',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    INDEX idx_student_id (student_id),
    INDEX idx_method (method),
    INDEX idx_result (capture_result),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='Log of fingerprint capture attempts for analysis';
-- Create student_fingerprints table for demo purposes
CREATE TABLE IF NOT EXISTS student_fingerprints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    fingerprint_data TEXT NOT NULL,
    device_info JSON NULL,
    quality_score INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    INDEX idx_student_id (student_id),
    INDEX idx_created_at (created_at)
);

-- Update existing fingerprints table if needed
ALTER TABLE fingerprints 
ADD COLUMN IF NOT EXISTS device_info JSON NULL,
ADD COLUMN IF NOT EXISTS quality_score INT DEFAULT 0;
