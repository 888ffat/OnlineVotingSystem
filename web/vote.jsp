<%@ page import="java.sql.*, com.mvc.util.DBConnection" %>
<%
    int eid = Integer.parseInt(request.getParameter("eid"));
%>

<h2>Select Your Candidate</h2>

<form method="post" action="VoteServlet">
<input type="hidden" name="eid" value="<%=eid%>">

<%
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM candidates WHERE election_id=?");
    ps.setInt(1, eid);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
    <input type="radio" name="cid" value="<%= rs.getInt("candidate_id") %>" required>
    <%= rs.getString("name") %> <br>
<% } %>

<br>
<button type="submit">Submit Vote</button>
</form>
