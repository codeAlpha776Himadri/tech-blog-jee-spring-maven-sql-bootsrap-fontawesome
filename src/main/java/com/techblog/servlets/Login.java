package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.techblog.dao.BlogDao;
import com.techblog.dao.BlogDaoImpl;
import com.techblog.dao.UserDao;
import com.techblog.dao.UserDaoImpl;
import com.techblog.entities.Blog;
import com.techblog.entities.User;
import com.techblog.entities.UserFullDetail;

public class Login extends HttpServlet {
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ;
        resp.setContentType("text/html");

        ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
        UserDao userDao = user_ctx.getBean("UserDao", UserDaoImpl.class);
        BlogDao blogDao = user_ctx.getBean("BlogDao", BlogDaoImpl.class);

        try {
            
            String useremail = req.getParameter("user_email") ;
            String userpass = req.getParameter("user_password") ;

            if (useremail != null && userpass != null) {

                User user = userDao.getUserByEmailAndPassword(useremail, userpass) ;
                UserFullDetail userDetails = null ;
                List<Blog> blogs = null ;
                if (user != null) {
                    userDetails = userDao.getUserFullDetailByUserId(user.getUser_id()) ;
                    blogs = blogDao.getBlogsByUserId(user.getUser_id()) ;
                }

                if (user != null && userDetails != null) {
                    
                    // login success
                    HttpSession session = req.getSession(true) ;
                    int blogCount = blogs == null ? 0 : blogs.size() ;
                    session.setAttribute("user", user); 
                    session.setAttribute("user-details", userDetails);
                    session.setAttribute("blogs-count", (Integer) blogCount);
                    

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

            // User user = userDao.getUserByEmailAndPassword("hck364864@gmail.com", "123456");
            UserFullDetail userFullDetail = userDao.getUserFullDetailByUserId(25) ;
            System.out.println(userFullDetail);

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            ((AnnotationConfigApplicationContext) user_ctx).close();

        }

    }


}
