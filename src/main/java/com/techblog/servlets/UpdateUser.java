package com.techblog.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.techblog.dao.UserDao;
import com.techblog.dao.UserDaoImpl;
import com.techblog.entities.User;
import com.techblog.entities.UserFullDetail;

@MultipartConfig
@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ; 
        resp.setContentType("text/html");
        
        HttpSession session = req.getSession(false) ;

        String updateParameter = req.getParameter("update-parameter") ;
        String updatedValue = req.getParameter("update-value") ;

        if (updateParameter != null && updatedValue != null && session != null) {

            ApplicationContext user_ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
            UserDao userDao = user_ctx.getBean("UserDao",UserDaoImpl.class) ;

            switch(updateParameter) {

                case "user-name" : {

                    try {
                        User user = (User) session.getAttribute("user") ;
                        if (userDao.updateUserName(user, updatedValue)) {
                            
                            User currentUser = (User) session.getAttribute("user") ; 
                            currentUser.setUser_name(updatedValue);
                            
                            out.print("update success...");
                        }
                        else {
                            out.print("update failed...") ;
                        }
                        
                    } catch (Exception e) {
                        e.printStackTrace() ;
                        out.print("update failed...") ;
                    }

                }
                break;

                case "user-email" : {

                    try {
                        User user = (User) session.getAttribute("user") ;
                        if (userDao.updateUserEmail(user, updatedValue)) {
                            
                            User currentUser = (User) session.getAttribute("user") ; 
                            currentUser.setUser_email(updatedValue);
                            
                            out.print("update success...");
                        }
                        else {
                            out.print("update failed...") ;
                        }
                    } catch (Exception e) {
                        e.printStackTrace() ;
                        out.print("update failed...") ;
                    }

                }
                break;

                case "user-password" : {
                    
                    try {
                        User user = (User) session.getAttribute("user") ;
                        if (userDao.updateUserPassword(user, updatedValue)) {
                            
                            User currentUser = (User) session.getAttribute("user") ;
                            currentUser.setUser_password(updatedValue);
                            
                            out.print("update success...");
                        }
                        else {
                            out.print("update failed...") ;
                        }
                    } catch (Exception e) {
                        e.printStackTrace() ;
                        out.print("update failed...") ;
                    }

                }
                break;

                case "user-full-name" : {
                    
                    try {
                        User user = (User) session.getAttribute("user") ;
                        if (userDao.updateUserFullName(user, updatedValue)) {
                            
                            UserFullDetail userDetails = (UserFullDetail) session.getAttribute("user-details") ;
                            userDetails.setUser_full_name(updatedValue) ;
                            
                            out.print("update success...");
                        }
                        else {
                            out.print("update failed...") ;
                        }
                    } catch (Exception e) {
                        e.printStackTrace() ;
                        out.print("update failed...") ;
                    }

                }
                break;

                case "user-dob" : {
                    
                    try {
                        User user = (User) session.getAttribute("user") ;
                        Date date = new Date(new SimpleDateFormat("yyyy-MM-dd").parse(updatedValue).getTime()) ;
                        if (userDao.updateUserDOB(user, date)) {
                            
                            UserFullDetail userDetails = (UserFullDetail) session.getAttribute("user-details") ;
                            userDetails.setUser_dob(date);
                            
                            out.print("update success...");
                        }
                        else {
                            out.print("update failed...") ;
                        }
                    } catch (Exception e) {
                        e.printStackTrace() ;
                        out.print("update failed...") ;
                    }

                }
                break;

                case "user-about-me" : {
                    
                    try {
                        User user = (User) session.getAttribute("user") ;
                        if (userDao.updateUserAboutMe(user, updatedValue)) {
                            
                            UserFullDetail userDetails = (UserFullDetail) session.getAttribute("user-details") ;
                            userDetails.setUser_about_me(updatedValue);
                            
                            out.print("update success...");
                        }
                        else {
                            out.print("update failed...") ;
                        }
                    } catch (Exception e) {
                        e.printStackTrace() ;
                        out.print("update failed...") ;
                    }

                }
                break;

                case "user-img" : {

                    try {
                        User user = (User) session.getAttribute("user") ;
                        UserFullDetail userDetails  = (UserFullDetail) session.getAttribute("user-details") ; 

                        Part img_part = req.getPart("profile-img") ;
                        String img_filename = ((Integer) user.getUser_id()).toString()+ img_part.getSubmittedFileName() ;

                        if (userDao.updateUserImg(user, img_filename)) {
                            
                            
                            // write image to a local foldor in server
           
                            String new_path = req.getRealPath("/") + "images" + File.separator + img_filename ;
                            String old_path = req.getRealPath("/") + "images" + File.separator + userDetails.getUser_img() ;
                                    
                            deleteExistingImage(old_path) ;

                            saveImage(img_part.getInputStream(), new_path) ;



                            // update the session

                            userDetails.setUser_img(img_filename);

                            out.print("update success...");
                        }
                        else {

                            out.print("update failed...") ;

                        }
                    } catch (Exception e) {

                        e.printStackTrace() ;
                        out.print(e.getMessage()) ;

                    }
                    
                }
                break ;

                default : {
                    out.print("default: update failed...") ;
                    break ; 
                }

            }

            ((AnnotationConfigApplicationContext) user_ctx).close();

        }
        else {

            out.print("update failed...") ;

        }

        out.flush();

    }



    // helper

    public boolean deleteExistingImage(String path) {

        boolean isDeleted = false ;


        try {
            
            File file = new File(path) ;
            if (file.delete()) {
                isDeleted= true ;
            } 

        } catch (Exception e) {
            
            e.printStackTrace() ;

        }


        return isDeleted ; 

    }
    
    
    public boolean saveImage(InputStream stream, String path) {

        boolean isSaved= false ;

        try {
            
            byte data[] = new byte[stream.available()] ;
            stream.read(data) ;
           
            FileOutputStream op = new FileOutputStream(path) ;
           
            op.write(data) ;
           
            op.close() ;
            isSaved= true ; 

        } catch (Exception e) {
            e.printStackTrace();
        }


        return isSaved ;

    }



    // method to set the updated details in session object after update
    public void refreshRequest(HttpServletRequest req, HttpServletResponse resp, int user_id) throws ServletException, IOException {

        try {
            
            ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
            UserDao userDao = ctx.getBean("UserDao",UserDaoImpl.class) ;
            
            User user = userDao.getUserById(user_id) ;
            UserFullDetail userDetails = userDao.getUserFullDetailByUserId(user_id) ; 
            
            HttpSession session = req.getSession() ;

            session.setAttribute("user", user);
            session.setAttribute("user-details", userDetails);

            ((AnnotationConfigApplicationContext) ctx).close();

        } catch (Exception e) {
            
            e.printStackTrace();

        } 

    }
    
    





    public static void main(String[] args) {
        try{
            // Date date = new Date(new SimpleDateFormat("yyyy-MM-dd").parse("2011-12-14").getTime()) ;
            // System.out.println(date);



            // File file = new File("/home/hck364864/L-Java-Servlet-Projects/TechBlog-Project/src/main/java/com/techblog/servlets/uploads/new.txt");
            // if (file.delete()) {
            //     System.out.println("deleted");
            // } 
            // System.out.println(file.toPath());
            
            


        }catch(Exception e) {
            e.printStackTrace();
        }
    }

}
