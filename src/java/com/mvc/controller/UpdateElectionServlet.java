package com.mvc.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import com.mvc.util.DBConnection;

public class UpdateElectionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE elections SET title=?, description=?, start_date=?, end_date=?, status=? WHERE election_id=?"
            );

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, start);
            ps.setString(4, end);
            ps.setString(5, status);
            ps.setInt(6, id);

            ps.executeUpdate();
            response.sendRedirect("admin_manage_elections.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_manage_elections.jsp?msg=error");
        }
    }
}
