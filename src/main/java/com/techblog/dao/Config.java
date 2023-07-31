package com.techblog.dao;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class Config {

    private String driver = "com.mysql.cj.jdbc.Driver" ; 
    private String url = "jdbc:mysql://Localhost:3306/tech_blog_project";
    private String username = "root";
    private String password = "HMmy124#";
    
    @Bean
    public DriverManagerDataSource getDriverManagerDataSource() {
        DriverManagerDataSource ds = new DriverManagerDataSource() ;
        ds.setDriverClassName(this.driver);
        ds.setUrl(this.url);
        ds.setUsername(this.username);
        ds.setPassword(this.password);
        return ds ;
    }

    @Bean(name = {"jdbcTemplate"})
    public JdbcTemplate getJdbcTemplate() {
        JdbcTemplate template = new JdbcTemplate() ; 
        template.setDataSource(getDriverManagerDataSource());
        return template ;
    }

    @Bean(name = {"UserDao"})
    public UserDaoImpl getStudentDaoImplementation() {
        UserDaoImpl userDaoImpl = new UserDaoImpl() ;
        userDaoImpl.setJdbcTemplate(getJdbcTemplate()) ; 
        return userDaoImpl ; 
    }

    @Bean(name = {"BlogDao"})
    public BlogDaoImpl getBlogDaoImplementation() {
        BlogDaoImpl blogDaoImpl = new BlogDaoImpl() ;
        blogDaoImpl.setJdbcTemplate(getJdbcTemplate()) ; 
        return blogDaoImpl ; 
    }

    @Bean(name = {"LikeDao"})
    public LikeDaoImpl getLikeDaoImplementation() {
        LikeDaoImpl likeDaoImpl = new LikeDaoImpl() ;
        likeDaoImpl.setJdbcTemplate(getJdbcTemplate());
        return likeDaoImpl ;
    }

    @Bean(name = {"CommentDao"})
    public CommentDaoImpl getCommentDaoImplementation() {
        CommentDaoImpl commentDaoImpl = new CommentDaoImpl() ;
        commentDaoImpl.setJdbcTemplate(getJdbcTemplate());
        return commentDaoImpl ;
    }

}
