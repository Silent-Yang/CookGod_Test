package com.broadcast.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.ad.model.AdService;
import com.ad.model.AdVO;
import com.broadcast.model.BroadcastService;
import com.broadcast.model.BroadcastVO;
import com.google.gson.Gson;
import com.menuOrder.model.MenuOrderService;
import com.menuOrder.model.MenuOrderVO;
@ServerEndpoint("/WebSocketForServlet")
public class WebSocketForServlet implements ServletContextListener{
	private static Set<Session> webSessions = Collections.synchronizedSet(new HashSet<>());
	Gson gson = new Gson();
	@Override
	public void contextInitialized(ServletContextEvent event) {
		ServletContext servletContext = event.getServletContext();
		servletContext.setAttribute("webSessions", webSessions);
		Timer timer= new Timer();
		servletContext.setAttribute("Servlettimer", timer);
	}
	

	@OnOpen
	public void onOpen( Session userSession) throws IOException {
		// 設定成500KB為了配合Android bundle傳送大小
//		int maxBufferSize = 500 * 1024;
//		userSession.setMaxTextMessageBufferSize(maxBufferSize);
//		userSession.setMaxBinaryMessageBufferSize(maxBufferSize);
		
		webSessions.add(userSession);
		AdService adSvc =new AdService();
    	List<AdVO> adVOs = adSvc.getAllNowAd();
    
    	
    	
    	JsonObjectBuilder jsObjBuilder = Json.createObjectBuilder();
    	JsonArrayBuilder jsArrBuilder = Json.createArrayBuilder();
    	
    	for(AdVO adVO: adVOs) {
    		JsonObject jsonObject = jsObjBuilder.add("ad_ID", adVO.getAd_ID()).add("ad_con", adVO.getAd_con()).add("ad_title",adVO.getAd_title()).build();
    		jsArrBuilder.add(jsonObject);
    	}
    	JsonArray jsArr = jsArrBuilder.build();
    	userSession.getAsyncRemote().sendText(jsArr.toString());


	}

	// 此方法接收String型式資料
	@OnMessage
	public void onMessage(Session userSession, String message) {

		

	
	}


	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		
	}


	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext servletContext = sce.getServletContext();
		Timer timer = (Timer) servletContext.getAttribute("Servlettimer");
    	timer.cancel();
		ServletContextListener.super.contextDestroyed(sce);
	}
	
	
}
