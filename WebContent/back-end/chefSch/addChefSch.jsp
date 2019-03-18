<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.chefSch.model.*"%>

<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<title>新增主廚排程</title>
</head>
<body>
	<div class="card text-center" style="background-color: #D4E6F1">	  
	  <div class="card-body" >
	    <h5 class="card-title">新增主廚排程</h5>
	    <p class="card-text">addChefSch.jsp</p>
	    <a href="index.jsp" class="btn btn-primary">回首頁</a>
	  </div>
	</div>
	
	<%--Error Message --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red;font-size:20px;">Error:</font>
		<ul>
		    <c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="container justify-content-center">
  		<div class="row">
  			<div class="col-12">
				<form method = "post" action = "chefSch.do">	
					<div class="form-group">
			    		<label>排程日期</label>
			    		<input name="chef_sch_date" class="form-control" id="sch_date" type="text"/>${errMsgs.chef_sch_date}
				  	</div>
				  	
				  	<div class="form-group">
				 		<jsp:useBean id="chefSvc" scope="page" class="com.chef.model.ChefService" />
				    	<label>主廚編號</label>
				    	<select size="1" name="chef_ID" class="form-control">
				     		<c:forEach var="chefVO" items="${chefSvc.all}">
								<option value="${chefVO.chef_ID}" ${(menuOrderVO.chef_ID==cheftVO.chef_ID)? 'selected':'' } >${chefVO.chef_ID}
							</c:forEach>
				    	</select>
				  	</div>
				  	
				  	<div class="form-group">
				    	<label>排程狀態</label><br>
				    	<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="chef_sch_status" value="0" checked>
						  <label class="form-check-label">
						    有空
						  </label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="chef_sch_status" value="1">
						  <label class="form-check-label">
						    沒空
						  </label>
						</div>
				  	</div>
					<input type="hidden" name="action" value="insert">
					<input type="submit" class="btn btn-success btn-lg btn-block" value="新增訂單">		
				</form>
			</div>
  		</div>
  	</div>
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
	</script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"	integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"	crossorigin="anonymous">
	</script>
	<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous">
	</script>
</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<% 
  java.sql.Timestamp chef_sch_date = null;
  try {
	  	chef_sch_date = java.sql.Timestamp.valueOf(request.getParameter("chef_sch_date").trim());
   } catch (Exception e) {
	    chef_sch_date = null;
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#sch_date').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       //step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d' ,         //format:'Y-m-d H:i:s',
		   //value: '<%=chef_sch_date%>' , // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前
           maxDate:               '+1970-04-01'  // 去除今日(不含)之後
        });
</script>
</html>