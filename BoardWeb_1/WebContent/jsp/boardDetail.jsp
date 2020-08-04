<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>	<%-- <%@가 붙으면 세팅한다는 뜻 --%>
<%@ page import="com.koreait.web.BoardVO" %>
    
<%!
	// <-- !가 붙으면 이 메소드 밖에서 밑의 소스를 사용한다는 뜻(_jspservies의 밖)
	//여기는 메소드, 전역변수 사용가능 (private 사용가능)
	private Connection getCon() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "orcl";

		Class.forName("oracle.jdbc.driver.OracleDriver"); 

		Connection con = DriverManager.getConnection(url, username, password); // try-catch(예외처리)를 안해줘서 빨간줄, 여기서 getConnection메소드는 객체화를 하지않았기에 static메소드다
		//DriverManager는 Connection을 만드는역할을 한다								//들러온 파라미터만으로도 작업이 다 가능할경우 static을쓰는게 좋다 (속도가빠름, 사용하기 편리)
																			//DB에 연결된객체를 변수로 넘겨줌( DB와 자바를 선으로 연결해주는 역할이라고 보면됨)
		System.out.println("접속 성공!"); //연결이 잘됐다는걸 확인하기위해 찍음
		return con;
	}
	//http통신은 요청에 응답하면 연결을 바로 끊음 (요청했을때 보내주고 그걸 사용자의컴퓨터에 담은다음에 그화면을 보는것이다, 굉장히 효율적) 그렇기떄문에 connection을 연결후 바로 닫아주는것
	// 그렇기에 다시 요청을하면 연결을 해줘야한다 그렇기떄문에 페이지를 이동할때마다 Connection을 만들어주는것 
%>    
<%
	// 틀(프레임워크)에 jsp_Service라는 메소드가 있고 우리가 request를 쓰면 자동으로 객체화되서
	// 만들어준다 (이걸 내장객체라고 부란다)
	// final javax.servlet.http.HttpServletRequest request
	// 머리아파서 복잡하면 그냥 키값을 파라미터로 요청해서 쓸때는 request라는 내장객체를 쓴다고 생각하자
	
	String strI_board = request.getParameter("i_board"); // request는 쿼리스트링을 받을때 씀
	
						//요청.   파라미터		  (키값)
						
	if(strI_board == null) {	
%>
	<script>
		alert("잘 못 된 접급입니다");
		location.href='/jsp/boardList.jsp'
	</script>
<%
	return ;   // if문을 종료시켜야됨 return을 안시켜놓으면 밑에내용까지 쓸대없이 다 날려줌 
	}
	int i_board = Integer.parseInt(strI_board);
	// getParameter는 ?뒤의 쿼리스트링을 받아올수있는 능력이있음
	// a에 키값을 i_board라고 해놨기에때문에 여기서 "i_board"를 쓸수있는것
	// list에서는 데이터는 안가져온다(리스트를 볼때마다 데이터를 가져온다면 트래픽이 엄청든다)
	// 그렇기에 데이터는 디테일에서 가져오는것
	// 만약 넘어온 i_board(키값)이 없었다면 null값이 담긴다
	// 자바에서 패키지명은 무조건 소문자!(룰임)
	// 정수형으로 바꾸려면 parseInt를 해줘야함
	
	//String sql = " SELECT title,ctnt,i_student FROM t_board WHERE i_board = " + strI_board;
				
	String sql = " SELECT title,ctnt,i_student FROM t_board WHERE i_board = ? ";
	
	BoardVO vo = new BoardVO();
				
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try{
		con = getCon();
	//	ps가 sql문을 완성시키는 기능의 예시
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);//첫번쨰 물음표에다가 i_board을 넣음
	//	ps.setInt(물음표의위치,넣을값);
	//	문자열은 넣는순간 자동으로 ''로 감싸준다 ex) strI_board이 1이라면  => WHERE i_board = '1'이 된다
	//  ps.String(1, strI_board); 이렇게 해줘도 되지만 정수를 넣을때는 strI_board을 인트형으로 파싱해서 넣어주는게 정석

		rs = ps.executeQuery(); //반드시 위에서 ps로 문장을 완성시켜준후 executeQuery()를 해줘야한다.
		// execute뜻 실행하다 -> executeQuery는 Query를 실행하다
	
		if(rs.next()){ //if(rs.next()) 써주는이유 : 바로 String title을 해도되지만 만약 0줄일경우 에러가 터지기에 if(rs.next())를 적어준다
		//while(rs.next())해줘도 상관없음 (애매하다면 while쓰는것도 괜찮음)
		String title = rs.getNString("title");
		String ctnt = rs.getNString("ctnt");
		int i_student = rs.getInt("i_student");
		
		vo.setTitle(title);
		vo.setCtnt(ctnt);
		vo.setI_student(i_student);
		}
	}catch(Exception e){
		e.printStackTrace();
		out.println("문제");
		
	}finally{
		if(rs != null){try{rs.close();}catch(Exception e){}}
		if(ps != null){try{ps.close();}catch(Exception e){}}
		if(con != null){try{con.close();}catch(Exception e){}}	
	}
				
	
	
	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
<div><a href="/jsp/boardList.jsp">리스트로 가기</a> <!-- 뒤로가기 -->
	<a href="#" onclick="procDel(<%=i_board%>)">삭제</a>
	<a href="/jsp/boardMod.jsp?i_board=<%=i_board%>">수정</a>
</div> 
	
	<div>상세 페이지 : <%=strI_board %></div>
	제목 : <%= vo.getTitle() %> <br>
	내용 : <%= vo.getCtnt() %> <br>
	작성자: <%= vo.getI_student() %> <br>	
	
	<script>
		function procDel(i_board){
			//alert('i_board :' + i_board); 값넘어오는지 체크
			//var result = confirm('삭제하시겠습니까?'); 라고해도됨
			if(confirm('삭제 하시겠습니까?')){
				location.href = '/jsp/boardDel.jsp?i_board='+i_board; //엔터로 구분이 됐다면 ;을 생략해도됨(붙여쓴다면 무조건 써야함)
				//location.href는 뭐지?
				// location이라는 객체를 통해 href를 바꿔준다(그 주소로 이동시켜준다);
			}
		}
		
	</script>
	

	<!-- 단위 테스트 - 하나하나 일일이 테스트하면서 넘어감 -->

</body>
</html>