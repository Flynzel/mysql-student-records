-- Create and select the database
CREATE DATABASE IF NOT EXISTS student_records;
USE student_records;

-- Create tables
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    course     VARCHAR(50) NOT NULL,
    year_level TINYINT NOT NULL
);

CREATE TABLE subjects (
    subject_id   INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(10) NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    units        TINYINT NOT NULL
);

CREATE TABLE grades (
    grade_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    grade      DECIMAL(3,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Insert sample data
INSERT INTO students (first_name, last_name, course, year_level) VALUES
('Juan',  'Dela Cruz', 'BSIS', 4),
('Maria', 'Santos',    'BSIS', 3),
('Pedro', 'Reyes',     'BSIS', 4);

INSERT INTO subjects (subject_code, subject_name, units) VALUES
('IS101', 'Database Management Systems', 3),
('IS102', 'Systems Analysis and Design', 3),
('IS103', 'Web Development',             3);

INSERT INTO grades (student_id, subject_id, grade) VALUES
(1, 1, 1.50),
(1, 2, 1.75),
(2, 1, 2.00),
(3, 3, 1.25);

-- View all students
SELECT * FROM students;

-- View students in 4th year
SELECT first_name, last_name FROM students WHERE year_level = 4;

-- View students with their subjects and grades
SELECT s.first_name, s.last_name, sub.subject_name, g.grade
FROM grades g
JOIN students s   ON g.student_id = s.student_id
JOIN subjects sub ON g.subject_id = sub.subject_id;

-- Average grade per subject
SELECT sub.subject_name, AVG(g.grade) AS average_grade
FROM grades g
JOIN subjects sub ON g.subject_id = sub.subject_id
GROUP BY sub.subject_name;

-- Update a student's year level
UPDATE students SET year_level = 4 WHERE student_id = 2;

-- Delete a grade record
DELETE FROM grades WHERE grade_id = 4;
