<%@ page import="com.mvc.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || !user.getRole().equals("voter")){
        response.sendRedirect("login.jsp");
    }
%>

<h2>Welcome, <%= user.getFullName() %></h2>

<ul>
    <li><a href="active_elections.jsp">Vote in Elections</a></li>
    <li><a href="homepage.jsp">View Results</a></li>
    <li><a href="LogoutServlet">Logout</a></li>
</ul>

<% if(request.getParameter("msg") != null){ %>
    <p style="color:green;">Vote submitted successfully!</p>
<% } %>
