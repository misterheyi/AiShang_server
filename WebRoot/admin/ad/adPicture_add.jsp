<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
	Users u = (Users)session.getAttribute("USER");
%>
<!DOCTYPE>
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
<script type="text/javascript">
function validate_required(field,alerttxt)
{
with (field)
  {
  if (value==null||value=="")
    {alert(alerttxt);return false;}
  else {return true;}
  }
}

function validate_email(field,alerttxt)
{
with (field)
{
apos=value.indexOf("@");
dotpos=value.lastIndexOf(".");
if (apos<1||dotpos-apos<2) 
  {alert(alerttxt);return false;}
else {return true;}
}
}

function validate_form(thisform)
{
with (thisform)
  {
    if (validate_required(adPicture_file,"请选择文件")==false)
    {adPicture_file.focus();return false;}
  }
}

</script>
</head>

<body>
<div id="body-wrapper">
  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value=""/></jsp:include>
  <div id="main-content">

  	<div class="content-box">
	  <div class="content-box-header">
        <h3>增加海报</h3>
        <div class="clear"></div>
      </div>
      <div class="content-box-content">
      	<form onsubmit="return validate_form(this);" action="<%=basePath %>admin/controller/uploadPicture" method="post" enctype="multipart/form-data" >
            <p>
              <label>海报描述</label>
              <input class="text-input small-input" type="text" id="small-input" name="adPicture_desc" />
              <small>(可为空)</small> 
            </p>
            <p>
              <label>海报分类</label>
              <select name="adPictureGroup_id" class="small-input">
              <% if(u.getUserGroup_id() == 3) { %>
                <option value="1">店内促销</option>
                <option value="2">特色商品</option>
                <option value="3">价目表</option>
                <% } if(u.getUserGroup_id() <= 2) { %>
                <option value="4">滚动广告</option>
                <% } %>
              </select>
            </p>
            <p>
              <label>选择文件</label>
              <input class="text-input small-input" type="file" id="small-input" name="adPicture_file" />
              <small>(格式:png/jpg | 尺寸:根据终端分辨率，择优上传)</small> 
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
