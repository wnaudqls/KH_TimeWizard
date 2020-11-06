$(document).ready(function(){
	$("#submit").on("click", function(){
		if($("#user_pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#user_pw").focus();
			return false;
		}
	});
});