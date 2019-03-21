<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forumMsg.model.*,com.forumArt.model.*"%>
<%
	ForumMsgVO forumMsgVO = (ForumMsgVO) request.getAttribute("forumMsgVO");
	ForumArtVO forumArtVO = (ForumArtVO) request.getAttribute("forumArtVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>文章留言新增 - addForumMsg.jsp</title>
   
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
	width: 500px;
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
		 <h3>文章留言新增 - addForumMsg.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/dish/select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>留言資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/forumMsg/forumMsg.do" name="form1" >
<table>
	
	
	
	<tr>
		<td>文章編號:</td>
		<td><input type="TEXT" name="forum_art_ID" size="45"
			 value="<%= forumMsgVO.getForum_art_ID()%>" /></td>
	</tr>
	
	<tr>
		<td>留言內容:</td>
		<td><input type="TEXT" name="forum_msg_con" size="45"
			 value="<%= (forumMsgVO==null)? "MANAGER" : forumMsgVO.getForum_msg_con()%>" /></td>
	</tr>
	<tr>
		<td>留言狀態:</td>
		<td><input type="TEXT" name="forum_msg_status" size="45"
			 value="<%= (forumMsgVO==null)? "MANAGER" : forumMsgVO.getForum_msg_status()%>" /></td>
	</tr>
	<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="cust_ID" size="45"
			 value="<%= (forumMsgVO==null)? "MANAGER" : forumMsgVO.getCust_ID()%>" /></td>
	</tr>
<!--  	<tr>
    	<td>留言狀態:</td>
    	<td><input type="radio" name="stutas" value="display"> 顯示
  		<input type="radio" name="stutas" value="hide"> 隱藏</td>
    </tr>-->
	
</table>


<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>

</body>
</html>