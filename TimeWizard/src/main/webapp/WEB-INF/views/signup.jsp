<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
		font-size: 12px;
	}
	
	.contentbox input[type=text] {
		height: 1.5rem;
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
			<form class="signuptitle">
				<p class="signuptext">Create Account</p>
				<p class="signuptext2">or user your email for registration:</p>
				<div class="contentbox">
					<input type="text" placeholder="아이디(4~12자리)" />
				</div>
				<div class="contentbox">
					<input type="text" placeholder="비밀번호(6~10자리)" />
				</div>
				<div class="contentbox">
					<input type="text" placeholder="비밀번호 확인" />
				</div>
				<div class="contentbox">
					<input type="text" placeholder="이메일" />
				</div>
				<div class="chkbox">
					<input type="button" value="이메일 코드 전송" />
				</div>
				
				<div class="contentbox">
					<input type="text" placeholder="인증번호 입력" />
				</div>
				<div class="chkbox">
					<input type="button" value="이메일 인증" />
				</div>

				<div class="contentbox">
					<input type="text" placeholder="이름" />
				</div>
				<div class="chkbox">
					<input type="submit" value="SIGN UP" />
				</div>
			</form>
		</div>
	</section>
	
</body>
</html>