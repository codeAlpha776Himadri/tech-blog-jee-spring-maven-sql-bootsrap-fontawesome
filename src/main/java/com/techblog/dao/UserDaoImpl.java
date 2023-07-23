package com.techblog.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.techblog.entities.User;
import com.techblog.entities.UserFullDetail;

public class UserDaoImpl implements UserDao {

    private JdbcTemplate jdbcTemplate;


    // db access methods here 


    public boolean addUser(User user) throws Exception {

        boolean isSaved = false ;

        try {
            
            String query = "insert into users(user_name,user_email,user_password,user_gender) values(?,?,?,?);" ;
            // String query2 = "insert into user_full_details(user_id) values(?) ;" ; 
            this.jdbcTemplate.update(query, user.getUser_name(), user.getUser_email(), user.getUser_password(), user.getUser_gender()) ;
            
            if (addUserToUserFullDetails(user)) {
                isSaved= true ;
            } 

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



    @Override
    public UserFullDetail getUserFullDetailByUserId(int user_id) throws Exception {
        
        UserFullDetail userFullDetail = null ; 


        try {
            
            String query = "select user_id, user_full_name, user_dob, user_about_me, user_img from user_full_details where user_id=? ;" ;
            
            List<UserFullDetail> users = 
                this.jdbcTemplate.query(query,
                new RowMapper<UserFullDetail>(){
                
                public UserFullDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
                    
                    UserFullDetail userFullDetail = new UserFullDetail() ;

                    userFullDetail.setUser_id(rs.getInt(1));
                    userFullDetail.setUser_full_name(rs.getString(2)) ;
                    userFullDetail.setUser_dob(rs.getDate(3));
                    userFullDetail.setUser_about_me(rs.getString(4));
                    userFullDetail.setUser_img(rs.getString(5));

                    return userFullDetail ;
                }
            },user_id) ;

            if (users != null && users.size() == 1) {
                userFullDetail = users.get(0) ;
            } 

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ; 

        }


        return userFullDetail ;
    }



    @Override
    public boolean updateUserAboutMe(User user, String new_user_about_me) throws Exception {
        
        boolean isUpdated= false ; 

        try {
            
            String query = "update user_full_details set user_about_me=? where user_id=? ;" ;
            this.jdbcTemplate.update(query, new_user_about_me, user.getUser_id()) ;
            isUpdated=true ; 

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }



    @Override
    public boolean updateUserDOB(User user, Date new_user_dob) throws Exception {
        
        boolean isUpdated= false ; 

        try {
            
            String query = "update user_full_details set user_dob=? where user_id=? ;" ;
            this.jdbcTemplate.update(query, new_user_dob, user.getUser_id()) ;
            isUpdated=true ; 

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }



    @Override
    public boolean updateUserEmail(User user, String new_user_email) throws Exception {
        
        boolean isUpdated = false; 

        try {
            
            String query = "update users set user_email=? where user_email=? and user_password=? ;" ;
            this.jdbcTemplate.update(query, new_user_email, user.getUser_email(), user.getUser_password()) ;
            isUpdated = true ;

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }



    @Override
    public boolean updateUserFullName(User user, String new_user_full_name) throws Exception {
        
        boolean isUpdated= false ; 

        try {
            
            String query = "update user_full_details set user_full_name=? where user_id=? ;" ;
            this.jdbcTemplate.update(query, new_user_full_name, user.getUser_id()) ;
            isUpdated=true ; 

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }



    @Override
    public boolean updateUserImg(User user, String new_user_img) throws Exception {
        
        boolean isUpdated= false ; 

        try {
            
            String query = "update user_full_details set user_img=? where user_id=? ;" ;
            this.jdbcTemplate.update(query, new_user_img, user.getUser_id()) ;
            isUpdated=true ; 

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }



    @Override
    public boolean updateUserName(User user, String new_user_name) throws Exception {
        
        boolean isUpdated = false; 

        try {
            
            String query = "update users set user_name=? where user_email=? and user_password=? ;" ;
            this.jdbcTemplate.update(query, new_user_name, user.getUser_email(), user.getUser_password()) ;
            isUpdated = true ;

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }



    @Override
    public boolean updateUserPassword(User user, String new_user_password) throws Exception {
        
        boolean isUpdated = false; 

        try {
            
            String query = "update users set user_password=? where user_email=? and user_password=? ;" ;
            this.jdbcTemplate.update(query, new_user_password, user.getUser_email(), user.getUser_password()) ;
            isUpdated = true ;

        } catch (Exception e) {
            
            e.printStackTrace() ; 
            throw e; 

        }


        return isUpdated ; 

    }


    public boolean addUserToUserFullDetails(User user) throws Exception {

        boolean isSaved = false ; 

        try {
            
            User myUser = getUserByEmailAndPassword(user.getUser_email(), user.getUser_password()) ;
            String query = "insert into user_full_details(user_id) values(?) ;" ;
            this.jdbcTemplate.update(query, myUser.getUser_id()) ;
            isSaved = true ;  

        } catch (Exception e) {
            
            e.printStackTrace();
            throw e ;

        }


        return isSaved ;
    }


    @Override
    public User getUserById(int user_id) throws Exception {

        User user = null ;

        try {
            
            String query = "select user_id, user_name, user_email, user_password, user_gender, user_created_at from users where user_id=? ;" ;
            List<User> users = this.jdbcTemplate.query(query, new RowMapperImplUser() ,user_id) ;
            if (users != null && users.size() > 1) {
                user = users.get(0) ;
            }

        } catch (Exception e) {
            e.printStackTrace();
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
