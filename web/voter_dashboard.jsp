<%@ page import="com.mvc.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"voter".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voter Dashboard</title>

<style>
body{
    margin:0;
    font-family:"Segoe UI", Arial;
    background:#eef2f7;
}

/* ===== NAVBAR ==== */
.navbar{
    background:#1f3c88;
    color:white;
    padding:8px 25px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.navbar a{
    background:#4a80ff;
    padding:6px 14px;
    border-radius:6px;
    color:white;
    text-decoration:none;
    font-size:13px;
    text-decoration:none;
}

/* ===== MAIN ===== */
.container{
    max-width:1000px;
    margin:30px auto;
}

/* welcome card */
.welcome-card{
    background:white;
    padding:22px;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
    margin-bottom:25px;
}

.welcome-card h2{
    margin:0;
    color:#1f3c88;
}

.welcome-card p{
    margin-top:6px;
    color:#555;
}

/* success alert */
.alert{
    background:#e8f5e9;
    color:#2e7d32;
    padding:12px 16px;
    border-radius:8px;
    margin-bottom:20px;
    font-size:14px;
    box-shadow:0 2px 6px rgba(0,0,0,0.08);
}

/* dashboard cards */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:20px;
}

.card{
    background:white;
    padding:24px;
    border-radius:14px;
    box-shadow:0 4px 12px rgba(0,0,0,0.12);
    transition:0.3s;
    text-decoration:none;
    color:inherit;
}

.card:hover{
    transform:translateY(-4px);
    box-shadow:0 8px 18px rgba(0,0,0,0.15);
}

.card h3{
    margin:0 0 8px;
    color:#305fbf;
    font-size:20px;
}

.card p{
    color:#555;
    font-size:14px;
    line-height:1.4;
}

/* footer actions */
.actions{
    text-align:center;
    margin-top:35px;
}

.logout-btn{
    background:#777;
    color:white;
    padding:10px 20px;
    border-radius:6px;
    text-decoration:none;
    font-size:14px;
}

/* footer */
.footer{
    text-align:center;
    padding:20px;
    margin-top:40px;
    font-size:13px;
    color:#777;
}
</style>
</head>

<body>

<div class="navbar">
    <h2>Student Election Portal</h2>
    <a href="homepage.jsp">Home</a>
</div>

<div class="container">

<div class="welcome-card">
    <h2>Welcome, <%= user.getFullName() %></h2>
    <p>Manage your voting activity and stay updated on campus elections.</p>
</div>

<% if(request.getParameter("msg")!=null){ %>
<div class="alert">
     Vote submitted successfully!
</div>
<% } %>

<div class="grid">
    <a href="active_elections.jsp" class="card">
        <h3>Active Elections</h3>
        <p>View ongoing elections and cast your vote before deadlines.</p>
    </a>

    <a href="vote_history.jsp" class="card">
        <h3>Voting History</h3>
        <p>Review all elections you have participated in.</p>
    </a>
</div>

<div class="actions">
    <a href="LogoutServlet" class="logout-btn">Logout</a>
</div>

</div>

<div class="footer">
© 2026 Student Election Portal . Enterprise MVC Project
</div>

</body>
</html>
