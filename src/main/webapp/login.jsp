<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AEGIS Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: radial-gradient(circle at top, #0f172a, #020617);
        }

        .glass {
            backdrop-filter: blur(20px);
            background: rgba(255,255,255,0.05);
        }

        .glow-border {
            box-shadow: 0 0 25px rgba(59, 130, 246, 0.4);
            border: 1px solid rgba(59, 130, 246, 0.4);
        }

        .glow-input:focus {
            box-shadow: 0 0 15px rgba(96,165,250,0.7);
            border-color: rgba(96,165,250,1);
        }

        .hover-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 0 40px rgba(59,130,246,0.4);
        }
    </style>
</head>

<body class="h-screen flex items-center justify-center font-sans text-white">

    <div class="glass p-10 rounded-3xl shadow-2xl w-[420px] glow-border transition hover-card">

        <div class="text-center mb-8">
            <div class="w-20 h-20 mx-auto flex items-center justify-center rounded-full bg-blue-600/20 border border-blue-500/40 shadow-lg">
                <i class="fa-solid fa-shield-halved text-4xl text-blue-400"></i>
            </div>

            <h1 class="text-4xl font-extrabold mt-4 tracking-wide">AEGIS</h1>
            <p class="text-blue-300 text-sm mt-1">Medical Triage System</p>
        </div>

        <form action="auth" method="post" class="flex flex-col gap-6">

            <div class="relative">
                <i class="fa-solid fa-user absolute left-4 top-3 text-slate-400"></i>
                <input type="text" name="username" placeholder="Username" required
                       class="w-full glass glow-input text-white pl-12 p-3 rounded-lg border border-slate-600 outline-none transition">
            </div>

            <div class="relative">
                <i class="fa-solid fa-lock absolute left-4 top-3 text-slate-400"></i>
                <input type="password" name="password" placeholder="Password" required
                       class="w-full glass glow-input text-white pl-12 p-3 rounded-lg border border-slate-600 outline-none transition">
            </div>

            <button type="submit"
                    class="bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold py-3 rounded-lg shadow-lg transition transform hover:scale-105 active:scale-95">
                Secure Login
            </button>
        </form>

        <% if(request.getParameter("error") != null) { %>
            <div class="mt-5 p-3 bg-red-500/20 border border-red-500/50 rounded text-red-200 text-center text-sm animate-pulse">
                <i class="fa-solid fa-circle-exclamation mr-1"></i> <%= request.getParameter("error") %>
            </div>
        <% } %>

        <p class="text-center text-xs text-slate-400 mt-4">
            © 2025 AEGIS Health Systems
        </p>
    </div>

</body>
</html>
