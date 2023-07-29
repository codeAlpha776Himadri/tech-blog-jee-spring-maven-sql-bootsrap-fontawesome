
<%@page import="java.util.* , com.techblog.entities.* , com.techblog.dao.* " %>
<%@page import="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="java.lang.*"%>

<%

    String getType = request.getParameter("get-type") ;
    if (getType == null) {
        out.print("get-type not found...");
        return ; 
    }

    try {
 
            ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ; 
            BlogDao blogDao = ctx.getBean("BlogDao", BlogDaoImpl.class) ;
            UserDao userDao = ctx.getBean("UserDao", UserDaoImpl.class) ; 
            
            switch(getType) {
            
                case "all" : {

                    List<Blog> blogs = blogDao.getAllBlogs() ;
                    if (blogs.size() == 0 || blogs == null) {
                        %>
                            <div class='col-md-12 text-center'>
                                <div class='display-4'>
                                    No blogs <br>in this catagory
                                </div>
                            </div>
                        <%
                    }
                    else {

                        for (Blog blog : blogs) {
                            
                            System.out.println("all : "+blog.getUser_id()) ; 
                            User user = userDao.getUserById(blog.getUser_id()) ; 
                            String author = user == null ? "Guest" : user.getUser_name() ;

                        %>
                            <style>

                                .btn-outline-primary {
                                    --bs-btn-color: rgb(50, 50, 77);
                                    --bs-btn-border-color: rgb(50, 50, 77);
                                    --bs-btn-hover-color: #fff;
                                    --bs-btn-hover-bg: rgb(50, 50, 77);
                                    --bs-btn-hover-border-color: rgb(50, 50, 77);
                                }
                                
                            </style>
                            <div class='col-md-6 mb-3'>
                                <div class='card'>
                                    <img src="https://previews.123rf.com/images/peshkov/peshkov1910/peshkov191000662/133391293-creative-blogging-sketch-on-white-brick-wall-background-blog-and-media-concept-3d-rendering.jpg" class="card-img-top" alt="img" style="height: 8rem;">
                                    <div class="card-body">
                                        <div class="card-title" style="font-size: 18px">
                                            <b><%= blog.getBlog_title()%></b>
                                        </div>
                                        <div style="font-size: 14px">
                                            <b>Author</b> : <i><%= author%></i><br>
                                        </div>
                                        <div style="color: grey; font-size: 13px;"><%= blog.getBlog_created_at()%></div>
                                        <hr>
                                        <%= blog.getBlog_content()%>
                                    </div>
                                    <div class="card-footer text-center" style="background-color: white;">
                                        <a href="single_blog_page.jsp?blog_id=<%= blog.getBlog_id()%>" class="btn btn-outline-primary btn-sm">Read more...</a>
                                        <button class="btn btn-outline-primary btn-sm">
                                            <span class="fa fa-thumbs-o-up"></span>
                                            <span id="like-count">101</span>
                                        </button>
                                        <button class="btn btn-outline-primary btn-sm">
                                            <span class="fa fa-comment-o"></span>
                                            <span id="comment-count">101</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        <%
                            
                        }

                    }

                }
                break ; 


                case "by-blog-id" : {

                    int blogId = Integer.parseInt(request.getParameter("blog-id")) ;
                    if (((Integer)blogId).equals(null)) {
                        out.print("blog id not found...") ;
                    }
                    else {
                        Blog blog = blogDao.getBlogByBlogId(blogId) ;
                        
                    }

                }
                break ; 


                case "by-user-id" : {


                    Integer userId1 = Integer.parseInt(request.getParameter("user-id")) ;
                    User user = session != null ? (User) session.getAttribute("user") : null ;
                    Integer userId2 = user != null ? user.getUser_id() : null ;
                    if (userId1 != null || userId2 != null) {
                        List<Blog> blogs = blogDao.getBlogsByUserId(userId1 != null ? userId1 : userId2) ;
                        
                        if (blogs == null || blogs.size() == 0) {
                        %>
                            <div class='col-md-12 text-center'>
                                <div class='display-4'>
                                    No blogs <br>in this catagory
                                </div>
                            </div>
                        <%
                        }
                        else {
                            for (Blog blog : blogs) {
                                User blogUser = userDao.getUserById(blog.getUser_id()) ;
                                String author = blogUser == null ? "Guest" : blogUser.getUser_name() ;
                            %>
                              <style>

                                    .btn-outline-primary {
                                        --bs-btn-color: rgb(50, 50, 77);
                                        --bs-btn-border-color: rgb(50, 50, 77);
                                        --bs-btn-hover-color: #fff;
                                        --bs-btn-hover-bg: rgb(50, 50, 77);
                                        --bs-btn-hover-border-color: rgb(50, 50, 77);
                                    }
                                    
                                </style>
                                <div class='col-md-6 mb-3'>
                                    <div class='card'>
                                        <img src="https://previews.123rf.com/images/peshkov/peshkov1910/peshkov191000662/133391293-creative-blogging-sketch-on-white-brick-wall-background-blog-and-media-concept-3d-rendering.jpg" class="card-img-top" alt="img" style="height: 8rem;">
                                        <div class="card-body">
                                            <div class="card-title" style="font-size: 18px">
                                                <b><%= blog.getBlog_title()%></b>
                                            </div>
                                            <div style="font-size: 14px">
                                                <b>Author</b> : <i><%= author%></i><br>
                                            </div>
                                            <div style="color: grey; font-size: 13px;"><%= blog.getBlog_created_at()%></div>
                                            <hr>
                                            <%= blog.getBlog_content()%>
                                        </div>
                                        <div class="card-footer text-center" style="background-color: white;">
                                            <a href="single_blog_page.jsp?blog_id=<%= blog.getBlog_id()%>" class="btn btn-outline-primary btn-sm">Read more...</a>
                                            <button class="btn btn-outline-primary btn-sm">
                                                <span class="fa fa-thumbs-o-up"></span>
                                                <span id="like-count">101</span>
                                            </button>
                                            <button class="btn btn-outline-primary btn-sm">
                                                <span class="fa fa-comment-o"></span>
                                                <span id="comment-count">101</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            <%
                            }
                        }

                    }
                    else {

                            %>
                                <div class='col-md-12 text-center'>
                                    <div class='display-4'>
                                        No blogs <br>in this catagory
                                    </div>
                                </div>
                            <%

                    }
                    

                }
                break ; 


                case "by-tag" : {

                    String blogTag = request.getParameter("blog-tag") ; 
                    if (blogTag == null || blogTag.equals("")) {
                        %>
                            <div class='col-md-12 text-center'>
                                <div class='display-4'>
                                    Type not found
                                </div>
                            </div>
                        <%
                    } 
                    else {
                        List<Blog> blogs = blogDao.getBlogsByTag(blogTag) ;
                        
                        if (blogs == null || blogs.size() == 0 ) {
                        %>
                            <div class='col-md-12 text-center'>
                                <div class='display-4'>
                                    No blogs <br>in this catagory
                                </div>
                            </div>
                        <%
                        }
                        else {
                            for (Blog blog : blogs) {
                                User user = userDao.getUserById(blog.getUser_id()) ;
                                String author = user == null ? "Guest" : user.getUser_name() ;
                            %>
                              <style>

                                    .btn-outline-primary {
                                        --bs-btn-color: rgb(50, 50, 77);
                                        --bs-btn-border-color: rgb(50, 50, 77);
                                        --bs-btn-hover-color: #fff;
                                        --bs-btn-hover-bg: rgb(50, 50, 77);
                                        --bs-btn-hover-border-color: rgb(50, 50, 77);
                                    }
                                    
                                </style>
                                <div class='col-md-6 mb-3'>
                                    <div class='card'>
                                        <img src="https://previews.123rf.com/images/peshkov/peshkov1910/peshkov191000662/133391293-creative-blogging-sketch-on-white-brick-wall-background-blog-and-media-concept-3d-rendering.jpg" class="card-img-top" alt="img" style="height: 8rem;">
                                        <div class="card-body">
                                            <div class="card-title" style="font-size: 18px">
                                                <b><%= blog.getBlog_title()%></b>
                                            </div>
                                            <div style="font-size: 14px">
                                                <b>Author</b> : <i><%= author%></i><br>
                                            </div>
                                            <div style="color: grey; font-size: 13px;"><%= blog.getBlog_created_at()%></div>
                                            <hr>
                                            <%= blog.getBlog_content()%>
                                        </div>
                                        <div class="card-footer text-center" style="background-color: white;">
                                            <a href="single_blog_page.jsp?blog_id=<%= blog.getBlog_id()%>" class="btn btn-outline-primary btn-sm">Read more...</a>
                                            <button class="btn btn-outline-primary btn-sm">
                                                <span class="fa fa-thumbs-o-up"></span>
                                                <span id="like-count">101</span>
                                            </button>
                                            <button class="btn btn-outline-primary btn-sm">
                                                <span class="fa fa-comment-o"></span>
                                                <span id="comment-count">101</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            <%
                            }
                        }
                        
                    }

                }
                break ; 


                default : {
                   System.out.println("default") ;
                }
                break ; 

            }

            ((AnnotationConfigApplicationContext) ctx).close();

        } catch (Exception e) {
            
            e.printStackTrace() ;

        } finally {
            System.out.println("ended...") ; 
        }

        out.flush();

%>