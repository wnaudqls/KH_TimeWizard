/* $(document).on("click","button[name='disablebtn']",function(){
	var num = $(this).data('value');
	$("#userdelete").val(num);
}); */

function button_event(){

	if(confirm('회원 아이디를 비활성화 하겠습니까?')==true){
		
		document.userbye.submit();
		alert("비활성화를 성공하셨습니다.");
		
	} else {
		
		alert("비활성화를 취소하셨습니다.");
		
	}
};