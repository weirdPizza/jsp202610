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
		// String pwd = "AND PWD = '"+request.getParameter("pwd")+"'";
		
		
		String query = "SELECT * FROM TBL_USER WHERE USERID = '"+userId+"'";
		/* out.println(query); */
		ResultSet rs = stmt.executeQuery(query); 
		// select 조회는 executeQuery()고 데베에 변화를 주는 insert 이런 것들은 updateQuery()임.
		if(rs.next()){ 
		// pk로 조회하니까 결과가 1개 또는 0개임. updateQuery()일 경우 업뎃한 행 개수 리턴하니까 이런 조건 못 세우는 거 유의 
			/* out.println("로그인 성공!"); */
			// 아이디 존재
			/* query = "SELECT * FROM TBL_USER WHERE USERID = '"+userId+"'"+pwd;
			rs = stmt.executeQuery(query); */ 
/* 			if(rs.next()){
				// 비번도 존재
					response.sendRedirect("board-list.jsp");} */
			// 내코드
			
			if(rs.getString("PWD").equals(pwd)){// 쌤코드
				session.setAttribute("sessionId", rs.getString("USERID"));
				session.setAttribute("sessionName", rs.getString("NAME"));
				session.setAttribute("sessionRole", rs.getString("STATUS"));
				/* rs.getString("STATUS")는 문자형태로 넣었지만 오브젝트형!!으로 업캐스팅되어 저장됨! */
				
				session.setMaxInactiveInterval(60 * 30); // 30분 의미
				// 세션만료 시간 : 초단위(60 * 분)
				
				response.sendRedirect("board-list.jsp");
			} else{
				out.println("비밀번호가 존재하지 않습니다.");
			}
			
		}else{
			out.println("아이디가 존재하지 않습니다.");
		}
	%>
</body>
</html>