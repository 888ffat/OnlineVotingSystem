<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mvc.dao.CandidateDAO, java.sql.*, com.mvc.model.User" %>
<%
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
    <title>Manage Candidates | Voting Admin</title>
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
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            margin: 0;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
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

        .sidebar a:hover,
        .sidebar a.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid var(--secondary);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 60px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            margin-bottom: 35px;
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: var(--primary-dark);
            margin: 0;
            font-size: 28px;
        }

        /* Filter Card */
        .filter-card {
            background: var(--white);
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
            margin-bottom: 35px;
            display: flex;
            gap: 20px;
            align-items: flex-end;
        }

        label {
            font-weight: 700;
            font-size: 0.9rem;
            color: var(--text-dark);
            display: block;
            margin-bottom: 8px;
        }

        input[type="number"] {
            padding: 12px;
            width: 220px;
            border-radius: 10px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        .view-btn {
            background-color: var(--primary);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 4px 15px rgba(0, 121, 107, 0.25);
        }

        .view-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .table-container {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #f8fafc;
            color: var(--text-muted);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: 1px;
            padding: 20px 25px;
            border-bottom: 2px solid #edf2f7;
        }

        td {
            padding: 20px 25px;
            border-bottom: 1px solid #edf2f7;
            color: var(--text-dark);
            font-size: 14px;
        }

        tr:hover td {
            background-color: #fcfdfd;
        }

        .manifesto-text {
            color: var(--text-muted);
            line-height: 1.6;
        }
    </style>
</head>

<body>

<div class="sidebar">
    <h3>VOTING ADMIN</h3>
    <a href="admin_dashboard.jsp">Dashboard Overview</a>
    <a href="admin_manage_elections.jsp">Manage Elections</a>
    <a href="admin_create_election.jsp">Create Election</a>
    <a href="admin_add_candidate.jsp">Add Candidate</a>
    <a href="admin_manage_candidates.jsp" class="active">Candidate List</a>
    <a href="LogoutServlet" style="margin-top:auto;color:#fab1a0;">Logout</a>
</div>

<div class="main-content">
    <div class="page-header">
        <h2>Candidate Management</h2>
        <p style="color:var(--text-muted);margin-top:6px;">
            View candidates and their manifestos by election.
        </p>
    </div>

    <form method="get" class="filter-card">
        <div>
            <label>Election ID</label>
            <input type="number" name="eid" placeholder="e.g. 1"
                   value="<%= request.getParameter("eid") != null ? request.getParameter("eid") : "" %>" required>
        </div>
        <button class="view-btn">View Candidates</button>
    </form>

    <%
        if(request.getParameter("eid") != null){
            int eid = Integer.parseInt(request.getParameter("eid"));
            CandidateDAO dao = new CandidateDAO();
            ResultSet rs = dao.getCandidatesByElection(eid);
    %>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th width="30%">Candidate Name</th>
                    <th width="45%">Manifesto</th>
                    <th width="25%">Actions</th>

                </tr>
            </thead>
            <tbody>
                <%
                    boolean hasData = false;
                    while(rs.next()){
                        hasData = true;
                %>
                <tr>
                    <td style="font-weight:700;color:var(--primary-dark);">
                        <%= rs.getString("name") %>
                    </td>
                    <td>
                        <div class="manifesto-text"><%= rs.getString("manifesto") %></div>
                    </td>
                    <td>
                        <a href="edit_candidate.jsp?id=<%= rs.getInt("candidate_id") %>"
                           style="color:var(--primary);font-weight:700;">Edit</a>
                        |
                        <a href="DeleteCandidateServlet?id=<%= rs.getInt("candidate_id") %>"
                           style="color:#c53030;font-weight:700;"
                           onclick="return confirm('Delete this candidate?');">
                           Delete
                        </a>
                    </td>
                </tr>

                <% } if(!hasData){ %>
                <tr>
                    <td colspan="2" style="text-align:center;padding:40px;color:#999;">
                        No candidates found for Election ID: <%= eid %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</div>

</body>
</html>
