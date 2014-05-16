<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.aishang.db.bean.Users"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>爱尚网-后台管理</title>
<link rel="stylesheet" href="../../resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="../../resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../../resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="../../resources/scripts/jquery.wysiwyg.js"></script>
<style type="text/css">
	.banner {
		width: 400px;
		height: 150px;
		margin: 0 auto;
		display:block;
	}
	.button{
		margin-left:10px;
	}
</style>
</head>

<body>
<div id="body-wrapper">
  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="system"/></jsp:include>
  <div id="main-content">
	<div class="content-box">
	  <div class="content-box-header">
        <h3>上传权限</h3>
        <div class="clear"></div>
      </div>
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab1">
        <form method="post" action="<%=basePath %>admin/controller/openUploadAuth">
        <input type="hidden" name="type" value="<%=request.getParameter("type")%>" />
        <p>输入提供的密码后才可允许上传</p>
        <input class="text-input small-input" type="text" name="upload_password"/>
        <input type="submit" value="提交" class="button" />
        </form>
        </div>
      </div>
	</div>

    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" />
  </div>
</div>
</body>
</html>
