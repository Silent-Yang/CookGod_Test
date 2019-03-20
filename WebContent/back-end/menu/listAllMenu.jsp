<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menu.model.*"%>

<%
	MenuService menuSvc = new MenuService();
	List<MenuVO> list = menuSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>List_All_Menu</title>
<style type="text/css">
table {
	border: 2px solid gray;
	margin: 15px;
}

th, td {
	border: 1px solid;
	width: 100px;
	height: 50px;
	text-align: center;
	padding: 3px;
}

.menu_pic {
	width: 200px;
	height: 150px;
}
</style>
</head>
<body>
	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true" />
		<aside class="left-sidebar" data-sidebarbg="skin5">
			<%--==============<jsp:include page="/back-end/XXXX/sidebar.jsp" flush="true" />=================================--%>

		</aside>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<%--=================================工作區================================================--%>
				<%--Error Message--%>
				<c:if test="${not empty errorMsgs} }">
					<font style="color: red; font-size: 30px;">Error</font>
					<ul>
						<c:forEach var="errMsgs" items="${errorMsgs}">
							<li style="color: red;">${errMsgs}</li>
						</c:forEach>
					</ul>
				</c:if>
				<table>
					<tr>
						<th>套餐編號</th>
						<th>套餐照片</th>
						<th>套餐名稱</th>
						<th>套餐介紹</th>
						<th>套餐價錢</th>
						<th>套餐狀態</th>
						<th>編輯喜愛食材供應商</th>
						<th>刪除喜愛食材供應商</th>
					</tr>
					<%@ include file="page1.file"%>
					<c:forEach var="menuVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">
						<tr>
							<td>${menuVO.menu_ID}</td>
			
							<td><c:if test="${not empty menuVO.menu_pic}">
									<img class="menu_pic" src="<%=request.getContextPath()%>/menu/menu.do?showMenuPic=showMenuPic&menu_ID=${menuVO.menu_ID}">
								</c:if> 
								<c:if test="${empty menuVO.menu_pic}">
									<img class="menu_pic" src="<%=request.getContextPath()%>/images/noimage.jpg">
								</c:if>
							</td>
							<td>${menuVO.menu_name}</td>
							<td>${menuVO.menu_resume}</td>
							<td>${menuVO.menu_price}</td>
							<td><c:if test="${menuVO.menu_status=='m0'}">上架</c:if>
								<c:if test="${menuVO.menu_status=='m1'}">下架</c:if>
							</td>
							<td>
							<form method="post"
								action="<%=request.getContextPath()%>/menu/menu.do">
								<input type="submit" value="編輯"> 
								<input type="hidden" name="menu_ID" value="${menuVO.menu_ID}"> 
								<input type="hidden" name="action" value="getOneForUpdate">
							</form>
						</td>
						<td>
							<form method="post"
								action="<%=request.getContextPath()%>/menu/menu.do">
								<input type="submit" value="刪除"> 
								<input type="hidden" name="menu_ID" value="${menuVO.menu_ID}"> 
								<input type="hidden" name="action" value="delete">
							</form>
						</td>
						</tr>
					</c:forEach>
				</table>
				<%@ include file="page2.file"%>

				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>