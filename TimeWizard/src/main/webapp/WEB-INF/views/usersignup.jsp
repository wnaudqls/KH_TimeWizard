<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

#signform{
	position: fixed;
	color : navy;
	top: 8%;
	left: 35%;
	width: 400px;
	height: 800px;
	background-color: rice;
	border-radius: 13px 13px 13px 13px;
	box-shadow: 10px 4px 30px rgba(0, 0, 0, 0.29);
	
}

.email_button{
	background-color: #96DBE2;
	outline:none;
	text-color : white;
	margin :15px 89.5px 0p;
	padding : 1px 6x;
	margin-left: auto;
  	margin-right: auto;
 	width: 140px;
 	height: 40px;
 	font-size: 14px;
 	text-transform: uppercase;
 	border-radius: 20px;
 	color: white;
 	outline :0;
 
 	align : right;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

//아이디 중복체크 입니다.


$(document).ready(function() {
	$('input[name=user_id]').blur(function() {
		var idCheck = $('input[name=user_id]').val();
		if(idCheck == ""){
			alert("아이디를 입력해주세요!");
		}
		
		
			$.ajax({

				url : 'idcheck?user_id=' + idCheck,
				type : 'get',

				success : function(data) {
					var idPass;
					var idRegex = /^[A-Za-z0-9]{4,12}$/;
					var idRegex2 = /[a-zA-Z0-9]/;
					var han = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
					var han2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{4,12}$/;
					var color;
					var ans;
					if (data == 1) {
						ans = '이미 존재하는 아이디입니다.';
						color = 'red';
						idPass = false;
					} else {
						if(idRegex.test(idCheck) && !han.test(idCheck)){
						ans = '회원가입 가능한 아이디입니다.';
						color = 'navy';
						idPass = true;
							
						}else if((han.test(idCheck) && han2.test(idCheck))
								|| (idRegex.test(idCheck))
								|| ((idCheck.search(idRegex2) >= 0 && idCheck.search(han) >= 0)) && idCheck.length >= 4){
							ans = '아이디는 영문, 숫자만 가능합니다.';
							color = 'red';
							idPass = false;
						}else{
							ans = '아이디는 4-12자 이내로 입력해주세요.';
							color = 'red';
							idPass = false;
						}
					}
					
					//#은 id
					$('#idc').text(ans);
					$('#idc').css('color', color);
					
				}
			})
		
	});
})




// 비밀번호 체크
	$(function() {
		$("#alert-success").hide();
		$("#alert-danger").hide();
		$("input").keyup(function() {
			var pwd1 = $("#pwd1").val();
			var pwd2 = $("#pwd2").val();
			if (pwd1 != "" || pwd2 != "") {
				if (pwd1 == pwd2) {
					$("#alert-success").show();
					$("#alert-danger").hide();
					$("#submit").removeAttr("disabled");
				} else {
					$("#alert-success").hide();
					$("#alert-danger").show();
					$("#submit").attr("disabled", "disabled");
				}
			}
		});
	});

//이메일 인증 메일 보내기

var arr = new Array();
 
function emailSend(){

arr[5] = false;
var user_email = $("#user_email").val().trim();
alert(user_email);

$.ajax({
	url : "./emailSend?user_email="+ user_email,
	type : "get",
	
	success : function(data){
				console.log(data)
				alert("이메일이 발송되었습니다. 인증번호를 확인 후 입력하여주십시오.");
			 	//$(".email_auth_code").show();
				$("#email_auto_code").focus();
				//$("#emailcode").val(data);  
				arr[5] = true;
				
	}, 	error : function(e){
		alert("이메일 인증에 실패하셨습니다.")
	}
})
}

//이메일 인증
function emailCodeCheck(){

arr[5] = false;


var inputemailcode = $("#email_auto_code").val().trim();

if(email_auto_code!=null){
	$("#email_check").text("이메일 인증을 성공했습니다.").css({'color' : 'navy','font-size' : '16px'});
	
	arr[5] = true;
}else{
	$("#email_check").text("이메일 인증을 실패했습니다. 다시 시도하여주십시오.").css({ 'color' : '#FF6600', 'font-size' : '13px'});
}
}  


</script>

</head>
<body>
	<div class="overlay" id="signform">
		<div class="sign-up" id="sign-up-info">
			<h1>Create Account</h1>
			<div class="sns">
				<div class="icon">
					구글
				</div>
				<a href="${naver_url}">
					<div class="icon">
						네이버
					</div>
				</a>
				<div class="icon">
					카카오
				</div>
			</div>
			<p class="small"> or user your email for registration:
			<form id="sign-up-form" action="signupresult" method="post">
				<div>
					<input type="text" placeholder="아이디(4-12자리)" name="user_id" required="required"  autofocus />
					<div id="idc"></div>
				</div>	
				<div>
					<input type="password" placeholder="Password" name="user_pw" id="pwd1" required="required" tabindex="3"/>
					<input type="password" placeholder="Check Password" name="pw_check" id="pwd2"  required="required"  tabindex="3"/>
					
					<p class="alert alert-success" id="alert-success" style="color: navy; margin: 0;" >비밀번호가일치합니다.</p>
					<p class="alert alert-danger" id="alert-danger" style="color: red; margin: 0;" >비밀번호가 일치하지않습니다.</p>
				</div>		
				<input type="email" placeholder="Email" name="user_email" id="user_email" required="required" />
				<button type="button" onclick="emailSend();" class="email_button" >이메일 코드 전송</button> 
					<div>
						<input type="text" placeholder="인증번호 입력 " id="email_auto_code" />
						<button type="button" onclick="emailCodeCheck();" class="email_button" id="email_auto_code">이메일인증</button>
						<div id="email_check"></div>
					</div>
				 
				<input type="text" placeholder="Name" name="user_name" required="required" />
				<button class="control-button in">Sign Up</button>
			</form>
		</div>
	</div>
<script type="text/javascript">
let signupButton = document.getElementsByClassName("control-button")[0];
signupButton.disabled = "disabled";
let password = document.getElementsByName("user_pw")[0];
let checkPassword = document.getElementsByName("pw_check")[0];
checkPassword.addEventListener("keyup", ()=>{
	if (checkPassword.value == password.value){
		signupButton.disabled = "";
	} else {
		signupButton.disabled = "disabled";
	}
});

</script>
</body>
</html>