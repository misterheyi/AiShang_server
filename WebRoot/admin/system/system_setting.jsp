<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aishang.db.dao.SystemSettingDao"%>
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
        <h3>系统管理</h3>
        <ul class="content-box-tabs">
          <li><a href="#tab1" class="default-tab">上传密码设置</a></li>
        </ul>
        <div class="clear"></div>
      </div>
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab1">
        <form method="post" action="<%=basePath %>admin/controller/modifyUploadPwd">
        <input class="text-input small-input" type="text" name="upload_password" value="<%=new SystemSettingDao().getByType("upload_pwd").getSetting_value() %>"/>
        <input type="submit" value="修改" class="button" />
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
