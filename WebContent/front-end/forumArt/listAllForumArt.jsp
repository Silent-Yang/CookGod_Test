<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="com.forumArt.model.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:useBean id="forumArtDAO" scope="page"
	class="com.forumArt.model.ForumArtDAO" />
<jsp:useBean id="forumArtSvc" scope="page"
	class="com.forumArt.model.ForumArtDAO" />
<jsp:useBean id="chefSvc" scope="page"
	class="com.chef.model.ChefService" />

<%
   
    List<ForumArtVO> list = forumArtSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有文章資料</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h3 {
	font: 20px Times New Roman, arial, helvetica, sans-serif, Microsoft
		JhengHei;
	font-weight: bold;
	color: black;
	display: block;
	margin: 5px;
}

h4 {
	font: 18px Times New Roman, arial, helvetica, sans-serif, Microsoft
		JhengHei;
	font-weight: bold;
	color: blue;
	display: inline;
	margin: 5px;
}
</style>

<style>
table {
	width: 1500px;
	background-color: white;
	margin: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 1px;
	text-align: center;
}
</style>

<style>
.myTable {
	width: 100%;
}

.myTable * {
	text-align: center;
}
</style>


</head>
<body bgcolor='white'>


	<table id="table-1">
		<tr>
			<td>
				<h3>所有文章</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/forumArt/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>

			<th>文章名稱:</th>
			<th>文章照片:</th>
			<th>文章內紹:</th>
			<th>文章發表時間</th>
			<th>文章狀態</th>
			<th>主廚編號</th>

		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="forumArtVO" items="${list}" varStatus="s"
			begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/forumArt/forumArt.do"
						style="margin-bottom: 0px;">
						<A
							href="<%=request.getContextPath()%>/forumArt/forumArt.do?forum_art_ID=${forumArtVO.forum_art_ID}&action=getAllForumArt">${forumArtVO.forum_art_name}
						</a>
					</FORM>
				</td>

				<td><img
					src="<%=request.getContextPath()%>/forumArt/forumArt.do?forum_art_ID=${forumArtVO.forum_art_ID}"
					width="300" height="200"></td>
				<td>${forumArtVO.forum_art_con}</td>
				<td><fmt:formatDate value="${forumArtVO.forum_art_start}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${forumArtVO.forum_art_status}</td>
				<td>${chefSvc.getOneChef(forumArtVO.chef_ID).chef_name}</td>

				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/forumArt/forumArt.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="送出查詢"> <input type="hidden"
							name="forum_art_ID" value="${forumArtVO.forum_art_ID}"> <input
							type="hidden" name="action" value="listAllForumArt_ByForumMsg">
					</FORM>

				</td>

			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

	<c:if test="${openModal!=null}">

		<div class="modal fade" id="basicModal" tabindex="-1" role="dialog"
			aria-labelledby="basicModal" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">

					<div class="modal-header">

						<h3 class="modal-title" id="myModalLabel">食神來了</h3>
					</div>

					<div class="modal-body">

						<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
						<jsp:include page="/back-end/forumArt/listOneForumArt.jsp" />

						<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>

					</div>

				</div>
			</div>
		</div>

		<script>
    		 $("#basicModal").modal({show: true});
        </script>
	</c:if>

</body>
</html>