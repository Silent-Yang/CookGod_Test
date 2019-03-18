package com.forumArt.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.testuse.PicIOTest;

public class ForumArtJNDIDAO implements ForumArtDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CookGodDB");
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, ForumArtVO.getForum_art_name());
			pstmt.setBytes(2, ForumArtVO.getForum_art_pic());
			pstmt.setString(3, ForumArtVO.getForum_art_con());
			pstmt.setString(4,ForumArtVO.getForum_art_status());
			pstmt.setString(5,ForumArtVO.getChef_ID());
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
		}finally {	
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		if (con != null) {
			try {
			con.close();
		}catch (Exception e) {
			e.printStackTrace(System.err);
				}
			}			
		}
	}


	@Override
	public void update(ForumArtVO ForumArtVO) {
		
		Connection con = null;
		PreparedStatement pstmt =null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, ForumArtVO.getForum_art_name());
			pstmt.setBytes(2, ForumArtVO.getForum_art_pic());
			pstmt.setString(3, ForumArtVO.getForum_art_con());
			pstmt.setString(4, ForumArtVO.getForum_art_status());
			pstmt.setString(5, ForumArtVO.getChef_ID());
			pstmt.setString(6, ForumArtVO.getForum_art_ID());
		
			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
			}catch (SQLException se) {
				se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, forum_art_ID);
			
			pstmt.executeUpdate();
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
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
			
			con = ds.getConnection();
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
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
			
		}finally {
			if (rs != null) {
				try {
					rs.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ForumArtVO = new ForumArtVO();
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
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
		}finally {
			if (rs !=null) {
					try {
						rs.close();
					}catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		return list;
	}
}


