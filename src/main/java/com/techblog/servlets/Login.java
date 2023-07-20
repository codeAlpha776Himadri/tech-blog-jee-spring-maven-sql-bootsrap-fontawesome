package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.techblog.dao.UserDao;
import com.techblog.dao.UserDaoImpl;
import com.techblog.entities.User;

public class Login extends HttpServlet {
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ;
        resp.setContentType("text/html");

        ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
        UserDao userDao = user_ctx.getBean("UserDao", UserDaoImpl.class);

        try {
            
            String useremail = req.getParameter("user_email") ;
            String userpass = req.getParameter("user_password") ;

            if (useremail != null && userpass != null) {

                User user = userDao.getUserByEmailAndPassword(useremail, userpass) ;

                if (user != null) {
                    
                    // login success
                    HttpSession session = req.getSession(true) ;
                    session.setAttribute("user", user); 
                    out.print("login success...") ; 

                }
                else {

                    out.println("invalid credentials...") ;

                }

            }
            else {

                out.println("Unable to fetch data...");

            }

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            out.println("Server error...") ;

        } finally {

            ((AnnotationConfigApplicationContext) user_ctx).close();
            out.flush();

        }


    }



    // For test db checks

    public static void main(String[] args) {
        
        ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");

        UserDao userDao = user_ctx.getBean("UserDao", UserDaoImpl.class);

        try {

            User user = userDao.getUserByEmailAndPassword("hck364864@gmail.com", "123456");
            System.out.println(user);

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            ((AnnotationConfigApplicationContext) user_ctx).close();

        }

    }


}
