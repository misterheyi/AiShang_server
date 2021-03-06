<%@page import="com.aishang.db.bean.Users"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="sidebar">
<div id="sidebar-wrapper">
<%
	Users users = (Users)session.getAttribute("USER");
	String s = users.getUsers_name();
	String selected = request.getParameter("selected");
 %>
<img id="logo" src="<%=basePath %>resources/images/logo.png" alt="Simpla Admin logo" />
<div id="profile-links">您好, <a href="#" title="Edit your profile"><%=s %></a> 欢迎登录<br />
<br />
<a href="<%=basePath %>admin/controller/login" title="Sign Out">注销</a> 
</div>
      <ul id="main-nav">
        <li> 
          <a href="<%=basePath %>admin/index.jsp" class="nav-top-item no-submenu <%="index".equals(selected)?"current":""%>">首页</a> 
        </li>
        <%
        int id = users.getUserGroup_id();
        if(id != 4&& id != 1) {
         %>
        <li> 
          <a href="<%=basePath %>admin/users/users_list.jsp" class="nav-top-item no-submenu <%="users".equals(selected)?"current":""%>">人员管理</a> 
        </li>
        <%
        }
        if(id == 1) {
            %>
           <li> 
             <a href="<%=basePath %>admin/users/admin_users_list.jsp" class="nav-top-item no-submenu <%="users".equals(selected)?"current":""%>">人员管理</a> 
           </li>
           <%
           }
        if(id == 1 || id == 2 ||id==3) {
         %>
        <li> 
          <a href="<%=basePath %>admin/controller/checkUploadVideoAuth" class="nav-top-item no-submenu <%="video".equals(selected)?"current":""%>">视频管理</a> 
        </li>
        <li> 
           <a href="<%=basePath %>admin/controller/checkUploadPictureAuth" class="nav-top-item no-submenu <%="scrollpicture".equals(selected)?"current":""%>">待机图片管理</a>
         </li>
        <%
        }
        if(id == 3) {
         %>
        <li> 
          <a href="<%=basePath %>admin/ad/adPicture_list.jsp?show=1" class="nav-top-item no-submenu <%="picture".equals(selected)?"current":""%>">店内推荐</a>
        </li>
        <%
        }
        if(id == 3) {
         %>
        <li> 
          <a href="<%=basePath %>admin/hairstyle/hairstyle_list.jsp" class="nav-top-item no-submenu <%="hairstyle".equals(selected)?"current":""%>">发型库</a> 
        </li>
        <%
        }
        if(id == 1 || id == 4) {
         %>
        <li> 
          <a href="<%=basePath %>admin/hairstyle/hairstyle_me.jsp" class="nav-top-item no-submenu <%="hairstyle".equals(selected)?"current":""%>">发型库</a> 
        </li>
        <%
        }
        if(id == 1) {
         %>
        <li> 
          <a href="<%=basePath %>admin/version/version_list.jsp" class="nav-top-item no-submenu <%="version".equals(selected)?"current":""%>">版本管理</a> 
        </li>
        <li> 
          <a href="<%=basePath %>admin/system/system_setting.jsp" class="nav-top-item no-submenu <%="system".equals(selected)?"current":""%>">系统管理</a> 
        </li>
        <%
        }
         %>
      </ul>
</div>
</div>