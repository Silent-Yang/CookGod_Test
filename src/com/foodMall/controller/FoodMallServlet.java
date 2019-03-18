package com.foodMall.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.foodMall.model.FoodMallService;
import com.foodMall.model.FoodMallVO;

@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class FoodMallServlet extends HttpServlet{

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		InputStream in = null;
		try {
			String food_ID = req.getParameter("food_ID");
			String food_sup_ID = req.getParameter("food_sup_ID");
			FoodMallService foodMallSvc = new FoodMallService();
			FoodMallVO foodMallVO = foodMallSvc.getOneFoodMall(food_sup_ID, food_ID);
			if(foodMallVO.getFood_m_pic() != null) {
				out.write(foodMallVO.getFood_m_pic());
			} else {
				in = getServletContext().getResourceAsStream("/back-end/food/images/null2.jpg");
				byte[] buff = new byte[in.available()];
				in.read(buff);
				out.write(buff);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(in != null) {
				in.close();
			}
			out.close();
		}
		
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if("getOne_For_Display".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("food_ID");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入食材編號");
				}
				
				String food_ID = str;
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end");
				}
				
			}catch(Exception e) {
				
			}
			
		}
		if("insert".equals(action)) { // 來自addFoodMall.jsp的請求  
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String food_m_name = req.getParameter("food_m_name");
				String food_m_nameReg = "^[(\\u4e00-\\u9fa5)]{1,30}$";
				if (food_m_name == null || food_m_name.trim().length() == 0) {
					errorMsgs.add("食材商品名稱:請勿空白");
				} else if(!food_m_name.trim().matches(food_m_nameReg)) {
					errorMsgs.add("食材商品名稱:只能是中文, 且長度必需在1~30之間");
				}
				
				String food_m_status = req.getParameter("food_m_status");
				Integer food_m_price = null;
				try{
					food_m_price = new Integer(req.getParameter("food_m_price"));
				}catch (NumberFormatException e) {
					food_m_price = 0;
					errorMsgs.add("食材價格請填數字");
				}
				
				String food_m_unit = req.getParameter("food_m_unit");
				String food_m_place = req.getParameter("food_m_place");
				if (food_m_place == null || food_m_place.trim().length() == 0) {
					errorMsgs.add("食材產地:請勿空白");
				}
				String food_ID = req.getParameter("food_ID");
				
				Part part = req.getPart("food_m_pic");
				byte[] food_m_pic = null;
				if(part.getSubmittedFileName().length() != 0 && part.getContentType() != null) {
					InputStream in = null;
					try {
						in = part.getInputStream();
						food_m_pic = new byte[in.available()];
					
						in.read(food_m_pic);
					}catch (IOException e) {
						errorMsgs.add("上傳圖片失敗:" + e.getMessage());
					}finally {
						if( in != null) {
							in.close();
						}
					}
				}else {
					errorMsgs.add("請放上圖片");
				}
				String food_m_resume = req.getParameter("food_m_resume");
				String food_sup_ID = req.getParameter("food_sup_ID");
				
				FoodMallVO foodMallVO = new FoodMallVO();
				foodMallVO.setFood_m_name(food_m_name);
				foodMallVO.setFood_m_status(food_m_status);
				foodMallVO.setFood_m_price(food_m_price);
				foodMallVO.setFood_m_unit(food_m_unit);
				foodMallVO.setFood_m_place(food_m_place);
				foodMallVO.setFood_ID(food_ID);
				foodMallVO.setFood_m_pic(food_m_pic);
				foodMallVO.setFood_m_resume(food_m_resume);
				foodMallVO.setFood_sup_ID(food_sup_ID);
					
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("foodMallVO", foodMallVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodSupManaMall/addFoodMall.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				FoodMallService foodMallService = new FoodMallService();
				foodMallVO = foodMallService.addFoodMall(food_sup_ID, food_ID, food_m_name, food_m_status,
						food_m_price, food_m_unit, food_m_place, food_m_pic, food_m_resume, 0);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = 
					"/front-end/foodSupManaMall/listAllFoodMall.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/foodSupManaMall/addFoodMall.jsp");
				failureView.forward(req, res);
			}
		}
	}
	
}
