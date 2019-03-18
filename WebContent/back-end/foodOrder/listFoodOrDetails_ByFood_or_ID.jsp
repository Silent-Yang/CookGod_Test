<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.foodOrDetail.model.*" %>

<jsp:useBean id="listFoodOrDetails_ByFood_or_ID" scope="request" type="java.util.Set<FoodOrDetailVO>"/>
<jsp:useBean id="foodOrderSvc" class="com.foodOrder.model.FoodOrderService"/>
<html>
<head>
<title>食材商城訂單明細</title>
</head>
<body>
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
			<th>食材訂單編號</th>
			<th>食材供應商編號</th>
			<th>食材編號</th>
			<th>數量</th>
			<th>小計</th>
			<th>評分</th>
			<th>心得</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>

		<c:forEach var="foodOrDetailVO" items="${listFoodOrDetails_ByFood_or_ID}">
			<tr 
				${(foodOrDetailVO.food_or_ID == param.food_or_ID
					&& foodOrDetailVO.food_sup_ID == param.food_sup_ID
					&& foodOrDetailVO.food_ID == param.food_ID) ? 'bgcolor=#CCCCFF':''}>
				<!--將修改的那一筆加入對比色-->
				<td>${foodOrDetailVO.food_or_ID}</td>
				<td>${foodOrDetailVO.food_sup_ID}</td>
				<td>${foodOrDetailVO.food_ID}</td>
				<td>${foodOrDetailVO.food_od_qty}</td>
				<td>${foodOrDetailVO.food_od_stotal}</td>
				<td>${foodOrDetailVO.food_od_rate}</td>
				<td>${foodOrDetailVO.food_od_msg}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/foodOrDetail/foodOrDetail.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改">
						<input type="hidden" name="food_or_ID" value="${foodOrDetailVO.food_or_ID}">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<!-- 目前尚未用到  -->
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/foodOrDetail/foodOrDetail.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="food_or_ID" value="${foodOrDetailVO.food_or_ID}"> <input type="hidden"
							name="requestURL" value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>