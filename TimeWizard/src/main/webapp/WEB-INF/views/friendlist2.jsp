<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="/timewizard/css/actionpage2.css" rel="stylesheet">

<script type="text/javascript">
var iconDataURI = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAKBJREFUeNpiYBjpgBFd4P///wJAaj0QO9DEQiAg5ID9tLIcmwMYsDgABhqoaTHMUHRxpsGYBv5TGqTIZsDkYWLo6gc8BEYdMOqAUQeMOoAqDgAWcgZAfB9EU63SIAGALH8PZb+H8v+jVz64KiOK6wIg+ADEArj4hOoCajiAqMpqtDIadcCoA0YdQIoDDtCqQ4KtBY3NAYG0csQowAYAAgwAgSqbls5coPEAAAAASUVORK5CYII=";
var sock;
var nickname;
var client;
var uname = '${login.user_name}'
var fno;
var uno = ${login.user_no};
var friendval = {
		"user_no": uno
	}
var flist;
var nlist;


$(document).ready(function () {
	friendlist();
});
function searchfriend(){
var uname = $("#search_text").val();
console.log("유저이름: "+uname);
var searchval = {
			"user_name": uname
		}
console.log("searchval: "+searchval);
	$.ajax({
	    type: "post",
	    url: "/timewizard/searchList",
	    data: JSON.stringify(searchval),
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	searchList = data.searchList;
	    	console.log("서치리스트: "+searchList);
	    	$(".userlist").empty();
	    	$(".userlist").append("<p>Search List</p>");
	    	if(searchList == ''){
	    		$(".userlist").append("<p>-- 검색하신 분을 찾지 못했습니다. --</p>")
	    	}else{
	    		for(i in searchList){
	    			var user_name = searchList[i].user_name;
	    			var name = "\""+searchList[i].user_name+"\"";
	    			$(".userlist").append("<p>이름:"+ user_name +"</p>"+
	    			"<input type='button' value='친구추가' onclick='alertsys("+searchList[i].user_no+","+ uno +","+name+")'>");
	    		}
	    		
	    	}
	    	
	    },
	    error: function(data){
	    	$(".friendsbar").append("연결이 끊겼습니다.");
	    }
	});
}
function reset(){
	var uname = $("#search_text");
	$(uname).val("");
	friendlist();
	
}

function friendlist(){
	var url = location.href;
	var inviteurl = "\""+url.split("/timewizard")[1]+"\"";
	$.ajax({
	    type: "post",
	    url: "/timewizard/friend",
	    dataType: "json",
	    data: JSON.stringify(friendval),
	    contentType: "application/json",
	    success: function(data){
	    	$("#search_text").val("");
	    	flist = data.flist;
	    	nlist = data.nlist;
	    	$(".friendlist").empty();
	    	$(".userlist").empty();
	    	if(flist == ''){
	    		$(".friendlist").append("<p>-- 친구를 추가하세요 ^_^ --</p>")
	    	}else{
	    		for(i in flist){
	    			var user_name = flist[i].user_name;
	    			var name = "\""+flist[i].user_name+"\"";
	    			var user_no = flist[i].user_no;
	    	
	    			if(url.indexOf("joinroom")!== -1){
	    				if((flist[i].status == "ACCEPT")){
	    					$(".friendlist").append("<p>이름:"+ flist[i].user_name +"</p>"+
		    					"<input type='button' value='초대하기' onclick='invitefriend("+user_no+","+ uno +","+inviteurl+","+name+")'>");
	    				}
	    			}
	    			else {
	    			if((flist[i].status == "ACCEPT")){
	    					$(".friendlist").append("<p>이름:"+ flist[i].user_name +"</p>"+
	    					"<input type='button' value='친구삭제' onclick='deletefriend("+user_no+","+ uno +","+name+")'>");
	    			}else if(flist[i].status == "SEND"){
    					$(".friendlist").append("<p>"+ user_name +"님이 응답중 입니다.</p>");
    	    					
    	    		}else if(flist[i].status == "RESP"){
	    					$(".friendlist").append("<p>"+ user_name +"님이 친구신청 하셨습니다.</p>"+
	    					"<input type='button' value='수락' onclick='friendAccept("+user_no+")'/> "
	    					+" <input type='button' value='거절' onclick='friendDeny("+user_no+","+name+")'>");
	    				}
	    			}
	    		}
	    		
	    	}
	    	$(".userlist").append("<p><b>User List</b></p>");
	    	if(nlist == ''){
	    		$(".userlist").append("<p>-- 당신은 인싸>_&lt; --</p>");
	    	}else{
	    		for(i in nlist){
	    			var name = "\""+nlist[i].user_name+"\"";
	    			$(".userlist").append("<p>이름:"+ nlist[i].user_name+"&nbsp;"+
	    					"<input type='button' value='친구추가' onclick='alertsys("+nlist[i].user_no+","+ uno +","+name+")'>" +"</p>");
	    		}
	    	
	    	}
	    	
	    },
	    error: function(data){
	    	$(".friendsbar").append("연결이 끊겼습니다.");
	    }
	});
}

</script>
</head>
<body>

<aside class="friendsbar">
		<p>friends</p>
		<input type="text" placeholder="search.." id="search_text" />
		<button id="search_button" onclick="searchfriend();"><i class="fas fa-search" ></i>
		</button>
		<button id="search_button" onclick="reset();">
			초기화
		</button>
		<p><b>Your Friends</b></p>
		<!-- 나와 친구인 유저들 -->
		<div class="friendlist">
		
		
		
		</div>
		<div class="userlist">
		
		
		
		</div>
		
		
	</aside>


<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<script type="text/javascript">

var uno = ${login.user_no};
	//handler에서 정해준 서버 겅로로 설정
	sock = new SockJS("/timewizard/webserver");
	// SockJS로 연결한 웹소켓 주소에 Stomp을 씌움
	client = Stomp.over(sock)
	
	 Notification.requestPermission(function (result) {

        //요청을 거절하면,
        
        if (result === 'denied') {
        	console.log("알림이 비활성화 되었습니다.");
            return;
        }
        //요청을 허용하면,
        else {
        	console.log("알림이 활성화 되었습니다.");
            return;
        }
    });
	//연결 했을시,
	client.connect({}, function(){
	    client.subscribe("/subscribe/alert/good/"+uno, function (data) {
	    	var fnd = JSON.parse(data.body);
	    	var fnd_name = fnd['user_name'];
	    	var message = fnd_name+"님이 친구 신청을 하셨습니다.";
	    	var fno = fnd["user_no"];
	        var options = {
	            body: message,
	            icon: iconDataURI
	        }
	        //데스크탑 알림 요청
	        var sendalert = new Notification("알람", options);
	        
	      //알림 후 3초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //알람 메시지 닫기
	            friendlist();
	            //sendalert.close();
	        	}, 5000);
	    });
	    client.subscribe("/subscribe/confirm/check/"+uno, function (data) {
				
	    	var chk = data.body;
 			var message = chk+"님이 친구추가를 수락하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var checkalert = new Notification("친구 수락", options);
	        
 				//알림 후 3초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	             friendlist();
	            //checkalert.close();
	           
	       	 	}, 3000); 		
	       
	    	})
	    	client.subscribe("/subscribe/confirm/denychk/"+uno, function(data){
	    		var chk = data.body;
	 			var message = chk+"님이 친구신청을 거절하셨습니다.";
	 				options = {
	 		            body: message,
	 		            icon: iconDataURI
	 		        }
	 			var checkalert = new Notification("알림", options);
		        
	 				//알림 후 3초 뒤 친구목록 다시 불러옴
		        setTimeout(function () {
		            //얼람 메시지 닫기
		            friendlist();
		            //checkalert.close();
		           
		       	 	}, 3000); 		
		        
	    	});
	    client.subscribe("/subscribe/confirm/deletechk/"+uno, function(data){
    		var chk = data.body;
 			var message = chk+"님이 친구목록에서 삭제하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var checkalert = new Notification("알림", options);
	        
 				//알림 후 3초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	            friendlist();
	            //checkalert.close();
	           
	       	 	}, 3000); 		
	        
    		});
		});
	
function alertsys(fno, mynum, fname){
		    var message = fname+"님에게 메세지를 전송했습니다.";
	        
	        var options = {
	            body: message,
	            icon: iconDataURI
	        }
	       
	        var chk = confirm(fname+'님을 친구추가 하시겠습니까?');
	        if(chk){
	        	//데스크탑 알림 요청
	       		 var notification = new Notification("알람" ,options);
	       		alert("친구추가 메세지를 전송했습니다.");
	       		client.send("/publish/alert/friend", {},JSON.stringify({friend_no: fno, user_no: mynum, user_name: fname}));
	       	//알림 후 3초 뒤 친구목록 다시 불러옴
	        	setTimeout(function () {
	            //얼람 메시지 닫기
	            friendlist();
	           // notification.close();
	           
	      	  }, 3000);
	        	 
				
				
	        }else{
	        	alert("친구추가 메세지 전송을 취소했습니다.");
	        	
	        }

	}
	
function deletefriend(fno,myno,fname){
	
	var rly = confirm(fname+"님을 목록에서 삭제하시겠습니까?");
	
	if(rly){
		 var message = fname+"님이 목록에서 삭제되었습니다.";
	     
	     options = {
	        body: message,
	        icon: iconDataURI
	    }
	    	//데스크탑 알림 요청
	   		var deletealert = new Notification("친구삭제" ,options);
		 	client.send("/publish/confirm/delete", {}, JSON.stringify({user_no: myno, friend_no: fno}));
		 	
		 	//알림 후 3초 뒤 친구목록 다시 불러옴
	    	setTimeout(function () {
	    		friendlist();
	        //얼람 메시지 닫기
	        //deletealert.close();
	       
	  	  }, 3000);
	    	 
	}
else{
	
	}
}

function friendAccept(fno){

 		client.send("/publish/confirm/accept",{},JSON.stringify({friend_no: fno, user_no: uno, user_name: uname}));
 		client.subscribe("/subscribe/confirm/res/"+uno, function(chat){
 			var added = chat.body;
 			var message = added+"님과 이제 친구입니다";
 			var options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var acceptalert = new Notification("친구추가 수락", options);
	        
 			//알림 후 3초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	              friendlist();
	            //acceptalert.close();
	           
	        }, 3000);
			client.send("/publish/confirm/fnd",{},JSON.stringify({user_no: uno, friend_no: fno, user_name: uname}));
 			
		})

 		
 	}
 		
function friendDeny(fno,fname){
	//"거절"을 누르면 FriendControlller로 보내서 update, delete시키기
		//ajax로?
				
		  var message = fname+"님의 친구 신청을 거절하셨습니다.";
        
         var options = {
            body: message,
            icon: iconDataURI
        }
        	//데스크탑 알림 요청
       		var denyalert = new Notification("알람" ,options);
		 	client.send("/publish/confirm/deny", {}, JSON.stringify({friend_no: fno, user_no: uno, user_name: fname}));
		 	
		 	//알림 후 3초 뒤 친구목록 다시 불러옴
        	setTimeout(function () {
            //얼람 메시지 닫기
            friendlist();
            //denyalert.close();
            
      	  }, 3000);
        	
       		
}
function invitefriend(user_no, uno, url, name){
	
	  var message = name+"님에게 초대를 보냈습니다.";
  
  var options = {
     body: message,
     icon: iconDataURI
 }
 	//데스크탑 알림 요청
		var denyalert = new Notification("알람" ,options);
		 	client.send("/publish/invite/send", {}, JSON.stringify({friend_no: user_no, user_no: uno, url: url, user_name: uname}));
		 	
		 	//알림 후 3초 뒤 친구목록 다시 불러옴
 	setTimeout(function () {
     //얼람 메시지 닫기
     friendlist();
     //denyalert.close();
     
	  }, 3000);
	
}
</script>
</body>
</html>