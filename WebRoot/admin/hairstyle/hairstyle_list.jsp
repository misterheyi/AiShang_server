<%@page import="com.common.utils.CommonUtils"%>
<%@page import="com.aishang.db.dao.MarkHairStyleDAO"%>
<%@page import="com.aishang.db.bean.MarkHairStyle"%>
<%@page import="com.aishang.db.bean.HairStyle"%>
<%@page import="com.aishang.db.dao.HairStyleDAO"%>
<%@page import="com.aishang.db.bean.Users"%>
<%@page import="com.aishang.db.dao.UsersDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	//filePath = "http://bcs.duapp.com/aishangupload";
%>
<!DOCTYPE html >
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
	.imgCss {
		width: 120px;
		height: 150px;
	}
	td {
		vertical-align:middle;
	}
	.center{
		margin: 0 auto;
	}
</style>
</head>

<body>
<div id="body-wrapper">
  <jsp:include page="../include/sidebar.jsp" ><jsp:param name="selected" value="hairstyle"/></jsp:include>
  <div id="main-content">
	<div class="content-box">
	  <div class="content-box-header">
	  	<h3>发型库</h3>
	    <div class="clear"></div>
	  </div>
	  <div class="content-box-content">
	  	<table>
            <tbody>
            <%
            	Users user = (Users)session.getAttribute("USER");
            	request.setCharacterEncoding("UTF-8");
            	MarkHairStyleDAO markHairStyleDAO = new MarkHairStyleDAO();
            	ArrayList<MarkHairStyle> markHairStyles = markHairStyleDAO.getAllByUid(user.getUsers_id());
            	
            	String area = request.getParameter("area");
            	if(area != null)
            		area = new String(request.getParameter("area").getBytes("iso-8859-1"),"UTF-8");
            	else
            		area = "";
            	String desc = request.getParameter("desc");
            	if(desc == null)
            		desc = "";
            	else
            		desc = new String(desc.getBytes("iso-8859-1"),"UTF-8");
            	String height = request.getParameter("height");
            	if(height == null)
            		height = "";
            	else
            		height = new String(height.getBytes("iso-8859-1"),"UTF-8");
            	String sex = request.getParameter("sex");
            	if(sex == null)
            		sex = "";
            	else
            		sex = new String(sex.getBytes("iso-8859-1"),"UTF-8");
            	String pageNow = request.getParameter("p");

            	if(pageNow == null)
            		pageNow = "1";
            	HairStyleDAO hairStyleDAO = new HairStyleDAO();
            	List<HairStyle> list = new ArrayList<HairStyle>();
            	int rowCuont = 0;
            	switch(user.getUserGroup_id()){
            	case 3: 
            		list = hairStyleDAO.getStoreByGroup_LimitByUid(area, desc, height, sex, Integer.parseInt(pageNow), 20,user.getUsers_id());
            		rowCuont = hairStyleDAO.getStoreHairStyleCountByUid(user.getUsers_id());
            		break;
            	};
            	/**case 4:
        		list = hairStyleDAO.getUserByGroup_LimitByUid(area, desc, height, sex, Integer.parseInt(pageNow), 20,user.getUsers_id());
        		rowCuont = hairStyleDAO.getHairStyleCountByUid(user.getUsers_id());
        		break;
        		case 1:
        		list = hairStyleDAO.getAllByGroup_LimitUid(area, desc, height, sex, Integer.parseInt(pageNow), 20);
        		rowCuont = hairStyleDAO.getHairStyleCount();
        		break;*/
            	
          		int pageCount = (rowCuont - 1)/20 + 1;
          		int pagePre = Integer.parseInt(pageNow)-1 < 1 ? 1 : Integer.parseInt(pageNow)-1;
          		int pageNext = Integer.parseInt(pageNow)+1 > pageCount ? pageCount : Integer.parseInt(pageNow)+1;
            	
				int index = -1;
				if(list.size()>0)
          		for(int i = 0; i < (list.size()-1)/5+1; i++) { 
             %>
            	<tr>
            		<% for(int j = 0; j < 5; j++) {  index++; 
            		HairStyle style = new HairStyle();
            			if(index < list.size()) 
            			 style = list.get(index); 
            		%>
            		<td>
            		<div class="center">
            			<a <%=index < list.size()? "href='"+filePath + style.getHairStyle_path() +"'": ""%> target="_blank">
            			<img src="<%=index < list.size()? filePath + style.getHairStyle_path() : "x.png"%>" class="imgCss"/>
            			</a>
            			<% if(index < list.size() && user.getUserGroup_id() ==4) if(style.getUsers_id() != user.getUsers_id()){
            				if(CommonUtils.searchM(style.getHairStyle_id(), markHairStyles)){
            			 %>
            			  <br>
            			 	<input type="button" onclick="unmark(<%=style.getHairStyle_id() %>)" value="已标记"/>
            			 <% }else {%>
            			 <br>
            				<input type="button" onclick="mark(<%=style.getHairStyle_id() %>)" value="标记"/>
            			<% }} else { %>
            			<br>
            			<input type="button" value="by me" disabled="disabled"/>
            			<% } %>
            			</div>
            		</td>
            		<% } %>
            	</tr>
            <%
            	}
             %>
            	<!-- 
            	<tr>
            		<td><input type="checkbox" style="margin: 0 auto; display:block;"/></td>
            		<td><input type="checkbox" style="margin: 0 auto; display:block;"/></td>
            		<td><input type="checkbox" style="margin: 0 auto; display:block;"/></td>
            		<td><input type="checkbox" style="margin: 0 auto; display:block;"/></td>
            		<td><input type="checkbox" style="margin: 0 auto; display:block;"/></td>
            	</tr>
				 -->
            </tbody>
            <%
            	String[] sexs = {"女性","男性"};
            	String[] areas = {"亚洲","欧洲"};
            	String[] descs = {"活泼可爱","端庄典雅","优雅时尚","新锐个性","盘发扎发"};
            	String[] heights = {"长","中","短"};
             %>
            <tfoot>
            	<tr>
                	<td colspan="8">
                	<div class="bulk-actions align-left">
                	<form action="" method="get">
                    <select name="sex"> 
                    	<option value="">不限</option>
                    	<% for(int i = 0; i < sexs.length; i++){ %>
                    	<option value="<%=sexs[i]%>" <%=sex.equals(sexs[i])?"selected='selected'":"" %> ><%=sexs[i]%></option>
                    	<% } %>
                    </select>
                    <select name="area"> 
                    	<option value="">不限</option>
                    	<% for(int i = 0; i < areas.length; i++){ %>
                    	<option value="<%=areas[i]%>" <%=area.equals(areas[i])?"selected='selected'":"" %>><%=areas[i]%></option>
                    	<% } %>
                    </select>
                    <select name="desc"> 
                    	<option value="">不限</option>
                    	<% for(int i = 0; i < descs.length; i++){ %>
                    	<option value="<%=descs[i]%>" <%=desc.equals(descs[i])?"selected='selected'":"" %>><%=descs[i]%></option>
                    	<% } %>
                    </select>
                    <select name="height"> 
                    	<option value="">不限</option>
                    	<% for(int i = 0; i < heights.length; i++){ %>
                    	<option value="<%=heights[i]%>" <%=height.equals(heights[i])?"selected='selected'":"" %>><%=heights[i]%></option>
                    	<% } %>
                    </select>
                    <input type="submit" value="搜索" class="button">
                    <a href="hairstyle_me.jsp" class="button">我的</a>
                    </form>
                  	</div>
                 	<div class="pagination"> 
                 	<a href="" onclick="p(<%=1 %>);return false;">&laquo; 首页</a>
                 	<a href="" onclick="p(<%=pagePre %>);return false;">&laquo; 上一页</a>
					<%
						int i = Integer.parseInt(pageNow) / 5;
  						if(Integer.parseInt(pageNow) > (i+1)*5)
				  			i+=1;
  						if(Integer.parseInt(pageNow) == i*5)
  							i-=1;
                    	int first = i * 5;
                    	int length = 6;
                    	if(pageCount < 5){
                    		length = pageCount+1;
                    	}
                    	for(int j = 1; j < length; j++){
                    	if((first+j)<=pageCount){
                    %>
                    <a href="" onclick="p(<%=first+j %>);return false;" class='number <%=first+j==Integer.parseInt(pageNow) ? "current":""%>'><%=first+j %></a> 
                    <% 
                    	}}
                    %>
                 	<a href="" onclick="p(<%=pageNext %>);return false;">下一页 &raquo;</a>
                 	<a href="" onclick="p(<%=pageCount %>);return false;">尾页 &raquo;</a> 
                 	</div>
                 	<div class="clear"></div>
                	</td>
                </tr>
            </tfoot>
        </table>
	  </div>
	</div>
<script type="text/javascript">
function post(URL, PARAMS) {        
    var form = document.createElement("form");        
    form.action = URL;        
    form.method = "get";        
    form.style.display = "none";        
    for (var x in PARAMS) {        
        var opt = document.createElement("input");
        opt.setAttribute("name", x) ; 
		opt.setAttribute("value", PARAMS[x]);    
        form.appendChild(opt);        
    }   
    document.body.appendChild(form);        
    form.submit();
};  

	function p(page){
		var selects = document.getElementsByTagName("select");
		var sex = selects[0].options[selects[0].options.selectedIndex].value;
		var area = selects[1].options[selects[1].options.selectedIndex].value;
		var desc = selects[2].options[selects[2].options.selectedIndex].value;
		var height = selects[3].options[selects[3].options.selectedIndex].value;
		post("", {"p":page,"sex" :sex,"area":area,"desc":desc,"height":height});
		return false;
	};
	
	function mark(id){
		if(confirm("确定标记？")){
        		location.href="<%=basePath%>admin/controller/markHairStyle?hid="+id;
        }
	};
	function unmark(id){
		if(confirm("取消标记？")){
        		location.href="<%=basePath%>admin/controller/unmarkHairStyle?hid="+id;
        }
	};
</script>
    <div class="clear"></div>  
    <jsp:include page="../include/footer.jsp" />
  </div>
</div>
</body>
</html>