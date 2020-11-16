<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="https://cdn.webrtc-experiment.com/RecordRTC.js"> </script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="https://www.webrtc-experiment.com/getHTMLMediaElement.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<style type="text/css">
:root {
    --text-color: #f0f4f5;
    --background-color: #263343;
	--accent-color: #ff6b6b;
	--color: #E0E0E0;
	
	--light-color: whitesmoke;
	--dark-color: #363636;
}

#enter-quit-button {
	float: left !important;
}

.local__video__area {
	width: 100%;
	border: 1px solid red;
}
.remote__video__area {
	width: 100%;
	display: flex;
}
/* 하나의 video__area 안에 한 개의 local과 여러 개의 remote가 들어가도록 바꿨습니다... */
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

 .modals__area{
 }
 .modal__overlay {
	width: 100%; 
	height: 100%; 
	top: 0; 
	bottom: 0; 
	right: 0; 
	left: 0;
	z-index: 100;
	overflow: hidden;
	position: fixed;
	background: var(--dark-color);
	opacity: .8;
	display: block;
	justify-content: center;
	align-items: center;
	background-color: var(--dark-color);
	padding:0;
}
 
.modal__close {
	border-radius: 1rem;
	background-color: #FFF; 
	padding: 15px; 
	box-shadow: 0 0 8px rgba(0,0,0,0.6); 
	max-width: 500px; 
	width: 100%; 
	margin: auto; 
	position: fixed; 
	z-index: 110; 
	left: 0; 
	right: 0; 
	top: 50%;
	transform: translateY(-80%);
	-webkit-transform: translateY(-80%);
	-moz-transform: translateY(-80%);
}
.modal__close button {
	align-items: center;
	border: 1px solid transparent;
	border-radius: 4px;
	box-shadow: none;
	display: inline-flex;
	font-size: 0.8em;
	height: 1.5em;
	justify-content: flex-start;
	line-height: 1.5;
	padding-bottom: calc(0.5em - 1px);
	padding-left: calc(0.75em - 1px);
	padding-right: calc(0.75em - 1px);
	padding-top: calc(0.5em - 1px);
	position: relative;
	vertical-align: top;
	font-weight: 400;
}

.button__times {
	position: absolute !important;
    padding: 10px !important;
    margin-right: 20px;
	background-color: white;
    width: 2rem;
    height: 2rem !important;
}

div.close {
	text-align: center;
}
div.close > * {
	padding-bottom: 0.5rem;
}

.buttons__cell {
    display: flex;
    justify-content: center;
}

.buttons__cell button {
    margin-left: 1rem;
    margin-right: 1rem;
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
 			<button type="button" id="enter-quit-button">Enter</button>
		</div>
		<div class="videos__area">
			<div class="local__video__area"></div>
		</div>
		<div class="modals__area">
			<div class="modal__area"></div>
			<div class="modal__area"></div>
		</div>
		<!-- personal daily hui css와 modal 부분 동일 -->
	</div>
	<script type="text/javascript">
	let link = window.location.href;
	let user_id = "<%=user_id%>";
	let user_photo = "<%=user_photo%>";
	console.log("*id : " + user_id + "*photo : " + user_photo);
    let roomid = "${dto.group_title}"; // group title?
    </script>
    <script type="text/javascript" src="/timewizard/js/group-rtc.js"></script>
</body>
</html>