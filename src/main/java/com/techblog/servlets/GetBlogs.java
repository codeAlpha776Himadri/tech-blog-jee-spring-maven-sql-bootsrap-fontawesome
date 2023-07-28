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
import com.techblog.entities.Blog;
import com.techblog.entities.User;

public class GetBlogs extends HttpServlet {
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ; 
        resp.setContentType("text/html");

        String getType = req.getParameter("get-type") ;
        if (getType == null) {
            out.print("get-type not found...");
            return ; 
        }


        try {

            ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ; 
            BlogDao blogDao = ctx.getBean("BlogDao", BlogDaoImpl.class) ;
            
            switch(getType) {
            
                case "all" : {

                    List<Blog> blogs = blogDao.getAllBlogs() ;
                    req.setAttribute("blogs", blogs);
                    out.print("[all] : all blogs successfully set in req attribute...") ;

                }
                break ; 


                case "by-blog-id" : {

                    int blogId = Integer.parseInt(req.getParameter("blog-id")) ;
                    if (((Integer)blogId).equals(null)) {
                        out.print("blog id not found...") ;
                    }
                    else {
                        Blog blog = blogDao.getBlogByBlogId(blogId) ;
                        req.setAttribute("blog", blog);
                        out.print("[by blog id] : blog successfully set in req attribute...");
                    }

                }
                break ; 


                case "by-user-id" : {


                    Integer userId1 = Integer.parseInt(req.getParameter("user-id")) ;
                    HttpSession session = req.getSession(false)  ;
                    User user = session != null ? (User) session.getAttribute("user") : null ;
                    Integer userId2 = user != null ? user.getUser_id() : null ;
                    if (userId1 != null || userId2 != null) {
                        List<Blog> blogs = blogDao.getBlogsByUserId(userId1 != null ? userId1 : userId2) ;
                        req.setAttribute("blogs", blogs);
                        out.print("[by user id] : all blogs successfully set in req attribute...");
                    }
                    if (userId1 == null && userId2 == null) {
                        out.print("no user found...");
                    }
                    

                }
                break ; 


                case "by-tag" : {

                    String blogTag = req.getParameter("blog-tag") ; 
                    if (blogTag == null || blogTag.equals("")) {
                        out.print("blog tag not found...") ;
                    } 
                    else {
                        List<Blog> blogs = blogDao.getBlogsByTag(blogTag) ;
                        req.setAttribute("blogs", blogs);
                        out.print("[by tag] : all blogs successfully set in req attribute...");
                    }

                }
                break ; 


                default : {
                    out.print("invalid get-type...");
                }
                break ; 

            }

            ((AnnotationConfigApplicationContext) ctx).close();

        } catch (Exception e) {
            
            e.printStackTrace() ;
            out.print(e.getMessage()) ;

        }

        out.flush();
        

    }




    // For local db conn check

    public static void main(String[] args) {
        
        ApplicationContext blog_ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
        BlogDao blogDao = blog_ctx.getBean("BlogDao", BlogDaoImpl.class) ;

        try {
            
            /* insert */  

             
            // Blog blog = new Blog(9,"Java Servlets","Programming","Servlets are fundamental block to build jee apps...") ;
            // if (blogDao.addBlog(blog)) {
            //     System.out.println("Successfully inseted blog...");
            // }
            // else {
            //     System.out.println("Error inserting blog!!!");
            // }
            



            /* get blogs by tag */

            
            // List<Blog> blogs = blogDao.getBlogsByTag("Programming") ; 
            // if (blogs == null || blogs.size() == 0) {
            //     System.out.println("No blogs found...");
            // }else {
            //     for (Blog blog : blogs) {
            //         System.out.println(blog);
            //     }
            // }  
            




            /* get blogs by user_id */

             
            // List<Blog> blogs = blogDao.getBlogsByUserId(9) ; 
            // if (blogs == null || blogs.size() == 0) {
            //     System.out.println("No blogs found...");
            // }else {
            //     for (Blog blog : blogs) {
            //         System.out.println(blog);
            //     }
            // }
            

            
            

            /* get blog by blog_id */
            
            // Blog blog = blogDao.getBlogByBlogId(6) ; 
            // if (blog == null) {
            //     System.out.println("No blog found...");
            // }else {
            //     System.out.println(blog);
            // }


            // get all blogs 

            List<Blog> blogs = blogDao.getAllBlogs() ; 
            for (Blog blog : blogs) {
                System.out.println(blog);
            }




        } catch (Exception e) {
            
            e.printStackTrace() ;

        } finally {

            ((AnnotationConfigApplicationContext) blog_ctx).close();

        }

    }


}
