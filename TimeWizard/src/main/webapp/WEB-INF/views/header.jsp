<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

			<li><a href="mypage"><i class="fas fa-bars"></i></a></li>
			<li>
				<a href="#" class="web" onclick="window.open('stopwatch', 'window', 'width=300, height=190, left=0, top=100, status=no, resizable=no');return false">
				<i class="fas fa-stopwatch"></i></a>
				<a href="mstopwatch" class="mobile"><i class="fas fa-stopwatch"></i></a>
			</li>
			
			<%
			//로그인 되어있고 USER일때만 보이게!
			if(UDto != null && UDto.getUser_role().equals("USER")){  
			%>
			<li style="color: white">${login.user_name }</li>
			<li><a href="./logout">로그아웃</a></li>

			<%
			}
			%>
		</ul>
		<ul class="nav_icon">
			<li><i class="fab fa-twitter-square"></i></li>
			<li><i class="fab fa-facebook-square"></i></li>
		</ul>
		
		<a href="#" class="nav_toggle">
			<i class="fas fa-bars"></i>
		</a>
	</nav>

</body>
</html>