package com.techblog.dao;

import java.util.List;

import com.techblog.entities.Blog;

public interface BlogDao {
    public boolean addBlog(Blog blog) throws Exception ; 
    public List<Blog> getBlogsByUserId(int user_id) throws Exception ; 
    public List<Blog> getBlogsByTag(String blog_tag) throws Exception ;  
    public Blog getBlogByBlogId(int blog_id) throws Exception ;   
}
