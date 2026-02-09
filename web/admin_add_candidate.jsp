<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.mvc.util.DBConnection, com.mvc.model.User" %>
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
<title>Add Candidate | Voting Admin</title>

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

.main-content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px;
}

/* Card */
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

/* Form */
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

input[type="text"], select, textarea {
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

/* Button */
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

/* Success Message */
.success-msg {
    background: #e6fffa;
    color: var(--success);
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 20px;
    border-left: 5px solid var(--success);
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
    <a href="admin_create_election.jsp">Create Election</a>
    <a href="admin_add_candidate.jsp" class="active">Add Candidate</a>
    <a href="admin_manage_candidates.jsp">Candidate List</a>
    <a href="LogoutServlet" style="margin-top:auto;color:#fab1a0;">Logout</a>
</div>

<div class="main-content">
    <div class="form-card">

        <h2>Add New Candidate</h2>
        <p class="subtitle">Assign a student to an active election and add their manifesto.</p>

        <% if(request.getParameter("msg") != null){ %>
            <div class="success-msg">✅ Candidate added successfully!</div>
        <% } %>

        <form method="post" action="AddCandidateServlet">

            <div class="form-group">
                <label>Select Active Election</label>
                <select name="election" required>
                    <option disabled selected>-- Choose Election --</option>
                    <%
                        try {
                            Connection con = DBConnection.getConnection();
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery(
                                "SELECT * FROM elections WHERE status='active' OR status='Open'"
                            );
                            while(rs.next()){
                    %>
                        <option value="<%= rs.getInt("election_id") %>">
                            <%= rs.getString("title") %>
                        </option>
                    <% }} catch(Exception e){ e.printStackTrace(); } %>
                </select>
            </div>

            <div class="form-group">
                <label>Candidate Full Name</label>
                <input type="text" name="name" required>
            </div>

            <div class="form-group">
                <label>Manifesto</label>
                <textarea name="manifesto"></textarea>
            </div>

            <button class="submit-btn">Register Candidate</button>
        </form>

    </div>
</div>

</body>
</html>
