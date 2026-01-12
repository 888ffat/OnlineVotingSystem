<%@ page import="com.mvc.dao.CandidateDAO, java.sql.*" %>

<h2>Manage Candidates</h2>

<form method="get">
    Election ID:
    <input type="number" name="eid" required>
    <button type="submit">View</button>
</form>

<%
    if(request.getParameter("eid") != null){
        int eid = Integer.parseInt(request.getParameter("eid"));
        CandidateDAO dao = new CandidateDAO();
        ResultSet rs = dao.getCandidatesByElection(eid);
%>

<table border="1">
<tr>
    <th>Name</th>
    <th>Manifesto</th>
</tr>

<%
    while(rs.next()){
%>
<tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("manifesto") %></td>
</tr>
<% } %>
</table>

<% } %>

