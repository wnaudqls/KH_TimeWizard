<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link rel="stylesheet" href="resources/css/userlogin.css">
<script type="text/javascript"  src="resources/js/userlogin_ajaxlogin.js"></script>
</head>
<body>
	<div class="overlay">
		<div class="sign-in" id="sign-in-info">
			<h1>Sign In</h1>
			<div class="sns">
				<a href="${google_url}">
					<div class="icon">
						구글
					</div>
				</a>
				<a href="${naver_url}">
					<div class="icon">
						네이버
					</div>
				</a>
				<div class="icon" id="kakao-login-btn">
					카카오
				</div>
			</div>
			<p class="small"> or user your account:</p>
			<form id="sign-in-form">
				<div>
					<input type="text" placeholder="Id" name="user_id" id="user_id" />
					<input type="password" placeholder="Password" name="user_pw" id="user_pw"/><br/>
				</div>
				<div>
					<p class="forgot-password">Forgot your password?</p>
					<input type="button" class="control-button in" onclick="loginPrc()" value="Sign In">
					<a href="./signup"><p>sign up</p></a>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="resources/js/userlogin_kakaologin.js"></script>
</body>
</html>