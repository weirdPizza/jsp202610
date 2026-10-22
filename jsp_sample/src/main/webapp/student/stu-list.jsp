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
	}
	a {
		color: black;
		text-decoration: none;
	}
	a:hover{
		text-decoration: underline;
	}

</style>
</head>
<body>
	<%@ include file="../db.jsp" %>
	<h2>학생 리스트</h2>
	<table>
		<tr>
			<th>학번</th>
			<th>이름</th>
			<th>아이디</th>
			<th>학년</th>
			<th>학과명</th>
			<th>성별</th>
		</tr>
	<%
		String keyword = request.getParameter("keyword");
		String grade = request.getParameter("grade");
		if(keyword != null){
			keyword = " AND NAME LIKE '%"+keyword+"%'";
		}else{
			keyword="";
		}
		if(grade != null){
			grade = " AND GRADE=" +grade;
		}else{
			grade="";
		}
		String query = "SELECT S.STUNO, S.NAME, S.ID, S.GRADE, D.DNAME, DECODE(SUBSTR(JUMIN,7,1),1,'남자','여자') GENDER "+
			"FROM STU S INNER JOIN DEPARTMENT D "+
				"ON S.DEPTNO1 = D.DEPTNO WHERE 1=1"+ keyword + grade +" ORDER BY STUNO";
		System.out.println(query);
	
		ResultSet rs = stmt.executeQuery(query);
		while(rs.next()){
	%>
			<tr>
				<td><%= rs.getString("STUNO") %></td>
				<td><a href="javascript:;" onclick="fnView(<%= rs.getString("STUNO") %>)"><%= rs.getString("NAME") %></a></td>
				<td><%= rs.getString("ID") %></td>
				<td><%= rs.getString("GRADE") %></td>
				<td><%= rs.getString("DNAME") %></td>
				<td><%= rs.getString("GENDER") %></td>
			</tr>
	<%		
		}	
		int gradeList[] = {1,2,3,4};
	%>
	<form name="form">
		<div>
			검색어 : <input name="keyword" onchange="fnGrade()">
			<button onclick="fnSearch()">검색</button>
			<select name="grade">
				<option>::전체::</option>
		<%
			
			for(int i=0; i<gradeList.length; i++){
		%>
			<option value=<%=gradeList[i] %>><%= gradeList[i] %>학년</option>
		<%	
			}
		%>	
			</select>
		</div>
	</form>

	<hr>
	</table>
	<div>
		<a href="stu-add.jsp"><button>학생추가</button></a>
	</div>
</body>
</html>
<script>
	function fnView(stuNo){
		location.href="stu-view.jsp?stuNo="+stuNo;
	}
	function fnSearch(){
		let form = document.form;
		location.href = "stu-list.jsp?keyword="+form.keyword.value;
	}
	function fnGrade(){
		let form = document.form;
		location.href = "stu-list.jsp?grade="+form.grade.value;
	}
</script>