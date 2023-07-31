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

import com.techblog.dao.CommentDao;
import com.techblog.dao.CommentDaoImpl;
import com.techblog.entities.Comment;

public class CommentHandler extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out = resp.getWriter() ; 
        resp.setContentType("text/html");

        // check for user in session
        HttpSession session = req.getSession(false) ;
        if (session == null || session.getAttribute("user") == null) {
            out.print("invalid session") ; 
            return ;
        }

        String commentType = req.getParameter("comment-type") ; 
        Integer blogId = req.getParameter("blog-id") != null ?  Integer.parseInt(req.getParameter("blog-id")) : null ;
        Integer userId = req.getParameter("user-id") != null ? Integer.parseInt(req.getParameter("user-id")) : null ;
        Integer commentId= req.getParameter("comment-id") != null ? Integer.parseInt(req.getParameter("comment-id")) : null ; 
        

        if (commentType == null || commentType.equals("")) {
            out.print("no comment-type recieved") ; 
            return ; 
        }

        try {

            ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
            CommentDao commentDao = ctx.getBean("CommentDao",  CommentDaoImpl.class) ;

            switch(commentType) {

                case "add-comment" : {

                    String commentContent = req.getParameter("comment-content") ;
                    if (blogId == null || userId == null || commentContent == null) {
                        out.print("invalid parameters recieved...") ;
                    }
                    else {
                        Comment comment = new Comment(blogId, userId, commentContent) ;
                        if (commentDao.addCommentByBlogIdAndUserId(comment)) {
                            out.print("success") ;
                        }
                        else {
                            out.print("cant add comment") ;
                        }
                    }

                }
                break ; 

                case "delete-comment" : {
                    
                    if (commentId == null) {
                        out.print("comment id not recieved");
                    }
                    else {
                        if (commentDao.deleteCommentByCommentId(commentId)) {
                            out.print("success");
                        }
                        else {
                            out.print("cant delete comment") ;
                        }
                    }

                }
                break;

                default : {
                    out.print("invalid comment-type")  ;
                }
                break ; 

            }

            ((AnnotationConfigApplicationContext) ctx).close();

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            out.print(e.getMessage());

        }

        out.flush();

    }






    
    public static void main(String[] args) {
        
        ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
        CommentDao commentDao = ctx.getBean("CommentDao", CommentDaoImpl.class) ; 

        try {
            
            /* adding comment */

            // Comment comment = new Comment(9,30,"My another comment") ;
            // if (commentDao.addCommentByBlogIdAndUserId(comment)) {
            //     System.out.println("comment added successfully");
            // }
            // else {
            //     System.out.println("comment failed");
            // }


            /* fetching comment */

            List<Comment> comments = null ; 
            comments = commentDao.getCommentsByBlogId(9) ;
            for (Comment com : comments) {
                System.out.println(com);
            }


            /* deleting comment */

            // Comment comment = comments.get(0) ;
            // if (commentDao.deleteCommentByCommentId(comment.getComment_id())) {
            //     System.out.println("comment with id "+comment.getComment_id()+" deleted!!");
            // }
            // else {
            //     System.out.println("delete failed");
            // }



        } catch (Exception e) {

            e.printStackTrace() ; 

        }

        ((AnnotationConfigApplicationContext) ctx).close();

    }

}


