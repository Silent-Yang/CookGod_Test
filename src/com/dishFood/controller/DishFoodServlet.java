package com.dishFood.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.food.model.*;
import com.dishFood.model.*;

public class DishFoodServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("listFoods_ByDish".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				String dish_ID = new String(req.getParameter("dish_ID"));
				
				DishFoodService dishFoodSvc = new DishFoodService();
				Set<DishFoodVO> set = dishFoodSvc.getFoodsByDish(dish_ID);
				
				req.setAttribute("listFoods_ByDish",set);
				
				String url = "/back-end/dish/listFoods_ByDish.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		

		// 單一查詢
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			// 菜色編號判斷
			String dish_ID = req.getParameter("dish_ID");
			
			String food_ID = req.getParameter("food_ID");
			
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/dishFood/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 2.開始查詢資料 *****************************************/
			DishFoodService dishFoodSvc = new DishFoodService();
			DishFoodVO dishFoodVO = dishFoodSvc.getOneDishFood(dish_ID, food_ID);
			if (dishFoodVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/dishFood/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("dishFoodVO", dishFoodVO); // 資料庫取出的empVO物件,存入req
			String url = "/dishFood/listOneDishFood.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/dish/select_page.jsp");
//				failureView.forward(req, res);
//			}
		}

		// 單一修改
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// try {
			/*************************** 1.接收請求參數 ****************************************/
			String dish_ID = new String(req.getParameter("dish_ID"));
			String food_ID = new String(req.getParameter("food_ID"));

			/*************************** 2.開始查詢資料 ****************************************/
			DishFoodService dishFoodSvc = new DishFoodService();
			DishFoodVO dishFoodVO = dishFoodSvc.getOneDishFood(dish_ID,food_ID);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("dishFoodVO", dishFoodVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/dishFood/update_dishFood_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/dish/listAllDish.jsp");
//				failureView.forward(req, res);
//			}
		}

		// 修改
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			// 菜色編號
			String dish_ID = new String(req.getParameter("dish_ID").trim());
			// 食材編號
			String food_ID = new String(req.getParameter("food_ID").trim());
			// 菜色數量
			Integer dish_f_qty = null;
			try {
				dish_f_qty = new Integer(req.getParameter("dish_f_qty").trim());
			} catch (NumberFormatException e) {
				dish_f_qty = 0;
				errorMsgs.add("請輸入菜色數量.");
			}
			// 菜色單位
			String dish_f_unit = req.getParameter("dish_f_unit");
			String dish_f_unitReg = "^[A-Za-z]{1,3}$";
			if (dish_f_unit == null || dish_f_unit.trim().length() == 0) {
				errorMsgs.add("食材單位: 請勿空白");
			} else if (!dish_f_unit.trim().matches(dish_f_unitReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("食材命名: 只能是中字 , 且長度必需在1到3之間");
			}
			

			DishFoodVO dishFoodVO = new DishFoodVO();

			dishFoodVO.setDish_ID(dish_ID);
			dishFoodVO.setFood_ID(food_ID);
			dishFoodVO.setDish_f_qty(dish_f_qty);
			dishFoodVO.setDish_f_unit(dish_f_unit);
			
			

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("dishFoodVO", dishFoodVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/dishFood/update_dishFood_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			DishFoodService dishFoodSvc = new DishFoodService();
			dishFoodVO = dishFoodSvc.updateDishFood(dish_ID,food_ID,dish_f_qty,dish_f_unit);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("dishFoodVO", dishFoodVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back-end/dishFood/listOneDishFood.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/dish/update_dish_input.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		if ("AllFood".equals(action)) { // 來自select_page.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			// try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			// 菜色編號判斷
			String dish_ID = req.getParameter("dish_ID");
			
			String[] food_IDArr= req.getParameterValues("food_ID");
			
			
			DishFoodVO dishFoodVO = null;
			List<DishFoodVO> dishFoodList = new ArrayList<>();
			
			for(int i = 0; i < food_IDArr.length; i++){
				dishFoodVO = new DishFoodVO();
				dishFoodVO.setDish_ID(dish_ID);
				dishFoodVO.setFood_ID(food_IDArr[i]);
				dishFoodList.add(dishFoodVO);
			}
			req.setAttribute("dishFoodList", dishFoodList); 
			
			String url = null;
			if("AllFood".equals(action));
			 url ="/back-end/dishFood/addDishFood.jsp";
					 
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/dish/select_page.jsp");
//				failureView.forward(req, res);
//			}
		}


		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				// 菜色編號
				String dish_ID = req.getParameter("dish_ID");
				String[] food_IDArr = req.getParameterValues("food_ID");
				System.out.println("food_IDArr="+food_IDArr.length);
				System.out.println(dish_ID);
//				//菜色重量
				Integer dish_f_qty = null;
				try {
					dish_f_qty = new Integer(req.getParameter("dish_f_qty").trim());
				} catch (NumberFormatException e) {
					dish_f_qty = 0;
					errorMsgs.add("請輸入食材數量.");
				}
				
				// 菜色單位
				String dish_f_unit = req.getParameter("dish_f_unit");
				String dish_f_unitReg = "^[A-Za-z]{1,3}$";
				if (dish_f_unit == null || dish_f_unit.trim().length() == 0) {
					errorMsgs.add("食材單位: 請勿空白");
				} else if (!dish_f_unit.trim().matches(dish_f_unitReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("菜色單位:只能輸入英文");
				}

				DishFoodVO dishFoodVO = new DishFoodVO();
				List<DishFoodVO> dishFoodList = new ArrayList<>();
				
				for(int i = 0; i < food_IDArr.length; i++){
					System.out.println(food_IDArr[i]);
					dishFoodVO.setDish_ID(dish_ID);
					dishFoodVO.setFood_ID(food_IDArr[i]);
					dishFoodVO.setDish_f_qty(dish_f_qty);
					dishFoodVO.setDish_f_unit(dish_f_unit);
					dishFoodList.add(dishFoodVO);
				}

				// Send the use back to the form, if there were errors
				req.setAttribute("listFoods_ByDish", dishFoodList); // 含有輸入格式錯誤的empVO物件,也存入req
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/dishFood/addDishFood.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/
				DishFoodService dishFoodSvc = new DishFoodService();
				for(String food_ID:food_IDArr) {
					dishFoodVO = dishFoodSvc.addDishFood(dish_ID, food_ID, dish_f_qty, dish_f_unit);
				}
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/dish/listFoods_ByDish.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/dishFood/addDishFood.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String dish_ID = new String(req.getParameter("dish_ID"));
				String food_ID = new String(req.getParameter("food_ID"));

				/*************************** 2.開始刪除資料 ***************************************/
				DishFoodService dishFoodSvc = new DishFoodService();
				dishFoodSvc.deleteDishFood(dish_ID,food_ID);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/dishFood/listAllDishFood.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/dishFood/listAllDishFood.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
