<%@ page import="java.sql.*, com.aegis.dao.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // guard: only logged-in doctor can see this page
    String role = (String) session.getAttribute("role");
    if (session.getAttribute("user") == null || !"DOCTOR".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Doctor Dashboard - AEGIS</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>

<body class="bg-slate-100 min-h-screen font-sans text-slate-800">

    <!-- top bar -->
    <nav class="bg-sky-700 text-white shadow-md">
        <div class="max-w-6xl mx-auto px-4 py-3 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-full bg-white/15 flex items-center justify-center">
                    <i class="fa-solid fa-heart-pulse text-red-200"></i>
                </div>
                <div>
                    <h1 class="text-xl font-bold tracking-wide">
                        AEGIS <span class="font-light text-sky-100">MD Priority</span>
                    </h1>
                    <p class="text-xs text-sky-100/80">
                        Clinical triage overview for doctors
                    </p>
                </div>
            </div>

            <div class="flex items-center gap-4">
                <span class="text-sm bg-sky-800/60 px-3 py-1 rounded-full flex items-center gap-2">
                    <i class="fa-solid fa-user-doctor text-sky-100"></i>
                    <span>Dr. <%= session.getAttribute("user") %></span>
                </span>
                <a href="login.jsp"
                   class="bg-red-500 hover:bg-red-600 text-sm font-semibold px-4 py-2 rounded-lg shadow-sm transition">
                    Logout
                </a>
            </div>
        </div>
    </nav>

    <main class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-6">

        <!-- small info strip -->
        <section class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div class="bg-white border border-slate-200 rounded-xl px-4 py-3 flex items-center gap-3 shadow-sm">
                <div class="w-9 h-9 rounded-full bg-red-50 flex items-center justify-center">
                    <i class="fa-solid fa-triangle-exclamation text-red-500"></i>
                </div>
                <div>
                    <p class="text-xs text-slate-500 uppercase tracking-wide">Queue Order</p>
                    <p class="text-sm">Patients sorted by highest severity score first.</p>
                </div>
            </div>
            <div class="bg-white border border-slate-200 rounded-xl px-4 py-3 flex items-center gap-3 shadow-sm">
                <div class="w-9 h-9 rounded-full bg-yellow-50 flex items-center justify-center">
                    <i class="fa-solid fa-circle text-yellow-400"></i>
                </div>
                <div>
                    <p class="text-xs text-slate-500 uppercase tracking-wide">Color Meaning</p>
                    <p class="text-sm">Red: immediate · Yellow: urgent · Green: stable.</p>
                </div>
            </div>
            <div class="bg-white border border-slate-200 rounded-xl px-4 py-3 flex items-center gap-3 shadow-sm">
                <div class="w-9 h-9 rounded-full bg-emerald-50 flex items-center justify-center">
                    <i class="fa-solid fa-clipboard-check text-emerald-500"></i>
                </div>
                <div>
                    <p class="text-xs text-slate-500 uppercase tracking-wide">Action</p>
                    <p class="text-sm">Use “Treat &amp; Resolve” once the case is completed.</p>
                </div>
            </div>
        </section>

        <!-- main triage card -->
        <section class="bg-white border border-slate-200 rounded-2xl shadow-lg overflow-hidden">
            <!-- card header -->
            <div class="px-6 py-4 border-b border-slate-200 flex items-center justify-between bg-slate-50">
                <div class="flex items-center gap-2">
                    <i class="fa-solid fa-bell text-red-500"></i>
                    <div>
                        <h2 class="font-semibold text-slate-800 text-base md:text-lg">
                            Active Triage Queue
                        </h2>
                        <p class="text-xs text-slate-500">
                            Live list of patients waiting for doctor review.
                        </p>
                    </div>
                </div>
                <span class="hidden sm:inline-flex items-center gap-1 text-xs text-slate-500">
                    <i class="fa-solid fa-circle-info text-sky-500"></i>
                    Refresh the page to see latest updates.
                </span>
            </div>

            <!-- table -->
            <div class="overflow-x-auto">
                <table class="min-w-full text-left border-collapse">
                    <thead class="bg-slate-50 border-b border-slate-200">
                        <tr class="text-slate-500 text-[11px] md:text-xs uppercase tracking-wide">
                            <th class="px-6 py-3 font-semibold">Patient / Age</th>
                            <th class="px-6 py-3 font-semibold">Key Symptom</th>
                            <th class="px-6 py-3 font-semibold">Vitals (HR / O₂)</th>
                            <th class="px-6 py-3 font-semibold text-center">Score</th>
                            <th class="px-6 py-3 font-semibold text-right">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        <%
                            try {
                                // load all patients currently waiting
                                Connection conn = DBConnection.getConnection();
                                String sql = "SELECT id, name, age, heart_rate, oxygen_level, triage_score, triage_color, symptoms " +
                                             "FROM patients WHERE status = 'PENDING' ORDER BY triage_score DESC";
                                PreparedStatement ps = conn.prepareStatement(sql);
                                ResultSet rs = ps.executeQuery();
                                boolean hasData = false;

                                while (rs.next()) {
                                    hasData = true;

                                    // choose row + badge styling based on triage color
                                    String colorCode = rs.getString("triage_color");
                                    String badgeClass = "bg-emerald-500 text-white";
                                    String rowBg = "bg-white hover:bg-slate-50";
                                    String scoreText = "text-emerald-700";

                                    if ("RED".equals(colorCode)) {
                                        badgeClass = "bg-red-500 text-white";
                                        rowBg = "bg-red-50 hover:bg-red-100";
                                        scoreText = "text-red-700";
                                    } else if ("YELLOW".equals(colorCode)) {
                                        badgeClass = "bg-yellow-400 text-yellow-900";
                                        rowBg = "bg-yellow-50 hover:bg-yellow-100";
                                        scoreText = "text-yellow-700";
                                    }
                        %>
                        <tr class="<%= rowBg %> transition-colors">
                            <!-- patient / age -->
                            <td class="px-6 py-4 align-top">
                                <div class="font-semibold text-slate-900 text-sm md:text-base">
                                    <%= rs.getString("name") %>
                                </div>
                                <div class="text-[11px] text-slate-500 mt-0.5">
                                    Age: <%= rs.getInt("age") %>
                                </div>
                            </td>

                            <!-- symptom preview -->
                            <td class="px-6 py-4 align-top text-sm text-slate-600 italic max-w-xs overflow-hidden text-ellipsis whitespace-nowrap"
                                title="<%= rs.getString("symptoms") %>">
                                <%= rs.getString("symptoms").split(",")[0].trim() %>...
                            </td>

                            <!-- vitals -->
                            <td class="px-6 py-4 align-top text-sm text-slate-700">
                                <span class="font-mono font-semibold text-slate-900 text-sm">
                                    <%= rs.getInt("heart_rate") %>
                                </span>
                                <span class="text-[11px] text-slate-500 ml-1">BPM</span>
                                <span class="mx-1 text-slate-300">|</span>
                                <span class="font-mono font-semibold text-slate-900 text-sm">
                                    <%= rs.getInt("oxygen_level") %>%
                                </span>
                            </td>

                            <!-- triage score -->
                            <td class="px-6 py-4 align-top text-center">
                                <span class="inline-flex items-center justify-center px-3 py-1 rounded-full text-xs font-semibold <%= badgeClass %> <%= scoreText %>">
                                    <%= rs.getInt("triage_score") %>
                                </span>
                            </td>

                            <!-- action -->
                            <td class="px-6 py-4 align-top text-right">
                                <form action="resolve" method="post" class="inline-block">
                                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                    <button type="submit"
                                            class="inline-flex items-center gap-1 bg-sky-600 hover:bg-sky-700 text-[11px] md:text-xs font-semibold text-white px-4 py-2 rounded-full shadow-sm transition">
                                        Treat &amp; Resolve
                                        <i class="fa-solid fa-check text-xs"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                } // end while

                                if (!hasData) {
                        %>
                        <tr>
                            <td colspan="5" class="px-6 py-14 text-center text-slate-500 bg-white">
                                <div class="flex flex-col items-center gap-2">
                                    <i class="fa-solid fa-clipboard-check text-3xl text-slate-300"></i>
                                    <p>No active patients in queue.</p>
                                    <p class="text-xs text-slate-400">
                                        All current cases are cleared. Waiting for new patients.
                                    </p>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                        <tr>
                            <td colspan="5" class="px-6 py-4 text-red-600 bg-red-50 text-sm">
                                Error loading data: <%= e.getMessage() %>
                            </td>
                        </tr>
                        <%
                            } // end try/catch
                        %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</body>
</html>
