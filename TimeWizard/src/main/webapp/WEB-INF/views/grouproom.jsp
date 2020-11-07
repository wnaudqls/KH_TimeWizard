<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>채팅방: ${dto.group_title }</title>
</head>
<body>
<c:choose>
		<c:when test="${empty dto.group_title }">
			방이 존재하지 않습니다.
			<script type="text/javascript">
			setTimeout(function(){
				   // 3초 후 작동해야할 코드
				       location.href="../grouplist";
				   }, 3000);
			
			</script>
		</c:when>
		<c:otherwise>
		<c:if test="${dto.group_client ge dto.group_su}">
			<script type="text/javascript">
					alert("인원수 초과.");
					location.href="../grouplist";
		
			</script>
		</c:if>
		
		
		<c:if test="${!empty dto.group_pw }">
			<script type="text/javascript">
				var password = prompt("비밀번호를 입력하십시오.");
				if(password != '${dto.group_pw }'){
					alert("비밀번호가 틀렸습니다.");
					location.href="../grouplist";
				}
			</script>
		</c:if>
	

			<h1 id="title">${dto.group_title }</h1>
			<hr>
			<div id="localvideo"></div>

			<h2 id="clientnumber"></h2>

			<div id="remotevideo"></div>


			<input type="hidden" value="${dto.group_title }" id="rid">
			<!-- onkeyup: 키가 눌렀을때 나오는 이벤트(해당 태그를 선택한 상태여야함) -->
			<div id="textarea">
				<input type="text" id="message" onkeyup="enterkey()"
					placeholder="채팅을 입력하십시오." /> <input type="button" id="sendBtn"
					value="submit" /> <input id="roomid" /> <input type="button"
					id="btn-open-room" value="방열기">


				<!-- 이 부분은 방 만들때 값을 받아서 넣어주면 될 듯함 -->

				<input type="text" id="nickname" placeholder="이름을 입력헤주십시오."
					value="${login.user_name }"> <input type="button" id="disconnect"
					value="접속끊기" onclick="disconnect()"> <input type="button"
					id="connect" value="접속하기" onclick="connect()"> <input
					type="number" id="maxClient" hidden="" />

				<div id="messageArea"></div>
			</div>

<jsp:include page="friendlist.jsp"></jsp:include>
</c:otherwise>
</c:choose>
			<script type="text/javascript"
				src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
			<script type="text/javascript"
				src="../resources/js/RTCMultiConnection.min.js"></script>
			<script type="text/javascript" src="../resources/js/socket.io.js"></script>
			<script type="text/javascript" src="../resources/js/broadcast.js"></script>
			<!-- sockjs, stomp socket 추가 -->
			<script type="text/javascript"
				src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
			<script type="text/javascript"
				src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
			<script type="text/javascript" src="../resources/js/chat.js"></script>
	


</body>

<link rel="stylesheet" type="text/css"
	href="../resources/css/grouproom.css">
</html>