<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title></title>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	<!-- ##### Contact Area Start #####-->
	<section class="contact-area section-padding-100">
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<FORM METHOD="post"
			ACTION="<%=request.getContextPath()%>/foodSup/foodSup.do"
			name="form1">
			<table>
				<tr>
					<td>食材供應商編號:</td>
					<td>${foodSupVO.food_sup_ID}</td>
				</tr>
				<tr>
					<td><font color=red><b>*</b></font>食材供應商名稱:</td>
					<td><input type="TEXT" name="food_sup_name" size="45"
						value="${foodSupVO.food_sup_name}" /></td>
				</tr>
				<tr>
					<td>食材供應商電話:</td>
					<td><input type="TEXT" name="food_sup_tel" size="45"
						value="${foodSupVO.food_sup_tel}" /></td>
				</tr>
				<tr>
					<td>狀態:</td>
					<td>${foodSupStatusMap[foodSupVO.food_sup_status]}</td>
				</tr>
				<tr>
					<td>介紹:</td>
					<td><textarea name="food_sup_resume">${foodSupVO.food_sup_resume}</textarea>
						<script>CKEDITOR.replace('food_sup_resume');</script></td>
				</tr>
			</table>
			<br> <input type="hidden" name="action" value="update">
			<input type="hidden" name="food_sup_ID"
				value="${foodSupVO.food_sup_ID}"> <input type="hidden"
				name="food_sup_status" value="${foodSupVO.food_sup_status}">
			<input type="submit" value="送出修改">
		</FORM>

	</section>
	<!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>