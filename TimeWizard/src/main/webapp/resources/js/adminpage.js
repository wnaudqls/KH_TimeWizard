 $('.btn btn-primary').click(function(){
	
};



function clickDel(activeInfo) {
	activeInfo.action = "admindelete";
	activeInfo.method = "post";
	activeInfo.submit();
};