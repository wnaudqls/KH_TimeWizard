var sock;
var nickname = document.getElementById("nickname").value;
var client;
var rid = document.getElementById("rid").value;
var messageArea = document.getElementById("messageArea");
function disconnect(){
	client.send("/publish/chat/disconnect", {}, JSON.stringify({chat_title: rid, type:'LEAVE', writer: nickname}));
	client.subscribe("/subscribe/chat/room/"+rid, function (chat) {
	        var content = JSON.parse(chat.body);
	        $("#messageArea").append(content.writer+": "+ content.message+ "<br>");
	    });
document.getElementById("disconnect").style.display="none";
document.getElementById("connect").style.display="inline";
client.disconnect();
location.href="../grouplist"
}

	//handler에서 정해준 서버 겅로로 설정
	sock = new SockJS("/timewizard/webserver");
	client = Stomp.over(sock)
	// sock의 이벤트
	client.connect({}, function(){
		 // 3. send(path, header, message)로 메시지를 보낼 수 있다.
	    client.send("/publish/chat/join", {}, JSON.stringify({chat_title: rid, type:'ENTER', writer: nickname})); 
	    // 4. subscribe(path, callback)로 메시지를 받을 수 있다. callback 첫번째 파라미터의 body로 메시지의 내용이 들어온다.
	    client.subscribe("/subscribe/chat/room/"+rid, function (chat) {
	        var content = JSON.parse(chat.body);
	        $("#messageArea").append(content.writer+": "+ content.message+ "<br>")
	    });
		 client.subscribe("/subscribe/chat/join/"+rid, function (chat) {
	        var content = JSON.parse(chat.body);
	        $("#messageArea").append(content.message+ "<br>");
			
	    });
	})
	
 

$("#sendBtn").click(function() {
	sendMessage();
	$('#message').val('')
});



// 메시지 전송
function sendMessage() {
	msg = document.getElementById("message");
    client.send('/publish/chat/message', {}, JSON.stringify({chat_title: rid, type:'CHAT', writer: nickname , message: msg.value}));
	msg.value = '';
}

function enterkey() {
	//keyCode: 입력한 코드(13번 == enter)
	if (window.event.keyCode == 13) {
		sendMessage();
	}
}

function connect(){
	client.connect({}, function(){
		 // 3. send(path, header, message)로 메시지를 보낼 수 있다.
	    client.send("/publish/chat/join", {}, JSON.stringify({chat_title: rid, type:'ENTER', writer: nickname})); 
	    // 4. subscribe(path, callback)로 메시지를 받을 수 있다. callback 첫번째 파라미터의 body로 메시지의 내용이 들어온다.
	    client.subscribe("/subscribe/chat/room/"+rid, function (chat) {
	        var content = JSON.parse(chat.body);
	        $("#messageArea").append(content.writer+": "+ content.message+ "<br>")
	    });
		 client.subscribe("/subscribe/chat/join/"+rid, function (chat) {
	        var content = JSON.parse(chat.body);
	        $("#messageArea").append(content.message+ "<br>");
			
	    });
	})
 document.getElementById("disconnect").style.display="inline";
 document.getElementById("connect").style.display="none";
}


