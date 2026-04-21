CREATE TABLE IF NOT EXISTS exam_papers (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL,
  exam_id BIGINT DEFAULT NULL, -- can link to 'exams' table if it’s a formal exam
  subject_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  teacher_id BIGINT DEFAULT NULL,
  title VARCHAR(200) NOT NULL,
  type ENUM('exam','test','homework','quiz','practice') DEFAULT 'exam',
  total_marks DECIMAL(6,2) DEFAULT 100,
  duration_minutes INT DEFAULT NULL,
  instructions TEXT DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'draft', -- draft, published, archived
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS exam_questions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL,
  exam_paper_id BIGINT DEFAULT NULL,
  subject_id BIGINT DEFAULT NULL,
  question_text TEXT NOT NULL,
  question_type ENUM('objective','multiple_choice','true_false','short_answer','essay','file_upload') DEFAULT 'objective',
  options_json JSON DEFAULT NULL, -- ["A","B","C","D"]
  correct_answer VARCHAR(255) DEFAULT NULL,
  mark_value DECIMAL(5,2) DEFAULT 1,
  difficulty ENUM('easy','medium','hard') DEFAULT 'medium',
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS student_submissions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL,
  exam_paper_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  submission_json JSON DEFAULT NULL, -- stores answers or links to files
  score DECIMAL(6,2) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  graded_by BIGINT DEFAULT NULL,
  submitted_at DATETIME DEFAULT NULL,
  graded_at DATETIME DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'submitted' -- pending, graded, late, missing
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS question_bank_tags (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  UNIQUE KEY uq_tag (school_id, name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS question_tag_map (
  question_id BIGINT NOT NULL,
  tag_id BIGINT NOT NULL,
  PRIMARY KEY (question_id, tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
