<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to AEGIS</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-900 h-screen flex flex-col items-center justify-center text-white font-sans">

    <h1 class="text-5xl font-bold mb-4">AEGIS</h1>
    <p class="text-xl text-slate-400 mb-8">Advanced Triage System</p>

    <a href="login.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-lg shadow-lg transition">
        Login to Dashboard
    </a>

    <!-- Error Message Area -->
    <% if(request.getParameter("error") != null) { %>
        <div class="mt-8 p-4 bg-red-500/20 border border-red-500 text-red-200 rounded">
            <strong>System Alert:</strong> <%= request.getParameter("error") %>
        </div>
    <% } %>

</body>
</html>