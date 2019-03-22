<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.chef.model.*"%>
<% //String chef_ID = request.getParameter(chef_ID); %>

<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<title>updateFavFdSup.jsp</title>
</head>
<body>
	<div class="card text-center" style="background-color: #D4E6F1">
		<div class="card-body">
			<h5 class="card-title">編輯主廚簡歷</h5>
			<a
				href="<%=request.getContextPath()%>/front-end/chef/chef_profile.jsp"
				class="btn btn-primary">回上一頁</a>
		</div>
	</div>

	<%--Error Message --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red; font-size: 20px;">Error:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="container justify-content-center">
		<div class="row">
			<div class="col-12">
				<form method="post" action="<%=request.getContextPath()%>/chef/chef.do">
					<jsp:useBean id="chef" scope="page" class="com.chef.model.ChefService" />
					
					<div class="form-group">
						<label>主廚編號</label> 
						<input type="text" readonly class="form-control" name="chef_ID" value="${chefVO.chef_ID}" />
					</div>

					<div class="form-group">
						<label>主廚簡介</label>
						<textarea readonly rows="3" cols="100" name="chef_resume" class="form-control">${chefVO.chef_resume}</textarea>
					</div>
					
					<%	
						String status[] = new String [4];
						status[0]="b0";
						status[1]="b1";
						status[2]="b2";
						status[3]="b3";
						request.setAttribute("mystatus", status);
					%>

					<div class="form-group">
						<label>主廚狀態</label> <select size="1" name="chef_status"
							class="form-control">
							<c:forEach var="mydata" items="${mystatus}">
								<option value="${mydata}"
									${(chefVO.chef_status==mydata)? 'selected':'' }>${mydata}
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="chef_channel" value="${chefVO.chef_channel}">
					<input type="hidden" name="chef_area" value="${chefVO.chef_area}">
					<input type="hidden" name="action" value="getOneForUpdate"> 
					<input type="submit" class="btn btn-success btn-lg btn-block" value="修改">
				</form>
			</div>
		</div>
	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">
	</script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous">
	</script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous">
	</script>
</body>
</html>