<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	filePath = "http://bcs.duapp.com/aishangupload";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>增加美发店-爱尚网-后台管理</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery.wysiwyg.js"></script>
</head>
<body>
<%
	UsersDAO dao = new UsersDAO();
	Users users = dao.getById(Integer.parseInt(request.getParameter("uid")));
 %>
<div id="body-wrapper">
  	<jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value=""/></jsp:include>
	<div id="main-content">
		<div class="content-box">
			<div class="content-box-header">
    	    <h3>修改头像</h3>
        	<div class="clear"></div>
      		</div>
			<div class="content-box-content">
			  <form action="<%=basePath %>admin/controller/modifyUserFace" method="post" enctype="multipart/form-data">
			  <p>
			  	<label>名称</label>
              	<input class="text-input small-input" disabled="disabled" value="<%=users.getUsers_name() %>" type="text" id="small-input" name="users_name" />
              	<small></small> 
              </p>
			  <p>
              	<input class="text-input small-input" type="hidden" id="small-input" name="users_id" value="<%=users.getUsers_id()%>"/>
			  </p>
			  <p>
			    <label>旧头像</label>
			    <img src="<%=users.getUsers_face().equals("null") ? basePath+"resources/images/user_default.png" :filePath+users.getUsers_face() %>" alt="" style="width: 50px;height: 50px"/>
			  </p>
			  <p>
			    <label>新头像</label>
			  	<input class="text-input small-input" type="file" name="users_face"/>
			  </p>
	          <p>
              <input class="button" type="submit" value="提交" />
	          </p>
				</form>
			</div>
		</div>
	<div class="clear"></div>  
	<jsp:include page="../include/footer.jsp" />    
	</div>
</div>
</body>
</html>