package com.foodOrDetail.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.festOrderDetail.model.FestOrderDetailVO;
import com.foodOrDetail.model.FoodOrDetailService;
import com.foodOrDetail.model.FoodOrDetailVO;
import com.foodOrder.model.FoodOrderService;
import com.foodOrder.model.FoodOrderVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class FoodOrDetailServlet extends HttpServlet {
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("fsUpdateFoodODstatus".equals(action)) {
			fsUpdateFoodODstatus(req, res);
		} else if("custUpODRateS".equals(action)) {
			
		} else if("backUpFODStatus".equals(action)) {
			// 更新fod的狀態, 並檢查是否所有食材商品都已到貨
			backUpFODStatus(req, res);
		}
	
	}
	private void fsUpdateFoodODstatus(HttpServletRequest req, HttpServletResponse res) throws IOException {
		JsonObject errorMsgs = new JsonObject();
		try {
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String food_ID = req.getParameter("food_ID");
			if(food_ID == null) {
				errorMsgs.addProperty("errorMsgF_ID", "請輸入食材編號");
			}
			
			String food_sup_ID = req.getParameter("food_sup_ID");
			if(food_sup_ID == null) {
				errorMsgs.addProperty("errorMsgFSID", "請輸入食材供應商編號");
			}
			
			String food_or_ID = req.getParameter("food_or_ID");
			if(food_or_ID == null) {
				errorMsgs.addProperty("errorMsgFORID", "請輸入食材訂單編號");
			}
			
			String food_od_status = req.getParameter("food_od_status");
			if(food_or_ID == null) {
				errorMsgs.addProperty("errorMsgFODStatus", "請輸入狀態");
			}
			
			if(errorMsgs.isJsonNull()) {
				errorMsgs.addProperty("errorMsg","參數發生錯誤");
				writeJson(res, errorMsgs);
				return;
			}
			//===================================================
			FoodOrDetailService foodOrDetailSvc = new FoodOrDetailService();
			FoodOrDetailVO foodOrDetailVO = foodOrDetailSvc.getOneFoodOrDetail(food_or_ID, food_sup_ID, food_ID);
			foodOrDetailVO.setFood_od_status(food_od_status);
			
			foodOrDetailSvc.updateFoodOrDetail(food_or_ID, food_sup_ID, food_ID,
					foodOrDetailVO.getFood_od_qty(), foodOrDetailVO.getFood_od_stotal(), foodOrDetailVO.getFood_od_rate(), foodOrDetailVO.getFood_od_msg(),food_od_status);
			writeFoodOD(res,foodOrDetailVO);
			
		}catch(Exception e) {
			errorMsgs.addProperty("errorMsg", "發生錯誤" + e.getMessage());
			writeJson(res, errorMsgs);
		}
	}
	
	private void backUpFODStatus(HttpServletRequest req, HttpServletResponse res) throws IOException {
		JsonObject errorMsgs = new JsonObject();
		try {
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String food_ID = req.getParameter("food_ID");
			if(food_ID == null) {
				errorMsgs.addProperty("errorMsgF_ID", "請輸入食材編號");
			}
			
			String food_sup_ID = req.getParameter("food_sup_ID");
			if(food_sup_ID == null) {
				errorMsgs.addProperty("errorMsgFSID", "請輸入食材供應商編號");
			}
			
			String food_or_ID = req.getParameter("food_or_ID");
			if(food_or_ID == null) {
				errorMsgs.addProperty("errorMsgFORID", "請輸入食材訂單編號");
			}
			
			String food_od_status = req.getParameter("food_od_status");
			if(food_or_ID == null) {
				errorMsgs.addProperty("errorMsgFODStatus", "請輸入狀態");
			}
			
			if(errorMsgs.isJsonNull()) {
				errorMsgs.addProperty("errorMsg","參數發生錯誤");
				writeJson(res, errorMsgs);
				return;
			}
			//===================================================
			FoodOrDetailService foodOrDetailSvc = new FoodOrDetailService();
			FoodOrDetailVO foodOrDetailVO = foodOrDetailSvc.getOneFoodOrDetail(food_or_ID, food_sup_ID, food_ID);
			foodOrDetailVO.setFood_od_status(food_od_status);
			
			foodOrDetailSvc.updateFoodOrDetail(food_or_ID, food_sup_ID, food_ID,
					foodOrDetailVO.getFood_od_qty(), foodOrDetailVO.getFood_od_stotal(), foodOrDetailVO.getFood_od_rate(), foodOrDetailVO.getFood_od_msg(),food_od_status);
			FoodOrderService foodOrderSvc = new FoodOrderService();
			FoodOrderVO foodOrderVO = foodOrderSvc.getOneFoodOrder(food_or_ID);
			

			
			Set<FoodOrDetailVO> set = foodOrderSvc.getFoodOrDetailsByFood_or_ID(food_or_ID);
			if("o1".equals(foodOrderVO.getFood_or_status()) || "o0".equals(foodOrderVO.getFood_or_status())) {
				Set<FoodOrDetailVO> noSendSet = set.stream().filter(noSendFOD -> 
				"d0".equals(noSendFOD.getFood_od_status()) || "d1".equals(noSendFOD.getFood_od_status()))
						.collect(Collectors.toSet());
				if("o0".equals(foodOrderVO.getFood_or_status()) || null != noSendSet && (noSendSet.size() > 0)) {
					req.setAttribute("canSend", false);
					javax.json.JsonObject resVO = javax.json.Json.createObjectBuilder().add("food_od_status", food_od_status).build();
					System.out.println(resVO.toString());
					writeJsonStr(res,resVO.toString());
				} else {
					req.setAttribute("canSend", true);
					javax.json.JsonObject resVO = javax.json.Json.createObjectBuilder().add("food_od_status", food_od_status).add("canSend", true).build();
					System.out.println(resVO.toString());
					writeJsonStr(res,resVO.toString());
				}
			}

			
		}catch(Exception e) {
			errorMsgs.addProperty("errorMsg", "發生錯誤" + e.getMessage());
			writeJson(res, errorMsgs);
		}
	}
	
	private void writeJson(HttpServletResponse res, JsonObject outJson) throws IOException{
		res.setContentType("application/Json");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		out.print(outJson);
		out.flush();
		out.close();
	}
	private void writeFoodOD(HttpServletResponse res, FoodOrDetailVO foodODVO) throws IOException{
		res.setContentType("application/Json");
		res.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		PrintWriter out = res.getWriter();
		out.print(gson.toJson(foodODVO));
		out.flush();
		out.close();
	}
	private void writeJsonStr(HttpServletResponse res, String jsonResStr) throws IOException {
		res.setContentType("application/Json");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		out.print(jsonResStr);
		out.flush();
		out.close();
	}
}
