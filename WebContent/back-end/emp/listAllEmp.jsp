<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.emp.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	EmpService empSvc = new EmpService();
	List<EmpVO> list = empSvc.getAll();
	;
	pageContext.setAttribute("list", list);
%>


<!DOCTYPE html>
<html>
<head>
<title>所有員工資料 - listAllEmp.jsp</title>



<style>
table {
	width: 500px;
	background-color: white;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 10px;
	text-align: center;
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




				<h4>此頁練習採用 EL 的寫法取值:</h4>
				<table id="table-1">
					<tr>
						<td>
							<h3>所有員工資料 - listAllEmp.jsp</h3>
							<h4>
								<a
									href="<%=request.getContextPath()%>/back-end/emp/select_page.jsp">回首頁</a>
							</h4>
						</td>
					</tr>
				</table>

				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

				<table>
					<tr>
						<th>員工編號</th>
						<th>員工帳號</th>
						<th>員工密碼</th>
						<th>員工姓名</th>
						<th>大頭照</th>


					</tr>
					<%@ include file="/file/page1.file"%>
					<c:forEach var="empVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">

						<tr>
							<td>${empVO.emp_ID}</td>
							<td>${empVO.emp_acc}</td>
							<td>${empVO.emp_pwd}</td>
							<td>${empVO.emp_name}</td>

							<td><c:if test="${not empty empVO.emp_pic}">
									<img
										src="<%=request.getContextPath()%>/emp/emp.do?emp_ID=${empVO.emp_ID}">
								</c:if> <c:if test="${empty empVO.emp_pic}">
									<img src="<%=request.getContextPath()%>/images/null2.jpg">
								</c:if></td>


							<td>
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/emp/emp.do"
									style="margin-bottom: 0px;">
									<input type="submit" value="修改"> <input type="hidden"
										name="emp_ID" value="${empVO.emp_ID}"> <input
										type="hidden" name="action" value="getOne_For_Update">
								</FORM>
							</td>
							<td>
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/emp/emp.do"
									style="margin-bottom: 0px;">
									<input type="submit" value="刪除"> <input type="hidden"
										name="emp_ID" value="${empVO.emp_ID}"> <input
										type="hidden" name="action" value="delete">
								</FORM>
							</td>
						</tr>
					</c:forEach>
				</table>
				<%@ include file="/file/page2.file"%>
				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>