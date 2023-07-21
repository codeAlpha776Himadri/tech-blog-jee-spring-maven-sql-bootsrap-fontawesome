package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ;
        resp.setContentType("text/html");

        HttpSession session = req.getSession(false) ;
        session.invalidate();
        
        out.print("successfully logged out...") ;
        
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ;
        resp.setContentType("text/html");

        HttpSession session = req.getSession(false) ;
        session.invalidate();
        
        out.print("successfully logged out...") ;
        
    }

}
