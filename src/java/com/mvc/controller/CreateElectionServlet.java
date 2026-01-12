package com.mvc.controller;

import com.mvc.dao.ElectionDAO;
import com.mvc.model.Election;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class CreateElectionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        Election e = new Election();
        e.setTitle(req.getParameter("title"));
        e.setDescription(req.getParameter("description"));
        e.setStartDate(req.getParameter("start"));
        e.setEndDate(req.getParameter("end"));
        e.setStatus("active");

        ElectionDAO dao = new ElectionDAO();

        if (dao.createElection(e)) {
            res.sendRedirect("admin_manage_elections.jsp?msg=success");
        } else {
            res.sendRedirect("admin_create_election.jsp?msg=error");
        }
    }
}
