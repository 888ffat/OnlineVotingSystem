<h2>Create New Election</h2>

<form method="post" action="CreateElectionServlet">
    Title:<br>
    <input type="text" name="title" required><br><br>

    Description:<br>
    <textarea name="description"></textarea><br><br>

    Start Date:<br>
    <input type="datetime-local" name="start" required><br><br>

    End Date:<br>
    <input type="datetime-local" name="end" required><br><br>

    <button type="submit">Create Election</button>
</form>

<% if(request.getParameter("msg")!=null){ %>
    <p style="color:red;">Error creating election</p>
<% } %>

