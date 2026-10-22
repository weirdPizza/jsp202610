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
		ResultSet rs = null;
		String stuNo = request.getParameter("stuNo");
		String query = "SELECT S.STUNO, S.NAME, S.GRADE, SUBSTR(JUMIN,1,6) BIRTH, S.TEL, D.DNAME FROM STU S "+
				"INNER JOIN DEPARTMENT D "+
				"ON S.DEPTNO1 = D.DEPTNO "+
				"WHERE S.STUNO ="+stuNo;
		rs = stmt.executeQuery(query);
		if(rs.next()){
	%>
			<ul>
				<li>학번 : <%= rs.getString("STUNO") %></li>
				<li>이름 : <%= rs.getString("NAME") %></li>
				<li>학년 : <%= rs.getString("GRADE") %></li>
				<li>생년월일 : <%= rs.getString("BIRTH") %></li>
				<li>번호 : <%= rs.getString("TEL") %></li>
				<li>학과명 : <%= rs.getString("DNAME") %></li>
			</ul>
			<button onclick="fnRemove(<%= stuNo %>)">삭제</button>
			<button onclick="fnEdit(<%= stuNo %>)">수정</button>
	<%
		}else{
	%>
		<div>해당하는 학생이 존재하지 않습니다.</div>
	<%
		}
	%>
	<a href="stu-list.jsp"><button>목록으로</button></a>
</body>
</html>
<script>
	function fnRemove(stuNo){
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		location.href="stu-remove-result.jsp?stuNo="+stuNo;
	}
	function fnEdit(stuNo){
		location.href="stu-edit.jsp?stuNo="+stuNo;
	}
</script>