<%@page import="com.aishang.db.bean.HairStyle"%>
<%@page import="com.aishang.db.dao.HairStyleDAO"%>
<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aishang.vo.HairStyleVO"%>
<%@page import="com.aishang.manager.HairStyleManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
%>
<!DOCTYPE html>
<%@page import="com.aishang.db.bean.Users"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的发型库 | 爱尚网-后台管理</title>
<link rel="stylesheet" href="../../resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="../../resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../../resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="../../resources/scripts/jquery.wysiwyg.js"></script>
<style type="text/css">
	.imgCss {
		width: 45px;
		height: 60px;
	}
	td {
		vertical-align:middle;
	}
</style>
</head>

<body>
<div id="body-wrapper">
  	<jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="hairstyle"/></jsp:include>
	<div id="main-content">
      <div class="content-box">
	  <div class="content-box-header">
	  	<h3>我的发型库</h3>
	    <div class="clear"></div>
	  </div>
	  <%
	  	Users users = (Users)session.getAttribute("USER");
	    int groupId = users.getUserGroup_id();
	  	HairStyleDAO dao = new HairStyleDAO();
	  	int rowCuont = 0;
	  	if(users.getUserGroup_id()==1){
	  		rowCuont = dao.getHairStyleCount();
	  	}
	  	
	  	if(users.getUserGroup_id()==3){
	  		rowCuont = dao.getStoreHairStyleCountByUid(users.getUsers_id());//美发店
	  	}
	  	
	  	if(users.getUserGroup_id()==4){
	  		rowCuont = dao.getHairStyleCountByUid(users.getUsers_id());//发型师
	  	}
	  	
	  	int pageSize = 5;
  		int pageCount = (rowCuont - 1)/pageSize + 1;
  		String pageN = request.getParameter("p");
  		if(pageN == null)
  			pageN = "1";
  		int pageNow = Integer.parseInt(pageN);
  		int pageNext = pageNow+1 > pageCount ? pageCount : pageNow+1;
  		int pagePre = pageNow-1 < 1 ? 1 : pageNow-1;
  		
  		int i = pageNow / 5;
	  	if(pageNow > (i+1)*5)
  		i+=1;
  		if(pageNow == i*5)
  		i-=1;
  		
  		List<HairStyleVO> list = new ArrayList<HairStyleVO>();
  		HairStyleManager hairStyleManager = new HairStyleManager();
  		if(users.getUserGroup_id()==1){
  			list = hairStyleManager.getAllByLimit(pageNow, pageSize);
	  	}
  		if(users.getUserGroup_id()==3){
  			list = hairStyleManager.getStoreByLimit(users.getUsers_id(),pageNow, pageSize);
	  	}
  		if(users.getUserGroup_id()==4){
	  		list = hairStyleManager.getAllByUID_Limit(users.getUsers_id(), pageNow, pageSize);
	  	}
	   %>
	  <div class="content-box-content">
	  	<table>
	  		<thead>
	  			<tr>
	  				<td>预览</td>
	  				<td>地区</td>
	  				<td>性别</td>
	  				<td>类型</td>
	  				<td>发长</td>
	  				<%if(groupId==1){ %>
	               <td>上传者</td>
	               <td>用户组</td>
	               	<%} %>
	  				<td>操作</td>
	  			</tr>
	  		</thead>
            <tbody>
            	<%
            		for(int j = 0; j < list.size(); j++) { 
            			HairStyle hairStyle = list.get(j).getHairStyle();
            			Users user = list.get(j).getUser();
            	%>
            	<tr>
            		<td>
            			<a href="<%=filePath+hairStyle.getHairStyle_path() %>" target="_blank">
            			<img src="<%=filePath+hairStyle.getHairStyle_path() %>" class="imgCss">
            			</a>
            		</td>
            		<td><%=hairStyle.getHairStyle_area() %></td>
            		<td><%=hairStyle.getHairStyle_sex() %></td>
            		<td><%=hairStyle.getHairStyle_desc() %></td>
            		<td><%=hairStyle.getHairStyle_height() %></td>
            		<%if(groupId==1){ %>
	               <td><%=user.getUsers_email() %>[<%=user.getUsers_name() %>]</td>
	               <td><%String groupName =""; switch(user.getUserGroup_id()){case 1:groupName="超级管理员";break;case 3:groupName="美发店";break;case 4:groupName="发型师";break;} %><%=groupName %></td>
	               	<%} %>
            		<td>
            		<a href="hairstyle_modify.jsp" title="Edit"><img src="../../resources/images/icons/pencil.png" alt="Edit" /></a> 
                  	<a href="" title="Delete" onclick="deleteHS(<%=hairStyle.getHairStyle_id()%>);return false;"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
                	</td>
                	
            	</tr>
            	<% } %>
            </tbody>
            <tfoot>
            	<tr>
                <td colspan="8">
                <div class="bulk-actions align-left">
              	  <a href="hairstyle_add.jsp" class="button">增加</a>
              	  <% if(users.getUserGroup_id() ==4) {%>
              	  <a href="hairstyle_mark.jsp" class="button">查看我标记的发型</a>
              	  <% } %>
                </div>
                <div class="pagination">
                  	<a href="hairstyle_me.jsp" title="First Page">&laquo; 首页</a>
                  	<a href="hairstyle_me.jsp?p=<%=pagePre %>" title="Previous Page">&laquo; 上一页</a> 
                    <%
                    	int first = i * 5;
                    	int length = 6;
                    	if(pageCount < 5){
                    		length = pageCount+1;
                    	}
                    	for(int j = 1; j < length; j++){
                    	if((first+j)<=pageCount){
                    %>
                    <a href="hairstyle_me.jsp?p=<%=first+j %>" class='number <%=first+j==pageNow ? "current":""%>'><%=first+j %></a> 
                    <% 
                    	}}
                    %>
                  	<a href="hairstyle_me.jsp?p=<%=pageNext %>" title="Next Page">下一页 &raquo;</a>
                  	<a href="hairstyle_me.jsp?p=<%=pageCount %>" title="Last Page">尾页 &raquo;</a> 
                </div>
                </td>
                </tr>
            </tfoot>
        </table>
	  </div>
<script type="text/javascript">
		function deleteHS(id){
			if(confirm("确定删除？")){
        		location.href="<%=basePath%>admin/controller/deleteHairStyle?id="+id;
        	}
		};
</script>
	</div>
	<div class="clear"></div>  
	<jsp:include page="../include/footer.jsp" />    
	</div>
</div>

</body>
</html>