<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="foodSupSvc" class="com.foodSup.model.FoodSupService"/>
<jsp:useBean id="foodSvc" class="com.food.model.FoodService"/>
<html>
<head>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">
    <table class="table table-striped">
	  <thead>
	    <tr>
	      <th scope="col">訂單編號</th>
	      <th scope="col">食材名稱</th>
	      <th scope="col">數量</th>
	      <th scope="col">小計</th>
	      <th scope="col">評價</th>
	      <th scope="col">狀態</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach var="foodODVO" items="${foodSupSvc.getFoodODByFood_sup_ID(foodSupVO.food_sup_ID)}">
	    <tr>
	      <td>${foodODVO.food_or_ID}</td>
	      <td>${foodSvc.getOneFood(foodODVO.food_ID).food_name}</td>
	      <td>${foodODVO.food_od_qty}</td>
	      <td>${foodODVO.food_od_stotal}</td>
	      <td>${foodODVO.food_od_rate}</td>
	      <td>
	      	<form action="">
	      	</form>
	      </td>
	    </tr>
	    </c:forEach>
	</table>
    
    </section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>