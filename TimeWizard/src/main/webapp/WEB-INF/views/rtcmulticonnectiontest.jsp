<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://rawgit.com/muaz-khan/RTCMultiConnection/master/dist/RTCMultiConnection.min.js"></script>
<script src="https://www.WebRTC-Experiment.com/RecordRTC.js"></script>
<script src="https://www.webrtc-experiment.com/getHTMLMediaElement.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<style type="text/css">
.local {
	border: 1px solid red;
}
.remote__videos__container {
	display: flex;
}
.remote {
	border: 1px solid blue;
}
</style>
</head>
<body>
<%
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
	String name = login.getUser_name();
%>
	<div class="buttons__area">
		<button id="enter-quit-button">Enter</button>
	</div>
	<div class="videos__container">
		<div class="remote__videos__container"></div>
		<div class="video__container local"></div>
	</div>
	<script type="text/javascript">
	let link = window.location.href;
	let name = "<%=name%>";
	let roomid = ""; // group title?
	let button = document.getElementById("enter-quit-button");
	let localContainer = document.querySelector("div.local");
	let remoteContainer = document.querySelector("div.remote__videos__container");
	
	let connection = new RTCMultiConnection();
	connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
	connection.iceServers = [];
	connection.iceServers.push({
		urls: 'stun:stun.l.google.com:19302'
	});
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
	
	connection.extra = {fullName: name};
	connection.onstream = function(event){
		/*
		let existing = document.getElementById(event.streamid);
		console.log(existing);
    	if (existing && existing.parentNode) {
			existing.parentNode.removeChild(existing);
    	}
    	 */
    	console.log(event);
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
		if (event.type === "local") {
			video.volume = 0;
			try {
				video.setAttributeNode(document.createAttribute("muted"));
			} catch (e) {
				video.setAttribute("muted", true);
			}
		}
		video.srcObject = event.stream;
    	console.log(event);
		
		var height =
		  parseInt(connection.videosContainer.clientHeight / 3) - 100;
		var width = 20;
		var mediaElement = getHTMLMediaElement.getHTMLMediaElement(video, {
			title: event.userid,
			buttons: ["full-screen"],
			width: width,
			height: height,
			showOnMouseEnter: false
		});
		
		if (event.type == 'local'){
			localContainer.appendChild(video);
			localContainer.id = event.streamid;
			let name_div = document.createElement("div");
			name_div.setAttribute("class","video__name");
			name_div.textContent = event.extra.fullName;
			localContainer.appendChild(name_div);
		} else if (event.type == 'remote'){
			let remote_div = document.createElement("div");
			remote_div.setAttribute("class","video__container remote");
			remote_div.id = event.streamid;
			let name_div = document.createElement("div");
			name_div.setAttribute("class","video__name");
			name_div.textContent = event.extra.fullName;
			remote_div.appendChild(video);
			remote_div.appendChild(name_div);
			remoteContainer.appendChild(remote_div);
		}
    	console.log(event);
	}
	
	connection.onstreamended = function(event) {
	    let video_container = document.getElementById(event.streamid);
	    if (video_container && video_container.parentNode) {
	        video_container.parentNode.removeChild(video_container);
	    }
	};

	
	button.addEventListener("click", () => {
		if (button.textContent == 'Enter'){
			connection.openOrJoin(roomid, function(isRoomCreated, roomid, error){
				if(error){
					alert("방을 생성할 수 없습니다.\n오류메시지 : " + error);
					return;
				}
			});
			button.textContent = 'Quit';
		} else if (button.textContent == 'Quit'){
			button.textContent = 'Enter';
		}
	});
	</script>
	<script type="text/javascript">
	!(function() {
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
    function addStreamStopListener(stream, callback) {
        stream.addEventListener('ended', function() {
            callback();
            callback = function() {};
        }, false);
        stream.addEventListener('inactive', function() {
            callback();
            callback = function() {};
        }, false);
        stream.getTracks().forEach(function(track) {
            track.addEventListener('ended', function() {
                callback();
                callback = function() {};
            }, false);
            track.addEventListener('inactive', function() {
                callback();
                callback = function() {};
            }, false);
        });
    }
	</script>
</body>
</html>