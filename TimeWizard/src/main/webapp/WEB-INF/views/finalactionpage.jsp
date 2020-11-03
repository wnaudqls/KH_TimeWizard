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
					<p>이름 : ${fdto.user_name }</p>
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
					<p>${ndto.user_no}, ${ndto.user_name }<input type="button" value="친구추가" onclick="alertsys('${ndto.user_no}','${login.user_no }')"></p>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
	
	</aside>


	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>


<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<script type="text/javascript">
var sock;
var nickname;
var client;
var user = ${login.user_no};
var friendclass = document.getElementsByClassName(friendclass);
	//handler에서 정해준 서버 겅로로 설정
	sock = new SockJS("/timewizard/webserver");
	// Stomp로 웹소켓 연결
	client = Stomp.over(sock)
	
	//연결 했을시,
	client.connect({}, function(){
		 // 3. send(path, header, message)로 메시지를 보낼 수 있다.
	    client.send("/publish/login/join", {}); 
		 
		 //친구추가를 한 user_no
	    // 4. subscribe(path, callback)로 메시지를 받을 수 있다. callback 첫번째 파라미터의 body로 메시지의 내용이 들어온다.
	    client.subscribe("/subscribe/login/res/", function (chat) {
	   		console.log("chateueueueueueue : "+chat);
 			
 
	    });
	    
	    //친구추가를 받은 friend_no 
	    //${login.user_name}을 쓴 이유는 친구신청을 받은 클라이언트만 값을 받아야 하기 때문에
	    client.subscribe("/subscribe/alert/good/"+user, function (chat) {
	    	var fnd = JSON.parse(chat.body);
	    	console.log("subcribe: "+fnd);
		 
		 	if(confirm(fnd+"님을 친구로 받아들이겠습니까?")){
		 		//"수락"을 누르면 FriendController로 보내서 insert시키기
		 		//ajax로?
		 		client.send("/publish/confirm/accept",{},JSON.stringify({friend_no: fnd, user_no:user}));
		 		client.subscribe("/subscribe/confirm/res/"+user, function(chat){
		 			location.href="friend";
		 				
					})
					client.send("/publish/confirm/fnd",{},JSON.stringify({friend_no: fnd}));
		 			
		 		
		 		console.log("fnd : "+fnd+", "+"user : "+user);
		 		
		 	}else{
		 		//"거절"을 누르면 FriendControlller로 보내서 update, delete시키기
		 		//ajax로?
		 		client.send("/publish/confirm/deny", {});
		 	}
		 		
		 	
			//alert("알람수신 완료");	

	    });
	    client.subscribe("/subscribe/confirm/check/"+user, function chat() {
				console.log("asdf");
			location.href = "friend";
		});
	})
	
function alertsys(fname,name){
		alert("친구신청을 보냈습니다.");
		client.send("/publish/alert/friend", {}, 
		JSON.stringify({user_no: name, friend_no: fname})); 
		//name : 신청 보낸 사람, fname : 신청 받은 사람
		//friend_no를 같이 보냄
		//FriendController의 /alert/friend경로에 {user_name: name}의 JSON 형식으로 보냄

}
	
	

</script>
</body>
</html>










