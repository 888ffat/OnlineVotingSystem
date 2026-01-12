package com.mvc.controller;

import com.mvc.dao.ResultDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        int eid = Integer.parseInt(req.getParameter("eid"));

        ResultDAO dao = new ResultDAO();
        req.setAttribute("results", dao.getResultsByElection(eid));

        RequestDispatcher rd = req.getRequestDispatcher("results.jsp");
        rd.forward(req, res);
    }
}
