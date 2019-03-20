<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="custVO" class="com.cust.model.CustVO" />
<% custVO.setCust_ID("C00001"); %>

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
</head>
<body>




	<div id="statusOutput"></div>

	<div id="broadcastRcver"></div>


</body>
<script>
		var MyPoint = "/BroadCastServer";
		var host = window.location.host;
		var webCtx = '<%=request.getContextPath()%>';
		var userID = '<%=custVO.getCust_ID()%>';
		var endPointURL = "ws://" + host + webCtx + "/" + MyPoint + "/" + userID; 
		
		var statusOutput = document.getElementById("statusOutput");
		var webSocket;
		
		// 觸發connect()時註冊方法, 並建立WebSocket物件
		function connect() {
			//	建立 websocket 物件
			webSocket = new WebSocket(endPointURL);
			
			webSocket.onopen = function(event) {
				updateStatus("WebSocket 成功連線");
			};
			
			//	隨然我是在連線建立好時傳送訊息(ServerWebSocket), 依舊會觸發這個onmessage
			
			webSocket.onmessage = function(event) {
				var broadcastRcver = document.getElementById("broadcastRcver");
				broadcastRcver.innerText = broadcastRcver.innerText + event.data;
				window.alert("broadcastRcver");
			};

			webSocket.onclose = function(event) {
				
			};
		}
		
		
		
		function sendMessage() {
		    
		}

		
		function disconnect () {
			webSocket.close();
		}

		
		function updateStatus(newStatus) {
			statusOutput.innerHTML = newStatus;
		}
		
	</script>
</html>