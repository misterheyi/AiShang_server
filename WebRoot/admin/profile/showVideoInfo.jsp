<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@page import="com.aishang.db.bean.AdVideo"%>
<%@page import="com.aishang.db.dao.AdVideoDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
%>
<div class="content-box column-right">
	<div class="content-box-header">
		<h3>视频广告</h3>
	</div>
	<div class="content-box-content">
	<div class="tab-content default-tab">
		<table>
			<thead><tr><th>名称</th><th>类型</th><th>观看数</th><th>下载</th></tr></thead>		
			<%
				AdVideoDAO adVideoDAO = new AdVideoDAO();
				List<AdVideo> list = adVideoDAO.getAll();
			 %>
			<tbody>
				<% for(AdVideo video : list) { %>
				<tr>
					<th><%=video.getAdVideo_desc() %></th>
					<td><%=video.getAdVideo_type() == 0 ? "待机视频":"点选视频" %></td>
					<th><%=video.getAdVideo_count() %></th>
					<th><a href="<%=filePath+video.getAdVideo_path()%>" class="button" target="_blank">下载</a></th>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
    </div>
</div>

<div class="content-box column-left">
	<div class="content-box-header">
		<h3>平台信息</h3>
	</div>
	<div class="content-box-content">
	<div class="tab-content default-tab">
		<p>拥有<%=(new UsersDAO()).getStoreCount() %>家美发店</p>
		<p>拥有<%=(new UsersDAO()).getAgentCount() %>个代理商</p>
	</div>
	</div>
</div>