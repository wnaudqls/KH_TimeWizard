$(document).on("click","button[name='disablebtn']",function(){
	var num = $(this).data('value');
	$("#userdelete").val(num);
});