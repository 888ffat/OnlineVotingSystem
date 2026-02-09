<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Election Results</title>

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
    font-size:26px;
    font-weight:bold;
    margin-bottom:6px;
    color:#1f3c88;
}

.subtitle{
    text-align:center;
    color:#777;
    margin-bottom:25px;
}

/* ===== RESULT CARD ===== */
.card{
    background:white;
    padding:22px;
    border-radius:14px;
    box-shadow:0 4px 12px rgba(0,0,0,0.12);
    margin-bottom:18px;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-2px);
    box-shadow:0 6px 16px rgba(0,0,0,0.15);
}

.name{
    font-size:18px;
    font-weight:bold;
    color:#305fbf;
}

.leader{
    color:#2e7d32;
}

.badge{
    display:inline-block;
    background:#2e7d32;
    color:white;
    font-size:12px;
    padding:3px 8px;
    border-radius:12px;
    margin-left:8px;
}

.votes{
    margin-top:6px;
    font-size:14px;
    color:#555;
}

/* progress bar */
.bar{
    margin-top:10px;
    height:10px;
    background:#ddd;
    border-radius:6px;
    overflow:hidden;
}

.fill{
    height:100%;
    background:#4a80ff;
    width:0;
    transition:width 0.8s ease;
}

/* ===== ACTIONS ===== */
.actions{
    text-align:center;
    margin-top:30px;
}

.back-btn{
    background:#777;
    color:white;
    padding:9px 18px;
    border-radius:6px;
    text-decoration:none;
    font-size:14px;
}

/* ===== FOOTER ===== */
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
</div>

<div class="container">
<div class="title">Live Election Results</div>
<div class="subtitle">Current vote distribution</div>

<%
List<Map<String,Object>> results =
    (List<Map<String,Object>>) request.getAttribute("results");

int totalVotes =
    (results!=null && !results.isEmpty())
        ? (Integer) request.getAttribute("totalVotes")
        : 0;

int maxVotes=0;
if(results!=null){
    for(Map<String,Object> r:results){
        int v=(Integer)r.get("total");
        if(v>maxVotes) maxVotes=v;
    }
}

if(results!=null && !results.isEmpty()){
    for(Map<String,Object> r:results){
        String name=(String)r.get("name");
        int votes=(Integer)r.get("total");
        int percent = totalVotes==0?0:(votes*100/totalVotes);
        boolean isLeader = votes==maxVotes && maxVotes>0;
%>

<div class="card">
    <div class="name <%=isLeader?"leader":""%>">
        <%=name%>
        <% if(isLeader){ %><span class="badge">Leading</span><% } %>
    </div>

    <div class="votes">
        <%=votes%> votes - <%=percent%>%
    </div>

    <div class="bar">
        <div class="fill" style="width:<%=percent%>%"></div>
    </div>
</div>

<%
    }
}else{
%>
<div class="card">No votes recorded yet.</div>
<%
}
%>

<div class="actions">
    <a href="javascript:history.back()" class="back-btn">Back</a>
</div>


</div>

<div class="footer">
© 2026 Online Student Election System . Enterprise MVC Project
</div>

<script>
document.querySelectorAll('.fill').forEach(bar=>{
    const w = bar.style.width;
    bar.style.width='0';
    setTimeout(()=>bar.style.width=w,100);
});
</script>

</body>
</html>
