package com.aegis.controller;

import com.aegis.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String u = request.getParameter("username");
        String p = request.getParameter("password");

        // 1. Basic Input Validation
        if (u == null || u.trim().isEmpty() || p == null || p.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=Username+and+Password+are+required"
            );
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT username, role FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.trim());
            ps.setString(2, p);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // Prevent session fixation
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }

                HttpSession session = request.getSession(true);

                String role = rs.getString("role");
                session.setAttribute("user", rs.getString("username"));
                session.setAttribute("role", role);

                // ✅ FIXED: ABSOLUTE redirects using context path
                if ("STAFF".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/staff_dashboard.jsp");
                } else if ("DOCTOR".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/doctor_dashboard.jsp");
                } else {
                    session.invalidate();
                    response.sendRedirect(
                            request.getContextPath() + "/login.jsp?error=Account+Configuration+Error"
                    );
                }

            } else {
                response.sendRedirect(
                        request.getContextPath() + "/login.jsp?error=Invalid+username+or+password"
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=Internal+Server+Error"
            );
        }
    }

    // SAFE: prevents 404 if someone opens /auth in browser
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
