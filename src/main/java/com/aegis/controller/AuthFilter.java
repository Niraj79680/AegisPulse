package com.aegis.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AuthFilter handles Role-Based Access Control (RBAC).
 * It prevents unauthorized users from accessing dashboards via direct URL.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI();

        // 1. PUBLIC PATHS: Accessible without logging in
        boolean isPublic = path.endsWith("login.jsp") ||
                path.endsWith("index.jsp") ||
                path.contains("/auth") ||
                path.contains("/css/") ||
                path.contains("/js/");

        boolean isLoggedIn = (session != null && session.getAttribute("role") != null);

        if (isPublic || isLoggedIn) {
            if (isLoggedIn) {
                String role = (String) session.getAttribute("role");

                // 2. RBAC CHECK: Prevent non-doctors from accessing doctor pages
                if (path.contains("doctor_dashboard") && !"DOCTOR".equals(role)) {
                    res.sendError(403, "Access Denied: Doctor permissions required.");
                    return;
                }
            }
            // Allow the request to proceed
            chain.doFilter(request, response);
        } else {
            // 3. SECURE REDIRECT: Redirect to login if unauthenticated
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig f) {}

    @Override
    public void destroy() {}
}