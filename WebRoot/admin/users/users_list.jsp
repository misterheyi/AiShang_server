<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	filePath = "http://bcs.duapp.com/aishangupload";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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
	td {
		vertical-align:middle;
	}
</style>
</head>

<body>
<div id="body-wrapper">

  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="users"/></jsp:include>

<%
 	Users users = (Users)session.getAttribute("USER");
    int id = users.getUserGroup_id();
	UsersDAO usersDAO = new UsersDAO();
	
	int rowCuont = 10;
	if(id == 1) {
		rowCuont = usersDAO.getManagerAndStoreCount();
	}
	if(id == 2) {
		rowCuont = usersDAO.getStoreCount();
	}
	if(id == 3) {
		rowCuont = usersDAO.getHairStylistCountByMyStore(users.getUsers_id());
	}
	if(id == 5) {
		rowCuont = usersDAO.getStoreCount(users.getUsers_id());
	}
	
  	int pageSize = 10;
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
	
	ArrayList<Users> list = null;
	if(id == 1) {
		list = usersDAO.getManagerAndStoreByPageCount(pageNow, pageSize);
	}
	if(id == 2) {
		list = usersDAO.getStoreByPageCount(pageNow, pageSize);
	}
	if(id == 3) {
		list = usersDAO.getHairStylistByPageCount(users.getUsers_id(), pageNow, pageSize);
	}
	if(id == 5) {
		list = usersDAO.getHairStylistByPageCount(users.getUsers_id(), pageNow, pageSize);
	}
 %>

  <div id="main-content">
      <div class="content-box">
      <!-- Start Content Box -->
      <div class="content-box-header">
        <h3>用户</h3>
        <div class="clear"></div>
      </div>
      <!-- End .content-box-header -->
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab1">
          <table>

            <thead>
              <tr>
                <th>编号</th>
                <th>用户组</th>
				<% if(id == 3){ %>
				<th>头像</th>
                <% } %>
                <th>昵称</th>
                <th>邮箱</th>
                <th>IMEI</th>
                <th>操作</th>
              </tr>
            </thead>

            <tbody>  
<%
	if(rowCuont>0){
	for(Users u : list) {
 %>
              <tr>
                <td><%=u.getUsers_id() %></td>
                <td><%String group = "";switch(u.getUserGroup_id()){case 1:group="超级管理员";break;case 2:group="工作人员";break;case 3:group="美发店";break;case 4:group="发型师";break;case 5:group="代理商";break;} %>[<%=group %>]</td>
                <% if(id == 3){ %>
                <td><img src="<%=u.getUsers_face().equals("null") ? basePath+"resources/images/user_default.png" : filePath+u.getUsers_face() %>" style="width: 40px;height: 40px"/></td>
                <% } %>
                <td><%=u.getUsers_name() %></td>
                <td><%=u.getUsers_email() %></td>
                <td><%=u.getUsers_IMEI() %></td>
                <td>
                <% if(id == 3){ %>
                  <a href="users_modify_face.jsp?uid=<%=u.getUsers_id() %>" title="修改头像"><img src="../../resources/images/icons/image_add_48.png" alt="Edit"  style="width: 18px;height: 18px"/></a> 
                <% } %>
                  <a href="users_modify.jsp?uid=<%=u.getUsers_id() %>" title="修改"><img src="../../resources/images/icons/pencil.png" alt="Edit" /></a> 
                  <a href="" onclick="deleteUser(<%=u.getUsers_id()%>);return false;" title="删除"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
                </td>
              </tr>
<%
	}
	}
 %>
            </tbody>
 			<tfoot>
              <tr>
                <td colspan="6">
                  <div class="bulk-actions align-left">
                  <%
                  if(id == 1){
                   %>
                   	<!-- <a class="button" href="users_addManager.jsp">增加工作人员</a> -->
                  <%
                  	}
                  	if(id == 1 || id == 2){
                   %>
                    <!-- <a class="button" href="users_addStore.jsp">增加美发店</a> -->
                    <a class="button" href="users_addAgent.jsp">增加代理商</a>
                  <%
                  	}
                  	if(id == 3){
                   %>
                    <a class="button" href="users_addHairStylist.jsp">增加发型师</a>
                    <% }
                  	if(id == 5){
                   %>
                    <a class="button" href="users_addStore2.jsp">增加美发店</a>
                    <% }%>
                  </div>
                  <div class="pagination">
                  	<a href="users_list.jsp" title="First Page">&laquo; 首页</a>
                  	<a href="users_list.jsp?p=<%=pagePre %>" title="Previous Page">&laquo; 上一页</a> 
                    <%
                    	int first = i * 5;
                    	int length = 6;
                    	if(pageCount < 5){
                    		length = pageCount+1;
                    	}
                    	for(int j = 1; j < length; j++){
                    	if((first+j)<=pageCount){
                    %>
                    <a href="users_list.jsp?p=<%=first+j %>" class='number <%=first+j==pageNow ? "current":""%>'><%=first+j %></a> 
                    <% 
                    	}}
                    %>
                  	<a href="users_list.jsp?p=<%=pageNext %>" title="Next Page">下一页 &raquo;</a>
                  	<a href="users_list.jsp?p=<%=pageCount %>" title="Last Page">尾页 &raquo;</a> 
                  </div>
                  <!-- End .pagination -->
                  <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    <!-- End .content-box -->
    </div>
    <script type="text/javascript">
		function deleteUser(id){
			if(confirm("确定删除？")){
        		location.href="<%=basePath%>admin/controller/deleteUser?uid="+id;
        	}
		};
    </script>
    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" /> 
  </div>
  <!-- End #main-content -->
</div>
</body>
</html>
