package com.jy.student;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Test")
public class Test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Test() {
        super();
        
    }
    
    public Connection getCon() throws Exception {
    	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    	String userName = "hr";
    	String userPassword = "orcl";
    	
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	Connection con = DriverManager.getConnection(url, userName, userPassword);
    	return con;
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String i_student = request.getParameter("i_student");
		RequestDispatcher rs = request.getRequestDispatcher("WEB-INF/student/student.jsp");
		
		System.out.println("서블릿 성공 값 :" + i_student);
		
		rs.forward(request, response);
		
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		Connection con = null;
		
		try {
			con = getCon();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("connection 실패");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
