package com.techblog.entities;

import java.sql.Timestamp;

public class User {

    private int user_id;
    private String user_name;
    private String user_email;
    private String user_password;
    private String user_gender;
    private Timestamp user_created_at;

    public User(int user_id, String user_name, String user_email, String user_password, String user_gender,
            Timestamp user_created_at) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_email = user_email;
        this.user_password = user_password;
        this.user_gender = user_gender;
        this.user_created_at = user_created_at;
    }

    public User(String user_name, String user_email, String user_password, String user_gender) {
        this.user_name = user_name;
        this.user_email = user_email;
        this.user_password = user_password;
        this.user_gender = user_gender;
    }

    public User() {
        super();
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }

    public String getUser_gender() {
        return user_gender;
    }

    public void setUser_gender(String user_gender) {
        this.user_gender = user_gender;
    }

    public Timestamp getUser_created_at() {
        return user_created_at;
    }

    public void setUser_created_at(Timestamp user_created_at) {
        this.user_created_at = user_created_at;
    }

    @Override
    public String toString() {
        return "User [user_id=" + user_id + ", user_name=" + user_name + ", user_email=" + user_email
                + ", user_password=" + user_password + ", user_gender=" + user_gender + ", user_created_at="
                + user_created_at + "]";
    }

}
