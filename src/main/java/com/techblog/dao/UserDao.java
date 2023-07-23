package com.techblog.dao;

import java.sql.Date;

import com.techblog.entities.User;
import com.techblog.entities.UserFullDetail;

public interface UserDao {
    public boolean addUser(User user) throws Exception ; 
    public User getUserByEmailAndPassword(String user_email, String user_password) throws Exception ;
    public User getUserByEmail(String user_email) throws Exception ;
    public User getUserById(int user_id) throws Exception ;
    public UserFullDetail getUserFullDetailByUserId(int user_id) throws Exception;

    public boolean updateUserName(User user, String new_user_name) throws  Exception ; 
    public boolean updateUserEmail(User user, String new_user_email) throws  Exception ; 
    public boolean updateUserPassword(User user, String new_user_password) throws  Exception ; 

    public boolean updateUserFullName(User user, String new_user_full_name) throws Exception ; 
    public boolean updateUserDOB(User user, Date new_user_dob) throws Exception ; 
    public boolean updateUserAboutMe(User user, String new_user_about_me) throws Exception ; 
    public boolean updateUserImg(User user, String new_user_img) throws Exception ; 
}
