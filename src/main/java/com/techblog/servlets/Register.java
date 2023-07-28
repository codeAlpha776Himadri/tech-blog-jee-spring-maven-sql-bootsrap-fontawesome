package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
// import java.sql.Date;
// import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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

@MultipartConfig
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
        UserDao userDao = user_ctx.getBean("UserDao", UserDaoImpl.class);
        BlogDao blogDao = user_ctx.getBean("BlogDao", BlogDaoImpl.class);

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

                        HttpSession session = req.getSession(true) ;
                        
                        User currentStoredUser = userDao.getUserByEmail(useremail) ;
                        UserFullDetail userDetails = userDao.getUserFullDetailByUserId(currentStoredUser.getUser_id()) ;
                        
                        List<Blog> blogs = blogDao.getBlogsByUserId(user.getUser_id()) ;
                        Integer blogsCount = blogs == null ? 0 : blogs.size() ;

                        session.setAttribute("user", currentStoredUser);
                        session.setAttribute("user-details", userDetails);
                        session.setAttribute("blogs-count", blogsCount);
                        
                        out.print("Registration success, Please login...");

                    } else {
                        out.print("Registration error...");
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

            // User test_user = new
            // User("Rupali","rupa@gmail.com","rupa","female") ;

            // userDao.addUser(test_user) ;

            // userDao.updateUserName(test_user, "new-username") ;

            // System.out.println(userDao.getUserFullDetailByUserId(25)); 

            // User user = userDao.getUserByEmail("rupa@gmail.com") ;
            // userDao.updateUserDOB(user, new Date(new SimpleDateFormat("dd-MM-yyyy").parse("12-01-1982").getTime())) ;

            // System.out.println(userDao.getUserFullDetailByUserId(user.getUser_id()).getUser_dob()) ;

            User user = userDao.getUserById(1) ; 
            System.out.println(user);

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            ((AnnotationConfigApplicationContext) user_ctx).close();

        }

    }

}
