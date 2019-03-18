package com.forumArt.model;

import java.util.*;

import com.dish.model.DishJDBCDAO;
import com.dish.model.DishVO;

import java.sql.*;

import com.testuse.*;

public class ForumArtJDBCDAO implements ForumArtDAO_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "COOKGOD";
	String passwd = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO FORUM_ART (FORUM_ART_ID,FORUM_ART_NAME,FORUM_ART_PIC,FORUM_ART_CON,FORUM_ART_STATUS,CHEF_ID) VALUES ('A'||LPAD((FORUM_ART_SEQ.NEXTVAL),5,'0'),?,?,?,?,?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM FORUM_ART order by FORUM_ART_ID";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM FORUM_ART where FORUM_ART_ID = ?";
	private static final String DELETE =
			"DELETE FROM FORUM_ART where FORUM_ART_ID = ?";
	private static final String UPDATE = 
			"UPDATE FORUM_ART set FORUM_ART_NAME=?,FORUM_ART_PIC=?,FORUM_ART_CON=?,FORUM_ART_STATUS=?,CHEF_ID=? where FORUM_ART_ID = ?";

	@Override
	public void insert(ForumArtVO ForumArtVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		Class.forName(driver);
		con = DriverManager.getConnection(url, userid, passwd);
		pstmt = con.prepareStatement(INSERT_STMT);

		
		pstmt.setString(1, ForumArtVO.getForum_art_name());
		pstmt.setBytes(2, ForumArtVO.getForum_art_pic());
		pstmt.setString(3, ForumArtVO.getForum_art_con());
		pstmt.setString(4,ForumArtVO.getForum_art_status());
		pstmt.setString(5,ForumArtVO.getChef_ID());

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
	public void update(ForumArtVO ForumArtVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			
			pstmt.setString(1, ForumArtVO.getForum_art_name());
			pstmt.setBytes(2, ForumArtVO.getForum_art_pic());
			pstmt.setString(3, ForumArtVO.getForum_art_con());
			pstmt.setString(4, ForumArtVO.getForum_art_status());
			pstmt.setString(5, ForumArtVO.getChef_ID());
			pstmt.setString(6, ForumArtVO.getForum_art_ID());
			
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
	public void delete(String forum_art_ID) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, forum_art_ID);

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
	public ForumArtVO findByPrimarKey(String forum_art_ID) {
		
		ForumArtVO ForumArtVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, forum_art_ID);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				ForumArtVO = new ForumArtVO();
				ForumArtVO.setForum_art_ID(rs.getString("forum_art_ID"));
				ForumArtVO.setForum_art_name(rs.getString("forum_art_name"));
				ForumArtVO.setForum_art_pic(rs.getBytes("FORUM_ART_PIC"));
				ForumArtVO.setForum_art_con(rs.getString("FORUM_ART_CON"));
				ForumArtVO.setForum_art_start(rs.getTimestamp("forum_art_start"));
				ForumArtVO.setForum_art_status(rs.getString("forum_art_status"));
				ForumArtVO.setChef_ID(rs.getString("chef_ID"));
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

		return ForumArtVO;
	}

		


	@Override
	public List<ForumArtVO> getAll() {
		
		List<ForumArtVO> list = new ArrayList<ForumArtVO>();
		ForumArtVO ForumArtVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				ForumArtVO = new ForumArtVO();
				ForumArtVO.setForum_art_ID(rs.getString("forum_art_ID"));
				ForumArtVO.setForum_art_name(rs.getString("forum_art_name"));
				ForumArtVO.setForum_art_pic(rs.getBytes("FORUM_ART_PIC"));
				ForumArtVO.setForum_art_con(rs.getString("FORUM_ART_CON"));
				ForumArtVO.setForum_art_start(rs.getTimestamp("forum_art_start"));
				ForumArtVO.setForum_art_status(rs.getString("forum_art_status"));
				ForumArtVO.setChef_ID(rs.getString("chef_ID"));
				list.add(ForumArtVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." + e.getMessage());
		} catch (SQLException se) {
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

		ForumArtJDBCDAO ForumArt = new ForumArtJDBCDAO();
////		// 新增
		PicIOTest picIOTest = new PicIOTest();
//		
//		ForumArtVO ForumArtVO1 = new ForumArtVO();
//		
//		ForumArtVO1.setForum_art_name("御膳桂丁雞湯");
//		ForumArtVO1.setForum_art_pic(picIOTest.getPictureByteArray("C:/T3/DISH/御膳桂丁雞湯.jpg"));
//		ForumArtVO1.setForum_art_con("上湯採老母雞、豬腳、金華火腿慢火精熬，再佐以干貝、竹笙及新鮮菜捲等食材，鮮甜一口難忘。");
//		ForumArtVO1.setForum_art_status("D2");
//		ForumArtVO1.setChef_ID("C00001");
//    	ForumArt.insert(ForumArtVO1);
//		
		// 修改
		
//		ForumArtVO ForumArtVO2 = new ForumArtVO();
//		
//		
//		ForumArtVO2.setForum_art_name("嫩煎干貝");
//		ForumArtVO2.setForum_art_pic(picIOTest.getPictureByteArray("C:/T3/菜色/嫩煎干貝.jpg"));
//		ForumArtVO2.setForum_art_con("嚴選日本北海道純淨海域生食級干貝，雙面略煎上色，搭配松露醬品嚐，口口都能感受到大海的鮮甜滋味！");
//		ForumArtVO2.setForum_art_status("D1");
//		ForumArtVO2.setChef_ID("C00001");
//		ForumArtVO2.setForum_art_ID("A00006");
//		
//		ForumArt.update(ForumArtVO2);
		
		//刪除
//		ForumArt.delete("A00010");
		
//		//查詢
//		ForumArtVO ForumArtVO3 = ForumArt.findByPrimarKey("A00006");
//		System.out.print(ForumArtVO3.getForum_art_ID() + ",");
//		System.out.print(ForumArtVO3.getForum_art_name() + ",");
//		System.out.print(ForumArtVO3.getForum_art_pic() + ",");
//	    System.out.print(ForumArtVO3.getForum_art_con() + ",");
//		System.out.print(ForumArtVO3.getForum_art_start() + ",");
//		System.out.print(ForumArtVO3.getForum_art_status() + ",");
//		System.out.print(ForumArtVO3.getChef_ID() + ",");
//		System.out.println("---------------------");
//		
//		
//		//查詢
		List<ForumArtVO> list = ForumArt.getAll();
		for (ForumArtVO adish : list) {
			System.out.print(adish.getForum_art_ID() + ",");
			System.out.print(adish.getForum_art_name() + ",");
			System.out.print(adish.getForum_art_pic() + ",");
			System.out.print(adish.getForum_art_con() + ",");
			System.out.print(adish.getForum_art_start() + ",");
			System.out.print(adish.getForum_art_status() + ",");
			System.out.print(adish.getChef_ID() + ",");
			System.out.println();
		}
	}
}
