<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="https://cdn.webrtc-experiment.com/RecordRTC.js"> </script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="https://www.webrtc-experiment.com/getHTMLMediaElement.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<style type="text/css">
.local__video__area {
	width: 100%;
	border: 1px solid red;
}
.remote__videos__area {
	width: 100%;
	display: flex;
}
.remote {
	border: 1px solid blue;
}
.media__container {
	width: inherit;
	height: inherit;
}
.media__user__status {
	display: flex;
	position:absolute;
	padding:0;
	margin:0;
}
.user__photo {
	width: 3rem;
	height: 3rem;
	border-radius: 50%;
}
.user__id {
	font-size: 20px;
	color: rgb(160,160,160);
	text-shadow: 1px 1px rgb(255, 255, 255);
	margin: auto;
	margin-left: 0.5rem;
}
</style>
</head>
<%
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
	String user_id = (login.getUser_id().length() > 8)? login.getUser_id().substring(0,8):login.getUser_id();
	int user_no = login.getUser_no();
	String user_photo = login.getUser_photo();
%>
<body>
	<div class="webrtc__part">
		<div class="buttons__area">
			<button id="enter-quit-button">Enter</button>
			<button id="save-button">SAVE</button>
		</div>
		<div class="videos__area">
			<div class="remote__videos__area"></div>
			<div class="local__video__area"></div>
		</div>
		<div id="video-preview"></div>
		<div id="logs-preview"></div>
		<div class="downloadTest inner"></div>
	</div>
	<script type="text/javascript">
	let link = window.location.href;
	let user_id = "<%=user_id%>";
	let user_photo = "<%=user_photo%>";
	console.log("*id : " + user_id + "*photo : " + user_photo);
    let roomid = "${dto.group_title}"; // group title?
        
    let button = document.getElementById("enter-quit-button");
    let save = document.getElementById("save-button");
	let localContainer = document.querySelector("div.local__video__area");
    let videoContainer = document.querySelector("div.videos__area");
    let worker;
    
    
    /* RecordRTC PART */
    let recordRTC;
    var inner = document.querySelector('.inner'); // 다운로드 링크 삽입되는 div
    
    button.addEventListener("click", () => {
		if (button.textContent == 'Enter'){
			connection.openOrJoin(roomid, function(isRoomCreated, roomid, error){
                if (error){
                    alert("오류가 발생하여 방을 생성할 수 없습니다.\n오류: " + error);
                    connection.closeSocket();
                    return;
                }
            });
			
			/* RecordRTC PART */
			navigator.mediaDevices.getUserMedia({video:true})
			.then(function(stream){
				window.recordRTC = RecordRTC(stream, {type:'video'});
				window.recordRTC.startRecording();
			})
			.catch(function(err){
				alert("오류가 발생하여 영상을 저장할 수 없습니다.\n"+err);
			});
			
			button.textContent = 'Quit';
		} else if (button.textContent == 'Quit'){
		    
			window.recordRTC.stopRecording(); // 종료시에 모달창이 떠서 그냥 끌 건지 저장 처리를 할지 선택??
			connection.closeSocket();
			connection.getAllParticipants().forEach(function(participantid){
				connection.disconnectWith(participantid);
			});
		    connection.attachStreams.forEach(function(localStream) {
		        localStream.stop();
		    });
		    connection.closeSocket();
		    
			button.textContent = 'Enter';
		}
	});
    
    save.addEventListener("click", () => {
	    /* RecordRTC PART */
        window.recordRTC.stopRecording(function(url) {
            convertStreams(window.recordRTC.getBlob());
        });
    });
    
    
    let workerPath = 'https://localhost:8443/timewizard/js/ffmpeg_asm.js';
    
    function processInWebWorker() {
        let blob = URL.createObjectURL(new Blob(['importScripts("' + workerPath + '");var now = Date.now;function print(text) {postMessage({"type" : "stdout","data" : text});};onmessage = function(event) {var message = event.data;if (message.type === "command") {var Module = {print: print,printErr: print,files: message.files || [],arguments: message.arguments || [],TOTAL_MEMORY: message.TOTAL_MEMORY || false};postMessage({"type" : "start","data" : Module.arguments.join(" ")});postMessage({"type" : "stdout","data" : "Received command: " +Module.arguments.join(" ") +((Module.TOTAL_MEMORY) ? ".  Processing with " + Module.TOTAL_MEMORY + " bits." : "")});var time = now();var result = ffmpeg_run(Module);var totalTime = now() - time;postMessage({"type" : "stdout","data" : "Finished processing (took " + totalTime + "ms)"});postMessage({"type" : "done","data" : result,"time" : totalTime});}};postMessage({"type" : "ready"});'], {
            type: 'application/javascript'
        }));

        let worker = new Worker(blob);
        URL.revokeObjectURL(blob);
        return worker;
    }


    function convertStreams(videoBlob) {
        let blobResult; // fileReader.onload.videoBlob.result(); worker.postMessage(blobResult)
        let buffersReady; // ??
        let workerReady; // if message.type == 'ready' -> true
        let posted; // var postMesssage = function() {}

        var fileReader = new FileReader();
        fileReader.onload = function() {
            blobResult = this.result;
            postMessage();
        };
        fileReader.readAsArrayBuffer(videoBlob);

        if (!worker) {
            worker = processInWebWorker();
        }

        worker.onmessage = function(event) {
            var message = event.data;
            if (message.type == "ready") {
                workerReady = true;
                if (buffersReady)
                    postMessage();
            } else if (message.type == "done") {
                var result = message.data[0];
                var blob = new File([result.data], 'test.mp4', {
                    type: 'video/mp4'
                });
	
                uploadBlob(blob);
            }
        };
        var postMessage = function() {
            posted = true;

            worker.postMessage({
                type: 'command',
                arguments: '-i video.webm -filter:v setpts=0.5*PTS -an -strict -2 output.mp4'.split(' '),
                files: [
                    {
                        data: new Uint8Array(blobResult),
                        name: 'video.webm'
                    }
                ]
            });
        };
   	}
    
    function uploadBlob(blob){
    	let xhr = new XMLHttpRequest();
    	let formData = new FormData();
    	formData.append("file",blob);
    	xhr.open("POST", "/timewizard/file/upload");
    	xhr.send(formData);
    }

    let connection = new RTCMultiConnection();
    
	connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';

    connection.iceServers = [{
        'urls': [
        'stun:stun.l.google.com:19302',
        'stun:stun1.l.google.com:19302',
        'stun:stun2.l.google.com:19302',
        ]
    }];
    connection.iceServers.push({
        url: 'turn:numb.viagenie.ca',
        credential: 'muazkh',
        username: 'webrtc@live.com'
    });

	connection.session = {
	 video: true
	};
	connection.sdpConstraints.mandatory = {
			OfferToReceiveAudio: true,
			OfferToReceiveVideio: true
    };
    connection.mediaConstraints = {
        video: {
            width: {
                ideal: 1920
            },
            height: {
                ideal: 1080
            },
            frameRate: 30
        },
        audio: true
    }
	
    connection.extra = {user_id: user_id, user_photo: user_photo};
    
	connection.onstream = function(event){
		let existing = document.getElementById(event.streamid);
    	if (existing && existing.parentNode) {
			existing.parentNode.removeChild(existing);
        }

        event.mediaElement.removeAttribute("src");
        event.mediaElement.removeAttribute("srcObject");
        event.mediaElement.muted = true;
        event.mediaElement.volume = 0;
		
        let video = document.createElement("video");

        try {
            video.setAttributeNode(document.createAttribute("autoplay"));
            video.setAttributeNode(document.createAttribute("playsinline"));
        } catch (e) {
            video.setAttribute("autoplay", true);
            video.setAttribute("playsinline", true);
        }

        video.volume = 0;
        
        try {
            video.setAttributeNode(document.createAttribute("muted"));
        } catch (e) {
            video.setAttribute("muted",true);
        }
        
        video.srcObject = event.stream;
        
		let mediaElement = document.createElement("div");
		mediaElement.setAttribute("class","media__container");
		let mediaElement_user = document.createElement("div");
		mediaElement_user.setAttribute("class","media__user__status");
		let userid_div = document.createElement("div");
		userid_div.setAttribute("class","user__id");
		userid_div.textContent = event.extra.user_id;
		
		
		let userphoto_img = document.createElement("img");
		
		/* 여기까지 됨 */
		
		console.log((event.extra.user_photo != null || event.extra.user_photo != "null")?event.extra.user_photo:"null");
		userphoto_img.setAttribute("src","/timewizard/image/" + (event.extra.user_photo != null || event.extra.user_photo != "null")?event.extra.user_photo:"3J1kUZfY.jpg");
		/* TODO: get user photo */
		console.log("set mediaElement");
		
		userphoto_img.setAttribute("class","user__photo");
		mediaElement_user.appendChild(userphoto_img);
		mediaElement_user.appendChild(userid_div);
		mediaElement.appendChild(mediaElement_user);
		mediaElement.appendChild(video);
		
		console.log(event.type);
		/* zoom mode, pip mode etc */
		
		// img src 수정
		// width 수정
		// connection.videosContainer 설정 안함
		// var width = parseInt(connection.videosContainer.clientWidth / 3) - 20;

        if (event.type == 'local'){
            localContainer.appendChild(mediaElement);
            localStorage.setItem("localSrc", event.stream);
            console.log("추가확인!!!!!!!!!!!");
        }
        if (event.type == 'remote'){
            let remote_div = document.createElement("div");
            remote_div.setAttribute("class","video__container remote");
            remote_div.id = event.streamid;
            remote_div.appendChild(mediaElement);
            videoContainer.appendChild(remote_div);
        }

        mediaElement.id = event.streamid;

        localStorage.setItem(connection.socketMessageEvent, connection.sessionid);
	}
	
	connection.onstreamended = function(event) {
		console.log("CONNECTION ONSTREAM ENDED");
	    let video_container = document.getElementById(event.streamid);
	    if (video_container && video_container.parentNode) {
	        video_container.parentNode.removeChild(video_container);
	    }
	};

	

	(function() {
	    var params = {},
	        r = /([^&=]+)=?([^&]*)/g;

	    function d(s) {
	        return decodeURIComponent(s.replace(/\+/g, ' '));
	    }
	    var match, search = window.location.search;
	    while (match = r.exec(search.substring(1)))
	        params[d(match[1])] = d(match[2]);
	    window.params = params;
	})();
</script>
</body>
</html>