package com.techblog.dao;

import com.techblog.entities.User;

public interface UserDao {
    public boolean addUser(User user) throws Exception ; 
    public User getUserByEmailAndPassword(String user_email, String user_password) throws Exception ;
    public User getUserByEmail(String user_email) throws Exception ;
}
