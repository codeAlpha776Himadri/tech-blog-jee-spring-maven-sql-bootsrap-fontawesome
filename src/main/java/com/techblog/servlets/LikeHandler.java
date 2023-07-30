package com.techblog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.techblog.dao.LikeDao;
import com.techblog.dao.LikeDaoImpl;

public class LikeHandler extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        

    }
    

    




    // local db tests
    public static void main(String[] args) {
        ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
        LikeDao likeDao = ctx.getBean("LikeDao", LikeDaoImpl.class) ;

        try {
            
            // if (likeDao.likePost(9,32)) {
            //     System.out.println("liked");
            // }else {
            //     System.out.println("like failed");
            // }


            // if (likeDao.dislikePost(9,32)) {
            //     System.out.println("disliked");
            // }else {
            //     System.out.println("dislike failed");
            // }

        } catch (Exception e) {
           e.printStackTrace() ;
        }
    }

}
