package com.mvc.controller;

import com.mvc.dao.CandidateDAO;
import com.mvc.model.Candidate;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
//
public class AddCandidateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        Candidate c = new Candidate();
        c.setElectionId(Integer.parseInt(req.getParameter("election")));
        c.setName(req.getParameter("name"));
        c.setManifesto(req.getParameter("manifesto"));

        CandidateDAO dao = new CandidateDAO();

        if (dao.addCandidate(c)) {
            res.sendRedirect("admin_add_candidate.jsp?msg=success");
        } else {
            res.sendRedirect("admin_add_candidate.jsp?msg=error");
        }
    }
}
