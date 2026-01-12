<%@ page import="com.mvc.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || !user.getRole().equals("admin")){
        response.sendRedirect("login.jsp");
    }
%>

<h2>Welcome Admin, <%= user.getFullName() %></h2>

<ul>
    <li><a href="admin_create_election.jsp">Create Election</a></li>
    <li><a href="admin_manage_elections.jsp">Manage Elections</a></li>
    <li><a href="admin_add_candidate.jsp">Add Candidates</a></li>
    <li><a href="admin_manage_candidates.jsp">Manage Candidates</a></li>
    <li><a href="homepage.jsp">View Live Results</a></li>
    <li><a href="LogoutServlet">Logout</a></li>
</ul>
