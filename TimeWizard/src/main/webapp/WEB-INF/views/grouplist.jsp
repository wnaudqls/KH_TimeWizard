<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/grouplist.css">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<nav class="fixedtop">
	<div class="logo">
		<a class="titlelogo" href="main"><img alt="" src="resources/img/027-star 2.png"></a>
		<a class="titlename" href="main"><img alt="" src="resources/img/TIME WIZARD.png"></a>
	</div>
		
	<div class="menu">
		<div id="searchArea">
			<input type="text" id="search" placeholder="아이디 또는 방이름을 입력하세요" /> 
			<button id="searchBtn"><a><i class="fas fa-search"></i></a></button>
		</div>
		<div class="createroom">
			<input type="button" value="만들기" onclick="location.href='newroom'">
		</div>
	</div>
</nav>

<div class="fixedmain">
	<table class="grouproom">
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td>아무것도 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${list }">
					<%-- <tr>
						<th>번호</th>
						<td>${dto.chat_no }</td>
					</tr> --%>
					<tr class="grouptitle">
						<th class="group1">방이름</th>	
						<th class="group2">${dto.chat_title }</th>
					</tr>
					<tr class="groupmain">
						<th>아이디</th>	
						<th class="groupid">${dto.user_id }</th>
					</tr>
					<%-- <tr>
						<th>내용</th>
						<td>${dto.chat_content }</td>
					</tr> --%>
					<tr>
						<td colspan="2" align="right">
							<input type="button" value="접속하기" onclick="location.href='joinroom/${dto.chat_title }'">
						</td>
					</tr>
					<tr>
						<td colspan="2" style="height:1rem"></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</div>


</body>
</html>