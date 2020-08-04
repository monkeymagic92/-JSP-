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
	/*  한글이 넘어오면 깨지는걸 방지하는 인코딩 설정
		method="get" 방식으로 보내면 문제없지만 method="post" 방식으로 보내면 한글이 깨질수있음 
		request.setCharacterEncoding("UTF-8");
		또한 JSP_서블릿명령어3 메모장에 인코딩 설정 방법 넣어놨음 - XML 인코딩설정-
	*/
	
	
	// 넘어오는 겟 파라미터값은 무조건 문자열이기때문에 반환타입을 String으로 해야됨
	String title = request.getParameter("title");
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student"); // a222a  문자열 하나라도 있으면 에러
															// 왜냐 ? 밑에 파스인트할경우 문자하나라도 있음 에러 
	
	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
																	
																	
	
	// ★★정규화 작업 좋은예시 !! 
	// 컬럼값 i_student 를 문자로 적었을경우
	int intI_student;
	try {
		intI_student = Integer.parseInt(strI_student);
	} catch(Exception e) {
		out.println("Error!! strI_student 값에 문자열이 들어왔음 "  
				+ " try문에 파스인트 쳐줬기에 에러남 , 입력받은 값이 문자이기때문에 숫자로 변환 불가  (예전에 try-catch할때 문자열일경우 숫자 0로바꾸는) "
				+ " 메소드 만든거 생각하면 기억날것임 ");
%>		
	<script>
		alert("작성자에 숫자만 입력!");
		location.href='/jsp/boardWrite.jsp'
	</script>

<%
	}
	
	// DB에서 자동으로 전체 글 카운터 횟수 추가되게 하는 기능 
	String sql = " INSERT INTO t_board(i_board, title, ctnt, i_student) "
			+ " SELECT nvl(max(i_board),0) + 1,?,?,? " 
			+ " FROM t_board ";
	
	// INSERT INTO t_board (i_board, title, ctnt, i_student) SELECT 3,'asd','asf',4 FROM dual;
	// 꼭 VALUES 가 아니고 SELECT 에서도 이런식으로 스키마형식으로 값 넣을수 있음 
						
						
	Connection con = null;
	PreparedStatement ps = null;
	String str = "";
						
	int result =  -1;
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setString(1, title);
		ps.setString(2, ctnt);
		ps.setString(3, strI_student);
		result = ps.executeUpdate();
				
		str = " t_board 테이블에 새로운 글 추가 성공 ! ";
		
	} catch(Exception e) {
		e.printStackTrace();
		System.out.println("실패!");
		str = " t_board 에 테이블 추가 실패! ";
	} finally {
		if(ps != null) try{ps.close();} catch(Exception e) { }
		if(con != null) try{con.close();} catch(Exception e) { }
		
	}
	
	int err = 0;
	switch(result) {
	case 1:
		response.sendRedirect("/jsp/boardList.jsp"); // 자바에서 원하는 페이지이동   =  <a href=  >, location href 랑 같음
		return; // return : 은 메소드자체를 종료한다 ( 즉 서블릿메소드를 종료시킨다는 뜻)
		
	case 0:
		err = 10;
		break; // break; : switch문을 종료함
		
	case -1:
		err = 20;
		break;
	}
	
	response.sendRedirect("/jsp/boardWrite.jsp?err=" + err); 
	
	
	// 자바코드 = response.sendRedirect("주소명?변수명=" + 변수명); 왜냐 ? 얘는 html아님 그냥 자바임 자바 "  " + 변수명  이거 당연한거아님 ? 어렵게생각하지마라 
	// HTML 코드 : <a href=" 주소?변수명=<%자바변수명 "></a>
	
%>




<!-- 제일초반 제일상단 겟파라미터 값을 받아오고 잘 넘어오는지 테스트용 -->

<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>strI_student : <%=strI_student %></div>

<div><%=str %></div>
    