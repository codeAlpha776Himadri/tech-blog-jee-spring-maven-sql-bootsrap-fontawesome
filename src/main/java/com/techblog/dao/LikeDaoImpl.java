package com.techblog.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.techblog.entities.Like;

public class LikeDaoImpl implements LikeDao {

    private JdbcTemplate jdbcTemplate ; 



    @Override
    public boolean likePost(int blog_id, int user_id) throws Exception {
        
        boolean isLiked = false ;

        try {
            
            String query = "insert into likes (blog_id, user_id) values(?,?) ;" ;
            this.jdbcTemplate.update(query, blog_id, user_id) ;
            isLiked= true ;

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e ; 

        }

        return isLiked ; 

    }



    @Override
    public boolean dislikePost(int blog_id, int user_id) throws Exception {
        
        boolean disliked = false ; 

        try {
            
            String query = "delete from likes where blog_id=? and user_id=? ;" ;
            this.jdbcTemplate.update(query, blog_id, user_id) ; 
            disliked= true ; 

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ; 

        }

        return disliked ; 

    }



    @Override
    public List<Like> getLikesByBlogId(int blog_id) throws Exception {
    
        List<Like> likes = null ; 

        try {
            
            String query = "select like_id, blog_id, user_id, liked_at from likes where blog_id=? ;" ; 
            likes = this.jdbcTemplate.query(query, new RowMapper<Like>() {

                @Override
                public Like mapRow(ResultSet rs, int rowNum) throws SQLException {
                    
                    Like like = new Like() ; 

                    like.setLike_id(rs.getInt(1));
                    like.setBlog_id(rs.getInt(2));
                    like.setUser_id(rs.getInt(3));
                    like.setLiked_at(rs.getTimestamp(4));

                    return like ; 

                }
                
            }, blog_id) ;

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ; 

        }
        
        return likes ;
    }

    
    @Override
    public Like getLikeByBlogIdAndUserId(int blog_id, int user_id) throws Exception {

        Like like = null ; 

        try {
            
            String query = "select like_id, blog_id, user_id, liked_at from likes where blog_id=? and user_id=? ;" ;
            List<Like> likes = this.jdbcTemplate.query(query, new RowMapper<Like>() {

                @Override
                public Like mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Like like = new Like() ; 

                    like.setLike_id(rs.getInt(1));
                    like.setBlog_id(rs.getInt(2));
                    like.setUser_id(rs.getInt(3));
                    like.setLiked_at(rs.getTimestamp(4));

                    return like ;
                }
                
            }, blog_id, user_id) ;
            
            if (likes != null && likes.size() >= 1) {
                like = likes.get(0) ;
            }

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e ; 

        }

        return like ;

    }


    
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public LikeDaoImpl() {
        super() ;
    }

    public LikeDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
}
