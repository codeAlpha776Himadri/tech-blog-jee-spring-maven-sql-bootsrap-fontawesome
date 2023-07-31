package com.techblog.dao;

import java.util.List;

import com.techblog.entities.Comment;

public interface CommentDao {
    
    public boolean addCommentByBlogIdAndUserId(Comment comment) throws Exception ;
    public List<Comment> getCommentsByBlogId(int blog_id) throws Exception ;
    public boolean deleteCommentByCommentId(int comment_id) throws Exception ;

}
