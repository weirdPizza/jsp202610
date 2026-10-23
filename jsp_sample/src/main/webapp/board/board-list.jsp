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
	a {
		color: black;
		text-decoration: none;
	}
	a:hover{
		text-decoration: underline;
	}
	.active{
		font-weight : bold;
	}
</style>
</head>
<body>
	<%@ include file="../db.jsp" %>
	<h4 style="display:inline-block;"><%= session.getAttribute("sessionName") %> 님이 접속 중 입니다.</h4>
	<a href="login.jsp"><button>로그아웃</button></a>
	<hr>
	<h2>게시글 목록</h2>
	<hr>
		<%
			String size = request.getParameter("size");
			String selectSize = size != null ? size : "";
		
			int pageSize = 5; // 한페이지에 보여줄 개수
			int currentPage = 1; // 현재 위치하는 페이지
			if(request.getParameter("page") != null){
				currentPage = Integer.parseInt(request.getParameter("page"));
			}
			
			if(request.getParameter("size")!=null){
				pageSize = Integer.parseInt(request.getParameter("size"));
			}
			int offset = (currentPage - 1) * pageSize; // 건너뛴 개수
			
			String cntQuery = "SELECT COUNT(*) AS TOTAL FROM STU WHERE 1=1";
			
			/* --------------------------------------  */
		
			String query = "SELECT * FROM TBL_BOARD ORDER BY BOARDNO DESC";
			query += " OFFSET "+offset+" ROWS FETCH NEXT "+pageSize+" ROWS ONLY";
			
			String sessionRole = (String)session.getAttribute("sessionRole");
			/* setAttribute()는 Object형으로 저장됐으니까 꺼낼 때도 Object형으로 꺼내짐. 그래서 다운캐스팅 필요!!! */
			String sessionId = (String)session.getAttribute("sessionId");
			
			ResultSet cntRS = stmt.executeQuery(cntQuery);
			cntRS.next();
			/* if문 넣을 필요 없음 개수 없더라도 0 리턴이니까 */
			int total = cntRS.getInt("TOTAL"); // 총 게시물수
			int pageList = (int)Math.ceil((double)total / pageSize); // 총 페이지수
			
			ResultSet rs = stmt.executeQuery(query);
	
		%>
	<form name="form" action="board-list.jsp">
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
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>삭제</th>
			</tr>
		<%
			while(rs.next()){
				// out.println("<li>"+rs.getString("CONTENTS")+"</li>");
		%>
				<tr>
					<td><%= rs.getString("BOARDNO") %></td>
					<td><a href="javascript:;" onclick="fnView(<%= rs.getString("BOARDNO") %>)"><%= rs.getString("TITLE") %></a></td>
					<td><%= rs.getString("USERID") %></td>
					<td><%= rs.getString("CNT") %></td>
					<td>
						<%
							if(sessionId.equals(rs.getString("USERID")) || sessionRole.equals("A")){
						%>
								<button onclick="fnRemove(<%= rs.getString("BOARDNO") %>)">삭제</button>
						<%
							}
						%>
						
					</td>
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
						<a href="javascript:;" onclick="fnPage(<%=i %>)" class="active"><%= i %></a>
			<%
					}else{
			%>
						<a href="javascript:;" onclick="fnPage(<%=i %>)"><%= i %></a>
			<%
					}
				}
			%>
			<a href="javascript:;" onclick="fnPage(<%= currentPage+1 %>)" <%= currentPage==pageList ? "hidden":"" %>>▶</a>
		</div>
		<div><a href="board-add.jsp"><button>글쓰기</button></a></div>
		<input name="page" value="<%= currentPage %>" hidden>
	</form>
</body>
</html>
<script>
	function fnView(boardNo){
		location.href="board-view.jsp?boardNo="+boardNo;
	}
	function fnRemove(boardNo){
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		location.href="board-remove-result.jsp?boardNo="+boardNo;
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