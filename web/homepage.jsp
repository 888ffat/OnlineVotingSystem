<%@ page import="java.sql.*, com.mvc.util.DBConnection" %>

<h2>Ongoing Student Elections</h2>

<table border="1">
<tr>
    <th>Election</th>
    <th>Vote</th>
    <th>Results</th>
</tr>

<%
    Connection con = DBConnection.getConnection();
    String sql = "SELECT * FROM elections WHERE status='active' AND NOW() BETWEEN start_date AND end_date";
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(sql);

    while(rs.next()){
%>
<tr>
    <td><%= rs.getString("title") %></td>
    <td>
        <a href="login.jsp">Vote</a>
    </td>
    <td>
        <a href="ResultServlet?eid=<%= rs.getInt("election_id") %>">View Results</a>
    </td>
</tr>
<% } %>
</table>
