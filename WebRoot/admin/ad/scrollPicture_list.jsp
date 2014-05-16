<%@page import="com.aishang.db.bean.AdPicture"%>
<%@page import="com.aishang.db.dao.AdPictureDAO"%>
<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aishang.manager.AdPictureManager"%>
<%@page import="com.aishang.vo.AdPictureVO"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
	Users users = (Users)session.getAttribute("USER");
	int groupId = users.getUserGroup_id();
%>
<!DOCTYPE html>
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
</style>
</head>

<body>
<div id="body-wrapper">
  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="scrollpicture"/></jsp:include>
  <div id="main-content">
	<div class="content-box">
	  <div class="content-box-header">
        <h3>待机图片</h3>
        <ul class="content-box-tabs">
          <li><a href="#tab4" class="default-tab">待机图片</a></li>
        </ul>
        <div class="clear"></div>
      </div>
      	  <div class="content-box-content">
	    <table>
	  	<thead>
              <tr>
                <th>名称</th>
                <th>播放次数</th>
               <%if(groupId<=2){ %>
               <th>上传者</th>
               <th>用户组</th>
               	<%} %>
                <th>操作</th>
              </tr>
        </thead>
        <tbody>
        <%
	        AdPictureManager adPictureManager = new AdPictureManager();
			List<AdPictureVO> list = new ArrayList<AdPictureVO>();
			if(users.getUserGroup_id()==1){//超管
				list = adPictureManager.getAllScollPicture();
			}
			if(users.getUserGroup_id()==3){//美发店
				list = adPictureManager.getStoreScrollPictureByUid(users.getUsers_id());
			}
			if(users.getUserGroup_id()==2){//代理商
				list = adPictureManager.getAgentScollPictureByUid(users.getUsers_id());
			}
        
        	if(list.size()>0){
        	for(AdPictureVO adPictureVO : list) {
        		AdPicture adPicture = adPictureVO.getAdPicture();
        		Users user = adPictureVO.getUser();
         %>
        	<tr>
        		<td><a target="_blank" href="<%=filePath+adPicture.getAdPicture_path()%>"><%=adPicture.getAdPicture_desc() %></a></td>
        		<td><%=adPicture.getAdPictureCount() %></td>
        		 <%if(groupId<=2){ %>
               <td><%=user.getUsers_email() %>[<%=user.getUsers_name() %>]</td>
               <td><%String groupName =""; switch(user.getUserGroup_id()){case 1:groupName="超级管理员";break;case 3:groupName="美发店";break;case 2:groupName="代理商";break;} %><%=groupName %></td>
               	<%} %>
        		<td>
        		<a href="" title="Delete" onclick="deleteAD(<%=adPicture.getAdPicture_id()%>);return false;"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
                </td>
        	</tr>
          <%
          	}
        	}
           %>
        </tbody>
        <tfoot>
        	<tr>
        		<td colspan="3">
        		  <div class="bulk-actions align-left">
                    <a class="button" href="<%=basePath %><%if(groupId==3){ %>admin/controller/checkUploadPictureAuth?action=add<%}else{ %>admin/ad/scrollPicture_add.jsp<%} %>">增加广告</a> 
                  </div>
                  <div class="pagination"> 
                  </div>
                  <div class="clear"></div>
        		</td>
        	</tr>
        </tfoot>
		</table>	  
	  </div>
	</div>
    <script type="text/javascript">
		function deleteAD(id){
			if(confirm("确定删除？")){
        		location.href="<%=basePath%>admin/controller/deletePicture?type=4&id="+id;
        	}
		};
		
		
    </script>

    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" />
  </div>
</div>
</body>
</html>
