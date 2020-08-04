<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.koreait.web.DAO" %>
<%@ page import="com.koreait.web.BoardVO" %>


<%
	DAO dao = new DAO();
	
	String strI_board = request.getParameter("i_board");
	int intI_board = Integer.parseInt(strI_board);
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String title = "";
	String ctnt = "";
	int i_student = 0;
	
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	
	try {
		con = dao.getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1,intI_board);		
		rs = ps.executeQuery(); // 일단은 위에 ps문 다작성하고 execute 실행후 !!  rs.get ~~ 적기
		
		if(rs.next()) {	
			title = rs.getNString("title");
			ctnt = rs.getNString("ctnt");
			i_student = rs.getInt("i_student");
		}
		
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("boardMod.jsp - Error!");
	} finally {
		if(rs != null) {try {rs.close();} catch(Exception e) {} } // SELECT 사용할때 필요
		if(ps != null) {try {ps.close();} catch(Exception e) {} }
		if(con != null) {try {con.close();} catch(Exception e) {} }
	}
	
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=intI_board %>번 페이지 수정화면</title>
</head>
<body>
	</div>
	<div>
		<!-- value="" 는 작성된 값을 나타나게 할수있는 ... 그내용 그대로를 커서가 찍히게끔 가져옴  -->
		<h2><%=intI_board%> 페이지</h2>
		<form action="/jsp/boardUpdate.jsp?i_board=<%=intI_board %>" method="post">
			<input type="hidden" name="i_board" value="<%=strI_board %>">
			<div>
				<label>제목:<input type="text" value="<%=title %>" name="title"></label>
			</div>
			<div>
				<label>내용:<textarea name="ctnt"><%=ctnt %></textarea></label>
			</div>
			<div>
				<label>작성자:<%=i_student %><input type="text" value="<%= i_student%>" name="i_student"></label>
			</div>
			<div>
				<input type="submit" value="수정등록">
			</div>
		</form>
	</div>
</body>	
</html>