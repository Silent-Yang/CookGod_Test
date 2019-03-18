<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="foodMallSvc" class="com.foodMall.model.FoodMallService" />
<jsp:useBean id="foodSvc" class="com.food.model.FoodService" />
<jsp:useBean id="foodSupSvc" class="com.foodSup.model.FoodSupService" />
<jsp:useBean id="festMenuSvc" class="com.festMenu.model.FestMenuService"/>
<jsp:useBean id="checkType" class="com.mall.controller.CheckType"/>

<html>
<head>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />
	<section class="contact-area section-padding-100">
	<%-- 錯誤列表 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
	</c:if>
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th scope="col">標題</th>
				<th scope="col">數量</th>
				<th scope="col">小計</th>
				<th scope="col">
					<form action="<%=request.getContextPath()%>/mall/mall.do" method="post">
						<input type="hidden" name="action" value="toCheckOutOR">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
						<input type="submit" value="結帳">
					</form>
				</th>
			</tr>
		</thead>
		<tbody id="shopCartList">
			<c:set var="total" value="0"/>
			<c:forEach var="shopItem" items="${shoppingCart}">
				 <tr class="shopItemT">
				      <c:if test="${checkType.getIsFOD(shopItem)}">
						  <td>${foodMallSvc.getOneFoodMall(shopItem.food_sup_ID, shopItem.food_ID).food_m_name}</td>
						  <td>${shopItem.food_od_qty}</td>
						  <td>${shopItem.food_od_stotal}</td>
						  <td>
						  	<form>
							  	<input type="hidden" name="food_sup_ID" value="${shopItem.food_sup_ID}">
							    <input type="hidden" name="food_ID" value="${shopItem.food_ID}">
							    <input type="hidden" name="action" value="delCartItem">
							  	<button id="btnDel" type="button" class="btn btn-dark">刪除</button>
						  	</form>
						  </td>
						  <c:set var="total" value="${total+shopItem.food_od_stotal}"/>
					  </c:if>
					  <c:if test="${!checkType.getIsFOD(shopItem)}">
						  <td>${festMenuSvc.getOneFestMenu(shopItem.fest_m_ID).fest_m_name}</td>
						  <td>${shopItem.fest_or_qty}</td>
						  <td>${shopItem.fest_or_stotal}</td>
						  <td>
						  	<form>
							    <input type="hidden" name="fest_m_ID" value="${shopItem.fest_m_ID}">
							    <input type="hidden" name="action" value="delCartItem">
							  	<button id="btnDel" type="button" class="btn btn-dark">刪除</button>
						  	</form>
						  </td>
						  <c:set var="total" value="${total+shopItem.fest_or_stotal}"/>
					  </c:if>
					  </tr>
			</c:forEach>
			<tr><td>${total}</td></tr>
		</tbody>
	</table>
	</section>

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>