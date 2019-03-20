<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forumArt.model.*"%>

<%
  ForumArtVO forumArtVO = (ForumArtVO) request.getAttribute("forumArtVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>文章新增 - addForumArt.jsp</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>文章新增 - addForumArt.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/forumArt/select_page.jsp"><img
						src="images/tomcat.png" width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/forumArt/forumArt.do"
		name="form1" enctype="multipart/form-data">
		<table>

			<tr>
				<td>文章名稱:</td>
				<td><input type="TEXT" name="forum_art_name" size="45"
					value="<%= (forumArtVO==null)? "青蛙" : forumArtVO.getForum_art_name()%>" /></td>
			</tr>
			<tr>
				<td>文章照片:</td>
				<td><img id="preview_progressbarTW_img"
					src="<%=request.getContextPath()%>/back-end/images/null2.jpg"
					width="300" height="200" /> <input type="file" name="forum_art_pic"
					size="45" id="progressbarTWInput"
					value="<%= (forumArtVO==null)? "MANAGER" : forumArtVO.getForum_art_pic()%>" /><br></td>
			</tr>


			<tr>
				<td>文章內容:</td>
				<td><textarea rows="20" cols="40" name="forum_art_con"></textarea></td>
			</tr>

			<tr>
				<td>主廚編號:</td>
				<td><input type="TEXT" name="chef_ID" size="45"
					value="<%= (forumArtVO==null)? "C00001" : forumArtVO.getChef_ID()%>" /></td>
			</tr>



		</table>

		<script>

$("#progressbarTWInput").change(function(){

  readURL(this);

});

 

function readURL(input){

  if(input.files && input.files[0]){

    var reader = new FileReader();

    reader.onload = function (e) {

       $("#preview_progressbarTW_img").attr('src', e.target.result);

    }

    reader.readAsDataURL(input.files[0]);

  }

}

</script>

		<br> <input type="hidden" name="forum_art_status" value="A0">
		<input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>
</html>