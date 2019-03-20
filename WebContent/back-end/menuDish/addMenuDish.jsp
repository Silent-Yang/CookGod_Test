<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.menuDish.model.*"%>
<jsp:useBean id="menuSvc" scope="page" class="com.menu.model.MenuService" />
<jsp:useBean id="dishSvc" scope="page" class="com.dish.model.DishService" />
<%
  MenuDishVO menuDishVO = (MenuDishVO) request.getAttribute("MenuDishVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>新增套餐菜色</title>
   
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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


				<table id="table-1" style="background-color:blue;">
					<tr>
						<td>
							<h3>套餐菜色新增 - addMenuDish.jsp</h3>
						</td>
						<td>
							<h4>
								<a href="<%=request.getContextPath()%>/back-end/dish/select_page.jsp">回首頁</a>
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
				<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/menuDish/menuDish.do" >
					<table>
						<tr>
							<th>選擇套餐:</th>
							<td><input readonly type="text" name="menu_ID" value="${menuVO.Menu_ID}" /></td>
						</tr>
						<tr>
							<th>選擇菜色:</th>
							<td>
								
								<c:forEach var="menuDishVO" items="${dishSvc.all}"   varStatus="sc">
									<input type="checkbox" name="dish_ID" value="${menuDishVO.dish_ID}">
									<a href="<%=request.getContextPath()%>/menuDish/menuDish.do?dish_ID=${menuDishVO.dish_ID}&action=getDish">${dishSvc.getOneDish(menuDishVO.dish_ID).dish_name}</a>
								<c:if test="${sc.count%5 == 0 }">									
									<br>
								</c:if>	
								
								</c:forEach>
							</td>
						
						</tr>
						
					
					</table>
					<input type="hidden" name="action" value="insert">
					<input type="submit" value="送出"><br>
				</FORM>
			

	
<c:if test="${openModal!=null}">

<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
				
			<div class="modal-header">
                
                <h3 class="modal-title" id="myModalLabel">食神來了</h3>
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="/back-end/dish/listOneDish.jsp" />
               
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