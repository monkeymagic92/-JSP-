package com.koreait.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/BoardList")  		  // 주소는 아무거나 내꼴리는대로 적음됨
								  // @WebServlet("/") 이렇게하면 메인페이지 됨  ( ex www.nvaer.com)  ( 진입문 )
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public BoardListSer() {
    	super();        
        
    }
    //////////////////////////////////////////////////////////////    
    public Connection getCon() throws Exception {
    	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    	String userName = "hr";
    	String userPassword = "orcl";
    	
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	System.out.println("Connection Server login ^ ^*");
    	Connection con = DriverManager.getConnection(url, userName, userPassword);
    	return con;
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////
    // 8.4 집에서해보기 브라우저 url 창에서 주소 ?i_board=하하&i_name=키키 해보면 매개변수값 넘어감
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		String strI_name = request.getParameter("i_name");
		System.out.println("Servlet i_board : " + strI_board);
		System.out.println("Servlet i_name : " + strI_name);
		
		RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/view/boardList.jsp");
		rd.forward(request, response);
		
		
		
		////////////////////////////////////////////////////////////////////////////////	
		Connection con = null;
		
		try {
			con = getCon();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("connection 실패");
		}
		////////////////////////////////////////////////////////////////////////////////
		
	}

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}

