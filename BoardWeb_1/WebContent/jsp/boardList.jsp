<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>	
<%@ page import="com.koreait.web.BoardVO" %> 


<%!
	public Connection getCon() throws Exception {
		String url ="jdbc:oracle:thin:@localhost:1521:orcl"; // 포트번호
		String username = "hr";
		String password = "orcl";  
		
		Class.forName("oracle.jdbc.driver.OracleDriver"); // 어떤 드라이브 연결할지
		Connection con = DriverManager.getConnection(url,username,password);
		System.out.println("접속 성공!");	
		return con;
	}
%>

<%
	

	List<BoardVO> boardList = new ArrayList(); //BoardVO 객체를 여러개 담을수 있는 리스트 
	
	Connection con = null; 
	PreparedStatement ps = null; 
	ResultSet rs = null; // SELECT 사용할때 필요한 클래스(인터페이스 (?))
	
	String sql = " SELECT i_board, title "
			+ " FROM t_board ORDER BY i_board DESC";  // sql 문법 사용할땐 String sql(    ~~~    ); (괄호안 문법 마지막에 ; <-- 붙이면안됨) 해킹됨 (tip 앞뒤 띄워줌 좀더 안전함(문법에러방지))
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		
		while(rs.next()) {
			int i_board = rs.getInt("i_board"); // "i_board" (t_board의 컬럼명) // "i_board" 컬럼의 타입 : 정수타입    int i_board = (정수타입컬럼 값);
			String title = rs.getString("title"); // rs.getString() 또는 rs.getNString() 둘다같음    위에 내용과 같음
			
			BoardVO vo = new BoardVO(); // ★★ BoardVO 객체는 while 반복문 안에서만 써야됨 (왜냐? 랜덤값을 '반복문'밖에 넣은거랑 같음 그러니까 while문 안에서만 써야 계속 연속적으로 값을 넣는거임)
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);
		}
		
	} catch(Exception e) {
		e.printStackTrace();	
		out.println("boardList 에러!");
		
	} finally {
		// 열었으면 꼭 닫아줘야됨 위에서 con,ps,rs 열었으면 닫을때는 rs,ps,con 순으로 위에서 밑으로 -> 밑에서 위로
		// 따로따로 try catch를 한이유는 rs에서 에러가 뜨더라도, ps에서 닫아주고  또한 ps가 에러뜨더라도 con은 닫아줘야되니
		if(rs != null) {try {rs.close();} catch(Exception e) {} } // SELECT 사용할때 필요
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
        table { width: 300px; border: 1px solid black; border-collapse: collapse;}
        td { border: 1px solid black; text-align:center;}
        tr { height: 60px;}
        #f { text-align: center; color: red;} 
</style>
<body>
	<div id="f">
	게시판 리스트
	<a href="/jsp/boardWrite.jsp"><button>글쓰기</button></a>
	</div>	
	
	<table><caption>게시판</caption>
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		
		<% for(BoardVO vo : boardList) { %>
		<tr>
			<td><%=vo.getI_board() %></td>
			<td><a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board() %>">
			<!-- 쿼리스트링 : ?i_board= 이거할때 띄워쓰기 있으면안됨 다 붙여적혀야됨 -->
			<%=vo.getTitle() %></a></td>
		</tr>
		<% } %>
	</table>	
</body>
</html>