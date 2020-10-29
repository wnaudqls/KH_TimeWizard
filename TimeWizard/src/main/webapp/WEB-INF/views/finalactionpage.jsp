<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap" rel="stylesheet">
<link href="resources/css/actionpage.css" rel="stylesheet">
<script src="resources/js/actionpage.js" defer></script>
<script src="resources/js/tap.js" defer></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>

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
			<%
			//로그인 되어있고 USER일때만 보이게!
			if(UDto != null && UDto.getUser_role().equals("USER")){  
			%>
			<li>${login.user_name }님! 반갑습니다.</li>
			<li><a href="./logout">로그아웃</a></li>

			<%
			}
			%>
			<li><a href="mypage"><i class="fas fa-bars"></i></a></li>
			<li>
				<a href="#" class="web" onclick="window.open('stopwatch', 'window', 'width=300, height=190, left=0, top=100, status=no, resizable=no');return false">
				<i class="fas fa-stopwatch"></i></a>
				<a href="mstopwatch" class="mobile"><i class="fas fa-stopwatch"></i></a>
			</li>
		</ul>
		<ul class="nav_icon">
			<li><i class="fab fa-twitter-square"></i></li>
			<li><i class="fab fa-facebook-square"></i></li>
		</ul>
		
		<a href="#" class="nav_toggle">
			<i class="fas fa-bars"></i>
		</a>
	</nav>
	
	<section class="sectionbar">

		<div class="main_box">
			<div class="tab_box">
				<div class="tap active" onclick="openTab(event, 'con1')"><a href="#">Tap 1</a></div>
				<div class="tap" onclick="openTab(event, 'con2')"><a href="#">Tap 2</a></div>
			</div>
			<div class="content_box">
				<div id="con1" class="content on"><p>Content 1, Tap 1의 내용</p></div>
				<div id="con2" class="content"><p>Content 2, Tap 2의 내용</p></div>
			</div>
	</section>
	
	<aside class="friendsbar">
		friends
		<input type="text" placeholder="search.." id="search_text" />
		<button id="search_button"><a><i class="fas fa-search"></i></a></button>
	</aside>
	
	<!-- footer에 공지사항, 챗봇 -->
	<footer class="footerbar">
		<div class="footer_box">
			<a href="notice?nowpage=1&cntPerpage=5"><i class="fas fa-chalkboard-teacher"></i></a>
			<a href="#"><i class="far fa-paper-plane"></i></a>
		</div>
	</footer>

</body>
</html>















