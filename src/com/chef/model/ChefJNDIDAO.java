package com.chef.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

import com.cust.model.CustVO;
import com.emp.model.EmpJDBCDAO;
import com.emp.model.EmpVO;


public class ChefJNDIDAO implements ChefDAO_Interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CookGodDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String Insert_Stmt = 
			"INSERT INTO CHEF (CHEF_ID, CHEF_AREA, CHEF_STATUS, CHEF_CHANNEL, CHEF_RESUME) VALUES (?, ?, '0', 'NoChannel', ?)";
	private static final String Insert_Stmt_With_Cust = 
			"INSERT INTO CUST (CUST_ID,CUST_ACC,CUST_PWD,CUST_NAME,CUST_SEX,CUST_TEL,CUST_ADDR,CUST_PID,CUST_MAIL,CUST_BRD,CUST_REG,CUST_PIC,CUST_STATUS,CUST_NINAME) VALUES ('C'||LPAD((CUST_SEQ.NEXTVAL),5,'0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String Updata_Stmt_From_Emp = 
			"UPDATE CHEF SET CHEF_STATUS=?, CHEF_CHANNEL=? WHERE CHEF_ID= ?";
	private static final String Updata_Stmt_From_Chef = 
			"UPDATE CHEF SET CHEF_AREA=?, CHEF_RESUME=? WHERE CHEF_ID= ?";
	private static final String Delete_Stmt = 
			"DELETE FROM CHEF WHERE CHEF_ID= ?";
	private static final String Get_One_Chef_By_Chef_ID = 
			"SELECT * FROM CHEF WHERE CHEF_ID = ?";
	private static final String Get_All_Chef_By_Chef_Area = 
			"SELECT * FROM CHEF WHERE CHEF_AREA = ?";
	private static final String Get_All_Chef_From_Emp = 
			"SELECT * FROM CHEF";
	
	@Override
	public void insert(CustVO custVO, ChefVO chefVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			
			con.setAutoCommit(false);
			
    		// 先新增顧客
			String cols[] = {"CUST_ID"};
			pstmt = con.prepareStatement(Insert_Stmt_With_Cust , cols);			
			pstmt.setString(1, custVO.getCust_acc());
			pstmt.setString(2, custVO.getCust_pwd());
			pstmt.setString(3, custVO.getCust_name());
			pstmt.setString(4, custVO.getCust_sex());
			pstmt.setString(5, custVO.getCust_tel());
			pstmt.setString(6, custVO.getCust_addr());
			pstmt.setString(7, custVO.getCust_pid());
			pstmt.setString(8, custVO.getCust_mail());
			pstmt.setDate(9, custVO.getCust_brd());
			pstmt.setDate(10, custVO.getCust_reg());
			pstmt.setBytes(11, custVO.getCust_pic());
			pstmt.setString(12, custVO.getCust_status());
			pstmt.setString(13, custVO.getCust_niname());
			pstmt.executeUpdate();
			//掘取對應的自增主鍵值			
			String next_cust_ID = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_cust_ID = rs.getString(1);
				System.out.println("自增主鍵值= " + next_cust_ID +"(剛新增成功的顧客編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			// 再同時新增廚師
			
			pstmt = con.prepareStatement(Insert_Stmt);
			
			pstmt.setString(1, next_cust_ID);
			pstmt.setString(2, chefVO.getChef_area());
			pstmt.setString(3, chefVO.getChef_resume());
			
			pstmt.executeUpdate();

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException se) {
			throw new RuntimeException("Database Error : "+ se.getMessage());
		}finally {
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
	public void update(ChefVO chefVO) {		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(Updata_Stmt_From_Emp);

			pstmt.setString(1, chefVO.getChef_status());
			pstmt.setString(2, chefVO.getChef_channel());
			pstmt.setString(3, chefVO.getChef_ID());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("Database Error : "+ se.getMessage());
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
	public void delete(String chefId) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(Delete_Stmt);

			pstmt.setString(1, chefId);

			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("Database Error : "+ se.getMessage());
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
	public ChefVO findByPrimaryKey(String chef_ID) {		
		ChefVO chefVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();			
			pstmt = con.prepareStatement(Get_One_Chef_By_Chef_ID);
			
			pstmt.setString(1, chef_ID);			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {				
				chefVO = new ChefVO();				
				chefVO.setChef_ID(rs.getString("CHEF_ID"));
				chefVO.setChef_area(rs.getString("CHEF_AREA"));
				chefVO.setChef_channel(rs.getString("CHEF_CHANNEL"));
				chefVO.setChef_resume(rs.getString("CHEF_RESUME"));
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database Error : "+ se.getMessage());
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
		return chefVO;
	}
	
	@Override
	public List<ChefVO> getAllByChefArea(String chef_area) {
		List<ChefVO> listAllByChefArea = new ArrayList<ChefVO>();
		ChefVO chefVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();			
			pstmt = con.prepareStatement(Get_All_Chef_By_Chef_Area);
			
			pstmt.setString(1, chef_area);			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {				
				chefVO = new ChefVO();				
				chefVO.setChef_ID(rs.getString("CHEF_ID"));
				chefVO.setChef_area(rs.getString("CHEF_AREA"));
				chefVO.setChef_channel(rs.getString("CHEF_CHANNEL"));
				chefVO.setChef_resume(rs.getString("CHEF_RESUME"));
				listAllByChefArea.add(chefVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database Error : "+ se.getMessage());
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
		return listAllByChefArea;
	}

	@Override
	public List<ChefVO> getAll() {
		List<ChefVO> listAllChef = new ArrayList<ChefVO>();
		ChefVO chefVO = null;		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(Get_All_Chef_From_Emp);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				chefVO = new ChefVO();				
				chefVO.setChef_ID(rs.getString("CHEF_ID"));
				chefVO.setChef_area(rs.getString("CHEF_AREA"));
				chefVO.setChef_channel(rs.getString("CHEF_CHANNEL"));
				chefVO.setChef_resume(rs.getString("CHEF_RESUME"));
				listAllChef.add(chefVO); // Store the row in the list
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database Error : "+ se.getMessage());
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
		return listAllChef;
	}
}
