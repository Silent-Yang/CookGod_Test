package com.testuse;

import java.io.*;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

import com.ad.model.AdService;
import com.ad.model.AdVO;


import java.util.*;
import java.util.Map.Entry;


public class ScheduleServlet extends HttpServlet{    
    Timer timer ; 

    int count = 0;        
    public void destroy(){
        timer.cancel();
    }
    
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
    }
     //設定排程器       
    public void init(){        
    	ServletContext servletContext = getServletContext();
    	Set<javax.websocket.Session> webSessions = (Set<javax.websocket.Session>) servletContext.getAttribute("webSessions");
        timer = new Timer();
        Calendar cal = new GregorianCalendar(2019, Calendar.MARCH, 16, 0, 0, 0);        
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
            	
            	JsonObject jsonObject =null;
            	
            	int count = 0;
            	for(AdVO adVO: adVOs) {
            		Json.createObjectBuilder().add("adWall" + count++, adVO.getAd_con());
            	}
            	webSessions.forEach(webSession->webSession.getAsyncRemote().sendText(adCon.toString()
            			));
            
            
            }
        };

        timer.schedule(task, 10*1000);
    }
}