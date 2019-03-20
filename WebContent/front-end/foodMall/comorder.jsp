<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="custSvc" class="com.cust.model.CustService" />
<jsp:useBean id="foodOrderSvc"
	class="com.foodOrder.model.FoodOrderService" />
<html>
<head>
<title>單一食材商城訂單</title>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	<!-- ##### Contact Area Start #####-->
	<section class="contact-area section-padding-100">
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<c:if test="${not empty foodOrderVO}">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">食材訂單編號</th>
						<th scope="col">訂單狀態</th>
						<th scope="col">下訂日期</th>
						<th scope="col">出貨日期</th>
						<th scope="col">完成日期</th>
						<th scope="col">收件人</th>
						<th scope="col">收件地址</th>
						<th scope="col">聯絡方式</th>
						<th scope="col">下訂客戶</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td scope="col">${foodOrderVO.food_or_ID}</td>
						<td scope="col">${mallOrStatusMap[foodOrderVO.food_or_status]}</td>
						<td scope="col">${foodOrderVO.food_or_start}</td>
						<td scope="col">${foodOrderVO.food_or_send}</td>
						<td scope="col">${foodOrderVO.food_or_end}</td>
						<td scope="col">${foodOrderVO.food_or_name}</td>
						<td scope="col">${foodOrderVO.food_or_addr}</td>
						<td scope="col">${foodOrderVO.food_or_tel}</td>
						<td scope="col">${custSvc.getOneCust(foodOrderVO.cust_ID).cust_name}</td>
					</tr>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty festOrderList}">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">節慶訂單編號</th>
						<th scope="col">訂單狀態</th>
						<th scope="col">下訂日期</th>
						<th scope="col">出貨日期</th>
						<th scope="col">完成日期</th>
						<th scope="col">收件人</th>
						<th scope="col">收件地址</th>
						<th scope="col">聯絡方式</th>
						<th scope="col">下訂客戶</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="festOrderVO" items="${festOrderList}">
						<tr>
							<td scope="col">${festOrderVO.fest_or_ID}</td>
							<td scope="col">${mallOrStatusMap[festOrderVO.fest_or_status]}</td>
							<td scope="col">${festOrderVO.fest_or_start}</td>
							<td scope="col">${festOrderVO.fest_or_send}</td>
							<td scope="col">${festOrderVO.fest_or_end}</td>
							<c:if test="${not empty foodOrderVO}">
								<td scope="col">${foodOrderVO.food_or_name}</td>
								<td scope="col">${foodOrderVO.food_or_addr}</td>
								<td scope="col">${foodOrderVO.food_or_tel}</td>
							</c:if>
							<c:if test="${empty foodOrderVO}">
								<td scope="col">${custSvc.getOneCust(festOrderVO.cust_ID).cust_name}</td>
								<td scope="col">${custSvc.getOneCust(festOrderVO.cust_ID).cust_addr}</td>
								<td scope="col">${custSvc.getOneCust(festOrderVO.cust_ID).cust_tel}</td>
							</c:if>
							<td scope="col">${custSvc.getOneCust(festOrderVO.cust_ID).cust_name}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>


	</section>
	<!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>