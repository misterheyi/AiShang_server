<%@page import="com.aishang.db.dao.AdVideoDAO"%>
<%@page import="com.aishang.db.bean.AdVideo"%>
<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aishang.manager.AdVideoManager"%>
<%@page import="com.aishang.vo.AdVideoVO"%>
<%@page import="com.aishang.db.bean.UploadAuth"%>
<%@page import="com.aishang.db.dao.UploadAuthDao"%>
<%@page import="com.aishang.exception.MyException"%>
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
</head>

<body>
<div id="body-wrapper">
  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="video"/></jsp:include>
  <div id="main-content">
	<div class="content-box">
	  <div class="content-box-header">
	  	<h3>视频广告</h3>
	  </div>
	  <div class="content-box-content">
	    <table>
	  	<thead>
              <tr>
                <th>名称</th>
                <th>类型</th>
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
        	AdVideoManager adVideoManager = new AdVideoManager();
        	List<AdVideoVO> list = new ArrayList<AdVideoVO>();
        	//超管
        	if(users.getUserGroup_id()==1){
        		list = adVideoManager.getAll();        		
        	}
        	//代理商
        	if(users.getUserGroup_id()==2){
        		list = adVideoManager.getAgentVideoByUid(users.getUsers_id());
        	}
        	//美发店
        	if(users.getUserGroup_id()==3){
        		list = adVideoManager.getStoreVideoByUid(users.getUsers_id());
        	}
        	
        	if(list.size()>0){
        	for(AdVideoVO adVideoVO : list) {
        		AdVideo adVideo = adVideoVO.getAdVideo();
        		Users user = adVideoVO.getUser();
         %>
        	<tr>
        		<td><a target="_blank" href="<%=filePath+adVideo.getAdVideo_path()%>"><%=adVideo.getAdVideo_desc() %></a></td>
        		<td><%=adVideo.getAdVideo_type() == 0 ? "待机视频":"点选视频" %></td>
        		<td><%=adVideo.getAdVideo_count() %></td>
        		 <%if(groupId<=2){ %>
               <td><%=user.getUsers_email() %>[<%=user.getUsers_name() %>]</td>
               <td><%String groupName =""; switch(user.getUserGroup_id()){case 1:groupName="超级管理员";break;case 3:groupName="美发店";break;case 2:groupName="代理商";break;} %><%=groupName %></td>
               	<%} %>
        		<td>
        		<a href="" title="Delete" onclick="deleteAD(<%=adVideo.getAdVideo_id()%>);return false;"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
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
                    <a class="button" href="<%=basePath %><%if(groupId==3){ %>admin/controller/checkUploadVideoAuth?action=add<%}else{ %>admin/ad/adVideo_add.jsp<%} %>">增加广告</a> 
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
    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" />
  </div>
    <script type="text/javascript">
		function deleteAD(id){
			if(confirm("确定删除？")){
        		location.href="<%=basePath%>admin/controller/deleteVideo?id="+id;
        	}
		};
    </script>

</div>

</body>
</html>
