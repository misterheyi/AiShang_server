<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aishang.db.dao.UploadAuthDao"%>
<%@page import="com.aishang.db.bean.UploadAuth"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
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
	int groupId = users.getUserGroup_id();
	//美发店用户有上传权限需特殊处理
	UploadAuth uploadAuth = null;
	if(groupId==3){
		UploadAuthDao authDao = new UploadAuthDao();
		uploadAuth = authDao.getUploadAuthByUid(users.getUsers_id());
	}
 %>
<div id="body-wrapper">
  	<jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value=""/></jsp:include>
	<div id="main-content">
		<div class="content-box">
			<div class="content-box-header">
    	    <h3>修改</h3>
        	<div class="clear"></div>
      		</div>
			<div class="content-box-content">
				<form action="<%=basePath %>admin/controller/modifyUser" method="post">
			  <p>
			  	<label>名称</label>
              	<input class="text-input small-input" value="<%=users.getUsers_name() %>" type="text" id="small-input" name="users_name" />
              	<small></small> 
              </p>
              <p>
			  	<label>邮箱</label>
              	<input class="text-input small-input" value="<%=users.getUsers_email() %>" type="text" id="small-input" name="users_email" />
              	<small>(使用邮箱登录)</small> 
              </p>
              <p>
			  	<label>密码</label>
              	<input class="text-input small-input" type="password" id="small-input" name="users_password" />
              	<small>(注意密码安全)</small> 
              </p>
              <%if(groupId==4){ %>
              <p>
			  	<label>IMEI</label>
              	<input class="text-input small-input" value="<%=users.getUsers_IMEI() %>" type="text" id="small-input" name="users_IMEI" />
              	<small>(设备唯一标识码)</small> 
              </p>
              <%} %>
              <%if(uploadAuth!=null&&uploadAuth.getAuth_id()==0){
              %>
              <p>
              	<input class="text-input" type="checkbox" id="is_upload" name="users_is_upload" />是否允许上传视频或待机图片
              </p>  
              <%
              } %>
              <%if(uploadAuth!=null){ %>
              <p class="upload-auth">
			  	<label>上传视频数量</label>
              	<input class="text-input small-input" type="text" name="upload_adVideo_num" value="<%=uploadAuth.getAllow_video_num() %>"/>
              </p>
              <p class="upload-auth">
			  	<label>上传待机图片数量</label>
              	<input class="text-input small-input" type="text" name="upload_adPicture_num" value="<%=uploadAuth.getAllow_picture_num() %>"/>
              </p>
              <%} %>
			  <p>
              	<input class="text-input small-input" type="hidden" id="small-input" name="userGroup_id" value="<%=users.getUserGroup_id()%>"/>
              	<input class="text-input small-input" type="hidden" id="small-input" name="users_id" value="<%=users.getUsers_id()%>"/>
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