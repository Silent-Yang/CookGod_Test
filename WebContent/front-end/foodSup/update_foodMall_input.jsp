<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.foodMall.model.*" %>
<jsp:useBean id="foodMallVO" scope="request" type="com.foodMall.model.FoodMallVO"/>
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<html>
<head>
<title>修改食材商品</title>

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
				<br>
				<form method="post" action="<%=request.getContextPath()%>/foodMall/foodMall.do" name="form1" enctype="multipart/form-data">
				<table>
					<tr>
						<td>標題:<font color=red><b>*</b></font></td>
						<td><input type="TEXT" name="food_m_name" size="7" 
							 value="${foodMallVO.food_m_name}" /></td>
					</tr>
					<tr>
						<td>商品狀態:</td>
						<td>
							<c:choose>
								<c:when test="${foodMallVO.food_m_status eq 'p3' || foodMallVO.food_m_status eq 'p4'}">
									<c:forEach var="chooseMall" items="${mallStatusMap}" begin="3" end="4">
										<input type="radio" name="food_m_status" value="${chooseMall.key}"
											${(chooseMall.key == foodMallVO.food_m_status)?'checked':''}>${chooseMall.value}
									</c:forEach>
								</c:when>
								<c:when test="${foodMallVO.food_m_status eq 'p1'}">
									${mallStatusMap[foodMallVO.food_m_status]}
									<c:forEach var="chooseMall" items="${mallStatusMap}" begin="3" end="4">
										<input type="radio" name="food_m_status" value="${chooseMall.key}"
											${(chooseMall.key == foodMallVO.food_m_status)?'checked':''}>${chooseMall.value}
									</c:forEach>
								</c:when>
								<c:otherwise>
									<input type="hidden"  name="food_m_status" value="${foodMallVO.food_m_status}" >${mallStatusMap[foodMallVO.food_m_status]}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>商品價格:<font color=red><b>*</b></font></td>
						<td><input type="TEXT" name="food_m_price" size="7"
							 value="${foodMallVO.food_m_price}" /></td>
					</tr>
					<tr>
						<td>單位:<font color=red><b>*</b></font></td>
						<td>
							<c:forEach var="foodUnit" items="${foodUnitMap}">
								<input type="radio" name="food_m_unit" value="${foodUnit.key}"
									${(foodUnit.key == foodMallVO.food_m_unit)?'checked':''}>${foodUnit.value}
							</c:forEach>
					</tr>
					<tr>
						<td>產地:<font color=red><b>*</b></font></td>
						<td><input type="TEXT" name="food_m_place" size="7"
							 value="${foodMallVO.food_m_place}" /></td>
					</tr>
				<tr>
					<td>食材種類:</td>
					<td>
						<h3>${foodTypeMap[foodSvc.getOneFood(foodMallVO.food_ID).food_type_ID]}</h3>
					</td>
				</tr>
				
				<tr>
					<td>食材名稱:</td>
					<td>
						<h3>${foodSvc.getOneFood(foodMallVO.food_ID).food_name}</h3>
					</td>
				</tr>
				<tr>
					<td>商品照片:<font color=red><b>*</b></font></td>
					<td><input type="file" name="food_m_pic"/></td>
				</tr>
				<tr>
					<td>介紹:</td>
					<td>
						<textarea name="food_m_resume">${empty foodMallVO.food_m_resume ? "請介紹" : foodMallVO.food_m_resume}</textarea>
						<script>CKEDITOR.replace('food_m_resume');</script>
					</td>
				</tr>
				</table>
				<input type="hidden" name="food_ID" value="${foodMallVO.food_ID}">
				<input type="hidden" name="food_sup_ID" value="${foodMallVO.food_sup_ID}">
				<input type="hidden" name="action" value="update">
				<input type="submit" value="送出">
			</form>
			<img id="preView">
	
           
	</section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
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