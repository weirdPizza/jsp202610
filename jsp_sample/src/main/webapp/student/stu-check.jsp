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
		String stuNo = request.getParameter("stuNo");
		String query = "SELECT * FROM STU WHERE STUNO = "+stuNo;
		ResultSet rs = stmt.executeQuery(query);
		if(rs.next()) {
			// 존재하는 학번 -> 사용불가
			out.println("이미 사용중인 학번입니다.");
		}else {
			out.println("사용 가능한 학번입니다.");
			flg = true;
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
		/* window.opener엔 나를 띄운 브라우저의 정보가 담겨있음 */
		/* 그래서 날 띄운 애의 함수를 호출 가능 */
		<%-- window.opener.fnReturn("<%= flg %>"); --%>
		window.close();
	}
</script>