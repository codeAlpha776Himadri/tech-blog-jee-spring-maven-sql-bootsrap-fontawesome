package com.techblog.entities;

import java.sql.Timestamp;

public class Blog {

    private int blog_id;
    private int user_id;
    private String blog_tag;
    private String blog_content;
    private Timestamp blog_created_at;

    public Blog(int blog_id, int user_id, String blog_tag, String blog_content, Timestamp blog_created_at) {
        this.blog_id = blog_id;
        this.user_id = user_id;
        this.blog_tag = blog_tag;
        this.blog_content = blog_content;
        this.blog_created_at = blog_created_at;
    }

    public Blog(int user_id, String blog_tag, String blog_content) {
        this.user_id = user_id;
        this.blog_tag = blog_tag;
        this.blog_content = blog_content;
    }

    public Blog() {
        super();
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

    public String getBlog_tag() {
        return blog_tag;
    }

    public void setBlog_tag(String blog_tag) {
        this.blog_tag = blog_tag;
    }

    public String getBlog_content() {
        return blog_content;
    }

    public void setBlog_content(String blog_content) {
        this.blog_content = blog_content;
    }

    public Timestamp getBlog_created_at() {
        return blog_created_at;
    }

    public void setBlog_created_at(Timestamp blog_created_at) {
        this.blog_created_at = blog_created_at;
    }

    @Override
    public String toString() {
        return "Blog [blog_id=" + blog_id + ", user_id=" + user_id + ", blog_tag=" + blog_tag + ", blog_content="
                + blog_content + ", blog_created_at=" + blog_created_at + "]";
    }

}
