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
	let name = "<%=user_id%>";
    let roomid = "${dto.group_title}"; // group title?
        
    let button = document.getElementById("enter-quit-button");
    let save = document.getElementById("save-button");
	let localContainer = document.querySelector("div.local__video__area");
    let remoteContainer = document.querySelector("div.remote__videos__area");
    
    
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
		    
			/* webcam 계속 켜져있는 느낌...? */
		    
			button.textContent = 'Enter';
		}
	});
    
    save.addEventListener("click", () => {
	    /* RecordRTC PART */
        window.recordRTC.stopRecording(function(url) {
        	console.log("STOP RECORDING");
            // console.log('<a href="'+ workerPath +'" download="ffmpeg-asm.js">ffmpeg-asm.js</a> file download started. It is about 18MB in size; please be patient!');
            convertStreams(window.recordRTC.getBlob());
        });
    });
    
    
    var workerPath = 'https://localhost:8443/timewizard/js/ffmpeg_asm.js';
    /* 
    // download ffmpeg_asm.js file and copy to js folder
    // DO NOT MOVE AND COPY THIS FILE ON ECLIPSE MEMORY ERROR HAPPENED
		var workerPath = 'https://archive.org/download/ffmpeg_asm/ffmpeg_asm.js';
		if(document.domain == 'localhost') {
			workerPath = location.href.replace(location.href.split('/').pop(), '') + 'ffmpeg_asm.js';
		}
     */
    function processInWebWorker() {
        var blob = URL.createObjectURL(new Blob(['importScripts("' + workerPath + '");var now = Date.now;function print(text) {postMessage({"type" : "stdout","data" : text});};onmessage = function(event) {var message = event.data;if (message.type === "command") {var Module = {print: print,printErr: print,files: message.files || [],arguments: message.arguments || [],TOTAL_MEMORY: message.TOTAL_MEMORY || false};postMessage({"type" : "start","data" : Module.arguments.join(" ")});postMessage({"type" : "stdout","data" : "Received command: " +Module.arguments.join(" ") +((Module.TOTAL_MEMORY) ? ".  Processing with " + Module.TOTAL_MEMORY + " bits." : "")});var time = now();var result = ffmpeg_run(Module);var totalTime = now() - time;postMessage({"type" : "stdout","data" : "Finished processing (took " + totalTime + "ms)"});postMessage({"type" : "done","data" : result,"time" : totalTime});}};postMessage({"type" : "ready"});'], {
            type: 'application/javascript'
        }));

        var worker = new Worker(blob);
        URL.revokeObjectURL(blob);
        return worker;
    }

    var worker;

    function convertStreams(videoBlob) {
    	console.log("CONVERTSREAMS");
        var aab; // fileReader.onload.videoBlob.result(); worker.postMessage(aab)
        var buffersReady; // ??
        var workerReady; // if message.type == 'ready' -> true
        var posted; // var postMesssage = function() {}

        var fileReader = new FileReader();
        fileReader.onload = function() {
            aab = this.result;
            console.log(aab);
            postMessage();
        };
        fileReader.readAsArrayBuffer(videoBlob);

        if (!worker) {
            worker = processInWebWorker();
        }

        worker.onmessage = function(event) {
            var message = event.data;
            if (message.type == "ready") {
                // console.log('<a href="'+ workerPath +'" download="ffmpeg-asm.js">ffmpeg-asm.js</a> file has been loaded.');

                workerReady = true;
	            // console.log(buffersReady); // not if ready -> 21 * undefined
                if (buffersReady)
                    postMessage();
            } else if (message.type == "stdout") {
                // console.log(message.data);
            } else if (message.type == "start") {
                // console.log('<a href="'+ workerPath +'" download="ffmpeg-asm.js">ffmpeg-asm.js</a> file received ffmpeg command.');
            } else if (message.type == "done") {
       			// console.log("ONMESSAGE TYPE DONE");
                console.log(JSON.stringify(message));
				
                console.log(message.time);
                var result = message.data[0];
                console.log(JSON.stringify(result));

                var blob = new File([result.data], 'test.mp4', {
                    type: 'video/mp4'
                });
	
                // console.log(JSON.stringify(blob)); // {}
				console.log("NEW FILE BLOB");
                // console.log(JSON.stringify(blob)); // {}

                postBlob(blob);
            }
        };
        var postMessage = function() {
        	console.log("POSTMESSGAE");
            posted = true;

            worker.postMessage({
                type: 'command',
                arguments: '-i video.webm -filter:v setpts=0.5*PTS -an -strict -2 output.mp4'.split(' '),
                files: [
                    {
                        data: new Uint8Array(aab),
                        name: 'video.webm'
                    }
                ]
            });
        };
   	}

    function postBlob(blob) {
    	console.log("POSTBLOB");
    	// 미리보기로 남긴다거나?
    	/*
        var video = document.createElement('video');
        video.controls = true;
		 */
        var source = document.createElement('source');
        source.src = URL.createObjectURL(blob);
        source.type = 'video/mp4; codecs=mpeg4';
        /*
        video.appendChild(source);
        
        video.download = 'Play mp4 in VLC Player.mp4';
		 */
        inner.appendChild(document.createElement('hr'));
        var h2 = document.createElement('h2');
        h2.innerHTML = '<a href="' + source.src + '" target="_blank" download="Play mp4 in VLC Player.mp4" style="font-size:200%;color:red;">Download Converted mp4 and play in VLC player!</a>';
        inner.appendChild(h2);
        h2.style.display = 'block';
        /*
        inner.appendChild(video);

        video.tabIndex = 0;
        video.focus();
        video.play();
         */

    }

    var logsPreview = document.getElementById('logs-preview');

     
	
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
	
    connection.extra = {fullName: name};
    
	connection.onstream = function(event){
		console.log("CONNECTION ONSTREAM");
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
		userid_div.textContent = event.extra.fullName;
		let userphoto_img = document.createElement("img");
		userphoto_img.setAttribute("src","/timewizard/img/3J1kUZfY.jpg");
		userphoto_img.setAttribute("class","user__photo");
		mediaElement_user.appendChild(userphoto_img);
		mediaElement_user.appendChild(userid_div);
		mediaElement.appendChild(mediaElement_user);
		mediaElement.appendChild(video);
		/* zoom mode, pip mode etc */
		
		// img src 수정
		// width 수정
		// connection.videosContainer 설정 안함
		// var width = parseInt(connection.videosContainer.clientWidth / 3) - 20;

        if (event.type == 'local'){
            localContainer.appendChild(mediaElement);
            localStorage.setItem("localSrc", event.stream);
        }
        if (event.type == 'remote'){
            let remote_div = document.createElement("div");
            remote_div.setAttribute("class","video__container remote");
            remote_div.id = event.streamid;
            remote_div.appendChild(mediaElement);
            remoteContainer.appendChild(remote_div);
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