<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kakao Sharing</title>
<link rel="stylesheet" type="text/css" href="resources/css/kakaoshare.css">
<script src="resources/js/kakaoshare.js" defer></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>

	<img src="resources/image/park.JPG" alt="london park" width="400" height="200">
	<button id="kakao-link-btn" onclick="sendLink()">공유하기</button>
	<button id="kakao-link-btn" onclick="goLink()">공유하기</button>

</body>
</html>