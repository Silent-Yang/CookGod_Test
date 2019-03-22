<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menuOrder.model.*"%>
<%@ page import="com.cust.model.*"%>

<%
	MenuOrderService menuOrderSvc = new MenuOrderService();
	CustVO custVO =(CustVO) session.getAttribute("custVO");
	String cust_ID = custVO.getCust_ID();
	List<MenuOrderVO> listAll = menuOrderSvc.getAllByCustID(cust_ID);
	pageContext.setAttribute("listAll", listAll);
%>
<html>
<title>List_All_Menu_Order_By_Cust_ID</title>
<head>
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
</style>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">
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
							<th>評價訂單</th>
							<% //<th>刪除訂單</th> %>
						</tr>
						<%@ include file="page1.file"%>
						<c:forEach var="menuOrderVO" items="${listAll}"
							begin="<%=pageIndex %>" end="<%=pageIndex+rowsPerPage-1 %>">
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
								<td>
								<c:if test="${(menuOrderVO.menu_od_end!=null)&&(menuOrderVO.menu_od_rate==0)}">
									<form method="post"
										action="<%=request.getContextPath()%>/menuOrder/menuOrder.do">
										<input type="submit" value="評價"> <input type="hidden" name="menu_od_ID" value="${menuOrderVO.menu_od_ID}">
										<input type="hidden" name="action" value="getOneForRate">
									</form>
								</c:if>
								</td>
								<!-- <td>
									<form method="post"
										action="<%=request.getContextPath()%>/menuOrder/menuOrder.do">
										<input type="submit" value="刪除"> <input type="hidden"
											name="menu_od_ID" value="${menuOrderVO.menu_od_ID}"> <input
											type="hidden" name="action" value="delete">
									</form>
								</td> -->
							</tr>
						</c:forEach>
					</table>
					<%@ include file="page2.file"%>
				</div>
			</div>
		</div>
    </section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>