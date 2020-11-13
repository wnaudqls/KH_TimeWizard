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
	//아이디 찾기 아작스
	$(".findid_button").click(function(){
		var user_email_id = $(".user_email_id").val();
		var url = "/timewizard/findID?user_email="+user_email_id;
		$.ajax({
			type: "POST",
			url: url,
			success: function(data){
				
				$(".id_result").append("<p>"+data.user_id+"</p>");
			},
			error: function(data){
				alert("아이디 찾기 통신 실패ㅠㅠㅠ");
			}
		});
	});
		
		//아이디 찾기
		//이메일 유효성
		$(".user_email_id").keyup(function(){
			let user_email = $(".user_email_id").val(); 
			let emailjung = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if(user_email == ""){
				$(".email_check_id").html('이메일을 입력해주세요.');
				$(".email_check_id").css('color','red');
				$(".email_button_id").attr("disabled",true);
				
			}else if(emailjung.test(user_email)){
				$(".email_check_id").html('알맞은 이메일입니다.');
				$(".email_check_id").css('color','#ddd');
				$(".email_button_id").attr("disabled",false);
				console.log("user_email : "+user_email);
				
				//인증번호 버튼
				$(".email_button_id").click(function(){
					
					$.ajax({
						url : "/timewizard/login/emailSend?user_email="+ user_email,
						type : "get",
						
						success : function(data){
									console.log(data)
									alert("이메일이 발송되었습니다. 인증번호를 확인 후 입력하여주십시오.");
									$(".email_code_id ").focus();
									//인증번호가 안적혀 있으면, 인증번호 확인버튼 못누르게
									if($(".email_code_id").val()!=""){
										$(".email_code_check_id").attr("disabled",false);
										$(".email_code_check_id").text("인증번호가 맞습니다.").css("color","#ddd");
										
									}
									//인증번호가 적혀있으면, 인증번호 확인버튼 누르게
									
									
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
function email_check(data){
	var email_code_id = $(".email_code_id").val();
}
 





</script>
</head>
<body>
<!-- header 넣기 -->
<h1>ID / PW Find</h1>

	<div class="FindID">
		<div class="id_title"><h2>Find ID</h2></div>
		<div style="border: 1px solid red;">
			<div class="id_name_area">
				NAME
				<input type="text" placeholder="이름을 적어주세요." name="user_name" class="user_name_id" required="required" autofocus="autofocus">
			</div>
			<div class="id_email_area">
				EMAIL
				<input type="email" placeholder="이메일을 입력해주세요." name="user_email" class="user_email_id" required="required">
				<input type="button" class="email_button_id" value="인증번호">
				<div class="email_check_id"></div>
			</div>
			<div class="id_email_check">
				EMAIL CHECK
				<input type="text" placeholder="인증번호를 입력해주세요." class="email_code_id" required="required">
				<input type="button" class="email_code_check_id" value="인증번호 확인">
				<div class="email_code_check_id"></div>
			</div>
			<div class="id_find_button">
				<input type="button" value="찾기" class="findid_button">
			</div>
		</div>
		<div class="id_result"></div>
	</div>


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
				<input type="button" onclick="" value="인증번호 확인">
				<div class="email_code_check_pw"></div>
			</div>
			<div class="pw_find_button">
				<input type="submit" value="찾기" class="findpw_button">
			</div>
		</div>
		<div id="pw_result"></div>
	</div>
</form>
<!-- footer 넣기 -->
</body>
</html>