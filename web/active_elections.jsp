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
<title>Active Elections</title>

<style>
body{
    margin:0;
    font-family:"Segoe UI", Arial;
    background:#eef2f7;
}

/* ===== NAVBAR ===== */
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

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:20px;
}

/* ===== CARD ===== */
.card{
    background:white;
    padding:20px;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

.card h3{
    margin:0 0 6px;
    color:#305fbf;
}

.leader{
    margin-top:10px;
    font-weight:bold;
    color:#2e7d32;
}

/* progress bar */
.bar{
    margin-top:8px;
    height:8px;
    background:#ddd;
    border-radius:5px;
    overflow:hidden;
}

.fill{
    height:100%;
    background:#4a80ff;
}

/* buttons */
.actions{
    margin-top:15px;
}

.vote-btn, .result-btn, .disabled-btn{
    padding:7px 12px;
    border-radius:5px;
    text-decoration:none;
    font-size:13px;
    margin-right:6px;
    display:inline-block;
}

.vote-btn{ background:#4a80ff; color:white; }
.result-btn{ background:#777; color:white; }
.disabled-btn{
    background:#ccc;
    color:#666;
    cursor:not-allowed;
}

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
<div class="title">Active Elections</div>

<div class="grid">

<%
Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT election_id, title, description FROM elections WHERE status='active'"
);
ResultSet rs = ps.executeQuery();

boolean hasData=false;

while(rs.next()){
    hasData=true;
    int eid = rs.getInt("election_id");

    /* total votes */
    PreparedStatement psVotes = con.prepareStatement(
        "SELECT COUNT(*) FROM votes WHERE election_id=?"
    );
    psVotes.setInt(1,eid);
    ResultSet vr = psVotes.executeQuery();
    vr.next();
    int totalVotes = vr.getInt(1);

    /* leader */
    PreparedStatement psLead = con.prepareStatement(
        "SELECT c.name, COUNT(v.vote_id) total " +
        "FROM candidates c LEFT JOIN votes v ON c.candidate_id=v.candidate_id " +
        "WHERE c.election_id=? GROUP BY c.candidate_id " +
        "ORDER BY total DESC LIMIT 1"
    );
    psLead.setInt(1,eid);
    ResultSet lead = psLead.executeQuery();

    String leader="No votes yet";
    int top=0;
    if(lead.next()){
        leader=lead.getString("name");
        top=lead.getInt("total");
    }

    int percent = totalVotes==0?0:(top*100/totalVotes);

    /* already voted? */
    PreparedStatement psCheck = con.prepareStatement(
        "SELECT COUNT(*) FROM votes WHERE election_id=? AND user_id=?"
    );
    psCheck.setInt(1,eid);
    psCheck.setInt(2,user.getUserId());
    ResultSet cr = psCheck.executeQuery();
    cr.next();
    boolean voted = cr.getInt(1)>0;
%>

<div class="card">
    <h3><%=rs.getString("title")%></h3>
    <p><%=rs.getString("description")%></p>

    <div class="leader">
        Leading: <%=leader%> (<%=top%> votes)
    </div>

    <div class="bar">
        <div class="fill" style="width:<%=percent%>%"></div>
    </div>

    <small>Total votes: <%=totalVotes%></small>

    <div class="actions">
        <% if(voted){ %>
            <span class="disabled-btn">Already Voted</span>
        <% }else{ %>
            <a href="vote.jsp?eid=<%=eid%>" class="vote-btn">Vote</a>
        <% } %>
        <a href="ResultServlet?eid=<%=eid%>" class="result-btn">Results</a>
    </div>
</div>

<%
    cr.close(); psCheck.close();
    lead.close(); psLead.close();
    vr.close(); psVotes.close();
}

if(!hasData){
%>
<div class="card">No active elections at the moment.</div>
<%
}

rs.close();
ps.close();
con.close();
%>

</div>
</div>

<div class="footer">
© 2026 Student Election Portal . Enterprise MVC Project
</div>

</body>
</html>
