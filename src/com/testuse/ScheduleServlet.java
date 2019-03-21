package com.testuse;

import java.io.*;
import java.time.LocalTime;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.servlet.*;
import javax.servlet.http.*;


import com.ad.model.AdService;
import com.ad.model.AdVO;


import java.util.*;
import java.util.Map.Entry;


public class ScheduleServlet extends HttpServlet{    

    
    int count = 0;        
    public void destroy(){
    	
    	
    }
    
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
    }
     //設定排程器       
    public void init(){
    	Timer timer= new Timer();
    	getServletContext().setAttribute("Servlettimer", timer);
    	ServletContext servletContext = getServletContext();
    	Set<javax.websocket.Session> webSessions = (Set<javax.websocket.Session>) servletContext.getAttribute("webSessions");
        timer = new Timer();
        Calendar cal = new GregorianCalendar(2019, Calendar.MARCH, 20, 0, 0, 0);  
        LocalTime now = LocalTime.now();
        TimerTask task = new TimerTask(){
        	//設定排程器執行內容
            public void run(){
            	
            	
            	//方法一跑迴圈
            	//將現在時間&廣告開始&結束時間轉換成Long
//            	 Long time = System.currentTimeMillis();
//            	 AdVO adVO= new AdVO();
//            	 Long ad_start =adVO.getAd_start().getTime();
//            	 Long ad_end = adVO.getAd_end().getTime();
//            	 
//            	 //如果現在時間為廣告開始與結束之間，使用推播執行該廣告
//            	 if(time>=ad_start && time<=ad_end) {
//            		 String ad_con = adVO.getAd_con();
//            	}	 
            	
            	//方法二
            	AdService adSvc =new AdService();
            	List<AdVO> adVOs = adSvc.getAllNowAd();
            
            	JsonObjectBuilder jsObjBuilder = Json.createObjectBuilder();
            	JsonArrayBuilder jsArrBuilder = Json.createArrayBuilder();
            	
//            	int count = 0;
            	for(AdVO adVO: adVOs) {
            		JsonObject jsonObject = jsObjBuilder.add("ad_ID", adVO.getAd_ID()).add("ad_con", adVO.getAd_con()).add("ad_title",adVO.getAd_title()).build();
            		jsArrBuilder.add(jsonObject);
            	}
            	JsonArray jsArr = jsArrBuilder.build();
            	webSessions.forEach(webSession->webSession.getAsyncRemote().sendText(jsArr.toString()));
            
            
            }
        };

        timer.schedule(task, 10*1000);
//        timer.schedule(new task, 20*1000);
//        timer.scheduleAtFixedRate(task, 10*1000, 10*1000);
    }
}