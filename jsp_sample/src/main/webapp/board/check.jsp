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
		Boolean flg = false;
		String userId = request.getParameter("userId");
		String query = "SELECT * FROM TBL_USER WHERE USERID = '"+userId+"'";
		System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		if(rs.next()){
			/* 존재하는 유저 -> 사용 불가 */
			out.println("이미 사용중인 아이디입니다.");
		}else{
			out.println("사용 가능한 아이디입니다.");
			flg=true;
		}
	%>
	<div>
		<button onclick="fnClose()">되돌아가기</button>
	</div>
</body>
</html>
<script>
	function fnClose(){
		window.opener.fnReturn(<%= flg %>);
		window.close();
	}
</script>