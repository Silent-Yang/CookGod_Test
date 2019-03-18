<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cust.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	CustVO custVO = (CustVO) session.getAttribute("custVO"); //SustServlet.java(Concroller), 存入req的custVO物件
%>

<html>
<head>
<title>顧客資料 - listOneCust.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>
	<%
		if (custVO != null) {
	%>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>顧客資料 - ListOneCust.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/cust/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			
			<th>顧客帳號</th>
			<th>顧客密碼</th>
			<th>顧客姓名</th>
			<th>顧客性別</th>
			<th>顧客電話</th>
			<th>顧客地址</th>
			<th>顧客身份證字號</th>
			<th>E-mail</th>
			<th>顧客生日</th>
			<th>顧客註冊日</th>
			<th>大頭照</th>
			<th>顧客狀態</th>
			<th>顧客暱稱</th>
		</tr>
		<tr>
			
			<td><%=custVO.getCust_acc()%></td>
			<td><%=custVO.getCust_pwd()%></td>
			<td><%=custVO.getCust_name()%></td>
			<c:if test="${custVO.cust_sex.equals('M')}" var="true" scope="request">
				<td>男生</td>
			</c:if>
			<c:if test="${custVO.cust_sex.equals('F')}" var="true" scope="request">
				<td>女生</td>
			</c:if>
			<td><%=custVO.getCust_tel()%></td>
			<td><%=custVO.getCust_addr()%></td>
			<td><%=custVO.getCust_pid()%></td>
			<td><%=custVO.getCust_mail()%></td>
			<td><%=custVO.getCust_brd()%></td>
			<td><%=custVO.getCust_reg()%></td>
			<td><c:if test="${not empty custVO.cust_pic}"><img src="<%=request.getContextPath()%>/cust/cust.do?cust_ID=${custVO.cust_ID}"></c:if>
				    <c:if test="${empty custVO.cust_pic}"><img src="<%=request.getContextPath()%>/images/null2.jpg"></c:if></td>

			<c:if test="${custVO.cust_status.equals('a0')}" var="true"
				scope="session">
				<td>未停權</td>
			</c:if>
			<c:if test="${custVO.cust_status.equals('a1')}" var="true"
				scope="session">
				<td>停權</td>
			</c:if>
			<td><%=custVO.getCust_niname()%></td>

		</tr>
	</table>
	<%
		}
	%>
</body>
</html>