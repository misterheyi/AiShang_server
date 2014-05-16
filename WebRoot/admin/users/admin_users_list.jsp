<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aishang.vo.TreeUsersVO"%>
<%@page import="com.aishang.manager.UsersManager"%>
<%@page import="java.net.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>爱尚网-后台管理</title>
<link rel="stylesheet" href="../../resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../../resources/css/jquery.treetable.css" type="text/css" media="screen" />
<script type="text/javascript" src="../../resources/scripts/jquery.js"></script>
<script type="text/javascript" src="../../resources/scripts/jquery.treetable.js"></script>
<style type="text/css">
	td {
		vertical-align:middle;
	}
	table.treetable tr.expanded span.indenter a {
		background-image: url(../../resources/images/menu_minus.gif);
	}
	table.treetable tr.collapsed span.indenter a {
		background-image: url(../../resources/images/menu_plus.gif);
	}
</style>
</head>

<body>
<div id="body-wrapper">

  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="users"/></jsp:include>

<%
 	Users users = (Users)session.getAttribute("USER");
	
	String key_word = request.getParameter("key_word");
	
	
    int id = users.getUserGroup_id();
	UsersDAO usersDAO = new UsersDAO();
	
	int rowCuont = 10;
	//查询超管和代理商
	if(null!=key_word&&!"".equals(key_word)){
		
	}else{
		rowCuont = usersDAO.getManagerAndStoreCount();
		key_word = "";
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
	
	List<TreeUsersVO> list = null;
	UsersManager usersManager = new UsersManager();
	boolean isSearch = false;
	if(null!=key_word&&!"".equals(key_word)){
		//key_word = new String (key_word.getBytes("iso-8859-1"),"utf-8");
		key_word = URLDecoder.decode(key_word,"utf-8");
		list = usersManager.getManagerAndStoreByPageCount(key_word);
		rowCuont = list.size();
		isSearch = true;
	}else{
		list = usersManager.getManagerAndStoreByPageCount(pageNow, pageSize);	
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
          <table id="users_tree">

            <thead>
              <tr>
                <th>编号</th>
                <%if(id <=2){ %>
                <th>用户组</th>
                <%} %>
                <th>昵称</th>
                <th>邮箱</th>
                <th>操作</th>
              </tr>
            </thead>

            <tbody>  
<%
	if(rowCuont>0){
	for(TreeUsersVO treeUsersVO : list) {
		Users u1 = treeUsersVO.getParent();
			String group = "";switch(u1.getUserGroup_id()){case 1:group="超级管理员";break;case 2:group="代理商";break;case 3:group="美发店";break;case 4:group="发型师";break;}
			if(isSearch){
				u1.setUsers_name(u1.getUsers_name().replace(key_word, "<span style='color:#FFF;background:red;font-weight: bold;'>"+key_word+"<span>"));
				u1.setUsers_email(u1.getUsers_email().replace(key_word, "<span style='color:#FFF;background:red;font-weight: bold;'>"+key_word+"<span>"));
			}
 %>
              <tr data-tt-id="<%=u1.getUsers_id() %>">
                <td><%=u1.getUsers_id() %></td>
                <%if(id <=2){ %>
                <td>[<%=group %>]</td>
                <%} %>
                <td><%=u1.getUsers_name()%></td>
                <td><%=u1.getUsers_email()%></td>
                <td>
                  <a href="users_modify.jsp?uid=<%=u1.getUsers_id() %>" title="修改"><img src="../../resources/images/icons/pencil.png" alt="Edit" /></a> 
                  <a href="" onclick="deleteUser(<%=u1.getUsers_id()%>);return false;" title="删除"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
                </td>
              </tr>
<%
		List<TreeUsersVO> chiList = treeUsersVO.getChilds();
		if(chiList.size()>0){
				for(TreeUsersVO treeUsersVO2 : chiList) {
					Users u2 = treeUsersVO2.getParent();
						group = "";switch(u2.getUserGroup_id()){case 1:group="超级管理员";break;case 2:group="代理商";break;case 3:group="美发店";break;case 4:group="发型师";break;}
						if(isSearch){
							u2.setUsers_name(u2.getUsers_name().replace(key_word, "<span style='color:#FFF;background:red;font-weight: bold;'>"+key_word+"<span>"));
							u2.setUsers_email(u2.getUsers_email().replace(key_word, "<span style='color:#FFF;background:red;font-weight: bold;'>"+key_word+"<span>"));
						}
			 %>
			              <tr data-tt-id="<%=u2.getUsers_id() %>" data-tt-parent-id="<%=u1.getUsers_id()%>">
			                <td><%=u2.getUsers_id() %></td>
			                <%if(id <=2){ %>
			                <td>[<%=group %>]</td>
			                <%} %>
			                <td><%=u2.getUsers_name()%></td>
               				<td><%=u2.getUsers_email()%></td>
			                <td>
			                  <a href="users_modify.jsp?uid=<%=u2.getUsers_id() %>" title="修改"><img src="../../resources/images/icons/pencil.png" alt="Edit" /></a> 
			                  <a href="" onclick="deleteUser(<%=u2.getUsers_id()%>);return false;" title="删除"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
			                </td>
			              </tr>
			<%
					List<TreeUsersVO> subChiList = treeUsersVO2.getChilds();
					if(subChiList.size()>0){
						for(TreeUsersVO treeUsersVO3 : subChiList) {
							Users u3 = treeUsersVO3.getParent();
								group = "";switch(u3.getUserGroup_id()){case 1:group="超级管理员";break;case 2:group="代理商";break;case 3:group="美发店";break;case 4:group="发型师";break;}
								if(isSearch){
									u3.setUsers_name(u3.getUsers_name().replace(key_word, "<span style='color:#FFF;background:red;font-weight: bold;'>"+key_word+"<span>"));
									u3.setUsers_email(u3.getUsers_email().replace(key_word, "<span style='color:#FFF;background:red;font-weight: bold;'>"+key_word+"<span>"));
								}
					 %>
					              <tr data-tt-id="<%=u3.getUsers_id() %>" data-tt-parent-id="<%=u2.getUsers_id() %>">
					                <td><%=u3.getUsers_id() %></td>
					                <%if(id <=2){ %>
					                <td>[<%=group %>]</td>
					                <%} %>
					                <td><%=u3.getUsers_name()%></td>
               						<td><%=u3.getUsers_email()%></td>
					                <td>
					                  <a href="users_modify.jsp?uid=<%=u3.getUsers_id() %>" title="修改"><img src="../../resources/images/icons/pencil.png" alt="Edit" /></a> 
					                  <a href="" onclick="deleteUser(<%=u3.getUsers_id()%>);return false;" title="删除"><img src="../../resources/images/icons/cross.png" alt="Delete" /></a> 
					                </td>
					              </tr>
					<%
						}
					}
				}
		}
	}
	}
 %>
            </tbody>
 			<tfoot>
              <tr>
                <td colspan="6">
                  <div class="bulk-actions align-left" style="width:600px;">
                  <form action="">
                  <input class="text-input small-input" type="text" name="users_key_word" id="users_key_word" value="<%=key_word %>"/>
        		  <input type="button" value="搜索" class="button" onclick="search()"/>
        		  <a class="button" href="users_addAgent.jsp">增加代理商</a>
        		  </form>
                  </div>
                  <div class="pagination">
                  	<a href="admin_users_list.jsp" title="First Page">&laquo; 首页</a>
                  	<a href="admin_users_list.jsp?p=<%=pagePre %>" title="Previous Page">&laquo; 上一页</a> 
                    <%
                    	int first = i * 5;
                    	int length = 6;
                    	if(pageCount < 5){
                    		length = pageCount+1;
                    	}
                    	for(int j = 1; j < length; j++){
                    	if((first+j)<=pageCount){
                    %>
                    <a href="admin_users_list.jsp?p=<%=first+j %>" class='number <%=first+j==pageNow ? "current":""%>'><%=first+j %></a> 
                    <% 
                    	}}
                    %>
                  	<a href="admin_users_list.jsp?p=<%=pageNext %>" title="Next Page">下一页 &raquo;</a>
                  	<a href="admin_users_list.jsp?p=<%=pageCount %>" title="Last Page">尾页 &raquo;</a> 
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
		function search(){
			var users_key_word = document.getElementById('users_key_word').value;
			if(users_key_word.length>0){
				window.location.href = "<%=basePath%>admin/users/admin_users_list.jsp?key_word="+encodeURI(encodeURI(users_key_word));
			}else{
				window.location.reload(true); 
			}
		}
		<%if(!"".equals(key_word)){%>
		$("#users_tree").treetable({ expandable: true });
		$("#users_tree").treetable("expandAll");
		<%}else{%>
		$("#users_tree").treetable({ expandable: true });
		<%}%>
		
    </script>
    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" /> 
  </div>
  <!-- End #main-content -->
</div>
</body>
</html>
