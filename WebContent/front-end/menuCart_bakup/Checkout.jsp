<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menu.model.*" %>

<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Mode II �d�ҵ{�� - Checkout.jsp</title>
</head>
<body bgcolor="#FFFFFF">
<img src="images/tomcat.gif"> <font size="+3">�����ѩ� - ���b </font>
<hr><p>

<table border="1">
	<tr bgcolor="#999999">
		<th width="200">�W</th>
		<th width="100">����</th>
		<th width="100">�ƶq</th>
	</tr>
	
	<%
		Vector<MenuVO> buylist = (Vector<MenuVO>) session.getAttribute("menuCartList");
		String amount =  (String) request.getAttribute("amount");
	%>	
	<%	for (int i = 0; i < buylist.size(); i++) {
			MenuVO order = buylist.get(i);
			String menu_name = order.getMenu_ID();
			int menu_price = order.getMenu_price();
			int menu_qty = order.getMenu_qty();
	%>
	<tr>
		<td width="200"><div align="center"><b><%=menu_name%></b></div></td>
		<td width="100"><div align="center"><b><%=menu_price%></b></div></td>
		<td width="100"><div align="center"><b><%=menu_qty%></b></div></td>
	</tr>
	<%}%>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td><div align="center"><font color="red"><b>�`���B�G</b></font></div></td>
		<td></td>
		<td> <font color="red"><b>$<%=amount%></b></font> </td>
		<td></td>
	</tr>
</table>
<p><a href="EShop.jsp">�O�_�~���ʪ�</a>
</body>
</html>