<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.forumArt.model.*"%>
<jsp:useBean id="chefSvc"      scope="page" class="com.chef.model.ChefService"/>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ForumArtVO forumArtVO = (ForumArtVO) request.getAttribute("forumArtVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>員工資料 - listOneForumart.jsp</title>

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
	width: 870px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneForumArt.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/forumArt/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>文章編號</th>
		<th>文章名稱</th>
		<th>文章照片</th>
		<th>文章內容</th>
		<th>文章狀態</th>
		<th>主廚編號</th>
	</tr>
	<tr>
		<td><%=forumArtVO.getForum_art_ID()%></td>
		<td><%=forumArtVO.getForum_art_name()%></td>
		<td><img src ="<%=request.getContextPath()%>/forumArt/forumArt.do?forum_art_ID=${forumArtVO.forum_art_ID}"  width="300" height="200"></td>
		<td><%=forumArtVO.getForum_art_con()%></td>
		<td><%=forumArtVO.getForum_art_status()%></td>
		<td>${chefSvc.getOneChef(forumArtVO.chef_ID).chef_name}</td> 
		
		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/forumArt/forumArt.do" style="margin-bottom: 0px;">
			     <input type="submit" value="審核">
			     <input type="hidden" name="forum_art_ID"  value="${forumArtVO.forum_art_ID}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/forumArt/forumArt.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="forum_art_ID"  value="${forumArtVO.forum_art_ID}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		
		
	</tr>
</table>

</body>
</html>