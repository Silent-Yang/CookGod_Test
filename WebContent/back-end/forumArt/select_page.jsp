<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Dish: Home</title>

<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: #FFFFFF;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
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

				<table id="table-1">
					<tr>
						<td><h3>IBM Dish: Home</h3>
							<h4>( MVC )</h4></td>
					</tr>
				</table>

				<p>This is the Home page for IBM Dish: Home</p>

				<h6>查詢:</h6>

				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

				<ul>
					<li><a href='listAllForumArt.jsp'>所有文章</a><br>
					<br></li>
					<li><a href='listAllForumArt_ByForumMsg.jsp'>所有留言</a><br>
					<br></li>
				</ul>
				<h6>新增</h6>

				<ul>
					<li><a href='addForumArt.jsp'>新增文章</a></li>
				</ul>
				<ul>
					<li><a
						href="<%=request.getContextPath() %>/back-end/forumMsg/addForumMsg.jsp">新增文章留言</a>
					</li>
				</ul>




				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>