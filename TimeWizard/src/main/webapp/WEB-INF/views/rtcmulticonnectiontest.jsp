<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://rawgit.com/muaz-khan/RTCMultiConnection/master/dist/RTCMultiConnection.min.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<script src="https://www.WebRTC-Experiment.com/RecordRTC.js"></script>
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
	<div class="buttons__area">
		<button id="open-or-join-button">Open Or Join</button>
	</div>
	<div class="videos__container">
		<div class="remote__videos__container"></div>
		<div class="video__container local"></div>
	</div>
	<script type="text/javascript">
	var connection = new RTCMultiConnection();
	
	//this line is VERY_important
	connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
	
	//if you want audio+video conferencing
	connection.session = {
	 audio: true,
	 video: true
	};
	
	connection.sdpConstraints.mandatory = {
			OfferToReceiveAudio: true,
			OfferToReceiveVideio: true
	};
	
	let localContainer = document.querySelector("div.local");
	let remoteContainer = document.querySelector("div.remote__videos__container");
    connection.onstream = function(event) {
    	/* 
    	 * var existing = document.getElementById(event.streamid);
    	 * if (existing && existing.parentNode) {
    	 * existing.parentNode.removeChild(existing);
    	 * }
    	 */
        event.mediaElement.removeAttribute("src");
        event.mediaElement.removeAttribute("srcObject");
        event.mediaElement.muted = true;
        event.mediaElement.volume = 0;
        
        var video = document.createElement("video");
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
		if (event.type === 'local'){
			localContainer.appendChild(event.mediaElement);
		} else if (event.type === 'remote'){
			let remote = document.createElement("div");
			remote.setAttribute("class","video__container remote");
			remote.appendChild(event.mediaElement);
			remoteContainer.appendChild(remote);
		}
		/* 의미가 뭐지?? */
        if (event.type === "local") {
          connection.socket.on("disconnect", function() {
            if (!connection.getAllParticipants().length) {
              window.location.reload();
            }
          });
        }
     };
	
	let button = document.getElementById("open-or-join-button");
	
	button.addEventListener("click", () => {
		button.disabled = true; // this.disabled not working
		connection.openOrJoin('your-room-id');
	});
	
	</script>
</body>
</html>