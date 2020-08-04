<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>	
<%@ page import="com.koreait.web.BoardVO" %> 
<%@ page import="com.koreait.web.DAO" %>

<%
	DAO dao = new DAO();

	Connection con = null;
	PreparedStatement ps = null;
	
	String i_board = request.getParameter("i_board");
	int intI_board = Integer.parseInt(i_board);
	String title = request.getParameter("title");
	String ctnt = request.getParameter("ctnt");
	String i_student = request.getParameter("i_student");
	int intI_student = Integer.parseInt(i_student);
	
	
		
	int result = -1; // 에러났을시 -1을 반환
	
	
	String err = "";
	if(title == "") {
		err = "제목을 작성하지 않았습니다";
	} else if (ctnt == "") {
		err = "내용을 작성하지 않았습니다";
	} 
	
	
	
	String sql = " UPDATE t_board set title = ?, ctnt = ?, i_student = ? WHERE i_board = ? ";
	
	try {
		
		con = dao.getCon();
		ps = con.prepareStatement(sql);
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3, intI_student);
		ps.setInt(4, intI_board);
		ps.executeUpdate(); // 익스큐트 업데이트 하기전에 ?에 값을 넣어줘야됨 ( 무조건 !!!!!!!!! 필수)
		
%>
		<script>
			alert("수정되었습니다");
			location.href="boardList.jsp"
		</script>
	<!-- 또는 
		자바코드로 할경우 : response.sendRedirect("/jsp/boardDetail.jsp?i_board=" + strI_board);
	 -->

<%
		
	} catch(Exception e) {
		e.printStackTrace();
		out.println("boardUpdate.jsp - Error!");
	} finally {
		if(ps != null) {try {ps.close();} catch(Exception e) {} }
		if(con != null) {try {con.close();} catch(Exception e) {} }
	}
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<style>
</style>
<body>
	<h1><%=err %></h1>
	<h1><%=intI_student %></h1>
</body>
</html>
