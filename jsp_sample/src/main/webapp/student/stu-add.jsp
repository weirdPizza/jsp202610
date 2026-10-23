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
	input[readonly]{
		background-color: #ccc;
	}
</style>
</head>
<body>
	<%@ include file="../db.jsp" %>
	<form name="form" action="stu-add-result.jsp">
		<table>
			<tr>
				<th>학번</th>
				<td>
					<input name="stuNo">
					<input type="button" value="중복체크" onclick="fnCheck()">
				</td>
				<th>이름</th>
				<td><input name="stuName"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input name="stuId"></td>
				<th>학년</th>
				<td>
					<select name="stuGrade">
						<option value="1">1학년</option>
						<option value="2">2학년</option>
						<option value="3">3학년</option>
						<option value="4">4학년</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>학과</th>
				<td colspan="3">
					<!-- 학과같은 경우는 위에 학년처럼 하드코딩하면 안됨. 
					왜? 학과는 이름이 바뀔 때마다 데베 내용 바뀌면 jsp코드도 바꿀거야? 
					ㄴㄴ 데베꺼 갖다 쓰는 게 낫겠죠? -->
					<select name="deptNo">
					<%
						ResultSet rs = null;
						/* 먼저 ResultSet을 위에서 정의하면 좋음 왜냐면 아래에서 여러번 쿼리를 정의할 수 있잖아ㅇㅇ */
						String query = "SELECT * FROM DEPARTMENT WHERE DNAME LIKE '%학과'";
						rs = stmt.executeQuery(query);
						
						while(rs.next()){
					%>
						<option value="<%=rs.getString("DEPTNO") %>"><%= rs.getString("DNAME") %></option>
						
					<%	
						}
					%>
					</select>
				</td>
			</tr>
		</table>
		
		<div>
			<input type="button" value="학생추가" onclick="fnAdd()">
			<input type="reset" value="초기화">
			<a href="stu-list.jsp"><button>목록으로</button></a>
		</div> <!-- 버튼은 form 태그 안에 있어야 정상동작함을 잊지 말기! -->
	</form>

</body>
</html>
<script>
	let addFlg = false;
	function fnAdd(){
		let form = document.form;
		if(!addFlg){
			alert("중복체크 확인 후 추가해주세요.");
			return;
		}
		if(form.stuNo.value.length != 4){
			alert("학번은 4글자 입니다.");
			return;
		}
		form.submit();
	}
	function fnCheck(){
		let form = document.form;
		let stuNo = form.stuNo.value;
		
		if(stuNo.length != 4){
			alert("학번은 4글자 입니다.");
			return;
		}
		window.open(`stu-check.jsp?stuNo=\${stuNo}`, "check", "width=500, height=500");
		/* jsp는 달러키를 특수키로 인식해서 이스케이프 문자 써줘야함 */
	}
	function fnReturn(flg){
		/* console.log(flg); */
		let form = document.form;
		if(flg){
			form.stuNo.readOnly = true;	
			addFlg = true;
		}	
	}
</script>