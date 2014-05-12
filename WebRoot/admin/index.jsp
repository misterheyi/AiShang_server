<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>爱尚网-后台管理</title>
<link rel="stylesheet" href="../resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="../resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="../resources/scripts/jquery.wysiwyg.js"></script>
</head>

<body>
<div id="body-wrapper">

  <jsp:include page="include/sidebar.jsp" ><jsp:param name="selected" value="index"/></jsp:include>

  <div id="main-content">

    <!-- Page Head -->
    <h2>欢迎您</h2>
    <p id="page-intro">你想做点什么？</p>
    <ul class="shortcut-buttons-set">
      <li>
      <%
      	Users users = (Users)session.getAttribute("USER");
       %>
        <a class="shortcut-button" href="users/users_modify.jsp?uid=<%=users.getUsers_id() %>">
          <span> <img src="../resources/images/icons/pencil_48.png" alt="icon" /><br />修改信息</span>
        </a>
      </li>
      <%if(users.getUserGroup_id() ==4){%>
      <li>
        <a class="shortcut-button" href="users/users_modify_face.jsp?uid=<%=users.getUsers_id() %>">
          <span> <img src="../resources/images/icons/image_add_48.png" alt="icon" /><br />修改头像</span>
        </a>
      </li>
      <%} %>
      <!--  
      <li>
        <a class="shortcut-button" href="#">
          <span> <img src="../resources/images/icons/clock_48.png" alt="icon" /><br />上传视频</span>
        </a>
      </li>
      <li>
        <a class="shortcut-button" href="#">
          <span> <img src="../resources/images/icons/paper_content_pencil_48.png" alt="icon" /><br />上传发型</span>
        </a>
      </li>
	  -->
    </ul>
    <div class="clear"></div>
    <% if(users.getUserGroup_id() ==1){ %>
	<jsp:include page="profile/showVideoInfo.jsp" />
	<% } if(users.getUserGroup_id()==4) {%>
	<jsp:include page="profile/showHairstyle.jsp" />
	<% } if(users.getUserGroup_id()==3) {%>
	<jsp:include page="profile/showHairstylist.jsp" />
	<% } if(users.getUserGroup_id()==2) {%>
	<jsp:include page="profile/showAgentInfo.jsp" />
	<% } %>
	<div class="clear"></div>
    <jsp:include page="include/footer.jsp" />
</div>
</div>
</body>
</html>
