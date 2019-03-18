package com.testuse;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.broadcast.model.BroadcastService;
import com.broadcast.model.BroadcastVO;

@ServerEndpoint("/BroadCastServer/{cust_IDOremp_ID}")
public class BroadCastServer {
	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(@PathParam("cust_IDOremp_ID") String cust_IDOremp_ID, Session userSession) throws IOException {
		// 這時候應該就建立好連線了
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(cust_IDOremp_ID + ": 已連線");
		BroadcastService broadcastSvc = new BroadcastService();
		List<BroadcastVO> broadcastVOs = broadcastSvc.getOneBroadcastByCustID(cust_IDOremp_ID);
		//	要用哪個再研究, async or basic, 串接字串
		StringBuilder sb = new StringBuilder();
		for(BroadcastVO broadcastVO: broadcastVOs) {
			sb.append(broadcastVO.getBroadcast_ID()).append(broadcastVO.getBroadcast_start())
			.append(broadcastVO.getBroadcast_con()).append(broadcastVO.getBroadcast_status());
		}
		userSession.getAsyncRemote().sendText(sb.toString());
	}
	
	// 這部分可能是後端或哪裡要發通知會用到這
	@OnMessage
	public void onMessage(Session userSession, String message) {
		for (Session session : allSessions) {
			if (session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: " + message);
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}
}
