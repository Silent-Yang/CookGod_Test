<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.foodMall.model.*"%>
<jsp:useBean id="foodMallVO" scope="request"
	type="com.foodMall.model.FoodMallVO" />
<jsp:useBean id="foodSvc" scope="page"
	class="com.food.model.FoodService" />
<html>
<head>
<title>修改食材商城</title>

</head>
<body>
	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true" />
		<aside class="left-sidebar" data-sidebarbg="skin5">
			<%--==============<jsp:include page="/back-end/XXXX/sidebar.jsp" flush="true" />=================================--%>
			<jsp:include page="/back-end/foodOrder/sidebar.jsp" flush="true" />
		</aside>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<%--=================================工作區================================================--%>
				<div class="row">
					<div class="col-5 align-self-center">
						<h4 class="page-title">修改商品</h4>
					</div>
				</div>
			</div>
			<%-- 錯誤列表 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<form method="post"
				action="<%=request.getContextPath()%>/foodMall/foodMall.do"
				name="form1" enctype="multipart/form-data">
				<table>
					<tr>
						<td>標題:</td>
						<td><input type="TEXT" name="food_m_name" size="45"
							value="<%= (foodMallVO==null)? "蔬果" : foodMallVO.getFood_m_name()%>" /></td>
					</tr>
					<tr>
						<td>商品狀態:</td>
						<td><select size="1" name="food_m_status">
								<c:forEach var="mallStatus" items="${mallStatusMap}">
									<option value="${mallStatus.key}"
										${(foodMallVO.food_m_status == mallStatus.key)?'selected':''}>${mallStatus.value}
								</c:forEach>
						</select>
					</tr>
					<tr>
						<td>商品價格:</td>
						<td><input type="TEXT" name="food_m_price" size="45"
							value="<%= (foodMallVO==null)? "10000" : foodMallVO.getFood_m_price()%>" /></td>
					</tr>
					<tr>
						<td>單位:</td>
						<td><input type="text" name="food_m_unit"
							value="<%= (foodMallVO==null)? "公斤" : foodMallVO.getFood_m_unit()%>">
						</td>
					</tr>
					<tr>
						<td>產地:</td>
						<td><input type="TEXT" name="food_m_place" size="45"
							value="<%= (foodMallVO==null)? "台灣" : foodMallVO.getFood_m_place()%>" /></td>
					</tr>


					<tr>
						<td>食材名稱:</td>
						<td>
							<h3>${foodSvc.getOneFood(foodMallVO.food_ID).food_name}</h3>
						</td>
					</tr>
					<tr>
						<td>商品照片:</td>
						<td><input type="file" name="food_m_pic" value="C:/XXX/XXX" /></td>
					</tr>
					<tr>
						<td>介紹:</td>
						<td><textarea name="food_m_resume">${empty foodMallVO.food_m_resume ? "請介紹" : foodMallVO.food_m_resume}</textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" name="food_ID" value="${foodMallVO.food_ID}">
				<input type="hidden" name="food_sup_ID"
					value="${foodMallVO.food_sup_ID}"> <input type="hidden"
					name="action" value="update"> <input type="submit"
					value="送出">
			</form>
			<img id="preView">


			<%--=================================工作區================================================--%>
			<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
			<%--=================================jQuery===============================================--%>


		</div>
	</div>
	<script>
		$(document).ready(
			function(){
				$(":file").change(
					function(){
						if(this.files && this.files[0]){
							let reader = new FileReader();
							reader.onload = function(e){
								$('#preView').attr('src', e.target.result);
							}
							reader.readAsDataURL(this.files[0]);
						}
					}
				);
			}
		);
	</script>
</body>
</html>