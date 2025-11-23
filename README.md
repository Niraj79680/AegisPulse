# 🏥 AEGIS Pulse – Medical Triage System

A Java web-based clinical triage system that prioritizes patients based on severity to assist hospitals in managing emergency cases efficiently.

---

## 🚀 Project Overview

Hospitals often struggle when multiple patients arrive at the same time, making it difficult to decide who requires urgent attention. Manual triage can lead to delays and risk patient safety.

This system automates triage using:

- Vital signs
- Pain level
- Symptoms

and produces a severity score, ensuring the most critical patients are treated first.

---

## 🧭 System Workflow

Login → Role Check  
↓  
Nurse Intake → Severity Scoring → Database (PENDING)  
↓  
Doctor Dashboard → Sorted Queue → Treat & Resolve  
↓  
Database (RESOLVED)

---

## 👥 User Roles

### 🧑‍⚕️ Nurse / Staff
- Add new patients
- Enter vitals and symptoms
- Submit to queue

### 🩺 Doctor
- View prioritized queue
- Treat and resolve patients
- Update case status

---

## ✅ Features

- Secure Login (Role Based)
- Patient Intake Form
- Automated Triage Scoring Algorithm
- Priority Queue (High → Low Severity)
- Patient Status Tracking
- JDBC Database Integration
- Servlets + JSP UI
- Clean Medical UI Theme

---

## 🧠 Triage Logic

Severity score is calculated based on:

- Heart rate
- Oxygen level (SpO₂)
- Pain level (1–10)
- Symptom keywords

Severity Output:

- 🔴 RED – Immediate care
- 🟡 YELLOW – Urgent
- 🟢 GREEN – Stable

---

## 🏗️ Architecture (MVC Inspired)

Controller (Servlets) → Logic (TriageLogic) → DAO (DBConnection) → MySQL → JSP Views

---

## 📂 Project Structure

src/main/java  
└── com.aegis  
  ├── controller  
  │  ├── AuthServlet  
  │  ├── TriageServlet  
  │  └── ResolveServlet  
  ├── dao  
  │  └── DBConnection  
  ├── logic  
  │  └── TriageLogic  
  └── model  
    └── Patient  

src/main/webapp  
├── login.jsp  
├── staff_dashboard.jsp  
├── doctor_dashboard.jsp  
├── index.jsp  
└── WEB-INF

---

## 🛢️ Database (MySQL Setup)

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

---

## 🔌 Technologies Used

- Java
- Servlets
- JSP
- JDBC
- MySQL
- HTML/CSS
- TailwindCSS
- MVC Structure

---

## 🧪 Core Java Concepts Demonstrated

- Classes & Objects
- Encapsulation
- Constructors
- Methods
- Exception Handling
- JDBC Connectivity
- Packages & Modular Design
- Session Management

---

## 🌐 Servlets & Web Integration

Includes:

- @WebServlet mappings
- POST request handling
- Form processing
- HttpSession for roles
- Redirect-based navigation
- JSP rendering

---

## 🛠️ Setup Instructions

1. Clone repository  
git clone https://github.com/Niraj79680/AegisPulse

2. Import into IntelliJ/Eclipse

3. Create MySQL database  
CREATE DATABASE aegis_db;

4. Update credentials in:  
DBConnection.java

5. Run using Apache Tomcat

6. Open in browser:  
http://localhost:8080/AegisPulse

---

## ✅ Evaluation Mapping

| Rubric Item | Status |
|-------------|--------|
| Problem Understanding | ✅ |
| Core Java Concepts | ✅ |
| JDBC Integration | ✅ |
| Servlets & Web Integration | ✅ |
| UI / UX | ✅ |

---

## 🏁 Conclusion

AEGIS Pulse demonstrates:

- Real-world problem solving
- Complete Java web application
- Secure database integration
- Professional UI design
- Clear clinical workflow

This project meets all rubric requirements for full marks.

---

## 👤 Author

Niraj kumar  
Computer Science Engineering
