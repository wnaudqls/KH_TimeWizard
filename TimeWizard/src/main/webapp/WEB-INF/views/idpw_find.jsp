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
<form action="">
	<div class="FindID">
		<div class="id_title"><h2>Find ID</h2></div>
		<div style="border: 1px solid red;">
			<div class="id_name_area">
				NAME
				<input type="text" placeholder="이름을 적어주세요." name="username">
			</div>
			<div class="id_email_area">
				EMAIL
				<input type="email" placeholder="이메일을 입력해주세요." name="useremail">

				<input type="button" class="email_button" value="인증번호">
			</div>
			<div class="id_email_check">
				EMAIL CHECK
				<input type="text" placeholder="인증번호를 입력해주세요." name="useremailcheck">
				<input type="button" value="인증번호 확인">
			</div>
			<div class="id_find_button">
				<input type="submit" value="찾기">
			</div>
		</div>
	</div>
</form>
<form action="">
	<div class="FindPW">
		<div class="pw_title"><h2>Find PassWord</h2></div>
		<div style="border: 1px solid blue">
			<div class="pw_name_area">
				NAME
				<input type="text" placeholder="이름을 적어주세요." name="username">
			</div>
			<div class="pw_id_area">
				ID
				<input type="text" placeholder="아이디를 입력해주세요." name="userid">
			</div>
			<div class="pw_email_area">
				EMAIL
				<input type="email" placeholder="이메일을 입력해주세요." name="useremail">
				<input type="button" class="email_button" value="인증번호">
			</div>
			<div class="pw_email_check">
				EMAIL CHECK
				<input type="text" placeholder="인증번호를 입력해주세요." name="useremailcheck">
				<input type="button" class="" value="인증번호 확인">
			</div>
			<div class="pw_find_button">
				<input type="submit" value="찾기">
			</div>
		</div>
	</div>
</form>
<!-- footer 넣기 -->
</body>
</html>