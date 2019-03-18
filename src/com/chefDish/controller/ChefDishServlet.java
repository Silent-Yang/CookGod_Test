package com.chefDish.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chefDish.model.*;

public class ChefDishServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			try {
				//1.接收參數
				String chef_ID = request.getParameter("chef_ID");
				String dish_ID = request.getParameter("dish_ID");
				ChefDishVO chefDishVO = new ChefDishVO();
				chefDishVO.setChef_ID(chef_ID);
				chefDishVO.setDish_ID(dish_ID);
				//2.新增資料
				try{
					ChefDishService chefDishSvc = new ChefDishService();
					chefDishVO = chefDishSvc.addChefDish(chef_ID, dish_ID);
				}catch(Exception e){
					errorMsgs.add("擅長菜色已存在");
					request.setAttribute("chefDishVO", chefDishVO);
					RequestDispatcher errView = request.getRequestDispatcher("/chefDish/addChefDish.jsp"); 
					errView.forward(request, response);
					return;
				}
				//3.新增成功
				RequestDispatcher successView = request.getRequestDispatcher("/chefDish/listAllChefDish.jsp");
				successView.forward(request, response);				
			//其他可能的Error
			}catch(Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher errView = 
						request.getRequestDispatcher("/chefDish/addChefDish.jsp");
				errView.forward(request, response);
			}
		}
		if("getOneForUpdate".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try{
				//1.接收請求參數，並做錯誤判斷
				String chef_ID = request.getParameter("chef_ID");
				String dish_ID = request.getParameter("dish_ID");

				//2.開始查詢資料
				ChefDishService chefDishSvc = new ChefDishService();
				ChefDishVO chefDishVO = chefDishSvc.getOneChefDish(chef_ID, dish_ID);
				
				//3.查詢完成，準備轉交
				//資料庫取出的menuOrderVO物件,存入request
				request.setAttribute("chefDishVO", chefDishVO);
				RequestDispatcher successView = 
						request.getRequestDispatcher("/chefDish/updateChefDish.jsp");
				successView.forward(request, response);
			}catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher errView = 
						request.getRequestDispatcher("/chefDish/listAllChefDish.jsp");
				errView.forward(request, response);
			}	
		}
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try{
				//1.接收請求參數，並做錯誤判斷
				String chef_ID = request.getParameter("chef_ID");
				String dish_ID = request.getParameter("dish_ID");
				String chef_dish_status = request.getParameter("chef_dish_status");
				
				ChefDishVO chefDishVO = new ChefDishVO();
				chefDishVO.setChef_ID(chef_ID);
				chefDishVO.setDish_ID(dish_ID);
				chefDishVO.setChef_dish_status(chef_dish_status);
								
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("chefDishVO", chefDishVO);
					RequestDispatcher errView = 
							request.getRequestDispatcher("/chefDish/updateChefDish.jsp");
					errView.forward(request, response);
					return;
				}
				
				//2.開始修改資料
				ChefDishService cheDishSvc = new ChefDishService();
				chefDishVO = cheDishSvc.update(chef_ID, dish_ID, chef_dish_status);
				chefDishVO = cheDishSvc.getOneChefDish(chef_ID, dish_ID);
				//3.修改完成，準備轉交
				request.setAttribute("chefDishVO", chefDishVO);
				RequestDispatcher successView = 
						request.getRequestDispatcher("/chefDish/listOneChefDish.jsp");
				successView.forward(request, response);
			}catch (Exception e) {
				errorMsgs.add("Update error:" + e.getMessage());
				RequestDispatcher errView = 
						request.getRequestDispatcher("/chefDish/updateChefDish.jsp");
				errView.forward(request, response);
			}	
		}
		if("delete".equals(action)) {			
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try {
				//1.接收參數
				String chef_ID = request.getParameter("chef_ID");
				String dish_ID = request.getParameter("dish_ID");
				//2.準備刪除
				ChefDishService chefDishSvc = new ChefDishService();
				chefDishSvc.delete(chef_ID, dish_ID);
				//3.刪除完成，準備轉交
				RequestDispatcher sucessView = request.getRequestDispatcher("/chefDish/listAllChefDish.jsp");
				sucessView.forward(request, response);
				//其他可能的錯誤處理
			}catch(Exception e){
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher errView = request.getRequestDispatcher("/chefDish/listAllChefDish.jsp");
				errView.forward(request, response);
			}
		}
	}
}
