package com.forumMsg.model;

import java.util.*;
import java.sql.*;

public class ForumMsgJDBCDAO implements ForumMsgDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "COOKGOD";
	String passwd = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO FORUM_MSG (FORUM_MSG_ID,FORUM_MSG_CON,FORUM_MSG_STATUS,FORUM_ART_ID,CUST_ID) VALUES ('MS'||LPAD((FORUM_ART_SEQ.NEXTVAL),4,'0'),?,?,?,?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM FORUM_MSG order by FORUM_MSG_ID";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM FORUM_MSG where FORUM_MSG_ID = ?";
	private static final String DELETE =
			"DELETE FROM FORUM_MSG where FORUM_MSG_ID = ?";
	private static final String UPDATE = 
			"UPDATE FORUM_MSG set FORUM_MSG_CON=? ,FORUM_MSG_STATUS = ?,FORUM_ART_ID = ?,CUST_ID= ? where FORUM_MSG_ID = ?";
	
	@Override
	public void insert(ForumMsgVO ForumMsgVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		Class.forName(driver);
		con = DriverManager.getConnection(url, userid, passwd);
		pstmt = con.prepareStatement(INSERT_STMT);

		
		pstmt.setString(1, ForumMsgVO.getForum_msg_con());
		pstmt.setString(2, ForumMsgVO.getForum_msg_status());
		pstmt.setString(3, ForumMsgVO.getForum_art_ID());
		pstmt.setString(4, ForumMsgVO.getCust_ID());

		pstmt.executeUpdate();

	} catch (ClassNotFoundException e) {
		throw new RuntimeException("Couldn't load database driver." + e.getMessage());
	} catch (SQLException se) {
		throw new RuntimeException("A database error occured." + se.getMessage());
	} finally {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException se) {
				se.printStackTrace(System.err);
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace(System.err);
			}
		}
	}
}
		
	

	@Override
	public void update(ForumMsgVO ForumMsgVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			
			
			pstmt.setString(1,ForumMsgVO.getForum_msg_con());
			pstmt.setString(2, ForumMsgVO.getForum_msg_status());
			pstmt.setString(3, ForumMsgVO.getForum_art_ID());
			pstmt.setString(4, ForumMsgVO.getCust_ID());
			pstmt.setString(5, ForumMsgVO.getForum_msg_ID());
			
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	

	@Override
	public void delete(String forum_msg_ID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, forum_msg_ID);

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Could't load database driver." + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}


	@Override
	public ForumMsgVO findByPrimaryKey(String forum_msg_ID) {
		
		ForumMsgVO ForumMsgVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, forum_msg_ID);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				ForumMsgVO = new ForumMsgVO();
				ForumMsgVO.setForum_msg_ID(rs.getString("forum_msg_ID"));
				ForumMsgVO.setForum_msg_con(rs.getString("forum_msg_con"));
				ForumMsgVO.setForum_msg_status(rs.getString("forum_msg_status"));
				ForumMsgVO.setForum_art_ID(rs.getString("forum_art_ID"));
				ForumMsgVO.setCust_ID(rs.getString("cust_ID"));
				
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." + e.getMessage());

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		return ForumMsgVO;
	}

	@Override
	public List<ForumMsgVO> getAll() {
		
		List<ForumMsgVO> list = new ArrayList<ForumMsgVO>();
		ForumMsgVO ForumMsgVO= null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				ForumMsgVO = new ForumMsgVO();
				ForumMsgVO.setForum_msg_ID(rs.getString("forum_msg_ID"));
				ForumMsgVO.setForum_msg_con(rs.getString("forum_msg_con"));
				ForumMsgVO.setForum_msg_start(rs.getTimestamp("forum_msg_start"));
				ForumMsgVO.setForum_msg_status(rs.getString("forum_msg_status"));
				ForumMsgVO.setForum_art_ID(rs.getString("forum_art_ID"));
				ForumMsgVO.setCust_ID(rs.getString("cust_ID"));
				list.add(ForumMsgVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." + e.getMessage());
		} catch (SQLException se) {
			//se.printStackTrace();,資料庫出事先打，錯誤先堆疊。
			
			throw new RuntimeException("A database eeror occured." + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	public static void main(String[] args) {

		ForumMsgJDBCDAO ForumMsg = new ForumMsgJDBCDAO();
////		// 新增
		
//		ForumMsgVO ForumMsgVO1 = new ForumMsgVO();
////		
//		ForumMsgVO1.setForum_msg_con("回家吃,吃雞雞了");		
//		ForumMsgVO1.setForum_msg_status("D2");
//		ForumMsgVO1.setForum_art_ID("A00006");
//		ForumMsgVO1.setCust_ID("C00001");
//		ForumMsg.insert(ForumMsgVO1);
//		
		// 修改
		
		ForumMsgVO ForumMsgVO2 = new ForumMsgVO();
//		
//		ForumMsgVO2.setForum_msg_con("不行啦");
//		ForumMsgVO2.setForum_msg_status("D1");
//		ForumMsgVO2.setForum_art_ID("A00004");
//		ForumMsgVO2.setCust_ID("C00001");
//		ForumMsgVO2.setForum_msg_ID("MS0006");
//		
//	    ForumMsg.update(ForumMsgVO2);
		
		//刪除
//		ForumMsg.delete("MS0011");
		
//		//查詢
		ForumMsgVO ForumMsgVO3 = ForumMsg.findByPrimaryKey("MS0007");
		System.out.print(ForumMsgVO3.getForum_msg_ID() + ",");
		System.out.print(ForumMsgVO3.getForum_msg_con() + ",");
		System.out.print(ForumMsgVO3.getForum_msg_status() + ",");
	    System.out.print(ForumMsgVO3.getForum_art_ID() + ",");
		System.out.print(ForumMsgVO3.getCust_ID() + ",");
		System.out.println("---------------------");
//		
//		
//		//查詢
//		List<ForumMsgVO> list = ForumMsg.getAll();
//		for (ForumMsgVO adish : list) {
//			System.out.print(adish.getForum_msg_ID() + ",");
//			System.out.print(adish.getForum_msg_con() + ",");
//			System.out.print(adish.getForum_msg_start() + ",");
//			System.out.print(adish.getForum_msg_status() + ",");
//			System.out.print(adish.getForum_art_ID() + ",");
//			System.out.print(adish.getCust_ID() + ",");
//			System.out.println();
	//	}
	}
}
