package com.techblog.servlets;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.techblog.dao.BlogDao;
import com.techblog.dao.BlogDaoImpl;
import com.techblog.entities.Blog;

public class GetBlogs {
    





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





        } catch (Exception e) {
            
            e.printStackTrace() ;

        } finally {

            ((AnnotationConfigApplicationContext) blog_ctx).close();

        }

    }

}
