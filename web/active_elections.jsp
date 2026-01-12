<%@ page import="java.sql.*, com.mvc.util.DBConnection" %>

<h2>Active Elections</h2>

<table border="1">
<tr><th>Election</th><th>Action</th></tr>

<%
    Connection con = DBConnection.getConnection();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM elections WHERE status='active'");

    while(rs.next()){
%>
<tr>
    <td><%= rs.getString("title") %></td>
    <td>
        <a href="vote.jsp?eid=<%= rs.getInt("election_id") %>">Vote Now</a>
    </td>
</tr>
<% } %>
</table>
