package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.techblog.dao.UserDao;
import com.techblog.dao.UserDaoImpl;
import com.techblog.entities.User;

@MultipartConfig
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
        UserDao userDao = user_ctx.getBean("UserDao", UserDaoImpl.class);

        try {

            String username = (String) req.getParameter("user_name");
            String useremail = (String) req.getParameter("user_email");
            String userpass = (String) req.getParameter("user_password");
            String usergender = (String) req.getParameter("user_gender");

            String termscheck = (String) req.getParameter("terms_check");

            if (termscheck != null && termscheck.equals("checked")) {

                User user = new User(username, useremail, userpass, usergender);

                if (userDao.getUserByEmail(useremail) == null) {

                    if (userDao.addUser(user)) {
                        out.println("Registration success, Please login...");
                    } else {
                        out.println("Registration error...");
                    }

                } else {

                    out.println("Email exists, Please login...");

                }

            } else {

                out.println("Please check terms & conditions...");

            }

        } catch (Exception e) {

            e.printStackTrace();
            out.println("Server error...");

        } finally {

            ((AnnotationConfigApplicationContext) user_ctx).close();
            out.flush();

        }

    }
    

    // For testing db conn locally

    public static void main(String[] args) {

        ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");

        UserDao userDao = user_ctx.getBean("UserDao", UserDaoImpl.class);

        try {

            User test_user = new
            User("test_name","test_email_new","test_pass","test_gender") ;

            userDao.addUser(test_user) ;

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            ((AnnotationConfigApplicationContext) user_ctx).close();

        }

    }

}
