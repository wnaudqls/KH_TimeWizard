<%@page import="com.minibean.timewizard.model.dto.ChatDto"%>
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
			<input type="button" value="만들기" onclick="location.href='groupnewroom'">
		</div>
	</div>
</nav>

<div class="fixedmain">
	
	<c:choose>
		<c:when test="${empty list }">
				<tr>
					<td>아무것도 없습니다.</td>
				</tr>
		</c:when>
			<c:otherwise>
		
				<c:forEach var="dto" items="${list }">
					<div class="grouproom">
						<div class="groupimg">
							img
						</div>
						<div class="grouptitle">
							<span class="group2">${dto.chat_title }</span>
						</div>
						<div class="groupmain">
							<span class="groupid">${dto.user_id }</span>
						</div>
						<div align="right">
							<input type="button" value="접속하기" onclick="location.href='joinroom/${dto.chat_title }'">
						</div>
					</div>
					<div style="width:1rem"></div>
<%-- 					<%
						if (items % 3 == 0) {
					%>
						<br/>
					<%
						}
					%> --%>
				</c:forEach>
				
			</c:otherwise>
		</c:choose>

</div>


</body>
</html>