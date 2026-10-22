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
		String stuName = request.getParameter("stuName");
		String stuId = request.getParameter("stuId");
		String stuGrade = request.getParameter("stuGrade");
		String deptNo = request.getParameter("deptNo");
		
		String query = String.format("INSERT INTO STU (STUNO, NAME, ID, GRADE, DEPTNO1) VALUES ('%s', '%s', '%s', %s, %s)", stuNo, stuName, stuId, stuGrade, deptNo);
		/* 문자열만 %s를 작은 따옴표로 감쌈ㅇㅇ */
		int result = stmt.executeUpdate(query);
		if(result>0){
			out.println("추가되었습니다.");	
		}else{
			out.println("추가에 실패했습니다.");		
		}
	%>
	<div>
		<a href="stu-list.jsp"><button>목록으로</button></a>
	</div>
</body>
</html>