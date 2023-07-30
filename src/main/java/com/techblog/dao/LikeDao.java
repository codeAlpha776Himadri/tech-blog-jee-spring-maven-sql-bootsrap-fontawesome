package com.techblog.dao;

import java.util.List;

import com.techblog.entities.Like;

public interface LikeDao {

    public boolean likePost(int blog_id, int user_id) throws Exception ; 
    public boolean dislikePost(int blog_id, int user_id) throws Exception ;
    public List<Like> getLikesByBlogId(int blog_id) throws Exception ; 

}
