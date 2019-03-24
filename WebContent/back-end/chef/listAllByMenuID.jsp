<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chef.model.*"%>

<%	
	ChefService chefSvc = new ChefService();
	String menu_ID = request.getParameter("menu_ID");
	List<ChefVO> list = chefSvc.getAllByMenuID(menu_ID);
	pageContext.setAttribute("list",list);
%>

<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
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
	<c:if test="${not empty errorMsgs}">
		<font style="color: red; font-size: 30px;">Error</font>
		<ul>
			<c:forEach var="errMsgs" items="${errorMsgs}">
				<li style="color: red;">${errMsgs}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="container justify-content-center">
		<div class="row">
			<div class="col-12">
				<table>
					<tr>
						<th>主廚編號</th>
						<th>主廚服務地區</th>
						<th style="width:400px;">主廚簡介</th>
						<th>審核主廚</th>
					</tr>
					<%@ include file="page1.file"%>
					<c:forEach var="chefVO" items="${list}" begin="<%=pageIndex %>"
						end="<%=pageIndex+rowsPerPage-1 %>">
						<tr>
							<td>${chefVO.chef_ID}</td>
							<td>${chefLocal[chefVO.chef_area]}</td>
							<td>${chefVO.chef_resume}</td>
							<td>
								<form method="post"
									action="<%=request.getContextPath()%>/chef/chef.do">
									<input type="submit" value="編輯"> 
									<input type="hidden" name="chef_ID" value="${chefVO.chef_ID}"> 
									<input type="hidden" name="action" value="getOneForDisplay">
								</form>
							</td>
						</tr>
					</c:forEach>
				</table>
				<%@ include file="page2.file"%>
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