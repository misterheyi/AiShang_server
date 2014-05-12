<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>增加代理商-爱尚网-后台管理</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery.wysiwyg.js"></script>
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
  if (validate_required(users_name,"昵称不能为空")==false)
    {users_name.focus();return false;}
  if (validate_email(users_email,"Email 不合法！")==false)
    {users_email.focus();return false;}
  if (validate_required(users_password,"密码不能为空")==false)
    {users_password.focus();return false;}
  if (validate_required(users_IMEI,"IMEI不能为空")==false)
    {users_IMEI.focus();return false;}
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
    	    <h3>增加代理商</h3>
        	<div class="clear"></div>
      		</div>
			<div class="content-box-content">
				<form onsubmit="return validate_form(this);" action="<%=basePath %>admin/controller/addUser1" method="post">
			  <p>
			  	<label>代理商名</label>
              	<input class="text-input small-input" type="text" id="small-input" name="users_name" />
              	<small></small> 
              </p>
              <p>
			  	<label>邮箱</label>
              	<input class="text-input small-input" type="text" id="small-input" name="users_email" />
              	<small>(使用邮箱登录)</small> 
              </p>
              <p>
			  	<label>密码</label>
              	<input class="text-input small-input" type="password" id="small-input" name="users_password" />
              	<small>(注意密码安全)</small> 
              </p>
              <!--  
              <p>
			  	<label>IMEI</label>
              	<input class="text-input small-input" type="text" id="small-input" name="users_IMEI" />
              	<small>(设备唯一标识码)</small> 
              </p>
              -->
			  <p>
              	<input class="text-input small-input" type="hidden" id="small-input" name="userGroup_id" value="2"/>
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