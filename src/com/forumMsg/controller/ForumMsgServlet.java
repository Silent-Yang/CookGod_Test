package com.forumMsg.controller;

import java.io.*;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import com.forumMsg.model.*;

public class ForumMsgServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		// 單一查詢
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			// 菜色編號判斷
			String FMID = req.getParameter("forum_msg_ID");
			if (FMID == null || (FMID.trim()).length() == 0) {
				errorMsgs.add("請輸入留言編號");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/select_page.jsp");
				failureView.forward(req, res);
				return;
			}

			String forum_msg_ID = null;
			try {
				forum_msg_ID = new String(FMID);
			} catch (Exception e) {
				errorMsgs.add("留言編號格式不正確");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 2.開始查詢資料 *****************************************/
			ForumMsgService forumMsgSvc = new ForumMsgService();
			ForumMsgVO forumMsgVO = forumMsgSvc.getOneForumMsg(forum_msg_ID);
			if (forumMsgVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("forumMsgVO", forumMsgVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/forumMsg/listOneForumMsg.jsp";
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
			
			String requestURL = req.getParameter("requestURL");

			// try {
			/*************************** 1.接收請求參數 ****************************************/
			String forum_msg_ID = new String(req.getParameter("forum_msg_ID"));

			/*************************** 2.開始查詢資料 ****************************************/
			ForumMsgService forumMsgSvc = new ForumMsgService();
			ForumMsgVO forumMsgVO = forumMsgSvc.getOneForumMsg(forum_msg_ID);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("forumMsgVO", forumMsgVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/forumMsg/update_forumMsg_input.jsp";
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
			
			// 留言編號
			String forum_msg_ID = new String(req.getParameter("forum_msg_ID".trim()));
			// 文章編號
			String forum_art_ID = req.getParameter("forum_art_ID");
			//文章內容
			String forum_msg_con = req.getParameter("forum_msg_con").trim();
			if (forum_msg_con == null || forum_msg_con.trim().length() == 0) {
				errorMsgs.add("留言內容請勿空白");
			}	
			//留言時間
			Timestamp forum_msg_start= new Timestamp(System.currentTimeMillis());
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			String timeStr = df.format(forum_msg_start); 
			forum_msg_start = Timestamp.valueOf(timeStr); 
			
			//留言狀態
			String forum_msg_status = req.getParameter("forum_msg_status").trim();
			if (forum_msg_status == null || forum_msg_status.trim().length() == 0) {
				errorMsgs.add("留言狀態.請勿空白");
			}	
			
			//顧客編號
			String cust_ID= req.getParameter("cust_ID");
			String cust_IDReg = "^[(C0-9_)]{6}$";
			if (cust_ID == null || cust_ID.trim().length() == 0) {
				errorMsgs.add("主廚編號: 請勿空白");
			} else if (!cust_ID.trim().matches(cust_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("主廚編號: 英文'C'開頭與後五碼數字");
			}

			ForumMsgVO forumMsgVO = new ForumMsgVO();

			forumMsgVO.setForum_art_ID(forum_art_ID);
			forumMsgVO.setForum_msg_ID(forum_msg_ID);
			forumMsgVO.setForum_msg_con(forum_msg_con);
			forumMsgVO.setForum_msg_start(forum_msg_start);
			forumMsgVO.setForum_msg_status(forum_msg_status);
			forumMsgVO.setCust_ID(cust_ID);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("forumMsgVO", forumMsgVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/update_forumMsg_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			ForumMsgService forumMsgSvc = new ForumMsgService();
			forumMsgVO = forumMsgSvc.updateForumMsg(forum_msg_ID,forum_msg_con,forum_msg_start,forum_msg_status,cust_ID,forum_art_ID);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("forumMsgVO", forumMsgVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back-end/forumMsg/listOneForumMsg.jsp";
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

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				// 文章編號
				String forum_art_ID = req.getParameter("forum_art_ID");
				
				//留言內容
				String  forum_msg_con = req.getParameter("forum_msg_con").trim();
				if (forum_msg_con == null || forum_msg_con.trim().length() == 0) {
					errorMsgs.add("留言內容請勿空白");
				}
				
				//文章狀態
				String  forum_msg_status = req.getParameter("forum_msg_status").trim();
				if (forum_msg_status == null || forum_msg_status.trim().length() == 0) {
					errorMsgs.add("菜色狀態,請勿空白");
				
				}
//				String status =null;
//				String forum_msg_status = req.getParameter("forum_msg_status");
//				if (forum_msg_status.equals("display") ) {
//					status="顯示";
//				}else{
//					status="隱藏";
//				}	
				
				//主廚編號
				String cust_ID = req.getParameter("cust_ID");
				String cust_IDReg = "^[(C0-9_)]{6}$";
				if ( cust_ID == null ||  cust_ID.trim().length() == 0) {
					errorMsgs.add("主廚編號: 請勿空白");
				} else if (! cust_ID.trim().matches( cust_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("主廚編號: 英文'C'開頭與後五碼數字");
				}
				

				ForumMsgVO forumMsgVO = new ForumMsgVO();

				forumMsgVO.setForum_art_ID(forum_art_ID);
				forumMsgVO.setForum_msg_con(forum_msg_con);
				forumMsgVO.setForum_msg_status(forum_msg_status);
				forumMsgVO.setCust_ID(cust_ID);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("forumMsgVO", forumMsgVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/addForumMsg.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				
				//forum_art_start,

				/*************************** 2.開始新增資料 ***************************************/
				ForumMsgService forumMsgSvc = new ForumMsgService();
				forumMsgVO = forumMsgSvc.addForumMsg(forum_art_ID,forum_msg_con,forum_msg_status,cust_ID);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/forumMsg/listAllForumMsg.jsp";
				System.out.println("AAA");
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
				} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/addForumMsg.jsp");
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
				String forum_msg_ID = new String(req.getParameter("forum_msg_ID"));

				/*************************** 2.開始刪除資料 ***************************************/
				ForumMsgService forumMsgSvc = new ForumMsgService();
				forumMsgSvc.deleteForumMsg(forum_msg_ID);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/forumMsg/listAllForumMsg.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumMsg/listAllForumMsg.jsp");
				failureView.forward(req, res);
			}
		}
	}
	
}


