<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forumMsg.model.*"%>

<%
  ForumMsgVO forumMsgVO = (ForumMsgVO) request.getAttribute("forumMsgVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>留言資料修改 - update_forumMsg_input.jsp</title>

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
		 <h3>留言資料修改 - update_forumMsg_input.jsp</h3>
		 <h4><a href=<%=request.getContextPath()%>/back-end/dish/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>菜色修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="forumMsg.do" name="form1" >
<table>
	
	<tr>
		<td>文章編號:<font color=red><b>*</b></font></td>
		<td><%=forumMsgVO.getForum_art_ID()%></td>
	</tr>
	<tr>
		<td>留言編號:<font color=red><b>*</b></font></td>
		<td><%=forumMsgVO.getForum_msg_ID()%></td>
	</tr>
	<tr>
		<td>留言內容:</td>
		<td><input type="TEXT" name="forum_msg_con" size="45" value="<%= forumMsgVO.getForum_msg_con()%>" /></td>
	
	<tr>
		<td>留言狀態:</td>
		<td><input type="TEXT" name="forum_msg_status" size="45" value="<%= forumMsgVO.getForum_msg_status()%>" /></td>
	
	<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="cust_ID" size="45" value="<%= forumMsgVO.getCust_ID()%>" /></td>
	</td>

</table>

<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="forum_msg_ID" value="<%=forumMsgVO.getForum_msg_ID()%>">
<input type="hidden" name="forum_art_ID" value="<%=forumMsgVO.getForum_art_ID()%>">
<input type="hidden" name="forum_msg_start" value="<%=forumMsgVO.getForum_msg_start()%>">
<input type="submit" value="送出修改"></FORM>
</body>
</html>