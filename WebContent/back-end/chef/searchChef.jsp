<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="custSvc" class="com.cust.model.CustService"/>
<html>
<head>
<title></title>
</head>
<body>
	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true"/>
		<jsp:include page="/back-end/sideBar/foodSupMana.jsp" flush="true"/>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
<%--=================================工作區================================================--%>
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
		
						<div class="alert alert-success" role="alert">請輸入或選擇一位主廚以查詢</div>
						<jsp:useBean id="chefSvc" scope="page"
							class="com.chef.model.ChefService" />
		
						<form method="post"
							action="<%=request.getContextPath()%>/back-end/chef/listOneByChefID.jsp">
							<div class="input-group mb-3">
								<input type="text" class="form-control" name="chef_ID"
									placeholder="請輸入主廚編號">
								<div class="input-group-append">
									<input type="submit" class="btn btn-outline-secondary" value="送出">
								</div>
							</div>
						</form>
		
						<form method="post"
							action="<%=request.getContextPath()%>/back-end/chef/listOneByChefID.jsp">
							<div class="input-group">
								<select size="1" name="chef_ID" class="form-control">
									<option value="請選擇主廚編號">請選擇主廚編號
										<c:forEach var="chefVO" items="${chefSvc.all}">
											<option value="${chefVO.chef_ID}">${custSvc.getOneCust(chefVO.chef_ID).cust_name}
										</c:forEach>
								</select>
								<div class="input-group-append">
									<input type="submit" class="btn btn-outline-secondary" value="送出">
								</div>
							</div>
						</form>
		
						<form method="post" action="<%=request.getContextPath()%>/back-end/chef/listAllByChefArea.jsp">
							<div class="input-group">
								<select size="1" name="chef_area" class="form-control">
									<option value="請選擇服務地區">請選擇服務地區
									<option value="0">北</option>
									<option value="1">中</option>
									<option value="2">南</option>
									<option value="3">東</option>
								</select>
								<div class="input-group-append">
									<input type="submit" class="btn btn-outline-secondary" value="送出">
								</div>
							</div>
						</form>
						<form method="post" action="<%=request.getContextPath()%>/back-end/chef/listAllByMenuID.jsp">
							<div class="input-group">
								<jsp:useBean id="menuSvc" scope="page" class="com.menu.model.MenuService" />
								<select size="1" name="menu_ID" class="form-control">
									<option value="請選擇套餐編號">請選擇套餐</option>
									<c:forEach var="menuVO" items="${menuSvc.all}">
										<option value="${menuVO.menu_ID}">${menuVO.menu_name}</option>
									</c:forEach>
								</select>
								<div class="input-group-append">
									<input type="submit" class="btn btn-outline-secondary" value="送出">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
<%--=================================工作區================================================--%>			
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>