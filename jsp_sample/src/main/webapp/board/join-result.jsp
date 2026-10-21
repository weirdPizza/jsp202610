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
		String name = request.getParameter("name");
		
		String query = "INSERT INTO TBL_USER (USERID, PWD, NAME, CDATETIME, UDATETIME) VALUES ("
				+ "'"+userId+"', "+
				"'"+pwd+"', "+
				"'"+name+"', "+"SYSDATE, SYSDATE)";
		
		//System.out.println(query);
		
		int result = stmt.executeUpdate(query);
		
		if(result>0){
	%>
		<div>
			환영합니다. 가입되었습니다.
		</div>
		<a href="login.jsp"><button>로그인</button></a>
	<%
		}else{
	%>
		<div>가입에 실패했습니다.</div>
	<%
		}
	%>

</body>
</html>