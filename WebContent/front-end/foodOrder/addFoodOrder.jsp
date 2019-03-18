<%@page import="com.cust.model.CustVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<div class="row">
			<div class="col-12">
				<div class="card card-body">
					<h4 class="card-title">結帳</h4>
					<form class="form-horizontal m-t-30" method="post" action="<%=request.getContextPath()%>/foodOrder/foodOrder.do">
						<div class="form-group">
						<label>收件人姓名</label>
						<input type="text" class="form-control" name="food_or_name"
											value="${empty foodOrderVO ? '': foodOrderVO.food_or_name}">
						</div>
						<div class="form-group">
							<label>收件地址</label>
							<input  id="addr" name="food_or_addr" class="form-control"
									type="text" value="${empty foodOrderVO ? '': foodOrderVO.food_or_addr}">
						</div>
						<div class="form-group">
							<label>收件人電話</label>
							<input type="text" name="food_or_tel" class="form-control" placeholder="09XXXXXXXX"
									value="${empty foodOrderVO ? '':foodOrderVO.food_or_tel}">
						</div>		
							<input type="hidden" name="cust_ID" value="${custVO.cust_ID}">
							<input type="hidden" name="action" value="insertOrODs">
							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
							<input class="btn btn-success" type="submit" value="結帳">
					</form>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>