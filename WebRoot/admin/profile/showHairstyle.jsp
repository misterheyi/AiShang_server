<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.MarkHairStyleDAO"%>
<%@page import="com.aishang.db.dao.HairStyleDAO"%>
<%@page import="com.aishang.db.bean.AdVideo"%>
<%@page import="com.aishang.db.dao.AdVideoDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="content-box column-left">
	<div class="content-box-header">
		<h3>平台信息</h3>
	</div>
	<div class="content-box-content">
		<div class="tab-content default-tab">
			<p>
				你上传了<%=(new HairStyleDAO()).getHairStyleCountByUid(((Users) session.getAttribute("USER")).getUsers_id())%>个发型
			</p>
			<p>
				你标记了个<%=(new MarkHairStyleDAO()).getCountByUID(((Users) session.getAttribute("USER")).getUsers_id())%>发型
			</p>
		</div>
	</div>
</div>