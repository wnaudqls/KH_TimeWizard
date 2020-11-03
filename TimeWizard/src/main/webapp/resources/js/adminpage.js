$(function(){
	
	var updown = "";

	$(".roleupdown").on("click",function(){
		var updown=$(this).attr('value');
	});

	$.ajax({
		type:"POST", 
		url:"adminrole",
		data:{updown:updown}, 
		async:false,
		success: function(data){						
		}});
		
});