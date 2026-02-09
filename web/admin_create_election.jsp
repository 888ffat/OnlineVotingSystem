<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mvc.model.User" %>
<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if(user == null || !user.getRole().equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Election | Online Student Election System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #00796b;
            --primary-dark: #004d40;
            --secondary: #26a69a;
            --bg-gradient: linear-gradient(135deg, #e8f5f2 0%, #f4f7f6 100%);
            --white: #ffffff;
            --text-dark: #2d3436;
            --text-muted: #636e72;
            --error: #d63031;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            margin: 0;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation - Synchronized with Add Candidate Page */
        .sidebar {
            width: 260px;
            background: var(--primary-dark);
            color: white;
            padding: 30px 0;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            height: 100vh;
        }

        .sidebar h3 {
            text-align: center;
            font-size: 1.2rem;
            margin-bottom: 40px;
            color: var(--secondary);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .sidebar a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            padding: 15px 30px;
            display: block;
            transition: 0.3s;
            border-left: 4px solid transparent;
        }

        .sidebar a:hover, .sidebar a.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid var(--secondary);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .form-card {
            background: var(--white);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 550px;
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: var(--primary-dark);
            margin: 0 0 10px 0;
            font-size: 26px;
        }

        .subtitle {
            color: var(--text-muted);
            margin-bottom: 30px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 14px;
        }

        input[type="text"],
        input[type="datetime-local"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #edf2f7;
            border-radius: 10px;
            box-sizing: border-box;
            font-size: 15px;
            background: #f8fafc;
            transition: 0.3s;
            font-family: inherit;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            background: white;
            box-shadow: 0 0 0 4px rgba(0, 121, 107, 0.1);
        }

        textarea {
            height: 100px;
            resize: none;
        }

        .submit-btn {
            width: 100%;
            background: var(--primary);
            color: white;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        /* Error Message Display */
        .error-msg {
            background-color: #fff5f5;
            color: var(--error);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 5px solid var(--error);
            font-size: 14px;
            font-weight: bold;
        }

        .footer-link {
            text-align: center;
            margin-top: 20px;
        }

        .footer-link a {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
        }

        .footer-link a:hover {
            color: var(--primary);
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3>VOTING ADMIN</h3>
        <a href="admin_dashboard.jsp">Dashboard Overview</a>
        <a href="admin_manage_elections.jsp">Manage Elections</a>
        <a href="admin_create_election.jsp" class="active">Create Election</a>
        <a href="admin_add_candidate.jsp">Add Candidate</a>
        <a href="admin_manage_candidates.jsp">Candidate List</a>
        <a href="LogoutServlet" style="margin-top: auto; color: #fab1a0;">Logout</a>
    </div>

    <div class="main-content">
        <div class="form-card">
            <h2>Create New Election</h2>
            <p class="subtitle">Set up a new voting event by defining the timeframe and title.</p>

            <%-- Error Message Display --%>
            <% if(request.getParameter("msg") != null) { %>
                <div class="error-msg">
                    ❌ Error: Something went wrong while creating the election.
                </div>
            <% } %>

            <form method="post" action="CreateElectionServlet">
                <div class="form-group">
                    <label for="title">Election Title</label>
                    <input type="text" id="title" name="title" placeholder="e.g., Campus Council 2026" required>
                </div>

                <div class="form-group">
                    <label for="description">Description (Optional)</label>
                    <textarea id="description" name="description" placeholder="Describe the purpose of this election..."></textarea>
                </div>

                <div class="form-group">
                    <label for="start">Start Date & Time</label>
                    <input type="datetime-local" id="start" name="start" required>
                </div>

                <div class="form-group">
                    <label for="end">End Date & Time</label>
                    <input type="datetime-local" id="end" name="end" required>
                </div>

                <button type="submit" class="submit-btn">Launch Election</button>
            </form>

        </div>
    </div>

</body>
</html>