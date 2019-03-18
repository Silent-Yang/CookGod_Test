package com.dish.model;

import java.util.*;
import com.dish.model.*;
import com.food.model.*;
import com.menuDish.model.MenuDishVO;
import com.testuse.PicIOTest;
import java.sql.*;

public class DishJDBCDAO implements DishDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "COOKGOD";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO DISH (DISH_ID,DISH_NAME,DISH_STATUS,DISH_PIC,DISH_RESUME,DISH_PRICE) VALUES ('D'||LPAD((DISH_SEQ.NEXTVAL),5,'0'),?,?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM DISH order by DISH_ID";
	private static final String GET_ONE_STMT = "SELECT * FROM DISH where DISH_ID = ? ";
	private static final String DELETE = "DELETE FROM DISH where DISH_ID=?";
	private static final String UPDATE = "UPDATE DISH set DISH_NAME=?,DISH_STATUS=?,DISH_PIC=?,DISH_RESUME=?,DISH_PRICE=? where DISH_ID=?";

	@Override
	public void insert(DishVO DishVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, DishVO.getDish_name());
			pstmt.setString(2, DishVO.getDish_status());
			pstmt.setBytes(3, DishVO.getDish_pic());
			pstmt.setString(4, DishVO.getDish_resume());
			pstmt.setInt(5, DishVO.getDish_price());

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
	public void update(DishVO DishVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, DishVO.getDish_name());
			pstmt.setString(2, DishVO.getDish_status());
			pstmt.setBytes(3, DishVO.getDish_pic());
			pstmt.setString(4, DishVO.getDish_resume());
			pstmt.setInt(5, DishVO.getDish_price());
			pstmt.setString(6, DishVO.getDish_ID());
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
	public void delete(String dish_ID) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, dish_ID);

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
	public DishVO findByPrimaryKey(String dishid) {

		DishVO DishVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, dishid);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				DishVO = new DishVO();
				DishVO.setDish_ID(rs.getString("dish_ID"));
				DishVO.setDish_name(rs.getString("dish_name"));
				DishVO.setDish_status(rs.getString("dish_status"));
				DishVO.setDish_pic(rs.getBytes("dish_pic"));
				DishVO.setDish_resume(rs.getString("dish_resume"));
				DishVO.setDish_price(rs.getInt("dish_price"));
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

		return DishVO;
	}

	@Override
	public List<DishVO> getAll() {
		List<DishVO> list = new ArrayList<DishVO>();
		DishVO DishVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				DishVO = new DishVO();
				DishVO.setDish_ID(rs.getString("dish_ID"));
				DishVO.setDish_name(rs.getString("dish_name"));
				DishVO.setDish_status(rs.getString("dish_status"));
				DishVO.setDish_pic(rs.getBytes("dish_pic"));
				DishVO.setDish_resume(rs.getString("dish_resume"));
				DishVO.setDish_price(rs.getInt("dish_price"));
				list.add(DishVO);
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


	@Override
	public void insertWithFoods(DishVO dishVO, List<FoodVO> list) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			
			con.setAutoCommit(false);
			
			String cols[] = {"DISH_ID"};
			pstmt = con.prepareStatement(INSERT_STMT,cols);
			pstmt.setString(1, dishVO.getDish_name());
			pstmt.setString(2, dishVO.getDish_status());
			pstmt.setBytes( 3, dishVO.getDish_pic());
			pstmt.setString(4, dishVO.getDish_resume());
			pstmt.setInt(   5, dishVO.getDish_price());
			
			pstmt.executeUpdate();
			
			String next_Dish_ID = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				next_Dish_ID = rs.getString(1);
				System.out.println("自增主鍵值="+next_Dish_ID+"(剛新增成功的菜色編號)");
			}else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
		
			FoodJDBCDAO dao = new FoodJDBCDAO();
			System.out.println("list.size()-A="+list.size());
			for (FoodVO aFood : list) {
				
				aFood.setFood_ID(new String(next_Dish_ID));
				dao.insert2(aFood, con);
				}
			
			con.commit();
			con.setAutoCommit(true);
			System.out.println("新增菜色編號"+next_Dish_ID+"時,共有菜色"+list.size()+"項同時被新增");
			}catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver."+e.getMessage());
			}catch (SQLException se) {
				if (con != null) {
					try {
						System.err.print("Transaction is being");
						System.err.println("rolled back-由-Menu");
						con.rollback();
					}catch (SQLException excep) {
						throw new RuntimeException("rollback error occured."+excep.getMessage());
					}
				}
				se.printStackTrace();
				throw new RuntimeException("A database error occured."+se.getMessage());
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
	public static void main(String[] args) {

		DishJDBCDAO dao = new DishJDBCDAO();
		// 新增
		com.testuse.PicIOTest pic = new com.testuse.PicIOTest();
		
		DishVO dishVO = new DishVO();
		
		dishVO.setDish_name("臘味櫻花蝦米糕");
		dishVO.setDish_status("D1");
		dishVO.setDish_pic(pic.getPictureByteArray("C:/T3/年菜套餐/黑蒜剝皮辣椒雞湯.jpeg"));
		dishVO.setDish_resume("鮮美透亮的櫻花蝦，配上香氣四溢的肝臘腸，與口感十足糯米糕結合，加以紅蔥頭油點綴，香氣直撲而來，口感軟而不爛！嚴選台灣在地食材與天然配料，這款家家戶戶年節必備之大菜，絕對讓您吃得安心！");
		dishVO.setDish_price(588);
		
		/*private String dish_ID;
	private String dish_name;
	private String dish_status;
	private byte[] dish_pic;
	private String dish_resume;
	private Integer dish_price;*/
		
		List<FoodVO> testList = new ArrayList<FoodVO>();
		FoodVO foodVO = new FoodVO();

		foodVO.setFood_ID("F00019");
		foodVO.setFood_name("小白菜");
		foodVO.setFood_type_ID("f0");
		
		
		testList.add(foodVO);
		
		dao.insertWithFoods(dishVO, testList);
		
//		// 修改
//		DishVO dishVO2 = new DishVO();
//
//		dishVO2.setDish_ID("D00008");
//		dishVO2.setDish_name("黑蒜剝皮辣椒雞湯");
//		dishVO2.setDish_status("D1");
//		dishVO2.setDish_pic(picIOTest.getPictureByteArray("C:/T3/年菜套餐/黑蒜剝皮辣椒雞湯.jpeg"));
//		dishVO2.setDish_resume("選用900克的紅羽土雞入湯，熬煮3小時以上，肉質紮實，口感絕佳，使用豬大骨、雞骨架熬製8小時以上，再佐以黑蒜以及花蓮在地剝皮辣椒，味道濃郁、湯頭卻清甜，加上剝皮辣椒特殊微辣口感，年菜就靠這道稱霸全場！");
//		dishVO2.setDish_price(799);
//		dish.update(dishVO2);
//		
//		//刪除
//		dish.delete("D00009");
//		//查詢
//		DishVO DishVO3 = dish.findByPrimaryKey("D00007");
//		System.out.print(DishVO3.getDish_ID() + ",");
//		System.out.print(DishVO3.getDish_name() + ",");
//		System.out.print(DishVO3.getDish_status() + ",");
//		System.out.print(DishVO3.getDish_pic() + ",");
//		System.out.print(DishVO3.getDish_resume() + ",");
//		System.out.print(DishVO3.getDish_price() + ",");
//		System.out.println("---------------------");

		//查詢
		List<DishVO> list = dao.getAll();
		for (DishVO adish : list) {
			System.out.print(adish.getDish_ID() + ",");
			System.out.print(adish.getDish_name() + ",");
			System.out.print(adish.getDish_status() + ",");
			System.out.print(adish.getDish_pic() + ",");
			System.out.print(adish.getDish_resume() + ",");
			System.out.print(adish.getDish_price() + ",");
			System.out.println();
		}
	}
}