package com.broadcast.controller;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnOpen;
import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.broadcast.model.BroadcastService;
import com.broadcast.model.BroadcastVO;
import com.google.gson.Gson;
import com.menuOrder.model.MenuOrderService;
import com.menuOrder.model.MenuOrderVO;



@ServerEndpoint("/BroadcastSocket/{userName}")
public class BroadcastSocket {
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("userName") String userName, Session userSession) throws IOException {
		// 設定成500KB為了配合Android bundle傳送大小
		int maxBufferSize = 500 * 1024;
		userSession.setMaxTextMessageBufferSize(maxBufferSize);
		userSession.setMaxBinaryMessageBufferSize(maxBufferSize);
		/* save the new user in the map */
		sessionsMap.put(userName, userSession);
		/* Sends all the connected users to the new user */
		Set<String> userNames = sessionsMap.keySet();
		State stateMessage = new State("open", userName, userNames);
		String stateMessageJson = gson.toJson(stateMessage);
		Collection<Session> sessions = sessionsMap.values();
		//session登入登出的顯示訊息
//		for (Session session : sessions) {
//			session.getAsyncRemote().sendText(stateMessageJson);
//		}

		String text = String.format(
				"Session ID = %s, connected; userName = %s%nusers: %s%nmaxTextMessageBufferSize = %s",
				userSession.getId(), userName, userNames, userSession.getMaxTextMessageBufferSize());
		System.out.println(text);
	}

	// 此方法接收String型式資料
	@OnMessage
	public void onMessage(Session userSession, String message) {
//		System.out.println("message received: " + message);
		MenuOrderVO menuOrderVO = gson.fromJson(message, MenuOrderVO.class);
		
		List<String>
	
		MenuOrderService menuOrderService = new MenuOrderService();
		BroadcastService broadcastService = new BroadcastService();
		StringBuilder broadcast_con_sb = new StringBuilder();
		broadcast_con_sb.append("訂單推播通知；您在")
				.append((menuOrderService.getOneMenuOrder(menuOrderVO.getMenu_od_ID()).getMenu_od_start()).toString())
				.append("所訂購的嚴選套餐訂單");

		if ("g1".equals(menuOrderVO.getMenu_od_status())) {
			broadcast_con_sb.append("已通過審核");

		} else if ("g2".equals(menuOrderVO.getMenu_od_status())) {
			broadcast_con_sb.append("未通過審核");
		}

		BroadcastVO broadcastVO=broadcastService.addBroadcast(broadcast_con_sb.toString(),menuOrderService.getOneMenuOrder(menuOrderVO.getMenu_od_ID()).getCust_ID());
		
		
		String receiver = menuOrderVO.getCust_ID();
		String sentMessage=gson.toJson(broadcastVO);
		Session receiverSession = sessionsMap.get(receiver);
		if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(sentMessage);
		}
	}


	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
			}
		}

		if (userNameClose != null) {
			State stateMessage = new State("close", userNameClose, userNames);
			String stateMessageJson = gson.toJson(stateMessage);
			Collection<Session> sessions = sessionsMap.values();
			for (Session session : sessions) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), userNames);
		System.out.println(text);
	}
}
