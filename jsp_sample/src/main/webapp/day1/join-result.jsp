<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>가입완료!</h2>
	<%
		out.println("<div>아이디 : "+request.getParameter("userId")+"</div>");
		out.println("<div>비밀번호 : "+request.getParameter("userPwd")+"</div>");
		out.println("<div>이름 : "+request.getParameter("userName")+"</div>");
		out.println("<div>성별 : "+request.getParameter("userGender")+"</div>");
	%>
</body>
</html>