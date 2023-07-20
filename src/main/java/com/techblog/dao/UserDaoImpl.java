package com.techblog.dao;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.techblog.entities.User;

public class UserDaoImpl implements UserDao {

    private JdbcTemplate jdbcTemplate;


    // db access methods here 


    public boolean addUser(User user) throws Exception {

        boolean isSaved = false ;

        try {
            
            String query = "insert into users(user_name,user_email,user_password,user_gender) values(?,?,?,?);" ;
            this.jdbcTemplate.update(query, user.getUser_name(), user.getUser_email(), user.getUser_password(), user.getUser_gender()) ;
            isSaved = true  ;

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ; 

        }

        return isSaved ;

    }



    public User getUserByEmailAndPassword(String user_email, String user_password) throws Exception {

        User user = null ; 


        String query = "select user_id, user_name, user_email, user_password, user_gender, user_created_at from users where user_email=? and user_password=? ;" ;

        try {
            
            List<User> users = this.jdbcTemplate.query(query, new RowMapperImplUser(), user_email, user_password) ;
            // System.out.println("users : "+ users);
            user = users.size() >= 1 ? users.get(0) : null ;

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ; 

        }

        return user ; 

    }



    public User getUserByEmail(String user_email) throws Exception {

        User user = null ;

        try {
            
            String query = "select user_id, user_name, user_email, user_password, user_gender, user_created_at from users where user_email=? ;" ;
            List<User> users = this.jdbcTemplate.query(query, new RowMapperImplUser(), user_email) ;
            // System.out.println("users : "+ users);
            user = users.size() >= 1 ? users.get(0) : null ;

        } catch (Exception e) {
            
            e.printStackTrace() ;
            throw e ;

        }

        return user ; 

    }






    public UserDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public UserDaoImpl() {
        super() ;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

}
