package com.techblog.entities;

import java.sql.Date;

public class UserFullDetail {

    private Integer user_id=null;
    private String user_full_name=null;
    private Date user_dob=null;
    private String user_about_me=null;
    private String user_img=null;

    public UserFullDetail(int user_id, String user_full_name, Date user_dob, String user_about_me, String user_img) {
        this.user_id = user_id;
        this.user_full_name = user_full_name;
        this.user_dob = user_dob;
        this.user_about_me = user_about_me;
        this.user_img = user_img;
    }

    public UserFullDetail() {
        super();
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUser_full_name() {
        return user_full_name;
    }

    public void setUser_full_name(String user_full_name) {
        this.user_full_name = user_full_name;
    }

    public Date getUser_dob() {
        return user_dob;
    }

    public void setUser_dob(Date user_dob) {
        this.user_dob = user_dob;
    }

    public String getUser_about_me() {
        return user_about_me;
    }

    public void setUser_about_me(String user_about_me) {
        this.user_about_me = user_about_me;
    }

    public String getUser_img() {
        return user_img;
    }

    public void setUser_img(String user_img) {
        this.user_img = user_img;
    }

    @Override
    public String toString() {
        return "UserFullDetail [user_id=" + user_id + ", user_full_name=" + user_full_name + ", user_dob=" + user_dob
                + ", user_about_me=" + user_about_me + ", user_img=" + user_img + "]";
    }

}
