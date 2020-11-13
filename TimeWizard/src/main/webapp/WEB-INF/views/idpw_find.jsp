<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID / PW FIND</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style>

:root {
    --text-color: #f0f4f5;
    --background-color: #263343;
	--accent-color: #ff6b6b;
	--color: #E0E0E0;
}

body {
	margin: 0;
	background-color: var(--background-color);
}

.signupbox {
	display: flex;
	justify-content: center;
	align-items: center;
}

.signupmenu {
	display: flex;
	width: 30%;
	height: 90vh;
	border: 1px solid var(--color);
	border-radius: 10px;
	background-color: white;
	justify-content: center;
	margin-top: 5vh;
}

.signuptitle {
	width: 100%;
	text-align: center;
	justify-content: center;
	align-items: center;
}

.signuptext {
	font-size: 24px;
	font-weight: bold;
	color: var(--background-color);
}

.signuptext2 {
	color: #95a5a6;
}

.contentbox input[type=text] {
	background-color: var(--color);
	width: 80%;
	height: 2rem;
	border: 0px;
	padding-left: 12px;
}

.contentbox input[type=email] {
	background-color: var(--color);
	width: 80%;
	height: 2rem;
	border: 0px;
	padding-left: 12px;
}

.chkbox input[type=button] {
	background-color: #96DBE2;
	color: white;
	width: 25%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
	margin-bottom: 1rem;
}

.chkbox input[type=submit] {
	background-color: #96DBE2;
	color: white;
	width: 25%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
	margin-top: 2rem;
}

.signuptitle div {
	padding: 8px;
}


@media screen and (max-width: 1140px) {
	.signupmenu {
		width: 80%;
	}
	
	.signuptext {
		font-size: 24px;
	}
	
	.signuptext2 {
		font-size: 15px;
	}
	
	.contentbox input[type=text] {
		height: 2rem;
	}

	
	.chkbox input[type=button] {
		width: 50%;
		height: 2rem;
		margin-bottom: 0.5rem;
	}
	
	.chkbox input[type=submit] {
		width: 50%;
		height: 2rem;
		margin-top: 0;
	}
	
}
</style>
</head>
<body>
<section class="signupbox">
		<div class="signupmenu">
			<div class="signuptitle">
				<p class="signuptext">Find Your ID or PW</p>
				<p class="signuptext2">Find Your ID</p>
				<div class="contentbox">
					<input type="text" placeholder="이메일을 입력해주세요." class="user_email_id" required="required" autofocus="autofocus"/>
				</div>
				<div class="email_check_id"></div>
				<div class="chkbox">
					<input type="button" class="email_button_id" value="인증번호" />
				</div>
				<div class="contentbox">
					<input type="text" placeholder="인증번호를 입력해주세요." class="email_code_id" required="required"/>
					<div class="email_code_text_id"></div>
				</div>
				<div class="chkbox">
					<input type="button" value="찾기" class="findid_button">
				</div>
				<div class="id_result"></div>
				<p class="signuptext2">Find Your PW</p>
				<div class="contentbox">
					<input type="text" placeholder="아이디를 입력해주세요." name="user_id" class="user_id" required="required" />
				</div>
				<div class="contentbox">
					<input type="email" placeholder="이메일을 입력해주세요." name="user_email" class="user_email_pw " required="required">
				</div>
				<div class="chkbox">
					<input type="button" class="email_button_pw" value="인증번호">
					<div class="email_check_pw"></div>
				</div>

				<div class="contentbox">
					<input type="text" placeholder="인증번호를 입력해주세요."  class="email_code_pw" required="required">
				<div class="email_code_text_pw"></div>
				</div>
				<div class="chkbox">
					<input type="button" value="찾기" class="findpw_button">
				</div>
			</div>
		</div>
	</section>
	
</body>
</html>