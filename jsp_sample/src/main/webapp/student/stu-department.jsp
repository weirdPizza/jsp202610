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
		String query1 = "SELECT * FROM DEPARTMENT WHERE DNAME LIKE '%대학'";
		ResultSet rs = stmt.executeQuery(query1);
		
		String param1 = request.getParameter("dept1");
		String param2 = request.getParameter("dept2");
		String param3 = request.getParameter("dept3");
	%>
	<form name="form" action="stu-department.jsp">
		<div>
			<select name="dept1" onchange="fnSelect()">
				<option value="">::선택::</option>
				<%
					while(rs.next()){
						String dept1=rs.getString("DNAME");
						String selected = param1 != null && dept1.equals(param1) ? "selected": "";
				%>
						<option value="<%= dept1%>" <%=selected %>><%= dept1 %></option>
				<%
					}
				%>
			</select>
			<select name="dept2" onchange="fnSelect()">
				<option value="">::선택::</option>
				<%
					String query2 = "SELECT D2.* FROM DEPARTMENT D1 "+
							"INNER JOIN DEPARTMENT D2 ON D2.PART=D1.DEPTNO";
					if(param1 != null){
						query2 += " WHERE D1.DNAME='"+param1+"'";
					}
					rs = stmt.executeQuery(query2);
					while(rs.next()){
						String dept2=rs.getString("DNAME");
						String selected = param2 != null && dept2.equals(param2) ? "selected": "";
				%>
						<option value="<%= dept2%>" <%=selected %>><%= dept2 %></option>
				<%
					}
				%>
			</select>
			<select name="dept3" onchange="fnSelect()">
				<option value="">::선택::</option>
				<%
					String query3 = "SELECT D3.* FROM DEPARTMENT D1 "+
							"INNER JOIN DEPARTMENT D2 ON D2.PART=D1.DEPTNO "+
							"INNER JOIN DEPARTMENT D3 ON D3.PART=D2.DEPTNO";
					if(param1 != null){
						query3 += " WHERE D1.DNAME='"+param1+"' AND D2.DNAME='"+param2+"'";
					}
					rs = stmt.executeQuery(query3);
					while(rs.next()){
						String dept3=rs.getString("DNAME");
						String selected = param3 != null && dept3.equals(param3) ? "selected": "";
				%>
						<option value="<%= dept3%>" <%=selected %>><%= dept3 %></option>
				<%
					}
				%>
			</select>
		</div>
	</form>
</body>
</html>
<script>
	function fnSelect(){
		let form = document.form;
		form.submit();
	}
</script>