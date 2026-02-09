package com.mvc.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import com.mvc.util.DBConnection;
//
public class DeleteElectionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM elections WHERE election_id=?"
            );
            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("admin_manage_elections.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_manage_elections.jsp?msg=error");
        }
    }
}
