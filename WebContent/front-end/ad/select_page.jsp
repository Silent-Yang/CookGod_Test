<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ad.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>



</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">

	<table id="table-1">
		<tr>
		<br>
		<br>
		<br>
			<td><h3>管告管理</h3>
				</td>
		</tr>
	</table>

	

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
			href='<%=request.getContextPath()%>/front-end/ad/listAllAd.jsp'>List</a>
			all Ad. <br>
		<br></li>


		<li>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/ad/ad.do">
				<b>輸入廣告編號:</b> <input type="text" name="ad_ID"> <input
					type="hidden" name="action" value="getOne_For_Display"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="adSvc" scope="page"
			class="com.ad.model.AdService" />

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

 </section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>