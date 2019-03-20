<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Custom CSS -->
<link
	href="<%=request.getContextPath()%>/back-endTemplate/assets/libs/chartist/dist/chartist.min.css"
	rel="stylesheet">
<!-- Custom CSS -->
<link
	href="<%=request.getContextPath()%>/back-endTemplate/dist/css/style.min.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css"
	rel="stylesheet">
</head>
<body>
	<!-- All Jquery -->
	<!-- ============================================================== -->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/assets/libs/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tether Core JavaScript -->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/assets/libs/popper.js/dist/umd/popper.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- slimscrollbar scrollbar JavaScript -->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/assets/extra-libs/sparkline/sparkline.js"></script>
	<!--Wave Effects -->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/dist/js/waves.js"></script>
	<!--Menu sidebar -->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/dist/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/dist/js/custom.min.js"></script>
	<!--This page JavaScript -->
	<!--chartis chart-->
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/assets/libs/chartist/dist/chartist.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back-endTemplate/dist/js/pages/dashboards/dashboard1.js"></script>
	<script
		src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
	<header class="topbar" data-navbarbg="skin6">
		<nav class="navbar top-navbar navbar-expand-md navbar-light">
			<div class="navbar-header" data-logobg="skin5">

				<!-- ============================================================== -->
				<!-- End Logo -->
				<!-- ============================================================== -->
				<!-- ============================================================== -->
				<!-- Toggle which is visible on mobile only -->
				<!-- ============================================================== -->
				<a class="topbartoggler d-block d-md-none waves-effect waves-light"
					href="javascript:void(0)" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation"> <i class="ti-more"></i>
				</a>
			</div>
			<!-- ============================================================== -->
			<!-- End Logo -->
			<!-- ============================================================== -->
			<div class="navbar-collapse collapse" id="navbarSupportedContent"
				data-navbarbg="skin6">
				<!-- ============================================================== -->
				<!-- toggle and nav items -->
				<!-- ============================================================== -->
				<ul class="navbar-nav float-left mr-auto">
					<!-- ============================================================== -->
					<!-- Search -->
					<!-- ============================================================== -->
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>食材管理</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>訂單管理</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>顧客資料管理</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>合作夥伴</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/emp/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>員工管理</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/ad/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>廣告管理</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>菜色管理</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>審核檢舉文章</span>
								</div>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark"
						href="<%=request.getContextPath()%>/back-end/food/select_page.jsp">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>在線客服平台</span>
								</div>
							</div>
					</a></li>

					<li class="nav-item"><a
						class="nav-link waves-effect waves-dark">
							<div class="d-flex align-items-center">
								<i class="font-20 mr-1"></i>
								<div class="ml-1 d-none d-sm-block">
									<span>歡迎:<font color=red> ${empVO.emp_name} </font>您好
									</span>
								</div>
							</div>

							<li class="nav-item"><a
								class="nav-link waves-effect waves-dark">
									<div class="d-flex align-items-center">
										<i class="font-20 mr-1"></i>
										<div class="ml-1 d-none d-sm-block">
											<FORM METHOD="get"
												action="<%=request.getContextPath()%>/back-endTemplate/logout.do">
												<input type="submit" value="登出">
											</FORM>
										</div>
									</div>
							</a></li>
				</ul>

			</div>
		</nav>
	</header>
</body>
</html>