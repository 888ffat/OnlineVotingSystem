package com.mvc.controller;

import com.mvc.dao.CandidateDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
//
public class DeleteCandidateServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        CandidateDAO dao = new CandidateDAO();
        dao.deleteCandidate(id);

        res.sendRedirect("admin_manage_candidates.jsp");
    }
}
