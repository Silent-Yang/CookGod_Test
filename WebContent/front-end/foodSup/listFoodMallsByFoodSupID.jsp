<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.foodMall.model.FoodMallService"%>
<%@ page import="com.foodMall.model.FoodMallVO"%>
<%@ page import="com.foodSup.model.FoodSupVO"%>

<%@ page import="java.util.List"%>
<jsp:useBean id="foodMallSvc" class="com.foodMall.model.FoodMallService"/>
<jsp:useBean id="foodSupSvc" class="com.foodSup.model.FoodSupService"/>
<jsp:useBean id="foodSvc" class="com.food.model.FoodService"/>


<html>
<head>
<title>供應商顯示所有食材商品 listAllFoodMall.jsp</title>

</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
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
	<table>
			<tr>
				<th>食材商名稱</th>
				<th>食材名稱</th>
				<th>標題</th>
				<th>商品狀態</th>
				<th>價格</th>
				<th>單位</th>
				<th>產地</th>
				<th>圖片</th>
				<th>介紹</th>
				<th>評價</th>
			</tr>

					
			<c:forEach var="foodMallVO" items="${foodSupSvc.getFoodMallsByFood_sup_ID(foodSupVO.food_sup_ID)}">
					<tr class="foodMallEntiy">
						<td>${foodSupSvc.getOneFoodSup(foodMallVO.food_sup_ID).food_sup_name}</td>
						<td>${foodSvc.getOneFood(foodMallVO.food_ID).food_name}</td>
						<td>${foodMallVO.food_m_name}</td>
						<td>${mallStatusMap[foodMallVO.food_m_status]}</td>
						<td>${foodMallVO.food_m_price}</td>
						<td>${foodMallVO.food_m_unit}</td>
						<td>${foodMallVO.food_m_place}</td>
						<%--<td><img src="data:image/png;base64,${foodMallVO.food_m_pic}"></td> --%>
						<td><img src="<%=request.getContextPath()%>/foodMall/foodMall.do?food_sup_ID=${foodMallVO.food_sup_ID}&food_ID=${foodMallVO.food_ID}"></td>
						<td>${foodMallVO.food_m_rate}</td>

						<td>
							<form method="post" action="<%=request.getContextPath()%>/foodMall/foodMall.do">
								<button id="update">修改</button>
								<input type="hidden" value="food_ID" value="${foodMallVO.food_ID}">
								<input type="hidden" value="food_sup_ID" value="${foodMallVO.food_sup_ID}">
								<input type="hidden" id="action" name="action">
							</form>
						</td>
					</tr>
				</c:forEach>
			</table>
				
	</section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
	<script>
		$(document).ready(function(){
			$(".foodMallEntiy").click(function(evt){
				let foodForm = $(this).find("form");
				if(evt.target.id != "update") { 
					foodForm.children("#requestURL").val('<%=request.getServletPath()%>');
					foodForm.children("#action").val("frontDisplay");
				}else{
					foodForm.children("#action").val("foodSupGetUpdate");	
				}
				foodForm.submit();
			});
		}); 
	</script>
</body>
</html>