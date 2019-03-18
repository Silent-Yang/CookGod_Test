package com.foodOrder.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;
import java.util.function.Function;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;

import com.cust.model.CustVO;
import com.festMenu.model.FestMenuService;
import com.festMenu.model.FestMenuVO;
import com.festOrder.model.FestOrderService;
import com.festOrder.model.FestOrderVO;
import com.festOrderDetail.model.FestOrderDetailVO;
import com.foodOrDetail.model.FoodOrDetailVO;
import com.foodOrder.model.FoodOrderService;
import com.foodOrder.model.FoodOrderVO;

public class FoodOrderServlet extends HttpServlet {
	JSONArray addrJson;

	public void init() {
		addrJson = readAddr();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();

		String action = req.getParameter("action");
		String cityID = req.getParameter("cityID");
		String areaID = req.getParameter("areaID");
		JSONArray resSelectAddr = null;
		if ("getCity".equals(action)) {
			resSelectAddr = new JSONArray();
			try {
				for (int i = 0; i < addrJson.length(); i++) {

					resSelectAddr.put(addrJson.getJSONObject(i).getString("CityName"));

				}
				out.write(resSelectAddr.toString());
				out.flush();
				out.close();
			} catch (JSONException e) {
				e.printStackTrace();
			}
			
		}

		if ("getSelect".equals(action)) {
			try {
				//	兩者皆不為空字串時, 會是true
				// 	null不等於空字串, 如果給的是空會是true
				if (!"".equals(cityID) && !"".equals(areaID)) {
					resSelectAddr = new JSONArray();

					JSONArray roadJsonArr = addrJson.getJSONObject(Integer.valueOf(cityID)).getJSONArray("AreaList")
							.getJSONObject(Integer.valueOf(areaID)).getJSONArray("RoadList");
					for (int i = 0; i < roadJsonArr.length(); i++) {
						resSelectAddr.put(roadJsonArr.getJSONObject(i).getString("RoadName"));
					}
					resSelectAddr.put(addrJson.getJSONObject(Integer.valueOf(cityID)).getJSONArray("AreaList")
							.getJSONObject(Integer.valueOf(areaID)).getString("ZipCode"));

				} else {

					resSelectAddr = new JSONArray();
					JSONArray areaJsonArr = addrJson.getJSONObject(Integer.valueOf(cityID)).getJSONArray("AreaList");

					for (int i = 0; i < areaJsonArr.length(); i++) {

						resSelectAddr.put(areaJsonArr.getJSONObject(i).getString("AreaName"));

					}
				}
				out.write(resSelectAddr.toString());
				out.flush();
				out.close();
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		// 利用action參數來決定要做哪個區塊的事
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("food_or_ID");

				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入食材編號");
				} 
				

				if (!errorMsgs.isEmpty()) {

					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/listAllFoodOrder.jsp");
					failureView.forward(req, res);
					return;
				}

				String food_or_ID = str;
				// Send the use back to the form, if there were errors

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/listAllFoodOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				
				FoodOrderVO foodOrderVO = foodOrderSvc.getOneFoodOrder(food_or_ID);
				if (foodOrderVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/listAllFoodOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				Set<FoodOrDetailVO> set = foodOrderSvc.getFoodOrDetailsByFood_or_ID(food_or_ID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				
				req.setAttribute("foodOrderVO", foodOrderVO); // 資料庫取出的FoodOrderVO物件,存入req
				/*********************/
				boolean openModal=true;
				req.setAttribute("openModal",openModal );	      
				req.setAttribute("listFoodOrDetails_ByFood_or_ID", set);
				/*********************/
				String url = "/back-end/foodOrder/listAllFoodOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);


				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/listAllFoodOrder.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Udate".equals(action)) { // 來自listAllFood.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				/*************************** 1.接收請求參數 ****************************************/
				String food_or_ID = req.getParameter("food_or_ID");
				/*************************** 2.開始查詢資料 ****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				FoodOrderVO foodOrderVO = foodOrderSvc.getOneFoodOrder(food_or_ID);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("foodOrderVO", foodOrderVO); // 資料庫取出的FoodOrderVO物件,存入req
				String url = "/back-end/foodOrder/update_foodOrder_input.jsp";
				RequestDispatcher sucessView = req.getRequestDispatcher(url);
				sucessView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/listAllFood.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_food_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String food_or_ID = req.getParameter("food_or_ID");
				String food_or_name = req.getParameter("food_or_name");
				String food_or_nameReg = "^[(\u4e00-\u9fa5)]{1,30}$";

				if (food_or_name == null || food_or_name.trim().length() == 0) {
					errorMsgs.add("食材名稱: 起勿空白");
				} else if (!food_or_name.trim().matches(food_or_nameReg)) {
					errorMsgs.add("食材名稱: 只能是中文且長度必需在1到30之間");
				}

				String food_or_addr = req.getParameter("food_or_addr").trim();
				if (food_or_addr == null || food_or_addr.trim().length() == 0) {
					errorMsgs.add("食材種類請勿空白");
				}

				FoodOrderVO foodOrderVO = new FoodOrderVO();
				foodOrderVO.setFood_or_ID(food_or_ID);
				foodOrderVO.setFood_or_name(food_or_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("foodOrderVO", foodOrderVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/update_food_input.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 *****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
//				FoodOrderVO = foodOrderSvc.updateFood(food_or_ID, food_or_name, food_or_addr);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("FoodOrderVO", foodOrderVO);
				String url = "/back-end/foodOrder/listOneFoodOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/update_foodOrder_input.jsp");
				failureView.forward(req, res);
			}

		}

		if ("insert".equals(action)) { // 來自addFoodOrder.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String food_or_name = req.getParameter("food_or_name");
				String food_or_nameReg = "^[(\u4e00-\u9fa5)]{1,30}$";
				if (food_or_name == null || food_or_name.trim().length() == 0) {
					errorMsgs.add("收件人 : 起勿空白");
				} else if (!food_or_name.trim().matches(food_or_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("收件人 : 只能是中文且長度必需在1到30之間");
				}

				String zipcode = req.getParameter("zipcode");
				if (zipcode == null || zipcode.trim().length() == 0) {
					errorMsgs.add("郵遞區號請勿空白");
				}
				
				Integer cityIn = null;
				try {
					cityIn = new Integer(req.getParameter("city").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("請選擇縣市");
				}
				
				Integer areaIn = null;
				try {
					areaIn = new Integer(req.getParameter("area").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("請選擇鄉鎮[市]區");
				}
				
				Integer roadIn = null;
				try {
					roadIn = new Integer(req.getParameter("road").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("請選擇路(街)名或鄉里");
				}
				
				String food_or_addrAfter = req.getParameter("food_or_addrAfter");
				if (food_or_addrAfter == null || food_or_addrAfter.trim().length() == 0) {
					errorMsgs.add("收件地址 : 起勿空白");
				}
				
				String food_or_addr = null;
				try {
					food_or_addr = zipcode + "-" + getPreAddr(cityIn, areaIn, roadIn) + food_or_addrAfter;
				} catch(JSONException e) {
					errorMsgs.add(e.getMessage());
				}
				
				String food_or_tel = req.getParameter("food_or_tel");
				String food_or_telReg = "^[\\d]{10}$";
				if (food_or_tel == null || food_or_tel.trim().length() == 0) {
					errorMsgs.add("收件人電話 : 起勿空白");
				} else if (!food_or_tel.trim().matches(food_or_telReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("收件人電話 : 09XXXXXXXX");
				}
				
				String cust_ID = req.getParameter("cust_ID");
				FoodOrderVO foodOrderVO = new FoodOrderVO();
				foodOrderVO.setFood_or_name(food_or_name);
				foodOrderVO.setFood_or_tel(food_or_tel);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("foodOrderVO", foodOrderVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/addFoodOrder.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				
				FoodOrderService foodOrderSvc = new FoodOrderService();
				foodOrderVO = foodOrderSvc.addFoodOrder("o0", food_or_name, food_or_addr, food_or_tel, cust_ID);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/foodOrder/listAllFoodOrder.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/foodOrder/addFoodOrder.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("listFoodOrDetails_ByFood_or_ID".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 ****************************************/
				String food_or_ID = req.getParameter("food_or_ID");

				/*************************** 2.開始查詢資料 ****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				Set<FoodOrDetailVO> set = foodOrderSvc.getFoodOrDetailsByFood_or_ID(food_or_ID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listFoodOrDetailsByFood_or_ID", set);    

				String url = "/back-end/foodOrder/listOneFoodOrder.jsp";
				             

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		if ("insertOrODs".equals(action)) { // 來自前端的請求
			insertOrODs(req, res);
		}

	}
	
	private void insertOrODs (HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);

		try {
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String food_or_name = req.getParameter("food_or_name");
			String food_or_nameReg = "^[(\u4e00-\u9fa5)]{1,30}$";
			if (food_or_name == null || food_or_name.trim().length() == 0) {
				errorMsgs.add("收件人 : 起勿空白");
			} else if (!food_or_name.trim().matches(food_or_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("收件人 : 只能是中文且長度必需在1到30之間");
			}

			String food_or_addr = req.getParameter("food_or_addr");
			if (food_or_addr == null || food_or_addr.trim().length() == 0) {
				errorMsgs.add("收件地址請勿空白");
			}
			
			
			String food_or_tel = req.getParameter("food_or_tel");
			String food_or_telReg = "^[\\d]{10}$";
			if (food_or_tel == null || food_or_tel.trim().length() == 0) {
				errorMsgs.add("收件人電話 : 起勿空白");
			} else if (!food_or_tel.trim().matches(food_or_telReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("收件人電話 : 09XXXXXXXX");
			}
			
			HttpSession session = req.getSession();
			@SuppressWarnings("unchecked")
			List<Object> shoppingCart = (Vector<Object>) session.getAttribute("shoppingCart");
			List<FoodOrDetailVO> foodCart = shoppingCart.stream()
					.filter(item -> item instanceof FoodOrDetailVO)
					.map(item -> {return (FoodOrDetailVO) item;})
					.collect(Collectors.toList());
			List<FestOrderDetailVO> festCart = shoppingCart.stream()
					.filter(item -> item instanceof FestOrderDetailVO)
					.map(item -> {return (FestOrderDetailVO) item;})
					.collect(Collectors.toList());
			
			String cust_ID =((CustVO) session.getAttribute("custVO")).getCust_ID();
			FoodOrderVO foodOrderVO = new FoodOrderVO();
			foodOrderVO.setFood_or_name(food_or_name);
			foodOrderVO.setFood_or_addr(food_or_addr);
			foodOrderVO.setFood_or_tel(food_or_tel);
			

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("foodOrderVO", foodOrderVO);
				RequestDispatcher failureView = req.getRequestDispatcher(req.getParameter("requestURL"));
				failureView.forward(req, res);
				return;
			}
			/*************************** 2.開始新增資料 ***************************************/
			if(foodCart.size() > 0) {
				FoodOrderService foodOrderSvc = new FoodOrderService();
				foodOrderVO = foodOrderSvc.addFoodOrder("o1", food_or_name, food_or_addr, food_or_tel, cust_ID, foodCart);
				req.setAttribute("foodOrderVO", foodOrderVO);
			}
			
			if(festCart.size() > 0) {
				List<FestOrderVO> festOrderVOs = new ArrayList<FestOrderVO>();
				FestOrderService festOrderSvc = new FestOrderService();
				FestMenuService fesMenuSvc = new FestMenuService();
				Map<java.sql.Date, List<FestOrderDetailVO>> festOrders = new LinkedHashMap<>();
				
				festOrders = festCart.stream()
						.collect(Collectors.groupingBy(
							festODVO -> fesMenuSvc.getOneFestMenu(festODVO.getFest_m_ID()).getFest_m_send()
						));
				
				festOrders.forEach((dateKey, festODVOs)->{
					FestOrderVO festOrderVO =
					festOrderSvc.insertFestOrder("o1", festODVOs.stream().mapToInt(
							FestOrderDetailVO::getFest_or_stotal).sum(), dateKey, cust_ID, festODVOs);
					festOrderVOs.add(festOrderVO);
				});
				req.setAttribute("festOrderList", festOrderVOs);
			}
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			String url = "/front-end/foodMall/comorder.jsp";
			session.removeAttribute("shoppingCart");
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 **********************************/
		} catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher(req.getParameter("requestURL"));
			failureView.forward(req, res);
		}
	}
	
	private String getPreAddr(int cityIn, int areaIn, int roadIn) throws JSONException {
		StringBuilder sb = new StringBuilder();
		sb.append(addrJson.getJSONObject(cityIn).getString("CityName"))
			.append("-").append(addrJson.getJSONObject(cityIn).getJSONArray("AreaList").getJSONObject(areaIn).getString("AreaName"))
			.append("-").append(
				addrJson.getJSONObject(cityIn).getJSONArray("AreaList").getJSONObject(areaIn)
					.getJSONArray("RoadList").getJSONObject(roadIn).getString("RoadName"));
		
		return sb.toString();
	}
	
	
	private JSONArray readAddr() {
		JSONArray addrJson = null;
		java.io.InputStream fio = getServletContext().getResourceAsStream("/file/addrNoEn.json");
		BufferedReader br = new BufferedReader(new InputStreamReader(fio));
		StringBuilder sb = new StringBuilder();
		try {
			String temp;
			while ((temp = br.readLine()) != null) {
				sb.append(temp);
			}
			addrJson = new JSONArray(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				fio.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return addrJson;
	}
	
}
