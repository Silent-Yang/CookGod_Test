<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.chef.model.*"%>
>

<html>
<head>
<!-- Required meta tags -->
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
	width: 700px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
	
	
}

th, td {
	padding: 1px;
	width: 1px;
}
</style>


<title>主廚資料修改</title>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	<!-- ##### Breadcrumb Area Start ##### -->
	<jsp:include page="/froTempl/headerChef.jsp" flush="true" />
	<!-- ##### Breadcrumb Area End ##### -->

	<!-- ##### Contact Area Start #####-->
	<section class="contact-area section-padding-100">
		<section class="contact-area section-padding-100">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<!-- Section Heading -->
						<div class="section-heading text-center wow fadeInUp"
							data-wow-delay="100ms">

							<h2 style="font-weight: bold">主廚資料修改</h2>
							<img
								src="<%=request.getContextPath()%>/froTempl/temp/img/core-img/x.png"
								alt="">



							<%-- 錯誤表列 --%>
							<c:if test="${not empty errorMsgs}">
								<font style="color: red">請修正以下錯誤:</font>
								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color: red">${message}</li>
									</c:forEach>
								</ul>
							</c:if>

							<div class="row justify-content-center">
								<div class="col-12 col-lg-8">
									<!-- Contact Form -->
									<div class="contact-form-area text-center">
										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/chef/chef.do"
											name="form1">
											<table>
												<tr>
													<td>主廚編號:</td>
													<td>${chefVO.chef_ID}</td>
												</tr>
												<tr>
													<td><font color=red><b>*</b></font>主廚名稱:</td>
													<td>${custVO.cust_name}</td>
												</tr>
												<tr>
													<td>服務地區:</td>
													<td><input type="radio" name="chef_area" size="10"
														value="0"
														${chefVO.chef_area=='0'||chefVO ==null ? 'checked':'' }
														class="form-control wow fadeInUp" data-wow-delay="100ms" />北<br>
														<input type="radio" name="chef_area" size="10" value="1"
														${chefVO.chef_area=='1'? 'checked':'' }
														class="form-control wow fadeInUp" data-wow-delay="100ms" />中<br>
														<input type="radio" name="chef_area" size="10" value="2"
														${chefVO.chef_area=='2'? 'checked':'' }
														class="form-control wow fadeInUp" data-wow-delay="100ms" />南<br>
														<input type="radio" name="chef_area" size="10" value="3"
														${chefVO.chef_area=='3'? 'checked':'' }
														class="form-control wow fadeInUp" data-wow-delay="100ms" />東<br></td>
												</tr>
												<tr>
													<td>狀態:</td>
													<td>${chefStatusMap[chefVO.chef_status]}</td>
												</tr>
												<tr>
													<td>介紹:</td>
													<td><textarea name="chef_resume">${chefVO.chef_resume}</textarea>
														<script>
															CKEDITOR.replace('chef_resume');
														</script></td>
												</tr>
											</table>
											<br> <input type="hidden" name="action" value="update">
											<input type="hidden" name="chef_ID" value="${chefVO.chef_ID}">
											<input type="hidden" name="chef_status"
												value="${chefVO.chef_status}">
											<button type="submit" class="btn pixel-btn wow fadeInUp"
												data-wow-delay="300ms">送出</button>
										</form>
									</div>
								</div>
							</div>

						</div>
		</section>
		<!-- ##### Contact Area End #####-->



	</section>
	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>