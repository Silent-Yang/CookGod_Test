<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.auth.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Auth: Home</title>



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


				<table id="table-1">
					<tr>
						<td><h3>IBM Auth: Home</h3>
							<h4>( MVC )</h4></td>
					</tr>
				</table>

				<p>This is the Home page forAuth: Home</p>

				<h3>資料查詢:</h3>

				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

				<ul>
					<li><a
						href='<%=request.getContextPath()%>/back-end/auth/listAllAuth.jsp'>List</a>
						all Auth. <br> <br></li>


					<li>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/auth/auth.do">
							<b>輸入員工編號:</b> <input type="text" name="emp_ID"> <input
								type="hidden" name="action" value="getOne_For_Display">
							<input type="submit" value="送出">
						</FORM>
					</li>

					<jsp:useBean id="authSvc" scope="session"
						class="com.auth.model.AuthService" />
					<jsp:useBean id="empSvc" scope="session"
						class="com.emp.model.EmpService" />
					<jsp:useBean id="funSvc" scope="session"
						class="com.fun.model.FunService" />
					<li>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/auth/auth.do">
							<b>選擇員工編號:</b> <select size="1" name="emp_ID">
								<c:forEach var="authVO" items="${authSvc.all}">
									<option value="${authVO.emp_ID}">${authVO.emp_ID}
								</c:forEach>
							</select> <input type="hidden" name="action" value="getOne_For_Display">
							<input type="submit" value="送出">
						</FORM>
					</li>

					<li>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/auth/auth.do">
							<b>選擇功能編號:</b> <select size="1" name="emp_ID">
								<c:forEach var="authVO" items="${authSvc.all}">
									<option value="${authVO.emp_ID}">${authVO.fun_ID}
								</c:forEach>
							</select> <input type="hidden" name="action" value="getOne_For_Display">
							<input type="submit" value="送出">
						</FORM>
					</li>
				</ul>


				<h3>權限管理</h3>

				<ul>
					<li><a
						href='<%=request.getContextPath()%>/back-end/auth/addAuth.jsp'>Add</a>
						a new Auth.</li>
				</ul>

				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>