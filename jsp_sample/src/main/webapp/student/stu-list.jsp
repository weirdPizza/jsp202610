<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, tr, th, td {
		border : 2px solid black;
		border-collapse: collapse;
		padding : 5px 10px;
		text-align: center;
	}
	a {
		text-decoration:none;
		color: black;
	}
	.page a {
		margin-right: 3px;
	}
	.active{
		text-decoration:underline;
		font-weight : bold;
	}
</style>
</head>
<body>
	<%@ include file="../db.jsp" %>
	<%
	String keyword = request.getParameter("keyword");
	String grade = request.getParameter("grade");
	String selectGrade = grade != null ? grade : "";
	
	String size = request.getParameter("size");
	String selectSize = size != null ? size : ""; // select 선택됨 나타내기 위한 변수, null 그대로 넣으면 에러니까 ""채움
	
	String order = request.getParameter("order") != null ? request.getParameter("order") : "dname";
	
	/* 페이징에 사용할 변수 ------------------ 페이징 중요!!!!!!!!*/
	int pageSize = 5; // 한페이지에 보여줄 개수
	int currentPage = 1; // 현재 위치하는 페이지
	if(request.getParameter("page") != null){
		currentPage = Integer.parseInt(request.getParameter("page")); // page는 결국 전달을 위한, page의 유효한 값은 currentPage로 받아서 쓰기 위한.
	}
	
	if(request.getParameter("size")!=null){
		pageSize = Integer.parseInt(request.getParameter("size")); // size도 전달용, pageSize는 받아서 쓰기 위한 용.
	}
	int offset = (currentPage - 1) * pageSize; // 건너뛴 개수
	
	String cntQuery = "SELECT COUNT(*) AS TOTAL FROM STU WHERE 1=1";

	
	/* ---------------------------------- */
	
	/* System.out.println(keyword); */
	String query =  "SELECT * " +
            		"FROM STU S " +
          			"INNER JOIN DEPARTMENT D ON S.DEPTNO1 = D.DEPTNO " +
          			"WHERE 1=1";
	if(keyword != null){
		query += " AND NAME LIKE '%" + keyword + "%'";
		cntQuery += " AND NAME LIKE '%" + keyword + "%'";
	}
	if(grade != null && !grade.equals("")){
		query += " AND GRADE = "+grade;
		cntQuery += " AND GRADE = "+grade;
	}
	
	/* order 쿼리 (아래) */
	query += order.equals("dname") || order==null ? " ORDER BY DNAME ASC" : order.equals("stuNo") ? " ORDER BY STUNO ASC" : " ORDER BY NAME ASC";
	/* 페이징쿼리 (아래) */
	query += " OFFSET "+offset+" ROWS FETCH NEXT "+pageSize+" ROWS ONLY";
	
	/* 페이징쿼리!!!!!!------------------------------------- */
	ResultSet cntRS = stmt.executeQuery(cntQuery);
	cntRS.next();
	/* if문 넣을 필요 없음 개수 없더라도 0 리턴이니까 */
	int total = cntRS.getInt("TOTAL"); // 총 게시물수
	int pageList = (int)Math.ceil((double)total / pageSize); // 총 페이지수
	/* --------------------------------------------------- */
	
	ResultSet rs = stmt.executeQuery(query);
	
	int gradeList[] = {1,2,3,4};
	%>
	<h2><a href="stu-list.jsp">학생 리스트</a></h2>
	<form name="form" action="stu-list.jsp">
		<div>
			검색어 : <input name="keyword" value="<%= keyword!=null ? keyword : ""%>">
				   <input type="button" value="검색" onclick="fnSearch()"></button>
		   <select name="grade" onchange="fnGrade()">
		  	 <option value=""> :: 전체 :: </option>
		   <%
		   		for(int i=0; i<gradeList.length; i++){
		   %>
		   			<option value="<%= gradeList[i] %>" <%= String.valueOf(gradeList[i]).equals(selectGrade) ? "selected" : "" %>><%= gradeList[i] %>학년</option>
		   <%			
		   		}
		   %>
		   </select>
		</div>
		<hr> 
		<div>
			<select name="size" onchange="fnSize()">
				<%
				int pageArr[] = {5, 10, 20, 50};
				for(int i=0; i<pageArr.length; i++){
				%>
					<option value="<%=pageArr[i]%>" <%= selectSize.equals(Integer.toString(pageArr[i])) ? "selected":"" %>><%= pageArr[i] %>개씩</option>
				<%
					}
				%>
			</select>
			|
			<label><input type="radio" name="order" value="stuName" <%= order.equals("stuName")? "checked":"" %> onclick="fnSearch()"> 이름순</label>
			<label><input type="radio" name="order" value="stuNo" <%= order.equals("stuNo")? "checked":"" %> onclick="fnSearch()"> 학번순</label>
			<label><input type="radio" name="order" value="dname" <%= order.equals("dname")? "checked":"" %> onclick="fnSearch()"> 학과순</label>
		</div>
		<hr>
		<table>
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>아이디</th>
				<th>학년</th>
				<th>학과</th>
			</tr>
		<%
			while(rs.next()){
		%>
			<tr>
				<td><%= rs.getString("STUNO") %></td>
				<td>
					<a href="stu-view.jsp?stuNo=<%= rs.getString("STUNO") %>"><%= rs.getString("NAME") %></a>
				</td>
				<td><%= rs.getString("ID") %></td>
				<td><%= rs.getString("GRADE") %></td>
				<td><%= rs.getString("DNAME") %></td>
			</tr>		
		<%		
			}
		%>
		
		</table>
		<div class="page">
			<a href="javascript:;"  onclick="fnPage(<%= currentPage-1 %>)" <%= currentPage==1 ? "hidden":"" %>>◀</a>
			<% 
				for(int i=1; i<=pageList; i++){
					if(i==currentPage){
			%>
						<%-- <a href="?page=<%= i %>&size=<%= size %>" class="active"><%= i %></a> --%>
						<a href="javascript:;" onclick="fnPage(<%=i %>)" class="active"><%= i %></a>
			<%
					}else{
			%>
						<%-- <a href="?page=<%= i %>&size=<%= size %>"><%= i %></a> --%>
						<a href="javascript:;" onclick="fnPage(<%=i %>)"><%= i %></a>
			<%
					}
				}
			%>
			<a href="javascript:;" onclick="fnPage(<%= currentPage+1 %>)" <%= currentPage==pageList ? "hidden":"" %>>▶</a>
		</div>
		<div>
			<a href="stu-add.jsp"><button>학생추가</button></a>
		</div>
		<input name="page" value="<%= currentPage %>" hidden>
	</form>
</body>
</html>
<script>
	// fnSearch, fnGrade, fnSize 는 결국 같은 내용이므로 하나로 합쳐도 된다.
	function fnSearch(){
		let form = document.form;
		form.page.value = 1;
		form.submit();
		//location.href = "stu-list.jsp?keyword="+form.keyword.value;
	}
	function fnGrade(){
		let form = document.form;
		form.page.value = 1;
		form.submit();
	}
	function fnSize(){
		let form = document.form;
		form.page.value = 1;
		form.submit();
	}
	function fnPage(page){
		let form = document.form;
		form.page.value = page;
		form.submit();		
	}
</script>


