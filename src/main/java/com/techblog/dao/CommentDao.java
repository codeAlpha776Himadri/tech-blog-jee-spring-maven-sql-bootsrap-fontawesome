package com.techblog.dao;

import java.util.List;

import com.techblog.entities.Comment;

public interface CommentDao {
    
    public boolean addCommentByBlogIdAndUserId(int blog_id, int user_id, String comment_content) throws Exception ;
    public List<Comment> getCommentsByBlogId(int blog_id) throws Exception ;
    public boolean deleteCommentByBlogIdAndCommentId(int blog_id, int user_id) throws Exception ;

}
