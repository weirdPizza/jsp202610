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
		String sessionId = (String)session.getAttribute("sessionId");
		int boardNo = (Integer)session.getAttribute("boardNo");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String kind = request.getParameter("kind");
		
/* 		String query = "INSERT INTO TBL_BOARD VALUES ("
				+ "BOARD_SEQ.NEXTVAL, " 
				+ "'"+title+"', '"
				+contents+"', '"
				+sessionId+"', "
				+"0, "
				+kind+", "
				+"SYSDATE, SYSDATE)"; */
		
		
		String query2 = String.format(
				"UPDATE TBL_BOARD SET TITLE = '%s', CONTENTS = '%s', UDATETIME = SYSDATE WHERE BOARDNO=%d",
				title,contents,boardNo);
		
				
		out.println(query2);
		
		int result = stmt.executeUpdate(query2);
		
		if(result>0){
			out.println("게시글이 수정되었습니다.");
	%>
			<div><a href="board-list.jsp"><button>목록으로</button></a></div>
	<%
		}else{
			out.println("에러가 발생했습니다.");
		}
	%>
</body>
</html>