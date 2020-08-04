<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String msg ="";
	String err = request.getParameter("err"); // boardWriteProc.jsp 에서 뒤로 다시 넘어옴
	
	
	// boardWirteProc.jsp 에서 에러가 발생했을경우 다시 write 페이지로 넘어와서 에러를 띄움 
	if(err != null) {
		switch(err) {
		case "10":
			msg="등록할수 없습니다";
			break;
			
		case "20":
			msg ="DB 에러 발생";
			break;
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
	input {
		margin-left: 50px;
		color: blue;
	}
	
	textarea {
		margin-left: 50px;
	}
	#msg { color: red; }
</style>


</head>
<body>
	<div id="msg">
	<%=msg %>   <!-- 에러 떳을시 출력부분 ( 위에 스위치문 만들어놨음 )  -->
	</div>
	

	<div>

		<!--  method="get" 또는 "post" 방식 둘중 하나를 선택할수 있다   -->
		<!--  url 주소창보면 get방식은 url이 다찍히지만 post방식은 안찍힘 -->
		<!--  보안이 필요하다 = get      내용이길고 보안을 중요 = post -->
		<!--  <label> 사용이유 : 말그대로 글자로 적힌 제목,내용,작성자 클릭하면 커서가 꽂힘 -->
		<!--  radio, checkbox 등 조그만한거 누르기 힘들때 글자눌러도 바로 찍히도록 하기위해 label사용 -->

		<!--  값 입력부분, 값 처리 부분 이렇게 서로 소스들을 나눠서 관리하는게 좋다. -->
		<!--  name="" 이부분은 key값으로 쓰인다 -->

		<!--  사용 역활 name="" : html,자바스크립에는 딱히 용도없음 / 서버에 값날릴때 'key'값으로 사용(쿼리스트링 key = value) / 서버를 위한 용도-->
		<!--         id="" : id는 유일하개 한개의 값만 주기위한(한놈uniqe) 용도, 즉, id="AA" 했으면 다른거는 다른아이디 걸어야됨 (중복되면안됨, 유일성 강조!!)-->
		<!--        class="" : 집단으로 사용하기위한, id와 다르게 class="AA" class="AA" 이런식으로 같은이름을 여러개 줄때 class="aa bb cc" 이런식으로 한클래스에 여러개 주기가능 -->

		<!--  submit : name="title", name="ctnt"... 등 name으로 받은값을 캡슐화해서 인풋버튼 클릭할경우 바로 값을 연동한 페이지로 넘기는 역활 -->
		<!--  value : 버튼에 글을 적는기능 그냥 보면 알것임 쉬움 이건 -->
		<!-- 자바스크립트에서 메소드명이 on~~ 어쩌고 시작하는건 다 이벤트임   ex) onsubmit=""      onclick=""   등등  -->
		<!-- onsubmit => input type="submit" 을 눌렀을대 동작을 함    -->
		
		<!-- onsubmit="return chk()">    여기서 확인창 눌러도 창이 안넘어가게하려면   onsubmit="return false" 를 해야 창이 안넘어감   -->
		<form id="frm" action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()">
			<div>
				<label>제목:<input type="text" name="title"></label>
			</div>
			<div>
				<label>내용:<textarea name="ctnt"></textarea></label>
			</div>
			<div>
				<label>작성자:<input type="text" name="i_student"></label>
			</div>
			<div>
				<input type="submit" value="글등록">
			</div>
		</form>
	</div>
	
	<!-- 자바스크립트는 html 코드 body 영역 제일아래 적는게 좋다  (위에해도 좋지만 아래에 하는게 좋음) -->
	<!--  css 는 항상 body 부분 위에 적는다 왜냐 ? 아래에 적으면 html 코드 다읽고 css를 적용하기때문에 '번쩍' 현상이 나타남  -->
	
	
	
	<script>
	// 유효성 검사부분 ( 하나라도 빈값이 들어갈경우 alert창 띄우는 부분 ) 
	
	/*
		function chk() {
			console.log(`title : \${frm.title.value}`);  // form 태그에 id="frm" 을줬음  즉 아이디값을 주면 바로 자바스크립트에서 객체화로 사용가능
			//console.log("title : " + frm.title.value);										 // 자바스크립트에서는 ${frm.title.value} 해도되지만  JSP에서는 \$ 해줘야됨  왜냐 ? jsp에서도 $표시를 사용하여 중첩되기 때문에 구분용
			if (frm.title.value == '') {
				alert("제목을 입력해 주세요");
				frm.title.focus();
				return false;
			} else if (frm.ctnt.value.length == 0) {
				alert("내용을 입력해 주세요");
				frm.ctnt.focus()    // 마우스 커서를 여기다가 주겠다
				return false;
			} else {
				alert("작성자를 입력해주세요")
				frm.i_student.focus()
				return false;
			}
			
		}
	*/
		// 위에 코드를 간지나게 작성
		function eleValid(ele, nm) {
			if(ele.value.length == 0) {
				alert(nm + "을(를) 입력해 주세요.")
				ele.focus()
				return true;
			}
		}
		
		function chk() {
			console.log(`title : \${frm.title.vluae}`);
			if(eleValid(frm.title,'제목')) {
				return false
			} else if (eleValid(frm.ctnt,'내용')) {
				return false
			} else if (eleValid(frm.i_student,'작성자')) {
				return false
			} 
				
		}
	</script>
	
</body>
</html>