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
		String query = "SELECT * FROM TBL_BOARD ORDER BY BOARDNO DESC";
		String sessionRole = (String)session.getAttribute("sessionRole");
		/* setAttribute()는 Object형으로 저장됐으니까 꺼낼 때도 Object형으로 꺼내짐. 그래서 다운캐스팅 필요!!! */
		String sessionId = (String)session.getAttribute("sessionId");
		ResultSet rs = stmt.executeQuery(query);
	%>
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
	<div><a href="board-add.jsp"><button>글쓰기</button></a></div>
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
</script>