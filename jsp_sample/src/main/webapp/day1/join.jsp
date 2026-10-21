<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="join-result.jsp">
		<div>
			아이디 : <input name="userId">
		</div>
		<div>
			비밀번호 : <input type="password" name="userPwd">
		</div>
		<div>
			이름 : <input name="userName">
		</div>
		<div> 성별 : 
			<label><input type="radio" name="userGender" value="M">남</label>
			<label><input type="radio" name="userGender" value="F">여</label>
		</div>
		<div>
			<input type="submit" value="가입">
		</div>
	</form>
</body>
</html>