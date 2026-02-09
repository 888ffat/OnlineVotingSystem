<%@ page import="java.sql.*, com.mvc.util.DBConnection, com.mvc.model.User" %>
<%
User user = (User) session.getAttribute("user");
if(user==null || !"voter".equals(user.getRole())){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vote History</title>

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
}

/* ===== MAIN ===== */
.container{
    max-width:1000px;
    margin:30px auto;
}

.title{
    text-align:center;
    font-size:24px;
    font-weight:bold;
    margin-bottom:25px;
    color:#1f3c88;
}

/* ===== CARD LIST ===== */
.history-card{
    background:white;
    padding:20px 22px;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
    margin-bottom:18px;
}

.history-card h3{
    margin:0 0 6px;
    color:#305fbf;
    font-size:18px;
}

.history-meta{
    font-size:14px;
    color:#555;
    margin-top:8px;
}

.badge{
    display:inline-block;
    padding:4px 10px;
    background:#4a80ff;
    color:white;
    border-radius:12px;
    font-size:12px;
    margin-top:8px;
}

/* empty */
.empty{
    background:white;
    padding:25px;
    border-radius:12px;
    text-align:center;
    color:#777;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
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
    <a href="voter_dashboard.jsp">Dashboard</a>
</div>

<div class="container">

<div class="title">Your Voting History</div>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean hasData=false;

try{
    con = DBConnection.getConnection();
    ps = con.prepareStatement(
        "SELECT e.title AS election_title, c.name AS candidate_name, v.vote_time " +
        "FROM votes v " +
        "JOIN candidates c ON v.candidate_id = c.candidate_id " +
        "JOIN elections e ON c.election_id = e.election_id " +
        "WHERE v.user_id=? ORDER BY v.vote_time DESC"
    );
    ps.setInt(1, user.getUserId());
    rs = ps.executeQuery();

    while(rs.next()){
        hasData=true;
%>

<div class="history-card">
    <h3><%=rs.getString("election_title")%></h3>

    <div class="badge">
        Voted for: <%=rs.getString("candidate_name")%>
    </div>

    <div class="history-meta">
        <%=rs.getTimestamp("vote_time")%>
    </div>
</div>

<%
    }

    if(!hasData){
%>
<div class="empty">
    You have not participated in any elections yet.
</div>
<%
    }

}catch(Exception e){
%>
<div class="empty" style="color:red;">
    <%=e.getMessage()%>
</div>
<%
}finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

</div>

<div class="footer">
© 2026 Student Election Portal . Enterprise MVC Project
</div>

</body>
</html>
