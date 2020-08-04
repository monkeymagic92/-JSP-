<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.DAO" %>
<%@ page import="com.koreait.web.BoardVO" %>


<%
	DAO dao = new DAO();

	
	Connection con = null;
	PreparedStatement ps = null;
	
	String strI_board = request.getParameter("i_board");
	int result = Integer.parseInt(strI_board);
	
	
	try {
		con = dao.getCon();
		String sql = " DELETE FROM t_board WHERE i_board = ? ";
		ps = con.prepareStatement(sql);
		ps.setInt(1,result);
		result = ps.executeUpdate();
		
		
	} catch(Exception e) {
		e.printStackTrace();
		out.println("Error!!");
	} finally {
		if(ps != null){try{ps.close();}catch(Exception e){}}
		if(con != null){try{con.close();}catch(Exception e){}}	
	}
	
	// result -1 : 에러    ,   result : 0 값삭제안됨  ,  result = 1 제대로된삭제 다시 게시판 페이지로 이동 
	
	/// 페이지 돌아가는 기능 자바와 , 자바스크립트의 함수
	// 자바 : response.sendRedirect -> jsp 서블릿 내장함수	
	// 자바스크립 : location.href='/jsp/boardWrite.jsp' 
	switch(result) {
	case -1:
		response.sendRedirect("/jsp/boardDetail.jsp?err=-1&i_board");
		break;
	case 0:
		response.sendRedirect("/jsp/boardDetail.jsp?err=0&i_board");
		break;
	case 1:
		response.sendRedirect("/jsp/boardList.jsp");
		break;
	}
	

%>


