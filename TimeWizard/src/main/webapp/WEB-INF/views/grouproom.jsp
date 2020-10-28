<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 id="title">대충 그룹방 이름</h1>
<hr>
<div id="localvideo">

</div>

<h2 id="clientnumber"></h2>

<div id="remotevideo">

</div>


<input type="hidden" value="${dto.roomid }" id="rid">
	<!-- onkeyup: 키가 눌렀을때 나오는 이벤트(해당 태그를 선택한 상태여야함) -->
	<div id="textarea">
		<input type="text" id="message" onkeyup="enterkey()"placeholder="채팅을 입력하십시오." /> 
		<input type="button" id="sendBtn"value="submit" /> 
		<input id="roomid" /> <input type="button" id="btn-open-room" value="방열기">
		

		<!-- 이 부분은 방 만들때 값을 받아서 넣어주면 될 듯함 -->

		<input type="text" id="nickname" placeholder="이름을 입력헤주십시오."> 
		<input type="button" id="connect" value="접속하기">
		<input type="button" id="disconnect" value="접속끊기">
		<input type="number" id="maxClient" hidden="" />

		<div id="messageArea">
		
		</div>
	</div>
</body>


<link rel="stylesheet" type="text/css" href="../resources/css/grouproom.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script type="text/javascript" src="../resources/js/RTCMultiConnection.min.js"></script>
<script type="text/javascript" src="../resources/js/socket.io.js"></script>
<script type="text/javascript" src="../resources/js/broadcast.js"></script>
	<!-- sockjs, stomp socket 추가 -->
	<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<script type="text/javascript">
var sock;
var nickname;
var client;
var rid = document.getElementById("rid").value;
var messageArea = document.getElementById("messageArea");
$("#connect").click(function() {
    nickname = document.getElementById("nickname").value;
    document.getElementById("nickname").style.display="none";
    document.getElementById("connect").style.display="none";
    document.getElementById("disconnect").style.display="inline";
    connect();
});
$("#disconnect").click(function() {
   
    document.getElementById("nickname").style.display="";
    document.getElementById("connect").style.display="";
    document.getElementById("disconnect").style.display="none";
    client.disconnect();
});
function disconnect(){
	sock.send(JSON.stringify({roomid :rid, type:'LEAVE', writer:nickname}));
	sock.close();
}
function connect() {
	//handler에서 정해준 서버 겅로로 설정
	sock = new SockJS("/timewizard/webserver");
	client = Stomp.over(sock)
	// Stompjs를 연결해줄 주소를 대입
	client.connect({}, function(){
		 // 3. send(path, header, message)로 메시지를 보낼 수 있다.
	    client.send("/publish/chat/join", {}, JSON.stringify({roomid: rid, type:'ENTER', writer: nickname})); 
	    // 4. subscribe(path, callback)로 메시지를 받을 수 있다. callback 첫번째 파라미터의 body로 메시지의 내용이 들어온다.
	    client.subscribe("/subscribe/chat/room/"+rid, function (chat) {
	   		console.log('asdfasf');
	        var content = JSON.parse(chat.body);
	        $("#messageArea").append(content.writer+": "+ content.message+ "<br>")
	    });
	})
	
 }


$("#sendBtn").click(function() {
	sendMessage();
	$('#message').val('')
});



// 메시지 전송
function sendMessage() {
	msg = document.getElementById("message");
    client.send('/publish/chat/message', {}, JSON.stringify({roomid: rid, type:'CHAT', writer: nickname , message: msg.value}));
	msg.value = '';
}

function enterkey() {
	//keyCode: 입력한 코드(13번 == enter)
	if (window.event.keyCode == 13) {
		sendMessage();
	}
}

</script>
</html>