<%@ page import="com.mvc.dao.ElectionDAO, java.sql.*" %>

<h2>Manage Elections</h2>

<table border="1">
<tr>
    <th>Title</th>
    <th>Start</th>
    <th>End</th>
    <th>Status</th>
</tr>

<%
    ElectionDAO dao = new ElectionDAO();
    ResultSet rs = dao.getAllElections();
    while(rs.next()){
%>
<tr>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getString("start_date") %></td>
    <td><%= rs.getString("end_date") %></td>
    <td><%= rs.getString("status") %></td>
</tr>
<% } %>
</table>
