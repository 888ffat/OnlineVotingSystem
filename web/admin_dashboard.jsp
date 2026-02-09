<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mvc.model.User" %>
<%@ page import="com.mvc.dao.ElectionDAO, com.mvc.dao.CandidateDAO, com.mvc.dao.UserDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || !user.getRole().equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }

    ElectionDAO electionDAO = new ElectionDAO();
    CandidateDAO candidateDAO = new CandidateDAO();
    UserDAO userDAO = new UserDAO();

    int totalElections = electionDAO.getTotalElections();
    int activeElections = electionDAO.getActiveElections();
    int totalCandidates = candidateDAO.getTotalCandidates();
    int totalStudents = userDAO.getTotalStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard | Voting System</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">

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

/* ===== SIDEBAR ===== */
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

/* ===== MAIN CONTENT ===== */
.main-content {
    flex: 1;
    padding: 60px;
    max-width: 1200px;
    margin: 0 auto;
}

.page-header {
    margin-bottom: 40px;
}

.page-header h2 {
    margin: 0;
    font-size: 28px;
    color: var(--primary-dark);
}

.page-header p {
    color: var(--text-muted);
    margin-top: 6px;
}

/* ===== STATS GRID ===== */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 25px;
    margin-bottom: 45px;
}

.stat-card {
    background: var(--white);
    padding: 25px;
    border-radius: 18px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.08);
    animation: fadeIn 0.5s ease;
}

.stat-card h4 {
    margin: 0;
    font-size: 12px;
    color: var(--text-muted);
    text-transform: uppercase;
    letter-spacing: 1px;
}

.stat-card .value {
    font-size: 2.2rem;
    font-weight: 800;
    color: var(--primary);
    margin: 12px 0;
}

.stat-card small {
    color: var(--text-muted);
}

/* ===== QUICK ACTIONS ===== */
.actions-card {
    background: var(--white);
    border-radius: 20px;
    padding: 35px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.08);
}

.actions-card h3 {
    margin-top: 0;
    color: var(--primary-dark);
}

.action-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 18px;
    margin-top: 25px;
}

.action-btn {
    text-decoration: none;
    padding: 16px;
    border-radius: 14px;
    border: 2px solid var(--primary);
    color: var(--primary);
    font-weight: 700;
    text-align: center;
    transition: 0.3s;
}

.action-btn:hover {
    background: var(--primary);
    color: white;
    transform: translateY(-2px);
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h3>Voting Admin</h3>
    <a href="admin_dashboard.jsp" class="active">Dashboard Overview</a>
    <a href="admin_manage_elections.jsp">Manage Elections</a>
    <a href="admin_create_election.jsp">Create Election</a>
    <a href="admin_add_candidate.jsp">Add Candidate</a>
    <a href="admin_manage_candidates.jsp">Candidate List</a>
    <a href="LogoutServlet" style="margin-top:auto;color:#fab1a0;">Logout</a>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">

    <div class="page-header">
        <h2>Welcome, <%= user.getFullName() %></h2>
        <p>Administrative control panel for the election system</p>
    </div>

    <!-- ===== STATS ===== -->
    <div class="stats-grid">
        <div class="stat-card">
            <h4>Total Elections</h4>
            <div class="value"><%= totalElections %></div>
            <small>All created elections</small>
        </div>

        <div class="stat-card">
            <h4>Active Elections</h4>
            <div class="value"><%= activeElections %></div>
            <small>Currently running</small>
        </div>

        <div class="stat-card">
            <h4>Total Candidates</h4>
            <div class="value"><%= totalCandidates %></div>
            <small>Registered participants</small>
        </div>

        <div class="stat-card">
            <h4>Registered Students</h4>
            <div class="value"><%= totalStudents %></div>
            <small>Eligible voters</small>
        </div>
    </div>

    <!-- ===== QUICK ACTIONS ===== -->
    <div class="actions-card">
        <h3>Quick Actions</h3>

        <div class="action-grid">
            <a href="admin_create_election.jsp" class="action-btn">Create Election</a>
            <a href="admin_manage_elections.jsp" class="action-btn">Edit Elections</a>
            <a href="admin_add_candidate.jsp" class="action-btn">Add Candidate</a>
            <a href="admin_manage_candidates.jsp" class="action-btn">Manage Candidates</a>
        </div>
    </div>

</div>

</body>
</html>
