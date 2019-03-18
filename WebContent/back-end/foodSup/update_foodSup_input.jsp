<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title></title>
</head>
<body>
	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true"/>
		<aside class="left-sidebar" data-sidebarbg="skin5">
<%--==============<jsp:include page="/back-end/XXXX/sidebar.jsp" flush="true" />=================================--%>
		
		</aside>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
<%--=================================工作區================================================--%>
			<%-- 錯誤列表 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/foodSup/foodSup.do" name="form1">
				<table>
					<tr>
						<td>食材供應商編號:</td>
						<td>${foodSupVO.food_sup_ID}</td>
					</tr>
					<tr>
						<td>食材供應商名稱:</td>
						<td>${foodSupVO.food_sup_name}</td>
					</tr>
					<tr>
						<td>食材供應商電話:</td>
						<td>${foodSupVO.food_sup_tel}</td>
					</tr>
					<tr>
						<td>狀態:</td>
						<td>
						<select size="1" name="food_sup_status">
							<c:forEach var="foodSupStatus" items="${foodSupStatusMap}">
								<option value="${foodSupStatus.key}"
									${(foodSupVO.food_sup_status == foodSupStatus.key)?'selected':''}>${foodSupStatus.value}
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td>介紹:</td>
						<td>${foodSupVO.food_sup_resume}</td>
					</tr>
				</table>
				<br>
				<input type="hidden" name="action" value="updateBack">
				<input type="hidden" name="food_sup_ID" value="${foodSupVO.food_sup_ID}">
				<input type="submit" value="送出修改">
			</FORM>

<%--=================================工作區================================================--%>			
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>