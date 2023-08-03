package com.techblog.entities;

import java.sql.Timestamp;

public class Comment {
    
    private Integer comment_id ; 
    private int blog_id ; 
    private int user_id ;
    private String comment_content ; 
    private Timestamp commented_at ;

    public Comment(int comment_id, int blog_id, int user_id, String comment_content, Timestamp commented_at) {
        this.comment_id = comment_id;
        this.blog_id = blog_id;
        this.user_id = user_id;
        this.comment_content = comment_content;
        this.commented_at = commented_at;
    } 

    public Comment(int blog_id, int user_id, String comment_content) {
        this.blog_id = blog_id;
        this.user_id = user_id;
        this.comment_content = comment_content;
    } 

    public Comment() {
        super() ; 
    }

    public Integer getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
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

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }

    public Timestamp getCommented_at() {
        return commented_at;
    }

    public void setCommented_at(Timestamp commented_at) {
        this.commented_at = commented_at;
    }

    @Override
    public String toString() {
        return "Comment [comment_id=" + comment_id + ", blog_id=" + blog_id + ", user_id=" + user_id
                + ", comment_content=" + comment_content + ", commented_at=" + commented_at + "]";
    }
    

}
