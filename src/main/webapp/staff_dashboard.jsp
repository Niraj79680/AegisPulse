<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security: Only allow STAFF to see this page
    if(session.getAttribute("user") == null || !"STAFF".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Staff Intake - AEGIS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-emerald-50 min-h-screen font-sans flex flex-col">

    <!-- Green Navbar for Staff -->
    <nav class="bg-emerald-600 p-4 text-white shadow-md flex justify-between items-center">
        <div class="flex items-center gap-2">
            <i class="fa-solid fa-user-nurse text-xl"></i>
            <h1 class="text-xl font-bold">AEGIS <span class="font-light text-emerald-200">Staff Portal</span></h1>
        </div>
        <div class="flex items-center gap-4">
            <span class="text-sm">Nurse <%= session.getAttribute("user") %></span>
            <a href="login.jsp" class="bg-emerald-800 px-3 py-1 rounded text-sm hover:bg-emerald-900 transition">Logout</a>
        </div>
    </nav>

    <!-- Success Message -->
    <% if("1".equals(request.getParameter("success"))) { %>
        <div class="max-w-lg mx-auto mt-6 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <strong class="font-bold">Success!</strong>
            <span class="block sm:inline">Patient added to the triage queue.</span>
        </div>
    <% } %>

    <!-- Main Content: Intake Form -->
    <div class="flex-grow flex items-center justify-center p-6">
        <div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-lg border-t-4 border-emerald-500">
            <div class="text-center mb-6">
                <h2 class="text-2xl font-bold text-slate-800">Patient Intake</h2>
                <p class="text-slate-500 text-sm">Enter patient vitals for Triage Queue</p>
            </div>

            <form action="triage" method="post" class="flex flex-col gap-4">
                <div>
                    <label class="text-xs font-bold text-slate-500 uppercase">Patient Name</label>
                    <input type="text" name="name" placeholder="John Doe" required class="w-full border p-3 rounded focus:ring-2 focus:ring-emerald-500 outline-none bg-slate-50 focus:bg-white transition">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="text-xs font-bold text-slate-500 uppercase">Age</label>
                        <input type="number" name="age" required class="w-full border p-3 rounded focus:ring-2 focus:ring-emerald-500 outline-none bg-slate-50 focus:bg-white transition">
                    </div>
                    <div>
                        <label class="text-xs font-bold text-slate-500 uppercase">Pain (1-10)</label>
                        <input type="number" name="pain" min="1" max="10" required class="w-full border p-3 rounded focus:ring-2 focus:ring-emerald-500 outline-none bg-slate-50 focus:bg-white transition">
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="text-xs font-bold text-slate-500 uppercase">Heart Rate</label>
                        <input type="number" name="hr" placeholder="BPM" required class="w-full border p-3 rounded focus:ring-2 focus:ring-emerald-500 outline-none bg-slate-50 focus:bg-white transition">
                    </div>
                    <div>
                        <label class="text-xs font-bold text-slate-500 uppercase">Oxygen %</label>
                        <input type="number" name="ox" placeholder="SpO2" required class="w-full border p-3 rounded focus:ring-2 focus:ring-emerald-500 outline-none bg-slate-50 focus:bg-white transition">
                    </div>
                </div>

                <div>
                    <label class="text-xs font-bold text-slate-500 uppercase">Symptoms</label>
                    <textarea name="symptoms" placeholder="Describe symptoms..." class="w-full border p-3 rounded h-24 focus:ring-2 focus:ring-emerald-500 outline-none bg-slate-50 focus:bg-white transition"></textarea>
                </div>

                <button type="submit" class="bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-3 rounded shadow transition flex justify-center items-center gap-2">
                    <i class="fa-solid fa-paper-plane"></i> Submit to Queue
                </button>
            </form>
        </div>
    </div>

</body>
</html>