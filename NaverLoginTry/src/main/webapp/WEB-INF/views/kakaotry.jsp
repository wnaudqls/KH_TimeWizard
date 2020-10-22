<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>
    <h1>KAKAO TRY</h1>
    <button onclick="loginWithKakao()">카카오로그인</button>
    <p id="token-result"></p>
    <script type="text/javascript">
    Kakao.cleanup();
    Kakao.init('8ba76a6026ec5b6b73ff1f95270d8845');
    const state = Math.random().toString(36).substr(2,11);
    console.log("state : " + state);
    sessionStorage.setItem('oauth_state_k', state);
      function loginWithKakao() {
        const USER_ACCESS_TOKEN = Kakao.Auth.authorize({
          redirectUri: 'http://localhost:8787/timewizard/login/kakaocallback',
          state: state,
          scope: 'account_email'
        });
        Kakao.Auth.setAccessToken(USER_ACCESS_TOKEN);
      }
    </script>
</body>
</html>
