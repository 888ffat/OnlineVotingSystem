<%@ page import="java.sql.*" %>

<h2>Live Election Results</h2>

<table border="1">
<tr>
    <th>Candidate</th>
    <th>Total Votes</th>
</tr>

<%
    ResultSet rs = (ResultSet) request.getAttribute("results");
    while(rs.next()){
%>
<tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getInt("total") %></td>
</tr>
<% } %>
</table>

<br>
<a href="homepage.jsp">Back to Home</a>
