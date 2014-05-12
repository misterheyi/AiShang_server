<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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
    if (validate_required(hairstyle,"请选择文件")==false)
    {hairstyle.focus();return false;}
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
        <h3>增加发型</h3>
        <div class="clear"></div>
      </div>
            <%
            	String[] sexs = {"女性","男性"};
            	String[] areas = {"亚洲","欧洲"};
            	String[] descs = {"活泼可爱","端庄典雅","优雅时尚","新锐个性","盘发扎发"};
            	String[] heights = {"长","中","短"};
             %>
      <div class="content-box-content">
      	<form onsubmit="return validate_form(this);" action="<%=basePath %>admin/controller/uploadHairStyle" method="post" enctype="multipart/form-data" >
            <p>
              <label>性别</label>
              <% for(int i = 0; i < sexs.length; i++){ %>
              <input type="radio" name="sex" value="<%=sexs[i] %>" <%=i==0 ? "checked='checked'":""%>/><%=sexs[i] %>
              <% } %>
            </p>
            <p>
              <label>地区</label>
              <% for(int i = 0; i < areas.length; i++){ %>
              <input type="radio" name="area" value="<%=areas[i] %>" <%=i==0 ? "checked='checked'":""%>/><%=areas[i] %>
              <% } %>
            </p>
            <p>
              <label>风格</label>
              <% for(int i = 0; i < descs.length; i++){ %>
              <input type="radio" name="desc" value="<%=descs[i] %>" <%=i==0 ? "checked='checked'":""%>/><%=descs[i] %>
              <% } %>
            </p>
            <p>
              <label>发长</label>
              <% for(int i = 0; i < heights.length; i++){ %>
              <input type="radio" name="height" value="<%=heights[i] %>" <%=i==0 ? "checked='checked'":""%>/><%=heights[i] %>
              <% } %>
            </p>
            <p>
              <label>选择文件</label>
			  <input type="file" name="hairstyle" class="text-input small-input"/>
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