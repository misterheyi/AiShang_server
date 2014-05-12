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
<title>增加美发店-爱尚网-后台管理</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery.wysiwyg.js"></script>
<style type="text/css">
.upload-auth{
	display:none;
}
</style>
<script type="text/javascript">
var isUpload = false;
function validate_required(field,alerttxt)
{
with (field)
  {
  if (value==null||value=="")
    {alert(alerttxt);return false;}
  else {return true;}
  }
}

function validate_num(field,alerttxt)
{
with (field)
  {
  if (value==null||value==""||isNaN(value))
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
  //if (validate_required(users_IMEI,"IMEI不能为空")==false)
    //{users_IMEI.focus();return false;}
  if(isUpload){
	  if (validate_num(upload_adVideo_num,"上传视频数量不合法")==false)
	    {upload_adVideo_num.focus();return false;}
	  if (validate_num(upload_adPicture_num,"上传待机图片数量不合法")==false)
	  {upload_adPicture_num.focus();return false;}
  }
  }
}

$(function(){

	$('#is_upload').click(function(){
		if($(this).attr('checked')){
			$('.upload-auth').show();
			isUpload = true;
		}else{
			$('.upload-auth').hide();
			isUpload = false;
		}
	});
	
});

</script>
</head>
<body>
<div id="body-wrapper">
  	<jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value=""/></jsp:include>
	<div id="main-content">
		<div class="content-box">
			<div class="content-box-header">
    	    <h3>增加美发店</h3>
        	<div class="clear"></div>
      		</div>
			<div class="content-box-content">
				<form onsubmit="return validate_form(this);" action="<%=basePath %>admin/controller/addUser2" method="post">
			  <p>
			  	<label>美发店名</label>
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
              	<input class="text-input" type="checkbox" id="is_upload" name="users_is_upload" />是否允许上传视频或待机图片
              </p>
              <p class="upload-auth">
			  	<label>上传视频数量</label>
              	<input class="text-input small-input" type="text" name="upload_adVideo_num"/>
              </p>
              <p class="upload-auth">
			  	<label>上传待机图片数量</label>
              	<input class="text-input small-input" type="text" name="upload_adPicture_num"/>
              </p>
			  <p>
              	<input class="text-input small-input" type="hidden" id="small-input" name="userGroup_id" value="3"/>
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