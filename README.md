🏥 AegisPulse – Intelligent Medical Triage System

AegisPulse is a Java-based web application designed to assist hospitals in managing emergency patients by automating the triage process. The system evaluates patient conditions using medical parameters and assigns priority levels to ensure timely and effective treatment.

🚀 1. Project Overview

In emergency scenarios, quick and accurate decision-making is critical. Manual triage can be inconsistent and error-prone.
AegisPulse addresses this by introducing an automated, rule-based triage system that supports medical staff in prioritizing patients efficiently.

🎯 2. Key Features

Role-based access control (RBAC)

Automated patient triage using rule-based logic

Secure authentication and session management

MVC-based clean architecture

Database-driven patient management

Real-time prioritization of patients

🧩 3. System Architecture
Controller Layer (Servlets)
        ↓
Business Logic Layer (TriageLogic)
        ↓
DAO Layer (Database Access)
        ↓
MySQL Database

**Core Components

AuthServlet – Handles user login and authentication

AuthFilter – Enforces role-based access control on protected resources

TriageServlet – Accepts patient data and applies triage logic

ResolveServlet – Marks patient cases as resolved

TriageLogic – Core algorithm for severity evaluation

🔐 4. Security & Access Control (IMPORTANT)

Security is implemented at multiple levels:

✔ Authentication

Users must log in via AuthServlet

Credentials are validated against the database

✔ Authorization (RBAC)

AuthFilter intercepts all protected requests

Ensures only authenticated users with valid roles can access resources

Prevents unauthorized access to internal pages

✔ Session Management

Sessions are validated on every request

Unauthenticated users are redirected to login

✔ SQL Injection Prevention

All database operations use PreparedStatement

No raw SQL concatenation is used

🧠 5. Triage Logic & Decision Making

The system evaluates patients using:

Heart rate

Oxygen level

Pain severity

Reported symptoms

Based on these values, a severity score is calculated and classified into:

RED – Critical

YELLOW – Moderate

GREEN – Stable

This logic ensures consistent and fair medical prioritization.

🧪 6. Testing Strategy
Unit Testing

TriageLogicTest validates the correctness of the severity calculation.

Ensures edge cases are handled properly.

Integration Testing

ComplaintIntegrationTest verifies end-to-end flow:

Input → Logic → Database → Response

Confirms smooth interaction between components.

🗄️ 7. Database Design
Tables
Users (id, username, password, role)
Patients (id, name, age, heart_rate, oxygen_level, pain_level, severity_score, status)


Normalized schema

Referential integrity

Secure access via prepared statements

🧰 8. Technology Stack

Java (JDK 8+)

JSP & Servlets

Apache Tomcat

MySQL

JDBC

Maven

🏁 9. Conclusion

AegisPulse is a complete, secure, and scalable web application that demonstrates:

Proper MVC architecture

Secure authentication and authorization

Real-world problem solving

Clean coding and modular design

This project meets academic requirements and reflects practical backend development skills.
