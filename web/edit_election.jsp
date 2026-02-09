<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.mvc.util.DBConnection, com.mvc.model.User" %>
<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if(user == null || !user.getRole().equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM elections WHERE election_id=?"
    );
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Election | Voting Admin</title>

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

/* ===== SIDEBAR ===== */
.sidebar {
    width: 260px;
    background: var(--primary-dark);
    color: white;
    padding: 30px 0;
    display: flex;
    flex-direction: column;
    height: 100vh;
}

.sidebar h3 {
    text-align: center;
    font-size: 1.2rem;
    margin-bottom: 40px;
    color: var(--secondary);
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
select,
textarea {
    width: 100%;
    padding: 12px;
    border: 2px solid #edf2f7;
    border-radius: 10px;
    font-size: 15px;
    background: #f8fafc;
    transition: 0.3s;
}

input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: var(--primary);
    background: white;
    box-shadow: 0 0 0 4px rgba(0,121,107,0.1);
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
}

.submit-btn:hover {
    background: var(--primary-dark);
    transform: translateY(-2px);
}
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
    <a href="LogoutServlet" style="margin-top:auto;color:#fab1a0;">Logout</a>
</div>

<div class="main-content">
    <div class="form-card">
        <h2>Edit Election</h2>
        <p class="subtitle">Update election details and status.</p>

        <form method="post" action="UpdateElectionServlet">
            <input type="hidden" name="id" value="<%= id %>">

            <div class="form-group">
                <label>Election Title</label>
                <input type="text" name="title"
                       value="<%= rs.getString("title") %>" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description"><%= rs.getString("description") %></textarea>
            </div>

            <div class="form-group">
                <label>Start Date & Time</label>
                <input type="datetime-local" name="start"
                       value="<%= rs.getString("start_date").replace(" ", "T") %>" required>
            </div>

            <div class="form-group">
                <label>End Date & Time</label>
                <input type="datetime-local" name="end"
                       value="<%= rs.getString("end_date").replace(" ", "T") %>" required>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="status">
                    <option value="Active" <%= rs.getString("status").equalsIgnoreCase("Active")?"selected":"" %>>Active</option>
                    <option value="Closed" <%= rs.getString("status").equalsIgnoreCase("Closed")?"selected":"" %>>Closed</option>
                </select>
            </div>

            <button type="submit" class="submit-btn">Update Election</button>
        </form>
    </div>
</div>

</body>
</html>
