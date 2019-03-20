<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ad.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	AdService adSvc = new AdService();
	List<AdVO> list = adSvc.getAll();
	;
	pageContext.setAttribute("list", list);
%>


<!DOCTYPE html>
<html>
<head>
<title>所有廣告資料 - listAllAd.jsp</title>


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

				<h4>此頁練習採用 EL 的寫法取值:</h4>
				<table id="table-1">
					<tr>
						<td>
							<h3>所有廣告資料 - listAllAd.jsp</h3>
							<h4>
								<a
									href="<%=request.getContextPath()%>/front-end/ad/select_page.jsp">回首頁</a>
							</h4>
						</td>
					</tr>
				</table>

				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

				<table>
					<tr>
						<th>廣告編號</th>
						<th>廣告標題</th>
						<th>廣告內文</th>
						<th>廣告上架日期</th>
						<th>廣告下架日期</th>
						<th>廣告狀態</th>
						<th>廣告類別</th>
						<th>食材供應商</th>
					</tr>
					<%@ include file="/file/page1.file"%>
					<c:forEach var="adVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">

						<tr>
							<td>${adVO.ad_ID}</td>
							<td>${adVO.ad_title}</td>
							<td>${adVO.ad_con}</td>
							<td>${adVO.ad_start}</td>
							<td>${adVO.ad_end}</td>
							<td>${adVO.ad_status}</td>
							<td>${adVO.ad_type}</td>
							<td>${adVO.food_sup_ID}</td>

							<td>
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/ad/ad.do"
									style="margin-bottom: 0px;">
									<input type="submit" value="修改"> <input type="hidden"
										name="ad_ID" value="${adVO.ad_ID}"> <input
										type="hidden" name="action" value="getOne_For_Update">
								</FORM>
							</td>
							<td>
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/ad/ad.do"
									style="margin-bottom: 0px;">
									<input type="submit" value="刪除"> <input type="hidden"
										name="ad_ID" value="${adVO.ad_ID}"> <input
										type="hidden" name="action" value="delete">
								</FORM>
							</td>
						</tr>
					</c:forEach>
				</table>
				<%@ include file="/file/page2.file"%>
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