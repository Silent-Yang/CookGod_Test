<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.foodOrder.model.FoodOrderVO"%>
<html>
<head>
<jsp:useBean id="custVO" scope="session" class="com.cust.model.CustVO">
	<jsp:setProperty name="custVO" property="cust_ID" value="C00015"></jsp:setProperty>
</jsp:useBean>
<% FoodOrderVO foodOrderVO = (FoodOrderVO)request.getAttribute("foodOrderVO");%>
<title></title>
</head>
<body>
	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true" />
		<aside class="left-sidebar" data-sidebarbg="skin5">
			<jsp:include page="/back-end/foodOrder/sidebar.jsp" flush="true" />
		</aside>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<%--=================================工作區================================================--%>
				<div class="container-fluid">
					<!-- ============================================================== -->
					<!-- Start Page Content -->
					<!-- ============================================================== -->
					<%-- 錯誤列表 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color: red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					<div class="row">
						<div class="col-12">
							<div class="card card-body">
								<h4 class="card-title">新增食材商城訂單</h4>
								<form class="form-horizontal m-t-30" method="post"
									action="<%=request.getContextPath()%>/foodOrder/foodOrder.do">
									<div class="form-group">
										<label>收件人姓名</label> <input type="text" class="form-control"
											name="food_or_name"
											value="${empty foodOrderVO ? '': foodOrderVO.food_or_name}">
									</div>
									<div class="form-group">
										<label>收件地址</label> <input id="zipcode" name="zipcode"
											class="form-control" type="text" readonly> <select
											id="city" name="city" size="1" class="form-control"></select>
										<select id="area" name="area" size="1" class="form-control">
											<option value="-1"></option>
										</select> <select id="road" name="road" size="1" class="form-control">
											<option value="-1"></option>
										</select> <input type="text" name="food_or_addrAfter"
											class="form-control" />
									</div>
									<div class="form-group">
										<label>收件人電話</label> <input type="text" name="food_or_tel"
											class="form-control" placeholder="09XXXXXXXX"
											value="${empty foodOrderVO ? '':foodOrderVO.food_or_tel}">
									</div>

									<input type="hidden" name="cust_ID" value="${custVO.cust_ID}">
									<input type="hidden" name="action" value="insert"> <input
										class="btn btn-success" type="submit" value="結帳">
								</form>
							</div>
						</div>
					</div>
					<!-- ============================================================== -->
					<!-- End PAge Content -->
					<!-- ============================================================== -->
					<!-- ============================================================== -->
					<!-- Right sidebar -->
					<!-- ============================================================== -->
					<!-- .right-sidebar -->
					<!-- ============================================================== -->
					<!-- End Right sidebar -->
					<!-- ============================================================== -->
				</div>

				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
			</div>
		</div>
	</div>
	<script>
		
		$(document).ready(
				
			function(){
				
				$.ajax({
					type:'GET',
					url:'<%=request.getContextPath()%>/foodOrder/foodOrder.do',
					data:{"action":"getCity"},
					dataType: "json",
					success: function(data){
						$('#city').append("<option value='-1'>請選擇縣市</option>");
						$.each(data, function(i, item){
							$('#city').append("<option value='"+i+"'>"+item+"</option>");
						});
						$('#area').append("<option value='-1'></option>");
						$('#road').append("<option value='-1'></option>");
					},
					error:function(){
						alert("ajax錯誤");
					}
				});
				
				
				$('#city').change(function(){
					$.ajax({
						type:'GET',
						url:'<%=request.getContextPath()%>/foodOrder/foodOrder.do',
						data:{"action":"getSelect", "cityID":$(this).val(), "areaID":""},
						dataType: "json",
						success: function(data){
							
							clearAreaRoadSelect();
							$.each(data, function(i, item){
								
								
								$('#area').append("<option value='"+i+"'>"+item+"</option>");
							});
						},
						error:function(){
							alert("ajax錯誤");
						}
					});
				});
				
				$('#area').change(function(){
					$.ajax({
						type:'GET',
						url:'<%=request.getContextPath()%>/foodOrder/foodOrder.do',
						data:{"action":"getSelect", "cityID":$('#city').val(), "areaID":$(this).val()},
						dataType: "json",
						success: function(data){
							clearRoadSelect();
							$.each(data, function(i, item){
								var length = data.length;
								if(i < length -1)
									$('#road').append("<option value='"+i+"'>"+item+"</option>");
								else
									$('#zipcode').val(item);
							});
						},
						error:function(){
							alert("ajax錯誤");
						}
					});
				})
			}
		);
		
		function clearAreaRoadSelect(){
			$('#area').empty();
			$('#area').append("<option value='-1'>請選擇鄉鎮[市]區</option>");
			$('#road').empty();

		}
		
		function clearRoadSelect(){
			$('#road').empty();
			$('#road').append("<option value='-1'>請選擇路(街)名或鄉里</option>");
		}
		
	</script>
</body>
</html>