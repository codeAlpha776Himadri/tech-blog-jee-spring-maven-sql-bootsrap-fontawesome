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

import com.techblog.dao.LikeDao;
import com.techblog.dao.LikeDaoImpl;

public class LikeHandler extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            out.print("invalid session...");
            return;
        }

        String likeType = req.getParameter("like-type");
        Integer blogId = Integer.parseInt(req.getParameter("blog-id"));
        Integer userId = Integer.parseInt(req.getParameter("user-id"));

        if (likeType == null || blogId == null || userId == null) {
            out.print("insufficient parameters recieved...");
            return;
        }

        try {

            ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
            LikeDao likeDao = ctx.getBean("LikeDao", LikeDaoImpl.class);

            switch (likeType) {

                case "like": {

                    // like the blog

                    if (likeDao.likePost(blogId, userId)) {
                        out.print("success");
                    } else {
                        out.print("Cant like! Server error...");
                    }

                }
                    break;

                case "dislike": {

                    // dislike the blog

                    if (likeDao.dislikePost(blogId, userId)) {
                        out.print("success");
                    } else {
                        out.print("Cant like! Server error...");
                    }

                }
                    break;

                default: {

                    out.print("invalid like type...");

                }
                    break;

            }

            ((AnnotationConfigApplicationContext) ctx).close();

        } catch (Exception e) {

            e.printStackTrace();
            out.print(e.getMessage());

        }

        out.flush();

    }


    



    // local db tests
    public static void main(String[] args) {
        ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao");
        LikeDao likeDao = ctx.getBean("LikeDao", LikeDaoImpl.class);

        try {

            if (likeDao.likePost(9, 32)) {
                System.out.println("liked");
            } else {
                System.out.println("like failed");
            }

            // if (likeDao.dislikePost(9,32)) {
            // System.out.println("disliked");
            // }else {
            // System.out.println("dislike failed");
            // }

        } catch (Exception e) {
            e.printStackTrace();
        }

        ((AnnotationConfigApplicationContext) ctx).close();
    }

}
