<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID/PW</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
		//아이디 찾기
		//이름 db에서 확인
		
		//아이디 찾기
		//이메일 db에서 확인
		
		//아이디 찾기
		//이메일 유효성
		$(".user_id_email").keyup(function(){
			let user_email = $(".user_id_email").val().trim(); 
			let emailjung = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if(user_email == ""){
				$(".email_check_id").html('이메일을 입력해주세요.');
				$(".email_check_id").css('color','red');
				$(".email_button_id").attr("disabled",true);
				
			}else if(emailjung.test(user_email)){
				$(".email_check_id").html('알맞은 이메일입니다.');
				$(".email_check_id").css('color','#ddd');
				$(".email_button_id").attr("disabled",false);
				
				$(".email_button_id").click(function(){
					$.ajax({
						url : "./emailSend?user_email="+ user_email,
						type : "get",
						
						success : function(data){
									console.log(data)
									alert("이메일이 발송되었습니다. 인증번호를 확인 후 입력하여주십시오.");
								 	//$(".email_auth_code").show();
									$(".email_code_id").focus();
									//$("#emailcode").val(data);  
									arr[5] = true;
									
						}, 	error : function(e){
							alert("이메일 인증에 실패하셨습니다.")
						}
					})
				})
			
			}else{
				$(".email_check_id").html('알맞은 이메일 형식이 아닙니다.');
				$(".email_check_id").css('color','red');
				$(".email_button_id").attr("disabled",true);
			}
		});
});

//이메일 인증 번호 확인
var arr = new Array();
var email_code_id = $(".email_code_id").val();
function emailCodeCheck(){
	arr[5] = false;
	
	var inputemailcode = $(".email_code_id").val().trim();
	
	if(email_code_id!=null){
		$(".email_code_check").text("이메일 인증을 성공했습니다.").css({'color' : 'navy','font-size' : '16px'});
		
		arr[5] = true;
	}else{
		$(".email_code_check").text("이메일 인증을 실패했습니다. 다시 시도하여주십시오.").css({ 'color' : '#FF6600', 'font-size' : '13px'});
	}
}  

</script>
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
				<input type="text" placeholder="이름을 적어주세요." name="user_name" required="required" autofocus="autofocus">
			</div>
			<div class="id_email_area">
				EMAIL
				<input type="email" placeholder="이메일을 입력해주세요." name="user_email" class="user_id_email" required="required">
				<input type="button" class="email_button_id" value="인증번호">
				<div class="email_check_id"></div>
			</div>
			<div class="id_email_check">
				EMAIL CHECK
				<input type="text" placeholder="인증번호를 입력해주세요." class="email_code_id" name="useremailcheck_id" required="required">
				<input type="button" onclick="emailCodeCheck();" class="email_code_check_id" value="인증번호 확인">
				<div class="email_code_check"></div>
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
				<input type="text" placeholder="이름을 적어주세요." name="user_name" required="required" autofocus="autofocus">
			</div>
			<div class="pw_id_area">
				ID
				<input type="text" placeholder="아이디를 입력해주세요." name="user_id" required="required">
			</div>
			<div class="pw_email_area">
				EMAIL
				<input type="email" placeholder="이메일을 입력해주세요." name="user_email" class="useremail" required="required">
				<input type="button" class="email_button_pw" value="인증번호">
				<div class="email_check_pw"></div>
			</div>
			<div class="pw_email_check">
				EMAIL CHECK
				<input type="text" placeholder="인증번호를 입력해주세요."  class="email_code_check_pw" name="useremailcheck_pw" required="required">
				<input type="button" onclick="emailCodeCheck();" value="인증번호 확인">
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