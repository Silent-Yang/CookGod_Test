<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>食材供應商資料 - listOneEmp.jsp</title>

</head>
<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

	<table>
		<tr>
			<th>食材供應商編號</th>
			<th>食材供應商名稱</th>
			<th>電話號碼</th>
			<th>狀態</th>
			<th>介紹</th>
		</tr>
		<tr>
			<td>${foodSupVO.food_sup_ID}</td>
			<td>${foodSupVO.food_sup_name}</td>
			<td>${foodSupVO.food_sup_tel}</td>
			<td>${foodSupStatusMap[foodSupVO.food_sup_status]}</td>
			<td>${foodSupVO.food_sup_resume}</td>
		</tr>
	</table>

</body>
</html>