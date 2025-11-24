package com.aegis.controller;

import com.aegis.dao.DBConnection;
import com.aegis.logic.TriageLogic;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/triage")
public class TriageServlet extends HttpServlet {

    private TriageLogic logicEngine = new TriageLogic();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        int hr = Integer.parseInt(request.getParameter("hr"));
        int ox = Integer.parseInt(request.getParameter("ox"));
        int pain = Integer.parseInt(request.getParameter("pain"));
        String symptoms = request.getParameter("symptoms");

        int score = logicEngine.calculateSeverityScore(hr, ox, pain, symptoms);
        String color = logicEngine.getTriageColor(score);

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO patients (name, age, heart_rate, oxygen_level, pain_level, symptoms, triage_score, triage_color, status) VALUES (?,?,?,?,?,?,?,?, 'PENDING')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setInt(3, hr);
            ps.setInt(4, ox);
            ps.setInt(5, pain);
            ps.setString(6, symptoms);
            ps.setInt(7, score);
            ps.setString(8, color);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        String role = (String) session.getAttribute("role");

        if ("STAFF".equals(role)) {
            response.sendRedirect("staff_dashboard.jsp?success=1");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
