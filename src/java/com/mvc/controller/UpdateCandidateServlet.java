package com.mvc.controller;

import com.mvc.dao.CandidateDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class UpdateCandidateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String manifesto = req.getParameter("manifesto");

        CandidateDAO dao = new CandidateDAO();
        dao.updateCandidate(id, name, manifesto);

        res.sendRedirect("admin_manage_candidates.jsp");
    }
}
