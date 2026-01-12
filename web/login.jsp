<form method="post" action="LoginServlet">
    Matric No: <input type="text" name="matric" required><br>
    Password: <input type="password" name="password" required><br>
    <button type="submit">Login</button>

    <% if(request.getParameter("error") != null){ %>
        <p style="color:red">Invalid login</p>
    <% } %>
</form>
