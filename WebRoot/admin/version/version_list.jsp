<%@page import="com.aishang.db.bean.Version"%>
<%@page import="com.aishang.db.dao.VersionDAO"%>
<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	filePath = "http://bcs.duapp.com/aishangupload";
%>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>爱尚网-后台管理</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/scripts/jquery.wysiwyg.js"></script>
</head>
<body>
<div id="body-wrapper">
  	<jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="version"/></jsp:include>
	<div id="main-content">
	<div class="content-box">
	  <div class="content-box-header">
		<h3>版本管理</h3>
		</div>
    <div class="content-box-content">
	    <table>
	  	<thead>
              <tr>
                <th>版本</th>
                <th>操作</th>
              </tr>
        </thead>
        <tbody>
        <%
        	VersionDAO dao = new VersionDAO();
        	List<Version> list = dao.getAll();
        	for(Version adVideo : list) {
         %>
        	<tr>
        		<td><%=adVideo.getVersion() %></td>
        		<td>
        		<a href="" title="Delete" onclick="deleteAD(<%=adVideo.getAd_id()%>);return false;">删除</a> |  
        		<a target="_blank" href="<%=filePath+adVideo.getPath() %>"  title="Delete" >下载</a> 
                </td>
        	</tr>
          <%
          	}
           %>
        </tbody>
        <tfoot>
        	<tr>
        		<td colspan="3">
        		  <div class="bulk-actions align-left">
                    <a class="button" href="version_add.jsp">增加版本</a> 
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
</div>
</body>
</html>