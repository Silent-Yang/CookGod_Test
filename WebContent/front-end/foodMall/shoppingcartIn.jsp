<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="foodMallSvc" class="com.foodMall.model.FoodMallService"/>
<jsp:useBean id="foodSvc" class="com.food.model.FoodService"/>
<jsp:useBean id="foodSupSvc" class="com.foodSup.model.FoodSupService" />
<jsp:useBean id="festMenuSvc" class="com.festMenu.model.FestMenuService"/>
<jsp:useBean id="checkType" class="com.mall.controller.CheckType"/>
<html>
<head>
</head>
<body>
	<p>
		<button class="btn btn-primary" type="button" data-toggle="collapse"
			data-target="#collapseShoppingCart" aria-expanded="false"
			aria-controls="collapseShoppingCart">購物車</button>
	</p>
	<div class="collapse" id="collapseShoppingCart">
		<div class="card card-body">
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">標題</th>
						<th scope="col">數量</th>
						<th scope="col">小計</th>
						<th scope="col">
							<form action="<%=request.getContextPath()%>/mall/mall.do"
								method="POST">
								<input type="hidden" name="action" value="CHECKOUTFOODMALL">
								<input type="submit" value="查看購物車" class="btn btn-dark">
								<input type="hidden" name="prePageURL" value="<%=request.getServletPath()%>">
							</form>
						</th>
					</tr>
				</thead>
				<tbody id="shopCartList">
					<c:forEach var="shopItem" items="${shoppingCart}">
						<tr class="shopItemT">
							<c:if test="${checkType.getIsFOD(shopItem)}">
								<td>${foodMallSvc.getOneFoodMall(shopItem.food_sup_ID, shopItem.food_ID).food_m_name}</td>
								<td>${shopItem.food_od_qty}</td>
								<td>${shopItem.food_od_stotal}</td>
								<td>
									<form action="<%=request.getContextPath()%>/mall/mall.do"
										method="post">
										<input type="hidden" name="food_sup_ID"
											value="${shopItem.food_sup_ID}"> 
										<input type="hidden"
											name="food_ID" value="${shopItem.food_ID}"> <input
											type="hidden" name="action" value="delShoppingCartItem">
										<button id="btnDel" type="button"
											class="btn btn-dark shoppingCartItemDel">刪除</button>
									</form>
								</td>
							</c:if>
							<c:if test="${!checkType.getIsFOD(shopItem)}">
								<td>${festMenuSvc.getOneFestMenu(shopItem.fest_m_ID).fest_m_name}</td>
								<td>${shopItem.fest_or_qty}</td>
								<td>${shopItem.fest_or_stotal}</td>
								<td>
									<form action="<%=request.getContextPath()%>/mall/mall.do"
										method="post">
										<input type="hidden" name="fest_m_ID" value="${shopItem.fest_m_ID}"> 
										<input type="hidden" name="action" value="delShoppingCartItem">
										<button id="btnDel" type="button" class="btn btn-dark shoppingCartItemDel">刪除</button>
									</form>
								</td>
							</c:if>
						</tr>
					</c:forEach>
					<tr id="copyShopIF" style="display: none">
						<td></td>
						<td></td>
						<td></td>
						<td>
							<form action="<%=request.getContextPath()%>/mall/mall.do"
								method="post">
								<input type="hidden">
								<input type="hidden">
								<input
									type="hidden" name="action" value="delShoppingCartItem">
								<button type="button" class="btn btn-dark shoppingCartItemDel">刪除</button>
							</form>
						</td>
					</tr>
					<tr id="copyShopFest" style="display:none">
						  <td></td>
						  <td></td>
						  <td></td>
						  <td>
						  	<form action="<%=request.getContextPath()%>/mall/mall.do"
								method="post">
							  	<input type="hidden">
							    <input type="hidden" name="action" value="delShoppingCartItem">
							  	<button type="button" class="btn btn-dark shoppingCartItemDel">刪除</button>
						  	</form>
						  </td>	
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		$(document).ready(function(){
				$(".shoppingCartItemDel").click(delShoppingCartItem);
		});
		// 發送刪除訊息
		function delShoppingCartItem(){
			let waitDelItem = $(this);
			console.log(waitDelItem.parent("form").serialize());
			$.ajax({
				type:"POST",
				url: waitDelItem.parent("form").attr("action"),
				data: waitDelItem.parent("form").serialize(),
				dataType:"json",
				success: function(data){
					actDelSCartItem(data);
				},
				error: function(errdata){
					alert("ajax 錯誤" + errdata);
					console.log(errdata);
				}
			});
		}
		// 刪除購物車項目
		function actDelSCartItem(data){
			let shopCartTrs = $("#shopCartList>tr");
			let shopCartLen = shopCartTrs.length;
			let food_sup_ID = data.food_sup_ID;
			let food_ID = data.food_ID;
			let fest_m_ID = data.fest_m_ID;
			
			jQuery.each( shopCartTrs, function(i, val){
				let inputArr = $(this).find("form").serializeArray();
				if(food_sup_ID === inputArr[0].value 
						&& inputArr[1].value === data.food_ID){
					$(this).remove();
					return;
				}
				console.log($(this));
				if(fest_m_ID === inputArr[0].value){
					console.log($(this));
					$(this).remove();
					return;
				}
			});
		}
	</script>
</body>
</html>