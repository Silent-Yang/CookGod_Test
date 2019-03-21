<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forumArt.model.*"%>

<%
  ForumArtVO forumArtVO = (ForumArtVO) request.getAttribute("forumArtVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>菜色資料修改 - update_forumArt_input.jsp</title>

<script 
  src="https://code.jquery.com/jquery-3.3.1.min.js"
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
	<tr><td>
		 <h3>文章內容修改 - update_forumArt_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/forumArt/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>文章修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="forumArt.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>文章編號:<font color=red><b>*</b></font></td>
		<td><%=forumArtVO.getForum_art_ID()%></td>
	</tr>
	<tr>
		<td>文章名稱:</td>
		<td><input type="TEXT" name="forum_art_name" size="45" value="<%=forumArtVO.getForum_art_name()%>" /></td>
	</tr>
	<tr>
		<td>文章照片:</td>
		<td><img id="preview_progressbarTW_img" src="<%=request.getContextPath()%>/forumArt/forumArt.do?forum_art_ID=${forumArtVO.forum_art_ID}"  width="300" height="200" width="300" height="200"/><br>
		<input type="file" name="forum_art_pic" value="<%=forumArtVO.getForum_art_pic()%>" /><br></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td><textarea rows="20" cols="40" name="forum_art_con"><%=forumArtVO.getForum_art_con()%></textarea></td>
	</tr>
	
	<tr>
		<td>主廚編號:</td>
		<td><input type="TEXT" name="chef_ID" size="45"	value="<%=forumArtVO.getChef_ID()%>" /></td>
	</tr>

 	<tr>
		<td>文章狀態</td>
		<td>
		<input type="radio" name="forumArtStatus" value="Shelf">發表
		<input type="radio" name="forumArtStatus" value="Obtained">隱藏</td>
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

<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="forum_art_ID" value="<%=forumArtVO.getForum_art_ID()%>">
<input type="hidden" name="forum_art_start" value="<%=forumArtVO.getForum_art_start()%>">
<input type="submit" value="送出修改"></FORM>
</body>
</html>