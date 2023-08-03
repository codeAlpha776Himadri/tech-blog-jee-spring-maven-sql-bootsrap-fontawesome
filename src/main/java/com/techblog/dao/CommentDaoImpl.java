package com.techblog.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.techblog.entities.Comment;

public class CommentDaoImpl implements CommentDao {

    private JdbcTemplate jdbcTemplate ; 

    @Override
    public boolean addCommentByBlogIdAndUserId(Comment comment) throws Exception {
        
        boolean isCommented = false ; 

        try {
            
            String query = "" ;
            if (comment.getComment_id() == null) {
                query = "insert into comments(blog_id, user_id, comment_content) values(?,?,?) ;" ;
                this.jdbcTemplate.update(query, comment.getBlog_id(), comment.getUser_id(), comment.getComment_content()) ;
            }
            else {
                query = "insert into comments(comment_id, blog_id, user_id, comment_content) values(?,?,?,?) ;" ;
                this.jdbcTemplate.update(query,comment.getComment_id(), comment.getBlog_id(), comment.getUser_id(), comment.getComment_content()) ;
            }

            isCommented= true ; 

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e ; 

        }


        return isCommented ; 

    }

    @Override
    public List<Comment> getCommentsByBlogId(int blog_id) throws Exception {
        
        List<Comment> comments= null ;

        try {
            
            String query = "select comment_id, blog_id, user_id, comment_content, commented_at from comments where blog_id=? ;" ;

            comments = this.jdbcTemplate.query(query, new RowMapper<Comment>() {

                @Override
                public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
                    
                    Comment comment = new Comment() ;

                    comment.setComment_id(rs.getInt(1)) ;
                    comment.setBlog_id(rs.getInt(2)) ;
                    comment.setUser_id(rs.getInt(3)) ;
                    comment.setComment_content(rs.getString(4));
                    comment.setCommented_at(rs.getTimestamp(5)) ;

                    return comment ; 

                }
                
            }, blog_id) ;


        } catch (Exception e) {
            
            e.printStackTrace();
            throw e;

        }


        return comments ;

    }

    @Override
    public boolean deleteCommentByCommentId(int comment_id) throws Exception {
        
        boolean isDeleted = false; 

        try {

            String query = "delete from comments where comment_id=? ;" ;
            this.jdbcTemplate.update(query, comment_id) ;
            isDeleted= true ; 
            
        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ;

        }


        return isDeleted ; 

    }



    public Comment getCommentById(int comment_id) throws Exception {

        Comment comment = null ;

        try {
            
            String query = "select comment_id, blog_id, user_id, comment_content, commented_at from comments where comment_id=? ;" ;

            List<Comment> comments = this.jdbcTemplate.query(query, new RowMapper<Comment>() {

                @Override
                public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
                    
                    Comment comment = new Comment() ;

                    comment.setComment_id(rs.getInt(1)) ;
                    comment.setBlog_id(rs.getInt(2)) ;
                    comment.setUser_id(rs.getInt(3)) ;
                    comment.setComment_content(rs.getString(4));
                    comment.setCommented_at(rs.getTimestamp(5)) ;

                    return comment ; 

                }
                
            }, comment_id) ;

            if (comments != null && comments.size() >=1) {
                comment = comments.get(0) ;
            }


        } catch (Exception e) {
            
            e.printStackTrace();
            throw e;

        }


        return comment ;        

    }




    public CommentDaoImpl() {
        super();
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
}
