<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID/PW</title>
</head>
<body>
<!-- header 넣기 -->
<h1>ID / PW Find</h1>
<form>
	<div class="FindID">
		<div class="id_title"><h3>Find ID</h3></div>
		<div>
			<div class="id_name_area">
				NAME
				<input type="text" placeholder="이름을 적어주세요." name="username">
			</div>
			<div class="id_email_area">
				EMAIL
				<input type="email" placeholder="이메일을 입력해주세요." name="useremail">
			</div>
			<div id="id_email_check">
				EMAIL CHECK
				<input type="text" placeholder="인증번호를 입력해주세요." name="useremailcheck">
			</div>
		</div>
	</div>
</form>
<form>
	<div class="FindPW">
	
	</div>
</form>
<!-- footer 넣기 -->
</body>
</html>