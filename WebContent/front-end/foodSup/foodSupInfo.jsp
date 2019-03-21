<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />

	 <!-- ##### Contact Area Start #####-->
    <section class="contact-area section-padding-100">
    	<div class="container">
		  <div class="row">
		    <div class="col-sm">
		    	<table class="table">
				  <tbody>
				    <tr>
				      <td>食材供應商名</td>
				      <td>${foodSupVO.food_sup_name}</td>
				    </tr>
				    <tr>
				      <td>聯絡電話</td>
				      <td>${foodSupVO.food_sup_tel}</td>
				    </tr>
				    <tr>
				      <td>狀態</td>
				      <td>${foodSupStatusMap[foodSupVO.food_sup_status]}</td>
				    </tr>
				    <tr>
				      <td>介紹</td>
				      <td>${foodSupVO.food_sup_resume}</td>
				    </tr>
				  </tbody>
				</table>
		    </div>
		    <div class="col-sm">
		    	<table class="table">
				  <tbody>
				  	<tr>
				      <td>帳號</td>
				      <td>${custVO.cust_acc}</td>
				    </tr>
				    <tr>
				      <td>密碼</td>
				      <td>${custVO.cust_pwd}</td>
				    </tr>
				    <tr>
				      <td>聯絡人姓名</td>
				      <td>${custVO.cust_name}</td>
				    </tr>
				    <tr>
				      <td>聯絡人性別</td>
				      <td>${custVO.cust_sex}</td>
				    </tr>
				    <tr>
				      <td>聯絡人電話</td>
				      <td>${custVO.cust_tel}</td>
				    </tr>
				    <tr>
				      <td>地址</td>
				      <td>${custVO.cust_addr}</td>
				    </tr>
				    <tr>
				      <td>聯絡人身分證字號</td>
				      <td>${custVO.cust_pid}</td>
				    </tr>
				    <tr>
				      <td>E_Mail</td>
				      <td>${custVO.cust_brd}</td>
				    </tr>
				    <tr>
				      <td>聯絡人生日</td>
				      <td>${custVO.cust_brd}</td>
				    </tr>
				    <tr>
				      <td>聯絡人註冊日期</td>
				      <td>${custVO.cust_pid}</td>
				    </tr>
				    <tr>
				      <td>照片</td>
				      <td>${custVO.cust_pic}</td>
				    </tr>
				    <tr>
				      <td>聯絡人暱稱</td>
				      <td>${custVO.cust_niname}</td>
				    </tr>
				  </tbody>
				</table>
		    </div>
		    <div class="col-sm">
		      
		    </div>
		  </div>
		</div>
    </section>
    <!-- ##### Contact Area End #####-->

	<jsp:include page="/froTempl/footer.jsp" flush="true" />
</body>
</html>