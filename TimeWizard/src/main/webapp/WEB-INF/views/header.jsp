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
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
	int user_no = login.getUser_no();
	String user_distinct = login.getUser_distinct();
	System.out.println("user role in header : " + login.getUser_role());
%>
	
	<nav class="navbar">
		<div class="nav_logo">
			<i class="fas fa-magic"></i>
			<a href="/timewizard/user/<%=user_distinct %>">TiWi</a>  <!-- 메인페이지로 -->
		</div>
		<ul class="nav_menu">
			<li><a href="/timewizard/user/<%=user_distinct %>"><i class="far fa-calendar-check"></i></a></li>
			<!-- Group메뉴 -->
			<li><a href="/timewizard/grouplist"><i class="fas fa-users"></i></a></li>
			<!-- Off-line 메뉴 -->
			<li><a href="/timewizard/tiwimap"><i class="fas fa-binoculars"></i></a></li>
			<!-- 알림 -->
			<li><a href="#"><i class="far fa-bell"></i></a></li>
		</ul>
		
		<ul class="nav_icon">
			<%
			//로그인 되어있고 ADMIN, USER일 때만 보이게!
			if(login.getUser_role().equals("ADMIN")){
			%>
					<li><a href="/timewizard/adminpage">${login.user_name }</a></li>
					<li><a href="/timewizard/logout">Logout</a></li>
			<%
			} else {
			%>
					<li><a href="/timewizard/mypage">${login.user_name }</a></li>
					<li><a href="/timewizard/logout">Logout</a></li>
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