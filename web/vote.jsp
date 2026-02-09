<%@ page import="java.sql.*, com.mvc.util.DBConnection" %>
<%
    int eid = Integer.parseInt(request.getParameter("eid"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Cast Your Vote</title>

<style>
body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    background:#eef2f7;
}

/* ===== NAVBAR === */
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

/* ===== PAGE ===== */
.container{
    max-width:900px;
    margin:40px auto;
}

.title{
    text-align:center;
    font-size:26px;
    font-weight:bold;
    color:#1f3c88;
}

.subtitle{
    text-align:center;
    color:#555;
    margin:8px 0 30px;
}

/* ===== VOTE CARD ===== */
.vote-card{
    background:white;
    padding:35px 40px;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(0,0,0,0.12);
    max-width:520px;
    margin:auto;
}

/* instruction */
.vote-hint{
    text-align:center;
    color:#666;
    margin-bottom:25px;
}

/* ===== CANDIDATE OPTIONS ===== */
.option{
    border:2px solid #e1e5ee;
    border-radius:12px;
    padding:16px 18px;
    margin-bottom:14px;
    cursor:pointer;
    display:flex;
    align-items:center;
    gap:14px;
    transition:0.25s;
}

.option:hover{
    border-color:#4a80ff;
    background:#f6f9ff;
}

.option input{
    transform:scale(1.3);
}

.option.selected{
    border-color:#305fbf;
    background:#eef3ff;
}

.option .name{
    font-size:17px;
    font-weight:600;
    color:#1f3c88;
}

/* ===== ACTIONS ===== */
.actions{
    margin-top:15px;
}

.submit-btn, .cancel-btn{
    padding:7px 12px;
    border-radius:5px;
    text-decoration:none;
    font-size:13px;
    margin-right:6px;
    display:inline-block;
}

.submit-btn{ background:#4a80ff; color:white; }
.cancel-btn{ background:#777; color:white; }

/* ===== FOOTER NOTE ===== */
.vote-note{
    margin-top:20px;
    text-align:center;
    font-size:13px;
    color:#777;
}
</style>

<script>
function selectCard(card){
    document.querySelectorAll('.option')
        .forEach(o=>o.classList.remove('selected'));
    card.classList.add('selected');
    card.querySelector('input').checked = true;
}

function confirmVote(){
    return confirm(
        "Your vote is final and cannot be changed.\n\nConfirm submission?"
    );
}
</script>

</head>
<body>

<div class="navbar">
    <h2>Student Election Portal</h2>
    <a href="voter_dashboard.jsp">Dashboard</a>
</div>

<div class="container">

<%
Connection con = DBConnection.getConnection();

/* Election details */
PreparedStatement pe = con.prepareStatement(
    "SELECT title, description FROM elections WHERE election_id=?"
);
pe.setInt(1, eid);
ResultSet er = pe.executeQuery();
er.next();
%>

<div class="title"><%=er.getString("title")%></div>
<div class="subtitle"><%=er.getString("description")%></div>

<div class="vote-card">

<p class="vote-hint">
    Please select <b>ONE</b> candidate and submit your vote.
</p>

<form method="post" action="VoteServlet" onsubmit="return confirmVote();">
<input type="hidden" name="eid" value="<%=eid%>">

<%
PreparedStatement ps = con.prepareStatement(
    "SELECT candidate_id, name FROM candidates WHERE election_id=?"
);
ps.setInt(1, eid);
ResultSet rs = ps.executeQuery();

boolean hasCandidate=false;
while(rs.next()){
    hasCandidate=true;
%>
<div class="option" onclick="selectCard(this)">
    <input type="radio" name="cid"
           value="<%=rs.getInt("candidate_id")%>" required>
    <div class="name"><%=rs.getString("name")%></div>
</div>
<%
}
if(!hasCandidate){
%>
<p style="color:red; text-align:center;">No candidates available.</p>
<%
}
%>

<div class="actions">
    <button class="submit-btn" type="submit">Submit Vote</button>
    <a href="active_elections.jsp" class="cancel-btn">Cancel</a>
</div>

<div class="vote-note">
    Your vote is anonymous, secure, and final.
</div>

</form>

</div>
</div>

<%
rs.close(); ps.close();
er.close(); pe.close();
con.close();
%>

</body>
</html>
