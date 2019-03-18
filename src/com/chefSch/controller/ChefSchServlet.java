package com.chefSch.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chefSch.model.ChefSchService;
import com.chefSch.model.ChefSchVO;


public class ChefSchServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try {
				//1.接收參數
				String chef_ID = request.getParameter("chef_ID");
				Date chef_sch_date = null;
				try{
					chef_sch_date = Date.valueOf(request.getParameter("chef_sch_date"));
				}catch(Exception e) {
					chef_sch_date = null;
					errorMsgs.add("請選擇日期");
				}
				String chef_sch_status = request.getParameter("chef_sch_status");
				
				ChefSchVO chefSchVO = new ChefSchVO();
				chefSchVO.setChef_ID(chef_ID);
				chefSchVO.setChef_sch_date(chef_sch_date);
				chefSchVO.setChef_sch_status(chef_sch_status);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("chefSchVO", chefSchVO);
					RequestDispatcher errView = request.getRequestDispatcher("/chefSch/addChefSch.jsp"); 
					errView.forward(request, response);
					return;
				}
				//2.新增資料
				try{
					ChefSchService chefSchSvc = new ChefSchService();
					chefSchVO = chefSchSvc.addChefSch(chef_ID, chef_sch_date, chef_sch_status);
				}catch(Exception e){
					errorMsgs.add("排程已存在");
					request.setAttribute("chefSchVO", chefSchVO);
					RequestDispatcher errView = request.getRequestDispatcher("/chefSch/addChefSch.jsp"); 
					errView.forward(request, response);
					return;
				}
				//3.新增成功
				RequestDispatcher successView = request.getRequestDispatcher("/chefSch/listAllChefSch.jsp");
				successView.forward(request, response);				
			//其他可能的Error
			}catch(Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher errView = 
						request.getRequestDispatcher("/chefSch/addChefSch.jsp");
				errView.forward(request, response);
			}
		}
		
		if("getOneForUpdate".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try{
				//1.接收請求參數，並做錯誤判斷
				String chef_ID = request.getParameter("chef_ID");
				Date chef_sch_date = Date.valueOf(request.getParameter("chef_sch_date"));

				//2.開始查詢資料
				ChefSchService chefSchSvc = new ChefSchService();
				ChefSchVO chefSchVO = chefSchSvc.getOneChefSch(chef_ID, chef_sch_date);
				
				//3.查詢完成，準備轉交
				//資料庫取出的menuOrderVO物件,存入request
				request.setAttribute("chefSchVO", chefSchVO);
				RequestDispatcher successView = 
						request.getRequestDispatcher("/chefSch/updateChefSch.jsp");
				successView.forward(request, response);
			}catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher errView = 
						request.getRequestDispatcher("/chefSch/listAllChefSch.jsp");
				errView.forward(request, response);
			}	
		}
		
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try{
				//1.接收請求參數，並做錯誤判斷
				String chef_ID = request.getParameter("chef_ID");
				Date chef_sch_date = Date.valueOf(request.getParameter("chef_sch_date"));
				String chef_sch_status = request.getParameter("chef_sch_status");
				
				ChefSchVO chefSchVO = new ChefSchVO();
				chefSchVO.setChef_ID(chef_ID);
				chefSchVO.setChef_sch_date(chef_sch_date);
				chefSchVO.setChef_sch_status(chef_sch_status);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("chefSchVO", chefSchVO);
					RequestDispatcher errView = 
							request.getRequestDispatcher("/chefSch/updateChefSch.jsp");
					errView.forward(request, response);
					return;
				}
				
				//2.開始修改資料
				ChefSchService chefSchSvc = new ChefSchService();
				chefSchVO = chefSchSvc.update(chef_ID, chef_sch_date, chef_sch_status);
				chefSchVO = chefSchSvc.getOneChefSch(chef_ID, chef_sch_date);
				//3.修改完成，準備轉交
				request.setAttribute("chefSchVO", chefSchVO);
				RequestDispatcher successView = 
						request.getRequestDispatcher("/chefSch/listOneChefSch.jsp");
				successView.forward(request, response);
			}catch (Exception e) {
				errorMsgs.add("Update error:" + e.getMessage());
				RequestDispatcher errView = 
						request.getRequestDispatcher("/chefSch/updateChefSch.jsp");
				errView.forward(request, response);
			}	
		}
		if("delete".equals(action)) {			
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try {
				//1.接收參數
				String chef_ID = request.getParameter("chef_ID");
				Date chef_sch_date = Date.valueOf(request.getParameter("chef_sch_date"));
				//2.準備刪除
				ChefSchService chefSchSvc = new ChefSchService();
				chefSchSvc.delete(chef_ID, chef_sch_date);
				//3.刪除完成，準備轉交
				RequestDispatcher sucessView = request.getRequestDispatcher("/chefSch/listAllChefSch.jsp");
				sucessView.forward(request, response);
				//其他可能的錯誤處理
			}catch(Exception e){
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher errView = request.getRequestDispatcher("/chefSch/listAllChefSch.jsp");
				errView.forward(request, response);
			}
		}
	}
}
