<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.chefSch.model.*"%>

<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<title>List_Chef_Sch_By_ID.jsp</title>
<style type="text/css">
	table{
		border: 2px solid gray;
		margin: 15px;
	}
	th,td{
		border:1px solid;
		width: 100px;
		height: 50px;
		text-align: center;
		padding:3px;
	}
</style>
</head>
<body>

	<%--Error Message--%>
	<c:if test = "${not empty errorMsgs} }">
		<font style="color:red;font-size:30px;">Error</font>
		<ul>
			<c:forEach var="errMsgs" items="${errorMsgs}">
				<li style="color:red;">${errMsgs}</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${listChefSchByChefID!=null}">
		<div class=chef_sch_date_title><p>請選擇日期</p></div>
		<div class="container justify-content-center">
	  		<div class="row">
	  			<c:forEach var="chefSchVO" items="${listChefSchByChefID}">
					<c:if test="${chefSchVO.chef_sch_status=='c0'}">
						<div class="col-2">
							<form method="post" action="<%=request.getContextPath()%>/chefSch/chefSch.do">
								<input type="hidden" name="action" value="setOrderDate">
								<input type="hidden" name="order_chef_sch_date" value="${chefSchVO.chef_sch_date}">
					  			<input type="submit" class="chef_sch_date btn btn-outline-secondary btn-block" value="${chefSchVO.chef_sch_date}">
					  		</form>
					  	</div>
					</c:if>
	  			</c:forEach>
	  		</div>
	  	</div>
  	</c:if> 	
<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
	</script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"	integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"	crossorigin="anonymous">
	</script>
	<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous">
	</script>
</body>
</html>