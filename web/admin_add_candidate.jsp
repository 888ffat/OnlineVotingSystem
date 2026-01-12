<%@ page import="java.sql.*, com.mvc.util.DBConnection" %>

<h2>Add Candidate</h2>

<form method="post" action="AddCandidateServlet">
    Election:
    <select name="election" required>
        <%
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM elections WHERE status='active'");
            while(rs.next()){
        %>
            <option value="<%= rs.getInt("election_id") %>">
                <%= rs.getString("title") %>
            </option>
        <% } %>
    </select><br><br>

    Candidate Name:<br>
    <input type="text" name="name" required><br><br>

    Manifesto:<br>
    <textarea name="manifesto"></textarea><br><br>

    Photo (URL / filename):<br>
    <input type="text" name="photo"><br><br>

    <button type="submit">Add Candidate</button>
</form>

<% if(request.getParameter("msg")!=null){ %>
    <p style="color:green;">Candidate added successfully</p>
<% } %>
