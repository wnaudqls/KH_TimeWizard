<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	UserInfoDto UDto = (UserInfoDto)session.getAttribute("login");
%>
	
	<nav class="navbar">
		<div class="nav_logo">
			<i class="fas fa-magic"></i>
			<a href="">TiWi</a>  <!-- 메인페이지로 -->
		</div>
		<ul class="nav_menu">
			<!-- Group메뉴 -->
			<li><a href="#"><i class="fas fa-users"></a></i></li>
			<!-- Off-line 메뉴 -->
			<li><a href="tiwimap"><i class="fas fa-binoculars"></i></a></li>
			<!-- 알림 -->
			<li><a href="#"><i class="far fa-bell"></i></a></li>
			<li>
				<a href="#" class="web" onclick="window.open('stopwatch', 'window', 'width=300, height=190, left=0, top=100, status=no, resizable=no');return false">
				<i class="fas fa-stopwatch"></i></a>
				<a href="mstopwatch" class="mobile"><i class="fas fa-stopwatch"></i></a>
			</li>
		</ul>
		
		<ul class="nav_icon">
			<%
			//로그인 되어있고 USER일때만 보이게!
			if(UDto != null){
			%>
			<c:choose>
				<c:when test="${userinfodto.user_role eq 'ADMIN' }">
					<li><a href="adminpage">${login.user_name }</a></li>
					<li><a href="./logout">Logout</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="mypage">${login.user_name }</a></li>
					<li><a href="./logout">Logout</a></li>
				</c:otherwise>
			</c:choose>
			<%
			}
			%>
		</ul>
		
		<a href="#" class="nav_toggle">
			<i class="fas fa-bars"></i>
		</a>
	</nav>

</body>
</html>