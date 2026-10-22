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
		String stuNo = request.getParameter("stuNo");
		String query = "DELETE FROM STU WHERE STUNO = "+stuNo;
		
		int result = stmt.executeUpdate(query);
		if(result>0){
			out.println("성공적으로 삭제되었습니다.");
		}else{
			out.println("시스템오류로 삭제에 실패했습니다.");
		}
	%>
	<div>
		<a href="stu-list.jsp"><button>목록으로</button></a>
	</div>
</body>
</html>