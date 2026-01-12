package com.mvc.controller;

import com.mvc.dao.VoteDAO;
import com.mvc.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class VoteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        int electionId = Integer.parseInt(req.getParameter("eid"));
        int candidateId = Integer.parseInt(req.getParameter("cid"));

        VoteDAO dao = new VoteDAO();

        if (dao.hasVoted(user.getUserId(), electionId)) {
            res.sendRedirect("voter_dashboard.jsp?msg=already_voted");
        } else {
            dao.vote(user.getUserId(), electionId, candidateId);
            res.sendRedirect("voter_dashboard.jsp?msg=success");
        }
    }
}
