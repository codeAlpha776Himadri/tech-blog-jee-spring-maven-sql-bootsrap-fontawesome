package com.techblog.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.techblog.entities.Blog;

public class RowMapperImplBlog implements RowMapper<Blog> {

    @Override
    public Blog mapRow(ResultSet rs, int rowNum) throws SQLException {

        Blog blog = new Blog() ; 

        try {
            
            blog.setBlog_id(rs.getInt(1));
            blog.setUser_id(rs.getInt(2));
            blog.setBlog_tag(rs.getString(3));
            blog.setBlog_content(rs.getString(4));
            blog.setBlog_created_at(rs.getTimestamp(5));


        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e ;

        }

        return blog ; 

    }
    
}
