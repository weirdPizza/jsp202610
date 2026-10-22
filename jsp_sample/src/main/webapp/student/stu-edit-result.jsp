<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
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
		
		//String query = String.format("UPDATE STU SET NAME = '%s', ID = '%s', GRADE = %s, DEPTNO1 = %s WHERE STUNO = %s", stuName, stuId,stuGrade,deptNo, stuNo);
		
 		String query = "UPDATE STU SET "+ 
				"NAME = '"+stuName+"', ID = '"+stuId+"' , GRADE ="+stuGrade+" , DEPTNO1 ="+deptNo+
				" WHERE STUNO = "+stuNo;
		//out.println(query);
		
		int result = stmt.executeUpdate(query);
		if(result > 0){
			out.println("성공적으로 수정되었습니다.");
		}else{
			out.println("시스템 오류로 수정에 실패했습니다.");
		}
	%>
	<div>
		<a href="stu-list.jsp"><button>목록으로</button></a>
	</div>
</body>
</html>