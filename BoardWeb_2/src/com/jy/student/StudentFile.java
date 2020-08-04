package com.jy.student;

import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet("/StudentFile")
public class StudentFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public StudentFile() {
        super();
     
    }
    
//    public Connection getCon() throws Exception {
//    	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
//    	String userName = "hr";
//    	String userPassword = "orcl";
//    	
//    	Class.forName("oracle.jdbc.driver.OracleDriver");
//    	Connection con = DriverManager.getConnection(url, userName, userPassword);
//    	System.out.println("서버 연결 성공!");
//    	return con;
//    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String i_student = request.getParameter("i_student");
		System.out.println("i_student 서블릿 : " + i_student);
		RequestDispatcher rs = request.getRequestDispatcher("WEB-INF/student/student.jsp");
		rs.forward(request, response);
		
		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
//		Connection con = null;
//		PreparedStatement ps = null;
//		
//		try {
//			con = getCon();
//			
//		} catch(Exception e) {
//			e.printStackTrace();
//			System.out.println("실패 ㅜㅜㅜㅜㅜㅜ");
//		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
