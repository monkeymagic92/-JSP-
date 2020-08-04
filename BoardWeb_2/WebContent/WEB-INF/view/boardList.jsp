<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String strI_board = request.getParameter("i_board");
	String strI_name = request.getParameter("i_name");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>리스트</div>
	<h1><%=strI_board %><h1>
	<h1><%=strI_name %><h1>
</body>
</html>