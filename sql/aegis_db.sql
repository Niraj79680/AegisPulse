DROP DATABASE IF EXISTS aegis_db;

CREATE DATABASE aegis_db;
USE aegis_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL
);

INSERT INTO users (username, password, role) VALUES
('doctor', 'doc123', 'DOCTOR'),
('nurse', 'nurse123', 'STAFF');

CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    heart_rate INT,
    oxygen_level INT,
    pain_level INT,
    symptoms TEXT,
    triage_score INT,
    triage_color VARCHAR(20),
    status VARCHAR(20) DEFAULT 'PENDING',
    assessment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM users;
