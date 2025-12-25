# 🏥 AegisPulse – Intelligent Medical Triage System  
A Java-based clinical triage system that automates patient prioritization using severity scoring, helping hospitals manage emergency cases efficiently and safely.

---

## 🚀 1. Project Overview
Hospitals often receive multiple emergency patients at the same time, making manual triage slow and error-prone.  
**AegisPulse** provides an automated triage algorithm that ranks patients based on vital signs, symptoms, and risk factors.

This ensures:
- Faster decision-making  
- Reduced human error  
- Fair and consistent triage  
- Better workload distribution between staff and doctors  

---

## 🎯 2. Key Features
### 👨‍⚕️ **Role-based access**
- **Staff (Nurse):** Add patients + enter vitals  
- **Doctor:** View severity-sorted queue + mark patients resolved  

### ⚙️ **Core System Functions**
- Intelligent severity scoring algorithm  
- Automated queue sorting  
- Real-time dashboard for doctors  
- Session-based authentication  
- Secure JDBC communication  
- Fully modular MVC structure  
- JSP + Servlet based frontend rendering  

---

## 🧩 3. System Architecture (MVC)
```
Controller (Servlets)
    ↓
Service / Logic Layer (Triage scoring)
    ↓
DAO Layer (JDBC DB operations)
    ↓
MySQL Database
    ↑
JSP Views (UI)
```

### ✔ Servlets
- `AuthServlet`  
- `TriageServlet`  
- `ResolveServlet`

### ✔ Logic Layer  
- `TriageLogic.java` — calculates severity using vitals + symptoms.

### ✔ DAO Layer  
Handles all DB operations using **Prepared Statements** for security.

---

## 🔍 4. Problem Understanding & Solution Design
### ✔ Problem  
During peak hospital hours, nurses must decide which patient needs immediate attention. Manual triage is risky and slow.

### ✔ Solution  
AegisPulse automates triage by:  
1. Collecting vitals + symptoms  
2. Calculating a severity score using a weighted formula  
3. Sorting patients by severity  
4. Showing doctors a real-time queue  
5. Allowing doctors to resolve cases  

### ✔ Why This Design?  
- Fair and consistent  
- Eliminates human bias  
- Faster care for critical patients  

---

## 🏛️ 5. Flow Diagram
```
[Login] → [Staff Dashboard] → [Enter Patient Info]
        → [Severity Algorithm] → [DB Store]
        → [Doctor Dashboard Sorted Queue]
        → [Resolve Patient]
```

---

## 🗄️ 6. Database Design

### 🔹 ER Diagram (Text Form)
```
Users (id, username, password, role)
        |
        | 1-to-many
        |
Patients (id, name, age, symptoms, vitals, severity_score, status)
```

### 🔹 Database Schema
```sql
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

```

---

## 🔢 7. Severity Scoring Algorithm
Higher = more critical.

---

## 🔐 8. JDBC Integration (Prepared Statements)
```java
String sql = "INSERT INTO patients(name, age, symptoms, heart_rate, pain_level, severity_score) VALUES (?, ?, ?, ?, ?, ?)";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, patient.getName());
stmt.setInt(2, patient.getAge());
stmt.setString(3, patient.getSymptoms());
stmt.setInt(4, patient.getHeartRate());
stmt.setInt(5, patient.getPainLevel());
stmt.setDouble(6, patient.getSeverityScore());
stmt.executeUpdate();
```

✔ Prevents SQL injection  
✔ Safe DB operations  

---

## 🌐 9. Servlets & Web Integration
### Example `TriageServlet.java`
```java
@WebServlet("/triage")
public class TriageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        int age = Integer.parseInt(req.getParameter("age"));
        int heart = Integer.parseInt(req.getParameter("heartRate"));
        int pain = Integer.parseInt(req.getParameter("pain"));

        double score = TriageLogic.calculate(heart, pain);

        Patient p = new Patient(name, age, heart, pain, score);
        new PatientDAO().save(p);

        resp.sendRedirect("staff_dashboard.jsp");
    }
}
```

✔ Proper request handling  
✔ Session management  
✔ MVC-compliant design  

---
## 10 Security and Testing

### Security
The application implements strong authentication and role-based access control (RBAC).
Authentication is handled using an `AuthServlet`, while authorization is enforced through an
`AuthFilter` that restricts access to application resources based on user roles.

### Testing
Unit and integration testing were implemented to improve the reliability and maintainability
of the complaint workflow.

- **Unit Testing:**  
  `TriageLogicTest` was implemented to validate core business logic, including severity score
  calculation and triage color decision rules.

- **Integration / Workflow Testing:**  
  `ComplaintIntegrationTest` was implemented to verify the complaint workflow by testing the
  interaction between complaint handling logic and triage decision components.

## 🖼️ 11. Screenshots (folder added in repo)

## ⚒️ 12. How to Run
### Requirements
- Java 8+  
- Apache Tomcat 9+  
- MySQL  
- IntelliJ / Eclipse  

### Steps
1. Clone the repo  
2. Import as Maven project  
3. Configure Tomcat  
4. Create the database using SQL above  
5. Update DB credentials in `DBConnection.java`  
6. Run on Tomcat  
7. Open in browser:
```
http://localhost:8081/AegisPulse
```

---

## 🔮 13. Future Enhancements
- ML-based severity prediction  
- Email/SMS alerts  
- Admin analytics dashboard  
- REST API for hospital system integration  
- Docker support  

---

## 🏁 14. Conclusion
AegisPulse is a complete Java web application demonstrating:

- Strong problem understanding  
- Full MVC architecture  
- Servlets + JSP integration  
- Secure JDBC usage  
- Clean modular design  
