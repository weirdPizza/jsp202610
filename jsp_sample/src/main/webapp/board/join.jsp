<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	input[readonly]{
		background-color: #ccc;
	}
</style>
<body>
	<%@ include file="../db.jsp" %>
	<!-- 아이디, 패스워드, 이름 입력받아서 TBL_USER에 저장 -->
	<form name="form" action="join-result.jsp">
		<div>
			아이디 : <input name="userId">
			<input type="button" value="중복체크" onclick="fnCheck()">
		</div>
		<div>
			비밀번호 : <input name="pwd" type="password">
		</div>
		<div>
			이름 : <input name="name">
		</div>
		<div>
			<input type="button" value="가입" onclick="fnJoin()">
			<!-- 가입 완료 후 로그인 페이지로 이동시켜야 -->
		</div>
	</form>
</body>
</html>
<script>
	let addFlg = false;
	function fnJoin(){
		let form = document.form;
		if(!addFlg){
			alert("중복체크 후 추가해주세요.");
			return;
		}
		if(form.userId.value.length<1){
			alert("아이디를 입력해주세요.");
			return;
		}
		if(form.pwd.value.length<1){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		if(form.name.value.length<1){
			alert("이름을 입력해주세요.");
			return;
		}
		form.submit();
	}
	function fnCheck(){
		let form = document.form;
		let userId = form.userId.value;
		
		if(userId.length == 0){
			alert("아이디를 입력해주세요.");
			return;
		}
		window.open(`check.jsp?userId=\${userId}`, "check", "width=500, height=500");
	}
	function fnReturn(flg){
		let form = document.form;
		if(flg){
			form.userId.readOnly = true;	
			addFlg = true;
		}	
	}
</script>