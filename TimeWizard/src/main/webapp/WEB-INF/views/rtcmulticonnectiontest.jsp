<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="https://www.WebRTC-Experiment.com/RecordRTC.js"></script>
<script src="https://www.webrtc-experiment.com/getHTMLMediaElement.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<style type="text/css">
.local__video__area {
	border: 1px solid red;
}
.remote__videos__area {
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
		</div>
		<div class="videos__area">
			<div class="remote__videos__area"></div>
			<div class="local__video__area"></div>
		</div>
	</div>
	<script type="text/javascript">
	let link = window.location.href;
	let name = "<%=user_id%>";
    let roomid = ${dto.group_title}; // group title?
        
    let button = document.getElementById("enter-quit-button");
	let localContainer = document.querySelector("div.local__video__area");
    let remoteContainer = document.querySelector("div.remote__videos__area");

    button.addEventListener("click", () => {
		if (button.textContent == 'Enter'){
			connection.openOrJoin(roomid, function(isRoomCreated, roomid, error){
                if (error){
                    alert("오류가 발생하여 방을 생성할 수 없습니다.\n오류: " + error);
                    connection.closeSocket();
                    return;
                }
            });
			button.textContent = 'Quit';
		} else if (button.textContent == 'Quit'){
			connection.closeSocket();
			button.textContent = 'Enter';
		}
	});
	
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
	 audio: true,
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
		console.log(event);
		
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
		console.log(mediaElement);
		/* zoom mode, pip mode etc */
		
		/*
		let mediaElement = getHTMLMediaElement(video, {
            title:  "<img src='/timewizard/img/3J1kUZfY.jpg' class='title__photo' />" + event.extra.fullName,
            buttons: ["full-screen"],
			showOnMouseEnter: false
        });
		// img src 수정
		// width 수정
		// connection.videosContainer 설정 안함
		// var width = parseInt(connection.videosContainer.clientWidth / 3) - 20;
		*/

        if (event.type == 'local'){
            localContainer.appendChild(mediaElement);
        }
        if (event.type == 'remote'){
            let remote_div = document.createElement("div");
            remote_div.setAttribute("class","video__container remote");
            remote_div.id = event.streamid;
            remote_div.appendChild(mediaElement);
            remoteContainer.appendChild(remote_div);
        }

        setTimeout(function() {
          mediaElement.media.play();
        }, 5000);

        mediaElement.id = event.streamid;

        localStorage.setItem(connection.socketMessageEvent, connection.sessionid);
	}
	
	connection.onstreamended = function(event) {
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