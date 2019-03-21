<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menu.model.*"%>
<html>
<head>
<title>The God of Cooking is Coming!</title>
<style type="text/css">
.col-4 {
	margin-top: 30px;
}

#spCart {
	cursor: pointer;
}

.card-img {
	width: 480px;
	height: 360px;
}
</style>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">
    	<div class="container-fliud">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="container-fliud">
					<div class="row" style="padding:50px;">
						<div class="col-5">
							<c:if test="${not empty menuVO.menu_pic}">
								<img class="card-img"
									src="<%=request.getContextPath()%>/menu/menu.do?showMenuPic=showMenuPic&menu_ID=${menuVO.menu_ID}">
							</c:if>
							<c:if test="${empty menuVO.menu_pic}">
								<img class="card-img"
									src="<%=request.getContextPath()%>/images/noimage.jpg">
							</c:if>
						</div>
						<div class="col-7">
							<div class="card-body">
								<form method="post"
									action="<%=request.getContextPath()%>/menu/menu.do">
									<h5 class="card-title">${menuVO.menu_name}</h5>
									<p class="card-text" style="height: 200px;">${menuVO.menu_resume}</p>
									<p class="card-text text-right">$${menuVO.menu_price}</p>
									<input type="hidden" name="menu_ID" value="${menuVO.menu_ID}">
									<input type="hidden" name="action" value="buyThisMenu">
									<input type="submit" class="btn btn-outline-secondary "
										style="float: right;" value="購買套餐">
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
    </section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>