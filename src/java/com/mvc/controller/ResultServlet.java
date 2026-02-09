package com.mvc.controller;

import com.mvc.dao.ResultDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        try {
            // Get election id from request
            int eid = Integer.parseInt(req.getParameter("eid"));

            // Fetch results using DAO
            ResultDAO dao = new ResultDAO();
            List<Map<String, Object>> results = dao.getResultsByElection(eid);

            // Calculate total votes for progress bars
            int totalVotes = results.stream()
                                    .mapToInt(r -> (Integer) r.get("total"))
                                    .sum();

            // Set attributes for JSP
            req.setAttribute("results", results);
            req.setAttribute("totalVotes", totalVotes);

            // Forward to JSP
            RequestDispatcher rd = req.getRequestDispatcher("results.jsp");
            rd.forward(req, res);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid election ID.");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error while fetching results.");
        }
    }
}
