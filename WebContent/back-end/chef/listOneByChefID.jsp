<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chef.model.*"%>

<%	
	ChefService chefSvc = new ChefService();
	String chef_ID = request.getParameter("chef_ID");
	ChefVO chefVO = chefSvc.getOneByChefID(chef_ID);
	pageContext.setAttribute("chefVO",chefVO);
%>

<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>List_All_By_Chef_ID.jsp</title>
</head>
<body>
		<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true"/>
		<jsp:include page="/back-end/sideBar/foodSupMana.jsp" flush="true"/>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
<%--=================================工作區================================================--%>

	<%--Error Message--%>
	<% if(chefVO==null){ %>
	<font style="color: red; font-size: 30px;">Error</font>
	<ul>
		<li style="color: red;">查無資料</li>
	</ul>
	<% } %>
	<div class="container justify-content-center">
		<div class="row">
			<div class="col-12">
				<table>
					<tr>
						<th>主廚編號</th>
						<th>主廚狀態</th>
						<th>主廚服務地區</th>
						<th>主廚頻道</th>
						<th style="width:400px;">主廚簡介</th>
						<th>審核主廚</th>
					</tr>
					<tr>
						<td>${chefVO.chef_ID}</td>
						<td>
							<c:if test="${chefVO.chef_status=='b0'}">未審核</c:if>
							<c:if test="${chefVO.chef_status=='b1'}">審核通過</c:if>
							<c:if test="${chefVO.chef_status=='b2'}">審核不過</c:if>
							<c:if test="${chefVO.chef_status=='b3'}">停權</c:if>
						</td>
						<td>${chefVO.chef_area}</td>
						<td>${chefVO.chef_channel}</td>
						<td>${chefVO.chef_resume}</td>
						<td>
							<form method="post"
								action="<%=request.getContextPath()%>/chef/chef.do">
								<input type="submit" value="編輯"> <input type="hidden"
									name="chef_ID" value="${chefVO.chef_ID}"> <input
									type="hidden" name="action" value="getOneForDisplay">
							</form>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

<%--=================================工作區================================================--%>			
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>