package com.techblog.entities;

import java.sql.Timestamp;

public class Like {
    
    private int like_id ; 
    private int blog_id ; 
    private int user_id ; 
    private Timestamp liked_at ;

    public Like(int like_id, int blog_id, int user_id, Timestamp liked_at) {
        this.like_id = like_id;
        this.blog_id = blog_id;
        this.user_id = user_id;
        this.liked_at = liked_at;
    }

    public Like(int blog_id, int user_id) {
        this.blog_id = blog_id;
        this.user_id = user_id;
    }

    public Like() {
        super() ;
    }

    public int getLike_id() {
        return like_id;
    }

    public void setLike_id(int like_id) {
        this.like_id = like_id;
    }

    public int getBlog_id() {
        return blog_id;
    }

    public void setBlog_id(int blog_id) {
        this.blog_id = blog_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Timestamp getLiked_at() {
        return liked_at;
    }

    public void setLiked_at(Timestamp liked_at) {
        this.liked_at = liked_at;
    }

    @Override
    public String toString() {
        return "Like [like_id=" + like_id + ", blog_id=" + blog_id + ", user_id=" + user_id + ", liked_at=" + liked_at
                + "]";
    }

}
