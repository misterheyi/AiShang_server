<%@page import="com.aishang.db.bean.AdPicture"%>
<%@page import="com.aishang.db.dao.AdPictureDAO"%>
<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	filePath = "http://bcs.duapp.com/aishangupload";
	Users u = (Users)session.getAttribute("USER");
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
  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="picture"/></jsp:include>
  <div id="main-content">
	<%
		String show = request.getParameter("show");
		if(show==null)
			show = "1";
		Users users = (Users)session.getAttribute("USER");
		AdPictureDAO adPictureDAO = new AdPictureDAO();
		List<AdPicture> list = adPictureDAO.getAllByUid(users.getUsers_id());
		List<AdPicture> ad1 = new ArrayList<AdPicture>();
		List<AdPicture> ad2 = new ArrayList<AdPicture>();
		List<AdPicture> ad3 = new ArrayList<AdPicture>();
		//List<AdPicture> ad4 = adPictureDAO.getScollPicture();
		List<AdPicture> ad4 = new ArrayList<AdPicture>();
		for (AdPicture adPicture : list) {
			switch (adPicture.getAdPictureGroup_id()) {
			case 1:
				ad1.add(adPicture);
				break;
			case 2:
				ad2.add(adPicture);
				break;
			case 3:
				ad3.add(adPicture);
				break;
			case 4:
				ad4.add(adPicture);
				break;
			}
		}
	 %>
	<div class="content-box">
	  <div class="content-box-header">
        <h3><%if(u.getUserGroup_id() == 5){ %>滚动广告<%}else{ %>店内推荐<%} %></h3>
        <ul class="content-box-tabs">
          <% if(u.getUserGroup_id() == 3) { %>
          <li><a href="#tab1" class="<%=show.equals("1")?"default-tab" :""%>">店内促销</a></li>
          <li><a href="#tab2" class="<%=show.equals("2")?"default-tab" :""%>">特色商品</a></li>
          <li><a href="#tab3" class="<%=show.equals("3")?"default-tab" :""%>">价目表</a></li>
          <% } if(u.getUserGroup_id() <= 2||u.getUserGroup_id() == 5) { %>
          <li><a href="#tab4" class="<%=show.equals("4")?"default-tab" :""%>">滚动广告</a></li>
          <% } %>
        </ul>
        <div class="clear"></div>
      </div>
      <div class="content-box-content">
        <% if(u.getUserGroup_id() == 3) { %>
        <div class="tab-content <%=show.equals("1")?"default-tab" :""%>" id="tab1">
        <table>
            <tbody>
            <%
            	int index_ad1 = -1;
            	boolean bool_ad1 = false;
            	if(ad1.size() > 0)
            	for(int i = 0; i < (ad1.size()-1)/2+1; i++) {
             %>
				<tr>
					<% index_ad1++; bool_ad1 = index_ad1 < ad1.size(); %>
					<td><img src="<%=bool_ad1 ? filePath+ad1.get(index_ad1).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad1 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad1 ? "deleteAD("+ad1.get(index_ad1).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad1 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
					<% index_ad1++; bool_ad1 = index_ad1 < ad1.size(); %>
					<td><img src="<%=bool_ad1 ? filePath+ad1.get(index_ad1).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad1 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad1 ? "deleteAD("+ad1.get(index_ad1).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad1 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
				</tr>
            <%
            	}
             %>
            </tbody>
            <tfoot>
             <tr>
                <td colspan="4">
                  <div class="bulk-actions align-left">
                    <a class="button" href="adPicture_add.jsp">增加海报</a> 
                  </div>
                 <div class="pagination"> 
                 </div>
                 <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
        </table>
        </div>
        
        <div class="tab-content <%=show.equals("2")?"default-tab" :""%>" id="tab2">
        <table>
            <tbody>
            <%
            	int index_ad2 = -1;
            	boolean bool_ad2 = false;
            	if(ad2.size() > 0)
            	for(int i = 0; i < (ad2.size()-1)/2+1; i++) {
             %>
				<tr>
					<% index_ad2++; bool_ad2 = index_ad2 < ad2.size(); %>
					<td><img src="<%=bool_ad2 ? filePath+ad2.get(index_ad2).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad2 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad2 ? "deleteAD("+ad2.get(index_ad2).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad2 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
					<% index_ad2++; bool_ad2 = index_ad2 < ad2.size(); %>
					<td><img src="<%=bool_ad2 ? filePath+ad2.get(index_ad2).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad2 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad2 ? "deleteAD("+ad2.get(index_ad2).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad2 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
				</tr>
            <%
            	}
             %>
            </tbody>
            <tfoot>
             <tr>
                <td colspan="4">
                  <div class="bulk-actions align-left">
                    <a class="button" href="adPicture_add.jsp">增加海报</a> 
                  </div>
                 <div class="pagination"> 
                 </div>
                 <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
        </table>
        </div>
        
        <div class="tab-content <%=show.equals("3")?"default-tab" :""%>" id="tab3">
        <table>
            <tbody>
            <%
            	int index_ad3 = -1;
            	boolean bool_ad3 = false;
            	if(ad3.size() > 0)
            	for(int i = 0; i < (ad3.size()-1)/2+1; i++) {
             %>
				<tr>
					<% index_ad3++; bool_ad3 = index_ad3 < ad3.size(); %>
					<td><img src="<%=bool_ad3 ? filePath+ad3.get(index_ad3).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad3 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad3 ? "deleteAD("+ad3.get(index_ad3).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad3 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
					<% index_ad3++; bool_ad3 = index_ad3 < ad3.size(); %>
					<td><img src="<%=bool_ad3 ? filePath+ad3.get(index_ad3).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad3 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad3 ? "deleteAD("+ad3.get(index_ad3).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad3 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
				</tr>
            <%
            	}
             %>
            </tbody>
            <tfoot>
             <tr>
                <td colspan="4">
                  <div class="bulk-actions align-left">
                    <a class="button" href="adPicture_add.jsp">增加海报</a> 
                    
                  </div>
                 <div class="pagination"> 
                 </div>
                 <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
        </table>
        </div>
        <% } if(u.getUserGroup_id() <= 2||u.getUserGroup_id() == 5) { %>
        <div class="tab-content <%=show.equals("4")?"default-tab" :""%>" id="tab4">
        <table>
            <tbody>
            <%
            	int index_ad4 = -1;
            	boolean bool_ad4 = false;
            	if(ad4.size() > 0)
            	for(int i = 0; i < (ad4.size()-1)/2+1; i++) {
             %>
				<tr>
					<% index_ad4++; bool_ad4 = index_ad4 < ad4.size(); %>
					<td><img src="<%=bool_ad4 ? filePath+ad4.get(index_ad4).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad4 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad4 ? "deleteAD("+ad4.get(index_ad4).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad4 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
					<% index_ad4++; bool_ad4 = index_ad4 < ad4.size(); %>
					<td><img src="<%=bool_ad4 ? filePath+ad4.get(index_ad4).getAdPicture_path() :"temp.png" %>" class="banner"/></td>
					<td><a <%=bool_ad4 ? "href=\"xx\"":"" %> title="Delete" onclick="<%=bool_ad4 ? "deleteAD("+ad4.get(index_ad4).getAdPicture_id()+");return false;":""%>"><img src="<%=bool_ad4 ? "../../resources/images/icons/cross.png" :"temp2.png" %>" alt="Delete" /></a> </td>
				</tr>
            <%
            	}
             %>
            </tbody>
            <tfoot>
             <tr>
                <td colspan="4">
                  <div class="bulk-actions align-left">
                    <a class="button" href="adPicture_add.jsp">增加广告</a> 
                    
                  </div>
                 <div class="pagination"> 
                 </div>
                 <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
        </table>
        </div>
        <% } %>
        
      </div>
	</div>
    <script type="text/javascript">
		function deleteAD(id){
			if(confirm("确定删除？")){
        		location.href="<%=basePath%>admin/controller/deletePicture?id="+id;
        	}
		};
		
		
    </script>

    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" />
  </div>
</div>
</body>
</html>
