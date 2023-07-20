package com.techblog.dao;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.techblog.entities.Blog;

public class BlogDaoImpl implements BlogDao {

    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addBlog(Blog blog) throws Exception {
        
        boolean isSaved = false ; 

        try {
            
            String query = "insert into blogs(user_id, blog_tag, blog_content) values(?,?,?) ;" ;
            this.jdbcTemplate.update(query, blog.getUser_id(), blog.getBlog_tag(), blog.getBlog_content()) ; 
            isSaved=true ;          

        } catch (Exception e) {
            
            e.printStackTrace() ;
            throw e ; 

        }

        return isSaved ; 

    }

    @Override
    public List<Blog> getBlogsByTag(String blog_tag) throws Exception {
        
        List<Blog> blogs = null ; 

        try {
            
            String query = "select blog_id, user_id, blog_tag, blog_content, blog_created_at from blogs where blog_tag=? ;" ;
            blogs = this.jdbcTemplate.query(query, new RowMapperImplBlog(), blog_tag) ; 

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ; 

        }


        return blogs ; 

    }

    @Override
    public List<Blog> getBlogsByUserId(int user_id) throws Exception {
        
        List<Blog> blogs = null ; 


        try {
            
            String query = "select blog_id, user_id, blog_tag, blog_content, blog_created_at from blogs where user_id=? ;" ;
            blogs = this.jdbcTemplate.query(query, new RowMapperImplBlog(), user_id) ; 

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e ; 

        }


        return blogs ;

    }


    @Override
    public Blog getBlogByBlogId(int blog_id) throws Exception {

        Blog blog = null ;

        try {

            String query = "select blog_id, user_id, blog_tag, blog_content, blog_created_at from blogs where blog_id=? ;" ;
            List<Blog> blogs = this.jdbcTemplate.query(query, new RowMapperImplBlog(), blog_id) ;
            
            if (blogs.size() >= 1) {
                blog = blogs.get(0) ;
            }

        }
        catch(Exception e) {

            e.printStackTrace() ;
            throw e ;

        }


        return blog ;

    }







    public BlogDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate ;
    }

    public BlogDaoImpl() {
        super() ;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
}
