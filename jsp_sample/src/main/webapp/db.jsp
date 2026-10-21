<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn;
	Statement stmt = null;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String db_url = "jdbc:oracle:thin:@localhost:1521:xe";
		String db_id = "system";
		String db_pw = "test12#$";
		conn = DriverManager.getConnection(db_url, db_id, db_pw);
		stmt = conn.createStatement();
/* 		System.out.println("DB연결 완료"); */

	} catch (ClassNotFoundException e) {
		System.out.println("JDBC 드라이버 로드오류");
	} catch (SQLException e) {
		System.out.println("DB 연결 오류");
	}
	%>
</body>
</html>