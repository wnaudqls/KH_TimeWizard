<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">

	$(function(){
		$("#loginchk").hide();
	});
	
	function loginPrc(){
		var user_id = $("#user_id").val().trim();
		var user_pw = $("#user_pw").val().trim();
		var loginVal = {
				"user_id": user_id,
				"user_pw": user_pw
		}
		
		if (user_id == null || user_id == "" || user_pw == null || user_pw == "" ){
			alert("ID와 PW를 모두 작성해 주세요");
		} else {
			$.ajax({
				type: "post",
				url: "login/ajaxlogin",
				data: JSON.stringify(loginVal),
				contentType: "application/json",
				dataType: "json",
				success: function(msg){
					if (msg.check == true) {
						location.href = 'login/success';
					} else {
						alert("ID 혹은 PW가 잘못 입력 되었습니다.");
					}
				},
				error: function(){
					alert("통신 실패");
				}
			});
		}
	}

</script>

<style type="text/css">
:root{
  --form-height:550px;
  --form-width: 900px;
  /*  Sea Green */
  --left-color: #9fdeaf;
  /*  Light Blue  */
  --right-color: #96dbe2;
}

body, html{
  width: 100%;
  height: 100%;
  margin: 0;
  font-family: 'Helvetica Neue', sans-serif;
  letter-spacing: 0.5px;
}

.container{
  width: var(--form-width);
  height: var(--form-height);
  position: relative;
  margin: auto;
  box-shadow: 2px 10px 40px rgba(22,20,19,0.4);
  border-radius: 10px;
  margin-top: 50px;
}

.overlay .sign-in, .overlay .sign-up{
  /*  Width is 385px - padding  */
  --padding: 50px;
  width: calc(385px - var(--padding) * 2);
  height: 100%;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
  padding: 0px var(--padding);
  text-align: center;
}

.overlay h1{
  margin: 0px 5px;
  font-size: 2.1rem;
}

.overlay p{
  margin: 20px 0px 30px;
  font-weight: 200;
}
/* 
------------------------
      Buttons
------------------------
*/
.switch-button, .control-button{
  cursor: pointer;
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 140px;
  height: 40px;
  font-size: 14px;
  text-transform: uppercase;
  background: none;
  border-radius: 20px;
  color: white;
}

.switch-button{
  border: 2px solid;
}

.control-button{
  border: none;
  margin-top: 15px;
}

.switch-button:focus, .control-button:focus{
  outline:none;
}

.control-button.up{
  background-color: var(--left-color);
}

.control-button.in{
  background-color: var(--right-color);
}

.social-media-buttons{
  display: flex;
  justify-content: center;
  width: 100%;
  margin: 15px;
}

.social-media-buttons .icon{
  width: 40px;
  height: 40px;
  border: 1px solid #dadada;
  border-radius: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 10px 7px;
}

.small{
  font-size: 13px;
  color: grey;
  font-weight: 200;
  margin: 5px;
}

.social-media-buttons .icon svg{
  width: 25px;
  height: 25px;
}

#sign-in-form input, #sign-up-form input{
  margin: 12px;
  font-size: 14px;
  padding: 15px;
  width: 260px;
  font-weight: 300;
  border: none;
  background-color: #e4e4e494;
  font-family: 'Helvetica Neue', sans-serif;
  letter-spacing: 1.5px;
  padding-left: 20px;
}

#sign-in-form input::placeholder{
  letter-spacing: 1px;
}

.forgot-password{
  font-size: 12px;
  display: inline-block;
  border-bottom: 2px solid #efebeb;
  padding-bottom: 3px;
}

.forgot-password:hover{
  cursor: pointer;
}


.sns {
	display: flex;
}
.icon {
	justify-content: space-around;
}
a {
	text-decoration: none;
}
.overlay {
	justify-content: center;
}
</style>
<script type="text/javascript">

</script>
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
				<%-- <a href="${kakao_url}"> --%>
				<div class="icon" id="kakao-login-btn">
					카카오
				</div>
			</div>
			<p class="small"> or user your account:
			<div>
				<input type="text" placeholder="Id" name="user_id" id="user_id" />
				<input type="password" placeholder="Password" name="user_pw" id="user_pw"/><br/>
			</div>
			<div>
				<p class="forgot-password">Forgot your password?</p>
				<input type="button" class="control-button in" onclick="loginPrc()" value="Sign In">
				<a href="login/signup"><p>sign up</p></a>
			</div>
		</div>
    </div>
	<script type="text/javascript">
		window.addEventListener('DOMContentLoaded', ()=>{
		    Kakao.cleanup();
		    Kakao.init('8ba76a6026ec5b6b73ff1f95270d8845');
		    let state = Math.random().toString(36).substr(2,11);
		    sessionStorage.setItem('oauth_state_k', state);
			const kakaobtn = document.getElementById("kakao-login-btn");
			kakaobtn.addEventListener("click", () =>{
				Kakao.Auth.login({
					success: function(authObj){
						Kakao.API.request({
							url: '/v2/user/me',
							success: function(res){
								const xhr = new XMLHttpRequest();
								xhr.open('POST','/timewizard/login/kakaocallback');
								xhr.setRequestHeader('Content-type','application/json');
								xhr.send(JSON.stringify(res));
								xhr.onreadystatechange = function (e){
									if (xhr.readyState == 4 && xhr.status == 200){
										window.location.replace(xhr.responseText);
									}
								}
							},
							fail: function(err){
								console.log(err);
							},
						})
					},
					fail : function(err){
						console.error(err);
					}
				})
			});
		});
	</script>
</body>
</html>