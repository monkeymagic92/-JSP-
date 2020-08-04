package com.koreait.web;

import java.sql.*;

public class DAO {
	
	
	// 싱글톤 만드는 법 
//	private static DAO dao = null;
//	
//	private DAO(){} // private 생성자
//	
//	public static DAO getDao(DAO dao) {
//		if(dao == null) {
//			dao = new DAO();
//		}
//		return dao;
//	}
	
	
	
	public Connection getCon() throws Exception{
		
		Connection con = null;
		

		try {
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String userName = "hr";
			String userPassword = "orcl";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, userName, userPassword);
			System.out.println("server login");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error");
		}

		return con;
	}
	
	// 위에 getCon() 메소드를 닫기위한 (즉, 커넥션을 닫기위한 메소드)
	public void closeCon(Connection con) throws Exception {
		con.close();
	}
	
	
	

}
