package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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

@WebServlet("/blog/new")
public class RegisterBlog extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // register a blog
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        HttpSession session = req.getSession(false);

        if (session == null) {
            out.print("invalid session");
            return;
        }

        User user = (User) session.getAttribute("user");

        // get all paramaters of blog from req

        int user_id = user.getUser_id();
        String blog_tag = req.getParameter("blog-tag");
        String blog_title = req.getParameter("blog-title");
        String blog_content = req.getParameter("blog-content");
        String blog_code_content = req.getParameter("blog-code-content");

        if (blog_tag != null && blog_tag == "programming" && blog_code_content == null) {
            out.print("code cant be null for programming");
            return;
        }

        try {

            // try to save to db

            ApplicationContext blog_ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
            BlogDao blogDao = blog_ctx.getBean("BlogDao", BlogDaoImpl.class);

            Blog blog = new Blog(user_id, blog_title, blog_tag, blog_content, blog_code_content);

            if (blogDao.addBlog(blog)) {

                // update blog count
                Integer blogs_count = (Integer) session.getAttribute("blogs-count") ;
                session.setAttribute("blogs-count", blogs_count + 1 ); 

                out.print("success...");

            }

            ((AnnotationConfigApplicationContext) blog_ctx).close();

        } catch (Exception e) {

            e.printStackTrace();
            out.print(e.getMessage());

        } finally {

            out.flush();

        }

    }

}
