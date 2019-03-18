package com.forumArt.controller;

import java.io.*;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.dish.model.DishService;
import com.dish.model.DishVO;
import com.forumArt.model.*;
import com.forumMsg.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ForumArtServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		
		String action = req.getParameter("action");
		
		if ("getAllForumArt".equals(action)) {
			System.out.println("6");

			try {
				
				String forum_art_ID = new String(req.getParameter("forum_art_ID"));

				ForumArtDAO dao = new ForumArtDAO();
				ForumArtVO forumArtVO = dao.findByPrimarKey(forum_art_ID);

				req.setAttribute("forumArtVO", forumArtVO); 
				
				
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				
				RequestDispatcher successView = req
						.getRequestDispatcher("/back-end/forumArt/listAllForumArt.jsp");
				successView.forward(req, res);
				return;

			} catch (Exception e) {
				throw new ServletException(e);
				
			}
	
	}
		
		ServletOutputStream out = res.getOutputStream();
		List<String> errorMsgs = new LinkedList<String>();

		String FAID = req.getParameter("forum_art_ID");

		try {
			ForumArtService FAS = new ForumArtService();
			ForumArtVO dao = (ForumArtVO) FAS.getOneForumArt(FAID);
			byte[] FApic = dao.getForum_art_pic();
			out.write(FApic);

		} catch (NullPointerException e) {
			errorMsgs.add("NotPicture");
		}
	
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
			String FAID = req.getParameter("forum_art_ID");
			if (FAID == null || (FAID.trim()).length() == 0) {
				errorMsgs.add("請輸入文章編號");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/select_page.jsp");
				failureView.forward(req, res);
				return;
			}

			String forum_art_ID = null;
			try {
				forum_art_ID = new String(FAID);
			} catch (Exception e) {
				errorMsgs.add("文章編號格式不正確");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 2.開始查詢資料 *****************************************/
			ForumArtService ForumArtSvc = new ForumArtService();
			ForumArtVO forumArtVO = ForumArtSvc.getOneForumArt(forum_art_ID);
			if (forumArtVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("forumArtVO", forumArtVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/forumArt/listOneForumArt.jsp";
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
			String forum_art_ID = new String(req.getParameter("forum_art_ID"));

			/*************************** 2.開始查詢資料 ****************************************/
			ForumArtService forumArtSvc = new ForumArtService();
			ForumArtVO forumArtVO = forumArtSvc.getOneForumArt(forum_art_ID);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("forumArtVO", forumArtVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/forumArt/update_forumArt_input.jsp";
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
			// 文章編號
			String forum_art_ID = new String(req.getParameter("forum_art_ID").trim());
			// 文章名稱
			String forum_art_name = req.getParameter("forum_art_name");
			String forum_art_nameReg = "^[(\u4e00-\u9fa5)]{2,10}$";
			if (forum_art_name == null || forum_art_name.trim().length() == 0) {
				errorMsgs.add("文章標題: 請勿空白");
			} else if (!forum_art_name.trim().matches(forum_art_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("文章標題: 只能是中字 , 且長度必需在2到10之間");
			}
			
			
			//文章照片
			byte[] forum_art_pic = null;
			Part part = req.getPart("forum_art_pic");
			if (part.getSize() == 0) {
				ForumArtService forumArtSvc = new ForumArtService();
				ForumArtVO forumArtVO = forumArtSvc.getOneForumArt(forum_art_ID);
				forum_art_pic = forumArtVO.getForum_art_pic();
			} else {
				long size = part.getSize();
				System.out.println(size);
				InputStream in = part.getInputStream();

				forum_art_pic = new byte[in.available()];
				if (in.available() != 0) {
					in.read(forum_art_pic);
					in.close();
				}
			}
			
			//文章內容
			String forum_art_con = req.getParameter("forum_art_con").trim();
			if (forum_art_con == null || forum_art_con.trim().length() == 0) {
				errorMsgs.add("文章內容請勿空白");
			}	
			//文章時間
			//String forum_art_startString = req.getParameter("forum_art_start");
			Timestamp forum_art_start= new Timestamp(System.currentTimeMillis());
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			String timeStr = df.format(forum_art_start); 
			forum_art_start = Timestamp.valueOf(timeStr); 
			
			//文章狀態
			
			String forum_art_status = null; 
			String forumArtStatus= req.getParameter("forumArtStatus");
			if (forumArtStatus.equals("Shelf")) {
				forum_art_status ="發表";
			}else {
				forum_art_status = "隱藏";
			}

			//主廚編號
			String chef_ID= req.getParameter("chef_ID");
			String chef_IDReg = "^[(C0-9_)]{6}$";
			if (chef_ID == null || chef_ID.trim().length() == 0) {
				errorMsgs.add("主廚編號: 請勿空白");
			} else if (!chef_ID.trim().matches(chef_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("主廚編號: 英文'C'開頭與後五碼數字");
			}

			ForumArtVO forumArtVO = new ForumArtVO();

			forumArtVO.setForum_art_ID(forum_art_ID);
			forumArtVO.setForum_art_name(forum_art_name);
			if (forum_art_pic != null) {
				forumArtVO.setForum_art_pic(forum_art_pic);
			}
			forumArtVO.setForum_art_con(forum_art_con);
			forumArtVO.setForum_art_start(forum_art_start);;
			forumArtVO.setForum_art_status(forum_art_status);
			forumArtVO.setChef_ID(chef_ID);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("forumArtVO", forumArtVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/update_forumArt_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			ForumArtService forumArtSvc = new ForumArtService();
			forumArtVO = forumArtSvc.updateForumArt(forum_art_ID,forum_art_name,forum_art_pic,forum_art_con,
					forum_art_start,forum_art_status,chef_ID);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("forumArtVO", forumArtVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back-end/forumArt/listOneForumArt.jsp";
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
			System.out.println("AAA");
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				System.out.println("AAA");
				// 文章名稱
				String forum_art_name = req.getParameter("forum_art_name");
				String forum_art_nameReg = "^[(\u4e00-\u9fa5)]{2,10}$";
				if (forum_art_name == null || forum_art_name.trim().length() == 0) {
					errorMsgs.add("菜色姓名: 請勿空白");
				} else if (!forum_art_name.trim().matches(forum_art_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("菜色名稱: 只能是中字 , 且長度必需在2到10之間");
				}
				System.out.println("AAA");
				//文章照片
				byte[] forum_art_pic = null;
				Part part = req.getPart("forum_art_pic");
				long size = part.getSize();
				InputStream in = part.getInputStream();

				forum_art_pic = new byte[in.available()];
				if (in.available() != 0) {
					in.read(forum_art_pic);
					in.close();
				} else {
					errorMsgs.add("請上傳照片");
				}
				
				System.out.println("AAA");
				//文章內容
				String  forum_art_con = req.getParameter("forum_art_con").trim();
				if (forum_art_con == null || forum_art_con.trim().length() == 0) {
					errorMsgs.add("文章內容請勿空白");
				}
				System.out.println("AAA");
				//文章狀態
				
				String forum_art_status = req.getParameter("forum_art_status");
				
				
				//主廚編號
				String chef_ID= req.getParameter("chef_ID");
				String chef_IDReg = "^[(C0-9_)]{6}$";
				if (chef_ID == null || chef_ID.trim().length() == 0) {
					errorMsgs.add("主廚編號: 請勿空白");
				} else if (!chef_ID.trim().matches(chef_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("主廚編號: 英文'C'開頭與後五碼數字");
				}
				

				ForumArtVO forumArtVO = new ForumArtVO();

				forumArtVO.setForum_art_name(forum_art_name);
				forumArtVO.setForum_art_pic(forum_art_pic);
				forumArtVO.setForum_art_con(forum_art_con);
				//forumArtVO.setForum_art_start(forum_art_start);
				forumArtVO.setForum_art_status(forum_art_status);
				forumArtVO.setChef_ID(chef_ID);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("forumArtVO", forumArtVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/addForumArt.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				
				//forum_art_start,

				/*************************** 2.開始新增資料 ***************************************/
				ForumArtService forumArtSvc = new ForumArtService();
				forumArtVO = forumArtSvc.addForumArt(forum_art_name,forum_art_pic,forum_art_con,forum_art_status,chef_ID);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/forumArt/listAllForumArt.jsp";
				System.out.println("AAA");
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/addForumArt.jsp");
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
				String forum_art_ID = new String(req.getParameter("forum_art_ID"));

				/*************************** 2.開始刪除資料 ***************************************/
				ForumArtService forumArtSvc = new ForumArtService();
				forumArtSvc.deleteForumArt(forum_art_ID);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/forumArt/listAllForumArt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/forumArt/listAllForumArt.jsp");
				failureView.forward(req, res);
			}
			
			
		}
			    // �Ӧ�select_page.jsp���ШD                                  // �Ӧ� dept/listAllDept.jsp���ШD
			if ("listAllForumArt_ByForumMsg".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/*************************** 1.�����ШD�Ѽ� ****************************************/
					String forum_art_ID = new String(req.getParameter("forum_art_ID"));

					/*************************** 2.�}�l�d�߸�� ****************************************/
					ForumArtService forumArtSvc = new ForumArtService();
					Set<ForumMsgVO> set = forumArtSvc.getForumMsgsByForumArt(forum_art_ID);
					System.out.println(forum_art_ID);
					/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
					req.setAttribute("listAllForumArt_ByForumMsg", set);
					String url = null;
					if ("listAllForumArt".equals(action))
						url = "/back-end/listAllForumArt.jsp"; 

					
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

					/*************************** ��L�i�઺���~�B�z ***********************************/
				} catch (Exception e) {
					throw new ServletException(e);
				}
			}
		}
	}


