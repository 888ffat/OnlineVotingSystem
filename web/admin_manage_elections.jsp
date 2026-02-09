<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mvc.dao.ElectionDAO, java.sql.*, com.mvc.model.User" %>
<%
    //Security Check
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
    <title>Manage Elections | Voting Admin</title>
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
            --success: #27ae60;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            margin: 0;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation - Template Sync */
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
            padding: 60px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 { color: var(--primary-dark); margin: 0; font-size: 28px; }

        .add-btn {
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.9rem;
            transition: 0.3s;
            box-shadow: 0 4px 15px rgba(0, 121, 107, 0.2);
        }

        .add-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        /* Table Container Styling */
        .table-container {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
            overflow: hidden;
            animation: fadeIn 0.7s ease-in;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
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
            padding: 18px 25px;
            border-bottom: 1px solid #edf2f7;
            color: var(--text-dark);
            font-size: 14px;
        }

        tr:hover td { background-color: #fcfdfd; }

        /* Status Badges - Modernized */
        .badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            display: inline-block;
        }

        .status-active, .status-open { background: #e6fffa; color: #00796b; border: 1px solid #b2f5ea; }
        .status-closed { background: #fff5f5; color: #c53030; border: 1px solid #feb2b2; }
        .status-pending { background: #fffaf0; color: #9c4221; border: 1px solid #fbd38d; }

        .action-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            transition: 0.2s;
        }

        .action-link:hover { color: var(--primary-dark); text-decoration: underline; }

    </style>
</head>
<body>

    <div class="sidebar">
        <h3>VOTING ADMIN</h3>
        <a href="admin_dashboard.jsp">Dashboard Overview</a>
        <a href="admin_manage_elections.jsp" class="active">Manage Elections</a>
        <a href="admin_create_election.jsp">Create Election</a>
        <a href="admin_add_candidate.jsp">Add Candidate</a>
        <a href="admin_manage_candidates.jsp">Candidate List</a>
        <a href="LogoutServlet" style="margin-top: auto; color: #fab1a0;">Logout</a>
    </div>

    <div class="main-content">
        <div class="page-header">
            <div>
                <h2>Election Management</h2>
                <p style="color: var(--text-muted); margin-top: 5px;">Monitor, edit, and track all student voting events.</p>
            </div>
            <a href="admin_create_election.jsp" class="add-btn">+ Create New Election</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Election Title</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            ElectionDAO dao = new ElectionDAO();
                            ResultSet rs = dao.getAllElections();
                            while(rs.next()){
                                String status = rs.getString("status").toLowerCase();
                                String badgeClass = "status-" + status;
                    %>
                    <tr>
                        <td style="font-weight: 700; color: var(--primary-dark);"><%= rs.getString("title") %></td>
                        <td><%= rs.getString("start_date") %></td>
                        <td><%= rs.getString("end_date") %></td>
                        <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
                        <td>
                            <a href="edit_election.jsp?id=<%= rs.getInt("election_id") %>" class="action-link">
                                Edit
                            </a>
                             |
                            <a href="DeleteElectionServlet?id=<%= rs.getInt("election_id") %>"
                               class="action-link"
                               onclick="return confirm('Are you sure you want to delete this election?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>