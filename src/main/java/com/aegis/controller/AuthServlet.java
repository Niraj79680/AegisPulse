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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u);
            ps.setString(2, p);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // reset old session (prevents role mixing)
                request.getSession().invalidate();
                HttpSession session = request.getSession(true);

                session.setAttribute("user", u);
                String role = rs.getString("role");
                session.setAttribute("role", role);

                // only valid roles allowed forward
                if ("STAFF".equals(role)) {
                    response.sendRedirect("staff_dashboard.jsp");
                } else if ("DOCTOR".equals(role)) {
                    response.sendRedirect("doctor_dashboard.jsp");
                } else {
                    // unknown role -> force logout
                    session.invalidate();
                    response.sendRedirect("login.jsp?error=Unauthorized Role");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid Credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Server Error");
        }
    }
}
