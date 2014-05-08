<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<div class="content-box column-left">
	<div class="content-box-header">
		<h3>平台信息</h3>
	</div>
	<div class="content-box-content">
	<div class="tab-content default-tab">
	<%
	Users users = (Users)session.getAttribute("USER");
	%>
		<p>拥有<%=(new UsersDAO()).getStoreCount(users.getUsers_id()) %>家美发店</p>
		<p>拥有<%=(new UsersDAO()).getHairStylistCountByAgent(users.getUsers_id()) %>个发型师</p>
	</div>
	</div>
</div>