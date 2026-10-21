<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../db.jsp" %>
	<%
		String userId = request.getParameter("userId");
		String pwd = request.getParameter("pwd");
		
		String query = "SELECT * FROM TBL_USER WHERE USERID = '"+userId+"' AND PWD = '"+pwd+"'";
		/* out.println(query); */
		ResultSet rs = stmt.executeQuery(query); 
		// select 조회는 executeQuery()고 데베에 변화를 주는 insert 이런 것들은 updateQuery()임.
		if(rs.next()){ 
		// pk로 조회하니까 결과가 1개 또는 0개임. updateQuery()일 경우 업뎃한 행 개수 리턴하니까 이런 조건 못 세우는 거 유의 
			/* out.println("로그인 성공!"); */
			response.sendRedirect("board-list.jsp");
		}else{
			out.println("로그인 실패");
		}
	%>
</body>
</html>