<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ad.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Ad: Home</title>



</head>
<body bgcolor='white'>
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
						<td><h3>IBM Ad: Home</h3>
							<h4>( MVC )</h4></td>
					</tr>
				</table>

				<p>This is the Home page forAd: Home</p>

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
						href='<%=request.getContextPath()%>/back-end/ad/listAllAd.jsp'>List</a>
						all Ad. <br> <br></li>


					<li>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/ad/ad.do">
							<b>輸入廣告編號:</b> <input type="text" name="ad_ID"> <input
								type="hidden" name="action" value="getOne_For_Display">
							<input type="submit" value="送出">
						</FORM>
					</li>

					<jsp:useBean id="adSvc" scope="page" class="com.ad.model.AdService" />

					<li>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/ad/ad.do">
							<b>選擇廣告編號:</b> <select size="1" name="ad_ID">
								<c:forEach var="adVO" items="${adSvc.all}">
									<option value="${adVO.ad_ID}">${adVO.ad_ID}
								</c:forEach>
							</select> <input type="hidden" name="action" value="getOne_For_Display">
							<input type="submit" value="送出">
						</FORM>
					</li>

					<li>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/ad/ad.do">
							<b>選擇廣告姓名:</b> <select size="1" name="ad_ID">
								<c:forEach var="adVO" items="${adSvc.all}">
									<option value="${adVO.ad_ID}">${adVO.ad_title}
								</c:forEach>
							</select> <input type="hidden" name="action" value="getOne_For_Display">
							<input type="submit" value="送出">
						</FORM>
					</li>
				</ul>


				<h3>廣告管理</h3>

				<ul>
					<li><a href='addAd.jsp'>Add</a> a new Ad.</li>
				</ul>

				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
	<script
		src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
</body>
</html>