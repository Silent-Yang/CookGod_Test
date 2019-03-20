<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="foodSupSvc" scope="page"
	class="com.foodSup.model.FoodSupService" />
<jsp:useBean id="custSvc" class="com.cust.model.CustService" />
<html>
<head>
<title></title>
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
				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font color='red'>請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				<select size="1" name="getStatus_For_Display">
					<c:forEach var="foodSupStatus" items="${foodSupStatusMap}">
						<option value="${foodSupStatus.key}">${foodSupStatus.value}
					</c:forEach>
				</select>
				<table>
					<tr>
						<th>食材供應商編號</th>
						<th>食材供應商名稱</th>
						<th>聯絡電話</th>
						<th>狀態</th>
					</tr>
					<c:forEach var="foodSupVO" items="${foodSupSvc.all}">
						<tr class="foodSupEntiy">
							<td>${foodSupVO.food_sup_ID}</td>
							<td>${foodSupVO.food_sup_name}</td>
							<td>${foodSupVO.food_sup_tel}</td>
							<td>${foodSupStatusMap[foodSupVO.food_sup_status]}</td>

							<td>
								<form method="post"
									action="<%=request.getContextPath()%>/foodSup/foodSup.do">
									<button id="update">修改</button>
									<input type="hidden" id="food_sup_ID" name="food_sup_ID"
										value="${foodSupVO.food_sup_ID}"> <input type="hidden"
										id="action" name="action"> <input type="hidden"
										id="requestURL" name="requestURL"
										value="<%=request.getServletPath()%>">
								</form>
							</td>
						</tr>
					</c:forEach>
				</table>
				<%if (request.getAttribute("listFoodMalls_ByFood_sup_ID") != null ) {%>
				<jsp:include
					page="/back-end/foodSup/listFoodMalls_ByFood_sup_ID.jsp"
					flush="true" />
				<%}%>
				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
	<script>
	
		$(document).ready(function(){
			$(".foodSupEntiy").click(function(evt){
				let foodForm = $(this).find("form");
				if(evt.target.id != "update") { 
					foodForm.children("#requestURL").val("<%=request.getServletPath()%>");
					foodForm.children("#action").val("listFoodMalls_ByFood_sup_ID");
				}else{
					foodForm.children("#action").val("getOne_For_Update");	
				}
				foodForm.submit();
			});
		});
	</script>
</body>
</html>