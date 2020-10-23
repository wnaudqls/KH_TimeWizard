<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kakao login</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
<body>
	
	<a id="kakao-login-btn"></a>
	<a href="http://developers.kakao.com/logout">logout</a>

	<script type="text/javascript">
		//사용할 앱의 JavaScript 키
		Kakao.init('7d52e34abe5fdbd54eb68fb7865afd73');
		
		// 카카오 로그인 버튼을 생성합니다.
		Kakao.Auth.createLoginButton({
			container : '#kakao-login-btn',
			
			success : function(authObj) {
				Kakao.API.request({
					//사용자정보 가져오기
					url : '/v2/user/me',

					success : function(res) {  //callback
						
						//form태그를 사용해서 값을 컨트롤러로 넘긴다. (동적 form 생성)
						var newForm = $('<form></form>');
						newForm.attr("method","post");
						newForm.attr("action","RegisterController.do");
						newForm.appendTo('body');
						var page=$("<input type='hidden' name='command' value='kakao'>");
						var email = $("<input type='hidden' name='email' value="+res.kakao_account.email+">");  //사용자의 이메일만 가져온다
						
						newForm.append(page);  //컨트롤러로 보내기
						newForm.append(email);  //사용자 이메일 값 붙여서 
						newForm.submit();  //컨트롤러로 이동
					}
				})
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
		
		//로그아웃
		function kakaoLogout() { 
			Kakao.Auth.logout(function(response) {
				alert(response + 'logout');
			}); 
	    }
	</script>

</body>
</html>