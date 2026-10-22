<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, tr, th, td{
		border: 2px solid black;
		border-collapse : collapse;
		padding : 5px 10px;
		text-align: center;
	}
	th{
		background-color: #ccc;
		padding: 10px 20px;
	}
	td input{
		width: 270px;
		height: 25px;
	}
	td{
		text-align: left;
		width: 300px;
		padding: 10px;
	}
</style>
</head>
<body>
	<%@ include file="../db.jsp" %>
	<%
		ResultSet rs = null;
		String stuNo = request.getParameter("stuNo");
		String query = "SELECT STUNO, NAME, ID, GRADE, DEPTNO1, DNAME FROM STU S "+
				"INNER JOIN DEPARTMENT D "+
				"ON S.DEPTNO1 = D.DEPTNO "+
				"WHERE STUNO = "+stuNo;
		
		rs = stmt.executeQuery(query);
		if(!rs.next()){
			out.println("해당하는 학생이 존재하지 않습니다.");
			/* 되돌아가기 버튼 만들어야 */
		}else{
			String deptNo = rs.getString("DEPTNO1");
	%>
	<form name="form" action="stu-edit-result.jsp">
		<input class="stuNo" name="stuNo" value="<%= rs.getString("STUNO") %>" hidden>
		<!-- 이렇게 disabled해야 하는 경우 hidden으로 값 보내줌.  -->
		<table>
			<tr>
				<th>학번</th>
				<td><input class="stuNo" name="stuNo" value="<%= rs.getString("STUNO") %>" disabled></td>
				<!-- input 태그를 disabled 로 설정한 경우 서버로 값이 안넘어감. 주의!!!!!!!! -->
				<th>이름</th>
				<td><input name="stuName" value="<%= rs.getString("NAME") %>"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input name="stuId" value="<%= rs.getString("ID") %>"></td>
				<th>학년</th>
				<td>
					<select name="stuGrade">
					<!-- 같은 코드 반복이니까 반복문 돌리는 게 좋음 -->
						<option value="1" <%= rs.getString("GRADE").equals("1")? "selected":"" %>>1학년</option>
						<option value="2" <%= rs.getString("GRADE").equals("2")? "selected":"" %>>2학년</option>
						<option value="3" <%= rs.getString("GRADE").equals("3")? "selected":"" %>>3학년</option>
						<option value="4" <%= rs.getString("GRADE").equals("4")? "selected":"" %>>4학년</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>학과</th>
				<td colspan="3">
					<select name="deptNo">
				<%
						String deptQuery = "SELECT * FROM DEPARTMENT WHERE DNAME LIKE '%학과'";
						ResultSet deptRs = stmt.executeQuery(deptQuery);
						/* 위에 담은 게 있는 rs니 똑같은 이름 쓰면 안됨. 새로 만들어줘야! */
						
						while(deptRs.next()){
					%>
						<option value="<%=deptRs.getString("DEPTNO") %>" <%= deptRs.getString("DEPTNO").equals(deptNo) ? "selected" : ""%>><%= deptRs.getString("DNAME") %></option>
						<%-- <%= deptRs.getString("DEPTNO").equals(rs.getString("DEPTNO1"))?"selected":"" %> --%>
					<%	
						}
					%>
					</select>
				</td>
			</tr>
		</table>
		
		<div>
			<input type="submit" value="수정">
			<input type="reset" value="초기화">
			<a href="stu-list.jsp"><button>목록으로</button></a>
		</div> <!-- 버튼은 form 태그 안에 있어야 정상동작함을 잊지 말기! -->
	</form>
	<%
		}
	%>
</body>
</html>
