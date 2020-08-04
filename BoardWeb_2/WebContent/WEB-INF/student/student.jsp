<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String i_student = request.getParameter("i_student");
	int intI_student = Integer.parseInt(i_student);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	i_student 값 * 2 : <%=intI_student * 2%>
</body>
</html>