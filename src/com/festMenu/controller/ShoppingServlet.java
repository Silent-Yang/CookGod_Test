package com.festMenu.controller;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.festMenu.model.FestMenuService;
import com.festMenu.model.FestMenuVO;

public class ShoppingServlet extends HttpServlet{
    
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		FestMenuService phs = new FestMenuService();
		Vector<FestMenuVO> buylist = (Vector<FestMenuVO>)session.getAttribute("shoppingcart");
		String action = req.getParameter("action");
		
		if ("checkout".equals(action)) {
			// 刪除購物車中的書籍
			if ("delete".equals(action)) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				buylist.remove(d);
			}
			// 新增書籍至購物車中
			else if ("add".equals(action)) {
				boolean match = false;
				
				String fest_m_ID=req.getParameter("fest_m_ID");
				String fest_m_name=req.getParameter("fest_m_name");
				Integer fest_m_qty=Integer.parseInt(req.getParameter("fest_m_qty"));
				Integer fest_m_price=Integer.parseInt(req.getParameter("fest_m_price"));				
				//取得後來新增的節慶料理
				FestMenuVO abook = getFestMenuVO(req);
				// 新增第一筆節慶料理編號至購物車時
				if (buylist == null) {
					buylist = new Vector<FestMenuVO>();
					buylist.add(abook);
				} else {
					for (int i = 0; i < buylist.size(); i++) {
						FestMenuVO book = buylist.get(i);
						// 假若新增的書籍和購物車的書籍一樣時
						if (book.getFest_m_ID().equals(abook.getFest_m_ID())) {
							book.setFest_m_qty(book.getFest_m_qty()
									+ abook.getFest_m_qty());
							buylist.setElementAt(book, i);
							match = true;
						} // end of if name matches
					} // end of for
					if (!match)
						buylist.add(abook);
				}
			}
			session.setAttribute("shoppingcart", buylist);
			String url = "/listOneFestMenu.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
	}
		// 結帳，計算購物車書籍價錢總數
				else if (action.equals("CHECKOUT")) {
					float total = 0;
					for (int i = 0; i < buylist.size(); i++) {
						FestMenuVO order = buylist.get(i);
						Integer fest_m_price = order.getFest_m_price();
						Integer fest_m_qty = order.getFest_m_qty();
						total += (fest_m_price * fest_m_qty);
					}

					String amount = String.valueOf(total);
					req.setAttribute("amount", amount);
					String url = "/Checkout.jsp";
					RequestDispatcher rd = req.getRequestDispatcher(url);
					rd.forward(req, res);
				}
			}

	private FestMenuVO getFestMenuVO(HttpServletRequest req) {
		// TODO Auto-generated method stub
		return null;
	}
}

