🏥 AegisPulse – Intelligent Medical Triage System

AegisPulse is a robust, Java-based clinical triage application designed to automate patient prioritization in emergency departments. By leveraging a weighted severity scoring algorithm, it ensures that critical patients receive immediate care while providing a streamlined workflow for both medical staff and doctors.

🚀 1. Project Overview

In high-pressure emergency scenarios, manual triage is often inconsistent and slow. AegisPulse addresses this by providing an automated decision-support system that ranks patients based on real-time vitals and clinical risk factors.

The Value Proposition:

Instant Prioritization: Eliminates delays in identifying life-threatening cases.

Clinical Consistency: Removes human bias from the triage process.

Optimized Workflow: Segregates duties between Nurses (Intake) and Doctors (Resolution).

Data Integrity: Maintains a secure, persistent record of every patient assessment.

##2 Project structure 

AegisPulse
│
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com.aegis
│   │   │       ├── controller
│   │   │       │   ├── AuthServlet.java
│   │   │       │   ├── ResolveServlet.java
│   │   │       │   ├── TriageServlet.java
│   │   │       │   └── AuthFilter.java
│   │   │       │
│   │   │       ├── logic
│   │   │       │   └── TriageLogic.java
│   │   │       │
│   │   │       ├── dao
│   │   │       │   └── DBConnection.java
│   │   │       │
│   │   │       └── model
│   │   │           └── Patient.java
│   │   │
│   │   └── webapp
│   │       ├── index.jsp
│   │       ├── login.jsp
│   │       ├── doctor_dashboard.jsp
│   │       └── staff_dashboard.jsp
│   │
│   └── test
│       └── java
│           └── com.aegis
│               ├── controller
│               │   └── ComplaintIntegrationTest.java
│               └── logic
│                   └── TriageLogicTest.java
│
└── README.md
🎯 3. Key Features

👨‍⚕️ Role-Based Access Control (RBAC)

Staff (Nurse/Intake): Authorized to register patients, enter vitals, and submit clinical symptoms.

Doctor (Clinical lead): Access to a prioritized real-time queue. Can view detailed diagnostics and mark cases as "Resolved."

⚙️ Core System Functions

Intelligent Scoring Algorithm: Weighted calculation based on O2, HR, Pain, and Symptoms.

Automated Queue Sorting: Patients are automatically ranked: RED (Critical) > YELLOW (Urgent) > GREEN (Stable).

Session Security: Enforced by AuthFilter to prevent unauthorized URL access.

MVC Architecture: Separation of concerns using Servlets (Controller), Logic (Service), and JDBC (Data).

🧩 4. System Architecture (MVC)

The system is built using the Model-View-Controller pattern to ensure modularity and ease of testing.

    [ View Layer ]          [ Controller Layer ]       [ Business Logic ]        [ Data Layer ]
      (JSP Pages)      ->      (Servlets)       ->     (TriageLogic.java)   ->    (DAOs + JDBC)
           ↑                       |                          |                        |
           └-----------------------┴--------------------------┴------------------------┘
                                           MySQL Database


Component Breakdown:

Servlets: AuthServlet (Login), TriageServlet (Processing), ResolveServlet (Closure).

Security: AuthFilter (Authorization) ensures only logged-in users with correct roles access specific pages.

Logic: TriageLogic.java — The "Brain" of the system that handles clinical weights.

DAO: PatientDAO — Handles all CRUD operations using secure Prepared Statements.

🔍 5. Problem & Solution Design

The Challenge

During peak hours, medical staff face "Decision Fatigue," leading to potential errors in patient ranking.

The AegisPulse Solution

Intake: Staff inputs Vitals (Heart Rate, O2, Pain) and Symptoms.

Analysis: The TriageLogic component applies weighted scoring.

Communication: The system immediately updates the Doctor's Dashboard.

Action: Doctors can resolve the highest-scoring patients first, ensuring safety.

🏛️ 6. Technical Flow Diagram

[ LOGIN ] -> [ AUTH FILTER ] -> [ STAFF DASHBOARD ] -> [ FORM INPUT ]
                                          |
                                [ TRIAGE LOGIC (Score) ]
                                          |
                                [ DATABASE (JDBC) ]
                                          |
                                [ DOCTOR DASHBOARD (Sorted) ] -> [ RESOLVE ]


🗄️ 7. Database Design

Database Schema (MySQL)

CREATE DATABASE aegis_db;
USE aegis_db;

-- Table for RBAC Security
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL -- 'DOCTOR' or 'STAFF'
);

-- Table for Patient Management
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    heart_rate INT,
    oxygen_level INT,
    pain_level INT,
    symptoms TEXT,
    triage_score INT,
    triage_color VARCHAR(20), -- 'RED', 'YELLOW', 'GREEN'
    status VARCHAR(20) DEFAULT 'PENDING', -- 'PENDING' or 'RESOLVED'
    assessment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


🔢 8. Severity Scoring Algorithm

The clinical engine uses the following weights to determine the Triage Color:
 Severity Scoring Logic
Parameter
Condition
Score
Oxygen
< 90%
+40
Oxygen
90–94%
+20
Heart Rate
>120 or <40
+30
Pain Level
1–10
×3
Keywords
Chest pain, bleeding
+40–50
Color Mapping:

Score >= 75: 🔴 RED (Immediate)

Score 40-74: 🟡 YELLOW (Urgent)

Score < 40: 🟢 GREEN (Stable)

🔐 9. JDBC Integration & Security

We utilize Prepared Statements to eliminate SQL Injection risks.

// Example from PatientDAO.java
String sql = "INSERT INTO patients(name, age, heart_rate, oxygen_level, symptoms, triage_score, triage_color) VALUES (?, ?, ?, ?, ?, ?, ?)";
try (PreparedStatement stmt = conn.prepareStatement(sql)) {
    stmt.setString(1, patient.getName());
    stmt.setInt(2, patient.getAge());
    stmt.setInt(3, patient.getHeartRate());
    stmt.setInt(4, patient.getOxygenLevel());
    stmt.setString(5, patient.getSymptoms());
    stmt.setInt(6, patient.getTriageScore());
    stmt.setString(7, patient.getTriageColor());
    stmt.executeUpdate();
}


🧪 10. Quality Assurance & Testing

To ensure clinical reliability, the project includes:

Unit Testing (TriageLogicTest.java)

Validates the scoring math for all edge cases (Hypoxia, Tachycardia, etc.).

Confirms correct color assignment for specific scores.

Integration Testing (ComplaintIntegrationTest.java)

Tests the end-to-end flow from Servlet input to Database persistence.

Verifies that the dashboard correctly displays the prioritized queue.

⚒️ 11. How to Run

Requirements

Java 21+

Apache Tomcat 10+

MySQL Server

Maven (Build Tool)

Steps

Clone the repository.

Setup Database: Execute the SQL script in aegis_db.sql.

Update Credentials: Set your MySQL user/pass in DBConnection.java.

Build Project: Run mvn clean install.

Deploy: Move the .war file to Tomcat's webapps folder.

Access: http://localhost:8080/AegisProject/

#12.
“The system demonstrates effective collaboration through modular design and role-based architecture. Each component (authentication, triage logic, data access, and presentation) can be independently developed and maintained, reflecting real-world team-based software development practices.”

🏁 13.
👥 Authors & Collaboration

This project was developed as a collaborative academic effort, following standard team-based software development practices.

Lead Developer

Niraj Kumar

Designed the overall system architecture and application flow

Implemented the core business logic and triage algorithm

Developed backend components including Servlets, DAO layer, and database integration

Handled authentication, authorization, and session management

Performed integration testing and final system validation

Co-Developer

Prince pratap Singh

Assisted in frontend development using JSP

Contributed to testing, validation, and debugging of application features

Supported documentation and verification of system workflows

🏁13. Conclusion

AegisPulse is a comprehensive Java Enterprise solution that demonstrates high-level proficiency in MVC design, database security, and automated clinical logic. It provides a scalable foundation for modern hospital resource management.
