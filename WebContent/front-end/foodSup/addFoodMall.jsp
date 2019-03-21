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
		<form method="post" action="<%=request.getContextPath()%>/foodMall/foodMall.do" name="form1" enctype="multipart/form-data">
			<table>
			<tr><td>${errorMsgs.excMsgs}</td></tr>
			<tr>
				<td>標題:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="food_m_name" size="20" 
					 value="<%= (foodMallVO==null)? "又大又甜的蘋果" : foodMallVO.getFood_m_name()%>" /></td>
					 <td><font color=red>${errorMsgs.em_name}</font></td>
			</tr>
			<tr>
				<td>商品價格:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="food_m_price" size="7"
					 value="<%= (foodMallVO==null)? "10000" : foodMallVO.getFood_m_price()%>" /></td>
					 <td><font color=red>${errorMsgs.em_price}</font></td>
			</tr>
			<tr>
				<td>單位:<font color=red><b>*</b></font></td>
				<td>
					<c:forEach var="foodUnit" items="${foodUnitMap}">
						<input type="radio" name="food_m_unit" value="${foodUnit.key}"
							${(foodUnit.key == foodMallVO.food_m_unit)?'checked':''}>${foodUnit.value}
					</c:forEach>
				</td><td><font color=red>${errorMsgs.em_unit}</font></td>
			</tr>
			<tr>
				<td>產地:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="food_m_place" size="7"
					 value="<%= (foodMallVO==null)? "台灣" : foodMallVO.getFood_m_place()%>" /></td>
				<td><font color=red>${errorMsgs.em_place}</font></td>
			</tr>
			<tr>
				<td>請選擇食材種類:<font color=red><b>*</b></font></td>
				<td>
					<select id="foodTypeSelect" size="1" name="food_type_ID">
						<option value="-1">請選擇</option>
					<c:forEach var="foodType" items="${foodTypeMap}">
						<option value="${foodType.key}" ${(foodType.key eq food_type_ID)?'selected':''}>${foodType.value}
					</c:forEach>
					</select>
				</td>
				<td>${errorMsgs.em_foodType}</td>
			</tr>
			<tr>
				<td>食材:<font color=red><b>*</b></font></td>
				<td>
					<select id="foodSelect" size="1" name="food_ID">
						<option value="-1"></option>
						<c:if test="${not empty food_type_ID}">
							<c:forEach var="typeFoodVO" items="${foodSvc.getFoodsByFood_type_ID(food_type_ID)}">
								<option value="${typeFoodVO.food_ID}" ${(typeFoodVO.food_ID eq foodMallVO.food_ID)?'selected':''}>${typeFoodVO.food_name}</option>
							</c:forEach>
						</c:if>
					</select>
				</td>
				<td><font color=red>${errorMsgs.em_foodID}</font></td>
			</tr>
			<tr>
				<td>商品照片:<font color=red><b>*</b></font></td>
				<td><input type="file" name="food_m_pic"  /></td>
				<td><font color=red>${errorMsgs.em_pic}</font></td>
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
					
					$("#foodTypeSelect").change(function(){
						$.ajax({
							type:"POST",
							url:"<%=request.getContextPath()%>/foodMall/foodMall.do",
							data:{"action":"getSelFoodFSAdd","food_type_ID":$("#foodTypeSelect").val()},
							dataType:"json",
							success: function(data){
								clearFoodSelect();
								let foodOpt;
								jQuery.each(data, function(inx,mval){
									foodOpt += 
										'<option value="'+ mval.food_ID +'">'+ mval.food_name +'</option>';

								})
								$("#foodSelect").append(foodOpt);
								console.log(data);
							},
							error: function(data){
								alert(ajax錯誤);
								console.log(data);
							}
						});
					});
				}
				
				
			);
			
			function clearFoodSelect(){
				$('#foodSelect').empty();
				$('#foodSelect').append("<option value='-1'>請選擇</option>");
			}
		</script>
	</section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>