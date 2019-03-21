<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chef.model.*"%>
<html>
<head>
<title>訂購套餐</title>
<style type="text/css">
.header {
	background-color: gray;
	height: 150px;
	width: 100%;
}

h2 {
	color: white;
	text-align: center;
	line-height: 130px;
}
input{
	margin-top:5px;
}
</style>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">
    	<%--Error Message--%>
	<c:if test="${not empty errorMsgs} }">
		<font style="color: red; font-size: 30px;">Error</font>
		<ul>
			<c:forEach var="errMsgs" items="${errorMsgs}">
				<li style="color: red;">${errMsgs}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="container-fliud">
		<div class="header">
			<h2>訂購套餐</h2>
		</div>
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<div class="container-fliud">
					<div class="row">
						<div class="col-12">
							已選擇套餐<br>
							<p class="card-text text-center">${menuVO.menu_name}</p>
							<c:if test="${not empty menuVO.menu_pic}">
								<img class="card-img-top" name="showMenuPic"
									src="<%=request.getContextPath()%>/menu/menu.do?showMenuPic=showMenuPic&menu_ID=${menuVO.menu_ID}"
									style="width: 100%; height: 250px;">
							</c:if>
							<c:if test="${empty menuVO.menu_pic}">
								<img class="card-img-top" name="showMenuPic"
									src="<%=request.getContextPath()%>/images/noimage.jpg"
									style="width: 100%; height: 250px;">
							</c:if>
							<p class="card-text text-right">$${menuVO.menu_price}</p>
							<input type="hidden" id="menu_ID" value="${menuVO.menu_ID}">
						</div>
					</div>
				</div>
				<c:if test="${listChefByMenuID!=null}">
					<p>請選擇地區主廚</p>
				</c:if>
				<div class="container-fliud">
					<div class="row">
						<div class="col-3">
							<p class="text-center">北部</p>
							<c:forEach var="chefVO" items="${listChefByMenuID}">
								<c:if test="${chefVO.chef_area == '0'}">
									<form method="post"
										action="<%=request.getContextPath()%>/chefSch/chefSch.do">
										<input type="submit"
											class="chef_ID btn btn-outline-secondary btn-block"
											name="chef_ID" value="${chefVO.chef_ID}"> <input
											type="hidden" name="action" value="listChefSchByID">
									</form>
								</c:if>
							</c:forEach>
						</div>
						<div class="col-3">
							<p class="text-center">中部</p>
							<c:forEach var="chefVO" items="${listChefByMenuID}">
								<c:if test="${chefVO.chef_area == '1'}">
									<form method="post"
										action="<%=request.getContextPath()%>/chefSch/chefSch.do">
										<input type="submit"
											class="chef_ID btn btn-outline-secondary btn-block"
											name="chef_ID" value="${chefVO.chef_ID}"> <input
											type="hidden" name="action" value="listChefSchByID">
									</form>
								</c:if>
							</c:forEach>
						</div>
						<div class="col-3">
							<p class="text-center">南部</p>
							<c:forEach var="chefVO" items="${listChefByMenuID}">
								<c:if test="${chefVO.chef_area == '2'}">
									<form method="post"
										action="<%=request.getContextPath()%>/chefSch/chefSch.do">
										<input type="submit"
											class="chef_ID btn btn-outline-secondary btn-block"
											name="chef_ID" value="${chefVO.chef_ID}"> <input
											type="hidden" name="action" value="listChefSchByID">
									</form>
								</c:if>
							</c:forEach>
						</div>
						<div class="col-3">
							<p class="text-center">東部</p>
							<c:forEach var="chefVO" items="${listChefByMenuID}">
								<c:if test="${chefVO.chef_area == '3'}">
									<form method="post"
										action="<%=request.getContextPath()%>/chefSch/chefSch.do">
										<input type="submit"
											class="chef_ID btn btn-outline-secondary btn-block"
											name="chef_ID" value="${chefVO.chef_ID}"> <input
											type="hidden" name="action" value="listChefSchByID">
									</form>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="chef_sch_date">
						<%@ include file="/front-end/chefSch/listChefSchDateByID.jsp"%>
					</div>
					<c:if test="${order_chef_sch_date!=null}">
						<div class="chef_sch_time">
							<div class=chef_sch_time_title>
								<p>請選擇日期</p>
							</div>
							<form method="post"
								action="<%=request.getContextPath()%>/menuOrder/menuOrder.do">
								<input type="text" name="menu_od_book_time" class="form-control"
									id="order_sch_date_time" /> <input type="hidden"
									name="menu_od_book_date" value="${order_chef_sch_date}">
								<input type="hidden" name="chef_ID" value="${order_chef_ID}">
								<input type="hidden" name="cust_ID" value="C00002"> <input
									type="hidden" name="menu_ID" value="${menuVO.menu_ID}">
								<input type="hidden" name="action" value="insert"><br>
								<input type="submit" class="btn btn-outline-secondary btn-block"
									value="送出訂單">
							</form>
						</div>
					</c:if>
				</div>
			</div>
			<div class="col-3"></div>
		</div>
		<div class="footer"></div>
	</div>
    </section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#order_sch_date_time').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 15,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'H:i:s' ,         //format:'Y-m-d H:i:s',
		   value: '${order_chef_sch_date}' , // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate: '${order_chef_sch_date}',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-04-01'  // 去除今日(不含)之後
        });
        
        var somedate = new Date('${order_chef_sch_date}');
        
        $('#order_sch_date_time').datetimepicker({
            beforeShowDay: function(date) {
          	  if (  date.getYear() <  somedate.getYear() || 
  		           (date.getYear() == somedate.getYear() && date.getMonth() <  somedate.getMonth()) || 
  		           (date.getYear() == somedate.getYear() && date.getMonth() == somedate.getMonth() && date.getDate() < somedate.getDate())
  		             ||
  		            date.getYear() >  somedate.getYear() || 
  		           (date.getYear() == somedate.getYear() && date.getMonth() >  somedate.getMonth()) || 
  		           (date.getYear() == somedate.getYear() && date.getMonth() == somedate.getMonth() && date.getDate() > somedate.getDate())
                ) {
                     return [false, ""]
                }
                return [true, ""];
        }});
</script>
</html>