<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/timewizard/css/userlogin.css">
<script src="https://kit.fontawesome.com/3914a9940d.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="/timewizard/js/userlogin-ajaxlogin.js"></script>
<script type="text/javascript" src="/timewizard/js/userlogin-kakaologin.js"></script>
</head>
<body>
	<div class="overlay">
		<div class="sign-in" id="sign-in-info">
			<h1>Sign In</h1>
			<div class="sns">
				<a href="${google_url}">
					<div class="icon">
						<i class="fab fa-google"></i>
					</div>
				</a>
				<a href="${naver_url}">
					<div class="icon">
						<img alt="네이버" src="/timewizard/img/NAVER Logo_Black.png">
					</div>
				</a>
				<div class="icon" id="kakao-login-btn">
					<i class="fab fa-kaggle"></i>
				</div>
			</div>
			<p class="small"> or user your account:
			<div id="sign-in-form">
				<div>
					<input type="text" placeholder="Id" name="user_id" id="user_id" />
					<input type="password" placeholder="Password" name="user_pw" id="user_pw"/><br/>
				</div>
				<div>
					<p class="forgot-password">Forgot your password?</p>
					<button class="control-button in" onclick="loginPrc()">Sign In</button>
					<a href="./signup"><p>sign up</p></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>