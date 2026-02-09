<%@ page import="java.sql.*, com.mvc.util.DBConnection" %>
<%
    Object user = session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Election Portal Homepage</title>

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

.login-btn{
    background:#4a80ff;
    padding:6px 14px;
    border-radius:6px;
    color:white;
    text-decoration:none;
    font-size:13px;
}

/* ===== STATS ===== */
.stats{
    max-width:1000px;
    margin:25px auto;
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:15px;
}

.stat-box{
    background:white;
    padding:15px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 3px 8px rgba(0,0,0,0.1);
}

.stat-box h3{
    margin:5px 0;
    color:#305fbf;
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
    margin-bottom:20px;
    color:#1f3c88;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:20px;
}

.card{
    background:white;
    padding:20px;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

.card h3{
    margin:0 0 8px;
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

.vote-btn, .result-btn{
    padding:7px 12px;
    border-radius:5px;
    text-decoration:none;
    font-size:13px;
    margin-right:6px;
}

.vote-btn{ background:#4a80ff; color:white; }
.result-btn{ background:#777; color:white; }

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

<!-- ===== NAVBAR ===== -->
<div class="navbar">
    <h2>Student Election Portal</h2>

    <a href="login.jsp"class="login-btn">Login</a>
</div>


<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();

/* ===== stats queries ===== */
ResultSet s1 = st.executeQuery("SELECT COUNT(*) FROM elections");
s1.next(); int totalElections = s1.getInt(1);

ResultSet s2 = st.executeQuery("SELECT COUNT(*) FROM elections WHERE status='active'");
s2.next(); int activeElections = s2.getInt(1);

ResultSet s3 = st.executeQuery("SELECT COUNT(*) FROM candidates");
s3.next(); int totalCandidates = s3.getInt(1);

ResultSet s4 = st.executeQuery("SELECT COUNT(*) FROM votes");
s4.next(); int totalVotes = s4.getInt(1);
%>

<!-- ===== STATS ROW ===== -->
<div class="stats">
    <div class="stat-box"><h3><%=totalElections%></h3>Total Elections</div>
    <div class="stat-box"><h3><%=activeElections%></h3>Active</div>
    <div class="stat-box"><h3><%=totalCandidates%></h3>Candidates</div>
    <div class="stat-box"><h3><%=totalVotes%></h3>Votes Cast</div>
</div>


<div class="container">

<div class="title">Ongoing Elections</div>

<div class="grid">

<%
ResultSet rs = st.executeQuery(
    "SELECT election_id, title, description FROM elections WHERE status='active'"
);

boolean hasData=false;

while(rs.next()){
    hasData=true;

    int eid = rs.getInt("election_id");

    PreparedStatement ps = con.prepareStatement(
        "SELECT COUNT(*) FROM votes WHERE election_id=?"
    );
    ps.setInt(1,eid);
    ResultSet vr = ps.executeQuery();
    vr.next();
    int voteCount = vr.getInt(1);

    /* leader */
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT c.name, COUNT(v.vote_id) total " +
        "FROM candidates c LEFT JOIN votes v ON c.candidate_id=v.candidate_id " +
        "WHERE c.election_id=? GROUP BY c.candidate_id ORDER BY total DESC LIMIT 1"
    );
    ps2.setInt(1,eid);
    ResultSet lead = ps2.executeQuery();

    String leader="No votes yet";
    int top=0;

    if(lead.next()){
        leader = lead.getString("name");
        top = lead.getInt("total");
    }

    int percent = voteCount==0?0:(top*100/voteCount);
%>

<div class="card">
    <h3><%=rs.getString("title")%></h3>

    <p><%=rs.getString("description")%></p>

    <div class="leader">
        Leading: <%=leader%> (<%=top%> votes)
    </div>

    <!-- progress bar -->
    <div class="bar">
        <div class="fill" style="width:<%=percent%>%"></div>
    </div>

    <small>Total votes: <%=voteCount%></small>

    <div class="actions">
        <a href="login.jsp" class="vote-btn">Vote</a>
        <a href="ResultServlet?eid=<%=eid%>" class="result-btn">Results</a>
    </div>
</div>

<%
    lead.close();
    ps2.close();
    vr.close();
    ps.close();
}

if(!hasData){
%>
<div class="card">No Active Elections</div>
<%
}

rs.close();
st.close();
con.close();
%>

</div>
</div>

<div class="footer">
© 2026 Student Election Portal . Enterprise MVC Project
</div>

</body>
</html>
