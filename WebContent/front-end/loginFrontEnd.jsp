<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cust.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=Big5">
<title>前台login</title>
</head>
<body>
<center>
	<form action="<%=request.getContextPath()%>/front-end/login.do" method="post">
		
			<table border=1>
				<tr>
					<td colspan=2>
						<p align=center>
							輸入<b>前台(測試登入)</b>:<br> 
							帳號cust:<b>ccc</b>foodSup:<b>foodsupc2</b>chef:<b>custa2</b><br>
							密碼cust:<b>123</b>foodSup:<b>123456</b>chef:<b>123456</b><br>
					</td>
				</tr>

				<tr>
					<td>
						<p align=right>
							<b>account:</b>
					</td>
					<td>
						<p>
							<input type=text name="account" value="" size=15>
					</td>
				</tr>

				<tr>
					<td>
						<p align=right>
							<b>password:</b>
					</td>
					<td>
						<p>
							<input type=password name="password" value="" size=15>
					</td>
				</tr>


				<tr>
					<td colspan=2 align=center>
					
							<input type="hidden" name="action" value="cust"> 
							<input type=submit value="  ok   ">
						
					</td>
				</tr>
			</table>
	</form>
</center>
</body>
</html>