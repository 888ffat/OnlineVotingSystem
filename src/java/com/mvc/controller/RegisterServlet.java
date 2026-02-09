package com.mvc.controller;

import com.mvc.dao.UserDAO;
import com.mvc.model.User;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
//
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        User user = new User();
        user.setFullName(req.getParameter("fullname"));
        user.setMatricNo(req.getParameter("matric"));
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        user.setRole("voter");

        UserDAO dao = new UserDAO();
        if (dao.register(user)) {
            res.sendRedirect("login.jsp?register=success");
        } else {
            res.sendRedirect("register.jsp?error=1");
        }
    }
}
