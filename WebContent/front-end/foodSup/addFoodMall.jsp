<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.foodMall.model.*" %>
<%@ page import="com.foodSup.model.FoodSupVO" %>
<%@ page import="java.util.Map" %>
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<%
	FoodMallVO foodMallVO = (FoodMallVO) request.getAttribute("foodMallVO");
%>

<html>
<head>

<title>新增食材商品</title>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">
    	<h3>食材供應商新增食材</h3>
		<c:if test="${not empty errorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<form method="post" action="<%=request.getContextPath()%>/foodMall/foodMall.do" name="form1" enctype="multipart/form-data">
			<table>
			<tr>
				<td>標題:</td>
				<td><input type="TEXT" name="food_m_name" size="45" 
					 value="<%= (foodMallVO==null)? "又大又甜的蘋果" : foodMallVO.getFood_m_name()%>" /></td>
			</tr>
			<tr>
				<td>商品價格:</td>
				<td><input type="TEXT" name="food_m_price" size="45"
					 value="<%= (foodMallVO==null)? "10000" : foodMallVO.getFood_m_price()%>" /></td>
			</tr>
			<tr>
				<td>單位:</td>
				<td>
					<input type="text" name="food_m_unit" value="<%= (foodMallVO==null)? "公斤" : foodMallVO.getFood_m_unit()%>">
				</td>
			</tr>
			<tr>
				<td>產地:</td>
				<td><input type="TEXT" name="food_m_place" size="45"
					 value="<%= (foodMallVO==null)? "台灣" : foodMallVO.getFood_m_place()%>" /></td>
			</tr>
			<tr>
				<td>食材:<font color=red><b>*</b></font></td>
				<td>
					<select size="1" name="food_ID">
						<c:forEach var="foodVO" items="${foodSvc.all}">
							<option value="${foodVO.food_ID}" ${(foodMallVO.food_ID == foodVO.food_ID)? 'selected':'' } >${foodVO.food_name}
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>商品照片:</td>
				<td><input type="file" name="food_m_pic" 
					 value="C:/XXX/XXX" /></td>
			</tr>
			<tr>
				<td>介紹:</td>
				<td>
					<textarea name="food_m_resume">${empty foodMallVO.food_m_resume ? "請介紹" : foodMallVO.food_m_resume}</textarea>
					<script>CKEDITOR.replace('food_m_resume');</script>
				</td>
			</tr>
			</table>
			<input type="hidden" name="food_sup_ID" value="${foodSupVO.food_sup_ID}">
			<input type="hidden" name="action" value="insert">
			<input type="submit" value="送出">
		</form>
		<img id="preView">
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
	</section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>