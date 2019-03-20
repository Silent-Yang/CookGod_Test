<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menuOrder.model.*"%>

<html>
<head>
<title>List_All_Menu_Order</title>
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
				<div class="container justify-content-center">
					<div class="row">
						<div class="col-12">
							<table>
								<tr>
									<th>訂單編號</th>
									<th>訂單狀態</th>
									<th>下訂日期</th>
									<th>預約日期</th>
									<th>完成日期</th>
									<th>訂單評價</th>
									<th>訂單留言</th>
									<th>顧客編號</th>
									<th>主廚編號</th>
									<th>套餐編號</th>
								</tr>
								<tr>
									<td>${menuOrderVO.menu_od_ID}</td>
									<td>${menuOrderVO.menu_od_status}</td>
									<td>${menuOrderVO.menu_od_start}</td>
									<td>${menuOrderVO.menu_od_book}</td>
									<td>${menuOrderVO.menu_od_end}</td>
									<td>${menuOrderVO.menu_od_rate}</td>
									<td>${menuOrderVO.menu_od_msg}</td>
									<td>${menuOrderVO.cust_ID}</td>
									<td>${menuOrderVO.chef_ID}</td>
									<td>${menuOrderVO.menu_ID}</td>
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