package com.techblog.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.techblog.entities.User;

public class RowMapperImplUser implements RowMapper<User> {

    @Override
    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
        
        User user = new User() ; 

        user.setUser_id(rs.getInt(1));
        user.setUser_name(rs.getString(2));
        user.setUser_email(rs.getString(3));
        user.setUser_password(rs.getString(4));
        user.setUser_gender(rs.getString(5));
        user.setUser_created_at(rs.getTimestamp(6));

        return user ;
    }
    
}
