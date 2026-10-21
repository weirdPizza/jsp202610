<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- id/pw가 test/1234면 '로그인 성공' 출력 -->
	<!-- 아니면 '로그인 실패' 출력 -->
	
	<%
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("pwd");
		
		
		if(userId.equals("test")&& userPwd.equals("1234")){
			out.println("로그인 성공!");
		}else{
			out.println("로그인 실패!");
		}
	%>
	
	<hr>
	<%= userId %> / <%= userPwd %>
</body>
</html>