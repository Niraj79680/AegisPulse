<%@ page import="java.sql.*, com.aegis.dao.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security: Only DOCTOR allowed
    String role = (String) session.getAttribute("role");
    if(session.getAttribute("user") == null || !"DOCTOR".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Doctor Dashboard - AEGIS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-slate-100 min-h-screen font-sans">
    <!-- Navbar (Blue Theme) -->
    <nav class="bg-gradient-to-r from-blue-700 to-indigo-800 p-4 text-white shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold tracking-wide">AEGIS <span class="font-light text-blue-200">MD Priority</span></h1>
            <div class="flex items-center gap-4">
                <span class="text-sm bg-black/20 px-3 py-1 rounded-full">Dr. <%= session.getAttribute("user") %></span>
                <a href="login.jsp" class="bg-red-500 hover:bg-red-600 transition px-4 py-2 rounded text-sm font-medium">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mx-auto p-6">
        <div class="bg-white rounded-xl shadow-2xl overflow-hidden">
            <div class="bg-white p-4 border-b flex justify-between items-center">
                <h2 class="font-bold text-slate-700 text-lg"><i class="fa-solid fa-bell mr-2 text-red-500 animate-pulse"></i>Active Triage Queue</h2>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-slate-100 border-b">
                        <tr class="text-slate-500 text-xs uppercase">
                            <th class="p-4 font-bold">Patient / Age</th>
                            <th class="p-4 font-bold">Key Symptom</th>
                            <th class="p-4 font-bold">Vitals (HR / O2)</th>
                            <th class="p-4 font-bold">Score</th>
                            <th class="p-4 font-bold text-right">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                        <%
                            try {
                                Connection conn = DBConnection.getConnection();
                                // This SQL query requires the 'status' column to exist in your database
                                String sql = "SELECT id, name, age, heart_rate, oxygen_level, triage_score, triage_color, symptoms FROM patients WHERE status = 'PENDING' ORDER BY triage_score DESC";
                                PreparedStatement ps = conn.prepareStatement(sql);
                                ResultSet rs = ps.executeQuery();
                                boolean hasData = false;

                                while(rs.next()) {
                                    hasData = true;
                                    String colorCode = rs.getString("triage_color");
                                    String badgeClass = "bg-green-100 text-green-700 border-green-200";
                                    String scoreColor = "text-slate-600";
                                    String rowBg = "hover:bg-slate-50";

                                    if("RED".equals(colorCode)) {
                                        badgeClass = "bg-red-500 text-white font-bold animate-pulse shadow-md";
                                        scoreColor = "text-red-700 font-bold";
                                        rowBg = "bg-red-100/50 hover:bg-red-200 border-l-4 border-red-600";
                                    } else if("YELLOW".equals(colorCode)) {
                                        badgeClass = "bg-yellow-400 text-yellow-900 border-yellow-500 font-medium";
                                        scoreColor = "text-yellow-600 font-bold";
                                        rowBg = "bg-yellow-50/50 hover:bg-yellow-100";
                                    }
                        %>
                        <tr class="<%= rowBg %> transition duration-150">
                            <td class="p-4">
                                <div class="font-bold text-slate-800"><%= rs.getString("name") %></div>
                                <div class="text-xs text-slate-500">Age: <%= rs.getInt("age") %></div>
                            </td>
                            <!-- Symptom Tooltip -->
                            <td class="p-4 text-sm text-slate-600 italic max-w-xs overflow-hidden text-ellipsis whitespace-nowrap"
                                title="<%= rs.getString("symptoms") %>">
                                <%= rs.getString("symptoms").split(",")[0].trim() %>...
                            </td>
                            <td class="p-4 text-sm">
                                <span class="font-mono font-bold text-slate-800"><%= rs.getInt("heart_rate") %></span> <span class="text-xs text-slate-500">BPM</span>
                                <span class="mx-1 text-slate-300">|</span>
                                <span class="font-mono font-bold text-slate-800"><%= rs.getInt("oxygen_level") %>%</span>
                            </td>
                            <td class="p-4 <%= scoreColor %> font-mono text-lg flex items-center justify-center">
                                <span class="px-3 py-1 rounded-full text-xs border <%= badgeClass %>"><%= rs.getInt("triage_score") %></span>
                            </td>
                            <td class="p-4 text-right">
                                <form action="resolve" method="post">
                                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white text-xs font-bold py-2 px-4 rounded shadow transition transform active:scale-95">
                                        Treat & Resolve <i class="fa-solid fa-check ml-1"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                } // End while loop

                                if(!hasData) {
                        %>
                            <tr><td colspan="5" class="p-12 text-center text-slate-400 italic">
                                <i class="fa-solid fa-clipboard-check text-2xl mb-2 text-slate-300"></i><br>
                                No active patients in queue. Excellent work!
                            </td></tr>
                        <%
                                }
                            } catch(Exception e) {
                        %>
                            <tr><td colspan="5" class="p-4 text-red-500">Error loading data: <%= e.getMessage() %></td></tr>
                        <%
                            } // End catch block
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>