<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap" rel="stylesheet">
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="/timewizard/js/actionpage.js" defer></script>
<script src="/timewizard/js/tap.js" defer></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>

</head>
<body>


	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	
	<section class="sectionbar">
		<div class="main_box">
			<div class="tab_box">
				<div class="tap active" onclick="openTab(event, 'con1')"><a href="#">Tap 1</a></div>
				<div class="tap" onclick="openTab(event, 'con2')"><a href="#">Tap 2</a></div>
			</div>
			<div class="content_box">

				<div id="con1" class="content on"><jsp:include page="/WEB-INF/views/personal_daily.jsp" flush="true"></jsp:include></div>
				<div id="con2" class="content"><p>Content 2, Tap 2의 내용</p><a href="calendar">Calender</a></div>
			</div>
		</div>
	</section>

	<aside class="friendsbar">
		<p>friends</p>
		<input type="text" placeholder="search.." id="search_text" />
		<button id="search_button"><a><i class="fas fa-search"></i></a></button>
		<b>Your Friends</b>
		<!-- 나와 친구인 유저들 -->
		<c:choose>
			<c:when test="${empty flist }">
				<p>-- 친구를 추가하세요 ^_^ --</p>
			</c:when>
			<c:otherwise>
				<c:forEach items="${flist }" var="fdto">
						<c:if test="${fdto.status == 'SEND' }">
							<p>${fdto.user_name }님이 응답중 입니다.</p>
						</c:if>
					<c:if test="${fdto.status == 'ACCEPT'}">
						<p>
						이름 : ${fdto.user_name }<input type="button" value="친구삭제" onclick="deletefriend(${fdto.user_no},${login.user_no },'${fdto.user_name }')">
						
						</p> 
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
		<!-- 나와 친구가 아닌 유저들 -->
		<c:choose>
			<c:when test="${empty nlist }">
				<p>-- 당신은 인싸>_&lt; --</p>
			</c:when>
			<c:otherwise>
				<c:forEach items="${nlist }" var="ndto">
					<p>${ndto.user_no}, ${ndto.user_name }<input type="button" value="친구추가" onclick="alertsys('${ndto.user_no}','${login.user_no }','${ndto.user_name }')"></p>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
	
	</aside>


	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>


<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<script type="text/javascript">
var iconDataURI = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAKBJREFUeNpiYBjpgBFd4P///wJAaj0QO9DEQiAg5ID9tLIcmwMYsDgABhqoaTHMUHRxpsGYBv5TGqTIZsDkYWLo6gc8BEYdMOqAUQeMOoAqDgAWcgZAfB9EU63SIAGALH8PZb+H8v+jVz64KiOK6wIg+ADEArj4hOoCajiAqMpqtDIadcCoA0YdQIoDDtCqQ4KtBY3NAYG0csQowAYAAgwAgSqbls5coPEAAAAASUVORK5CYII=";
var sock;
var nickname;
var client;
var u_no = ${login.user_no};
var uname = '${login.user_name}'
var friendclass = document.getElementsByClassName(friendclass);
var fnd_no;
	//handler에서 정해준 서버 겅로로 설정
	sock = new SockJS("/timewizard/webserver");
	// Stomp로 웹소켓 연결
	client = Stomp.over(sock)
	
	//연결 했을시,
	client.connect({}, function(){
	    client.subscribe("/subscribe/alert/good/"+u_no, function (chat) {
	    	var fnd = JSON.parse(chat.body);
	    	var fnd_name = fnd['user_name'];
	    	var message = fnd_name+"님이 친구 신청을 하셨습니다.";
	    	var fnd_no = fnd["user_no"];
	        var options = {
	            body: message,
	            icon: iconDataURI
	        }
	        //데스크탑 알림 요청
	        var sendalert = new Notification("알람", options);
	        
	        //알림 후 10초 뒤,
	        setTimeout(function () {
	            //알람 메시지 닫기
	            sendalert.close();
	        	if(confirm(fnd_name+"님을 친구로 받아들이겠습니까?")){
			 		//"수락"을 누르면 FriendController로 보내서 insert시키기
			 		//ajax로?
			 		client.send("/publish/confirm/accept",{},JSON.stringify({friend_no: fnd_no, user_no: u_no, user_name: uname}));
			 		client.subscribe("/subscribe/confirm/res/"+u_no, function(chat){
			 			var added = chat.body;
			 			message = added+"님과 이제 친구입니다";
			 				options = {
			 		            body: message,
			 		            icon: iconDataURI
			 		        }
			 			var acceptalert = new Notification("친구추가 수락", options);
				        
				        //알림 후 5초 뒤,
				        setTimeout(function () {
				            //얼람 메시지 닫기
				            acceptalert.close();
				        }, 5000);
						client.send("/publish/confirm/fnd",{},JSON.stringify({user_no: fnd_no, friend_no: u_no}));
			 			location.href="friend";
					})
			 			
			 		
			 		console.log("fnd : "+fnd+", "+"user : "+u_no);
			 		
			 	}else{
			 		//"거절"을 누르면 FriendControlller로 보내서 update, delete시키기
			 		//ajax로?
			 				
			 		  message = fnd_name+"님의 친구 신청을 거부하셨습니다.";
				        
				         options = {
				            body: message,
				            icon: iconDataURI
				        }
				        	//데스크탑 알림 요청
				       		var denyalert = new Notification("알람" ,options);
						 	client.send("/publish/confirm/deny", {}, JSON.stringify({user_no: fnd_no, friend_no: u_no}));
				        	setTimeout(function () {
				            //얼람 메시지 닫기
				            denyalert.close();
				      	  }, 10000);
	            
	        		}
	        	}, 5000);
	    });
	    client.subscribe("/subscribe/confirm/check/"+u_no, function (chat) {
				
	    	var chk = chat.body;
 			var message = chk+"님이 친구추가를 수락하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var checkalert = new Notification("친구 수락", options);
	        
	        //알림 후 10초 뒤,
	        setTimeout(function () {
	            //얼람 메시지 닫기
	            checkalert.close();
	       	 	}, 10000); 		
	        location.href="friend";
	    	})
	    	
 		
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
	        
	       		 //알림 후 5초 뒤,
	        	setTimeout(function () {
	            //얼람 메시지 닫기
	            notification.close();
	      	  }, 10000);
				alert("친구추가 메세지를 전송했습니다.");
				client.send("/publish/alert/friend", {},JSON.stringify({friend_no: fno, user_no: mynum, user_name: fname}));
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
	   		
		 	client.send("/publish/confirm/delete", {}, JSON.stringify({user_no: myno, friend_no: fno}));
	    	setTimeout(function () {
	    		var deletealert = new Notification("친구삭제" ,options);
	        //얼람 메시지 닫기
	        deletealert.close();
	        location.href="friend";
	  	  }, 2000);
	    	
	}
else{
	
	}
}
	

</script>
</body>
</html>










