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
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: sans-serif;
            overflow: hidden;
            background: linear-gradient(135deg, #e8fdfc 0%, #f4f9f9 40%, #e9f6ff 100%);
            position: relative;
        }

        .wave {
            position: absolute;
            width: 200%;
            height: 200%;
            top: -50%;
            left: -50%;
            background: radial-gradient(circle at 30% 30%, rgba(26,166,166,0.15), transparent 60%),
                        radial-gradient(circle at 70% 70%, rgba(0,180,220,0.15), transparent 60%);
            animation: float 8s ease-in-out infinite alternate;
            filter: blur(80px);
        }

        @keyframes float {
            from { transform: rotate(0deg) scale(1); }
            to   { transform: rotate(8deg) scale(1.15); }
        }

        .card {
            background: white;
            border-radius: 22px;
            box-shadow:
                0 15px 35px rgba(0,0,0,0.08),
                0 0 15px rgba(26,166,166,0.25),
                0 0 35px rgba(0,180,255,0.18);
            padding: 50px;
            width: 430px;
            opacity: 0;
            transform: translateY(25px);
            animation: card-enter .6s ease-out forwards, neonPulse 3s ease-in-out infinite;
            position: relative;
        }

        @keyframes card-enter {
            to { opacity: 1; transform: translateY(0); }
        }

        .card::before {
            content: "";
            position: absolute;
            inset: -20px;
            border-radius: 28px;
            background: radial-gradient(circle, rgba(0,255,255,0.25), rgba(0,255,255,0));
            filter: blur(35px);
            z-index: -1;
            animation: glowPulse 4s ease-in-out infinite alternate;
        }

        @keyframes glowPulse {
            from { opacity: .35; transform: scale(0.95); }
            to   { opacity: .6; transform: scale(1.05); }
        }

        @keyframes neonPulse {
            0%   { box-shadow: 0 0 15px rgba(26,166,166,0.25), 0 0 35px rgba(0,180,255,0.18); }
            50%  { box-shadow: 0 0 23px rgba(26,166,166,0.35), 0 0 55px rgba(0,180,255,0.24); }
            100% { box-shadow: 0 0 15px rgba(26,166,166,0.25), 0 0 35px rgba(0,180,255,0.18); }
        }

        .input-field {
            border: 1px solid #dce7e7;
            background: #f8fafb;
        }

        .input-field:focus {
            border-color: #1aa6a6;
            box-shadow: 0 0 0 3px rgba(26,166,166,0.18);
            background: white;
        }

        .button-main {
            background: linear-gradient(90deg, #1aa6a6, #1d9ed3);
            color: white;
            font-weight: 600;
            padding: 14px;
            border-radius: 10px;
            transition: .25s;
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .button-main:hover {
            filter: brightness(1.05);
            transform: translateY(-2px);
        }

        .button-main::after {
            content: "";
            position: absolute;
            top: 0;
            left: -120%;
            width: 60%;
            height: 100%;
            background: linear-gradient(120deg, transparent, rgba(255,255,255,0.6), transparent);
            transform: skewX(-20deg);
        }

        .button-main:hover::after {
            animation: shimmer .9s ease-out;
        }

        @keyframes shimmer {
            to { transform: translateX(260%) skewX(-20deg); }
        }

        .avatar {
            position: relative;
        }

        .avatar::before {
            content: "";
            position: absolute;
            inset: -8px;
            border-radius: 999px;
            border: 2px solid rgba(16,185,129,0.35);
            animation: pulse 2.4s infinite ease-out;
        }

        @keyframes pulse {
            0% { transform: scale(.9); opacity:.4; }
            70% { transform: scale(1.2); opacity:0; }
            100% { transform: scale(1.2); opacity:0; }
        }
    </style>
</head>

<body>
    <div class="wave"></div>

    <div class="card">
        <div class="text-center mb-6">
            <div class="w-20 h-20 mx-auto flex items-center justify-center rounded-full bg-emerald-50 border border-emerald-200 avatar">
                <i class="fa-solid fa-hospital text-4xl text-emerald-600"></i>
            </div>

            <h1 class="text-3xl font-bold mt-3 text-slate-700">AEGIS</h1>
            <p class="text-emerald-700 text-sm font-medium">Medical Triage System</p>
        </div>

        <!-- ✅ ONLY FIX IS HERE -->
        <form action="${pageContext.request.contextPath}/auth" method="post" class="flex flex-col gap-5">
            <div class="relative">
                <i class="fa-solid fa-user absolute left-4 top-3 text-slate-400"></i>
                <input type="text" name="username" placeholder="Username" required
                       class="input-field w-full pl-11 p-3 rounded-lg outline-none transition">
            </div>

            <div class="relative">
                <i class="fa-solid fa-lock absolute left-4 top-3 text-slate-400"></i>
                <input type="password" name="password" placeholder="Password" required
                       class="input-field w-full pl-11 p-3 rounded-lg outline-none transition">
            </div>

            <button type="submit" class="button-main">Secure Login</button>
        </form>

        <% if(request.getParameter("error") != null) { %>
            <div class="mt-5 p-3 bg-red-50 border border-red-300 rounded text-red-600 text-center text-sm">
                <i class="fa-solid fa-circle-exclamation mr-1"></i> <%= request.getParameter("error") %>
            </div>
        <% } %>

        <p class="text-center text-xs text-slate-400 mt-5">
            © 2025 AEGIS Health Systems
        </p>
    </div>

</body>
</html>
