<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // only STAFF allowed
    if (session.getAttribute("user") == null || !"STAFF".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Staff Intake - AEGIS</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="min-h-screen font-sans bg-gradient-to-br from-emerald-50 via-sky-50 to-emerald-100 flex flex-col">

    <!-- NAVBAR -->
    <nav class="bg-emerald-600/95 backdrop-blur shadow-lg">
        <div class="max-w-5xl mx-auto px-4 py-3 flex justify-between items-center">
            <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-2xl bg-emerald-500/30 flex items-center justify-center shadow-inner">
                    <i class="fa-solid fa-user-nurse text-white text-lg"></i>
                </div>
                <div>
                    <h1 class="text-xl font-semibold text-white tracking-wide">
                        AEGIS <span class="font-light text-emerald-100">Staff Portal</span>
                    </h1>
                    <p class="text-[11px] text-emerald-100/90">
                        Nursing intake for triage queue
                    </p>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <span class="hidden sm:inline-flex items-center gap-2 text-sm bg-emerald-500/40 px-3 py-1 rounded-full">
                    <i class="fa-solid fa-id-badge text-emerald-50 text-xs"></i>
                    <span>Nurse <%= session.getAttribute("user") %></span>
                </span>
                <a href="login.jsp"
                   class="bg-emerald-900/90 hover:bg-emerald-950 text-sm font-medium px-3 py-1.5 rounded-lg shadow-md transition flex items-center gap-1">
                    <i class="fa-solid fa-right-from-bracket text-xs"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- SUCCESS TOAST -->
    <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="w-full flex justify-center mt-5 px-4">
            <div class="max-w-lg w-full bg-emerald-50 border border-emerald-300/80 text-emerald-800 px-4 py-3 rounded-xl shadow-sm flex items-center gap-3 text-sm">
                <div class="w-7 h-7 rounded-full bg-emerald-500/15 flex items-center justify-center">
                    <i class="fa-solid fa-circle-check text-emerald-500"></i>
                </div>
                <div>
                    <p class="font-semibold">Success</p>
                    <p class="text-xs sm:text-sm">Patient added to the triage queue.</p>
                </div>
            </div>
        </div>
    <% } %>

    <!-- MAIN CONTENT -->
    <main class="flex-grow flex items-center justify-center px-4 py-8">
        <div class="max-w-4xl w-full relative">
            <!-- soft glow behind card -->
            <div class="absolute -inset-3 bg-gradient-to-r from-emerald-200/40 via-sky-200/30 to-emerald-100/0 blur-3xl -z-10"></div>

            <section class="bg-white/95 rounded-3xl shadow-2xl border border-emerald-100/70">
                <!-- CARD HEADER -->
                <div class="px-8 pt-7 pb-4 border-b border-slate-100 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
                    <div>
                        <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-50 text-emerald-700 text-[11px] font-semibold mb-2">
                            <i class="fa-solid fa-stethoscope text-emerald-500"></i>
                            Intake &amp; Vitals
                        </div>
                        <h2 class="text-2xl font-bold text-slate-800">Patient Intake</h2>
                        <p class="text-slate-500 text-sm mt-1">
                            Capture key vitals and symptoms before sending to the doctor’s triage queue.
                        </p>
                    </div>
                    <div class="md:text-right text-xs text-slate-400">
                        <p class="font-semibold text-slate-500">Step 1 of 2</p>
                        <p>Intake by nursing staff</p>
                        <p>Review by doctor next</p>
                    </div>
                </div>

                <!-- FORM BODY -->
                <form action="triage" method="post" class="px-8 py-6 space-y-5">
                    <!-- Patient Name -->
                    <div>
                        <label class="text-xs font-bold text-slate-600 uppercase tracking-wide">
                            Patient Name
                        </label>
                        <input type="text"
                               name="name"
                               placeholder="John Doe"
                               required
                               class="mt-1 w-full border border-slate-200 p-3 rounded-xl text-sm bg-slate-50
                                      focus:bg-white focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200
                                      outline-none transition shadow-sm">
                    </div>

                    <!-- Age + Pain -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label class="text-xs font-bold text-slate-600 uppercase tracking-wide">
                                Age
                            </label>
                            <input type="number"
                                   name="age"
                                   required
                                   class="mt-1 w-full border border-slate-200 p-3 rounded-xl text-sm bg-slate-50
                                          focus:bg-white focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200
                                          outline-none transition shadow-sm">
                        </div>
                        <div>
                            <label class="text-xs font-bold text-slate-600 uppercase tracking-wide flex items-center gap-1">
                                Pain (1–10)
                                <span class="text-[10px] font-normal text-slate-400">(patient reported)</span>
                            </label>
                            <input type="number"
                                   name="pain"
                                   min="1"
                                   max="10"
                                   required
                                   class="mt-1 w-full border border-slate-200 p-3 rounded-xl text-sm bg-slate-50
                                          focus:bg-white focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200
                                          outline-none transition shadow-sm">
                        </div>
                    </div>

                    <!-- HR + O2 -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label class="text-xs font-bold text-slate-600 uppercase tracking-wide">
                                Heart Rate
                            </label>
                            <div class="mt-1 flex gap-2">
                                <input type="number"
                                       name="hr"
                                       placeholder="BPM"
                                       required
                                       class="w-full border border-slate-200 p-3 rounded-xl text-sm bg-slate-50
                                              focus:bg-white focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200
                                              outline-none transition shadow-sm">
                            </div>
                        </div>
                        <div>
                            <label class="text-xs font-bold text-slate-600 uppercase tracking-wide">
                                Oxygen %
                            </label>
                            <div class="mt-1 flex gap-2">
                                <input type="number"
                                       name="ox"
                                       placeholder="SpO₂"
                                       required
                                       class="w-full border border-slate-200 p-3 rounded-xl text-sm bg-slate-50
                                              focus:bg-white focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200
                                              outline-none transition shadow-sm">
                            </div>
                        </div>
                    </div>

                    <!-- Symptoms -->
                    <div>
                        <label class="text-xs font-bold text-slate-600 uppercase tracking-wide">
                            Symptoms
                        </label>
                        <textarea name="symptoms"
                                  placeholder="Describe main complaint, onset, and any important notes..."
                                  class="mt-1 w-full border border-slate-200 p-3 rounded-xl text-sm h-28 bg-slate-50
                                         focus:bg-white focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200
                                         outline-none transition shadow-sm resize-none"></textarea>
                        <p class="mt-1 text-[11px] text-slate-400">
                            Keep it brief but clinically useful – this text is shown to the doctor in their queue.
                        </p>
                    </div>

                    <!-- Submit -->
                    <div class="pt-2">
                        <button type="submit"
                                class="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-semibold py-3
                                       rounded-xl shadow-lg transition transform active:scale-[0.98]
                                       flex justify-center items-center gap-2 text-sm tracking-wide">
                            <i class="fa-solid fa-paper-plane"></i>
                            <span>Submit to Triage Queue</span>
                        </button>
                    </div>
                </form>
            </section>
        </div>
    </main>

</body>
</html>
