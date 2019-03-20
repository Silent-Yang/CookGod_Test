<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fun.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	FunVO funVO = (FunVO) request.getAttribute("funVO"); //SustServlet.java(Concroller), 存入req的funVO物件
%>

<html>
<head>
<title>權限資料 - listOneFun.jsp</title>



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

				<%
		if (funVO != null) {
	%>

				<h4>此頁暫練習採用 Script 的寫法取值:</h4>
				<table id="table-1">
					<tr>
						<td>
							<h3>權限資料 - ListOneFun.jsp</h3>
							<h4>
								<a
									href="<%=request.getContextPath()%>/back-end/fun/select_page.jsp">回首頁</a>
							</h4>
						</td>
					</tr>
				</table>

				<table>
					<tr>
						<th>權限編號</th>

						<th>權限名稱</th>


					</tr>
					<tr>
						<td><%=funVO.getFun_ID()%></td>
						<td><%=funVO.getFun_name()%></td>


					</tr>
				</table>
				<%
		}
	%>

				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>