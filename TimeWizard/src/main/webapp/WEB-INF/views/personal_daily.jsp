<%@page import="com.minibean.timewizard.utils.personal.PersonalDailyCalendar"%>
<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/timewizard/css/personal_daily.css">
</head>
<body>
<%
	PersonalDailyCalendar dailyCalendar = new PersonalDailyCalendar();
	String month = dailyCalendar.getMonth();
	String day = dailyCalendar.getDay();
	String date = dailyCalendar.toString();
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
%>

	<div class="daily__part">
		<div class="list__area">
			<div class="date__area">
				<div class="date__status">
					<a><i class="fas fa-caret-square-left"></i></a>
					<a><i class="far fa-caret-square-left"></i></a>
					<span class="month"><%=month %>월 </span>
					<span class="day"><%=day %> 일</span>
					<a><i class="far fa-caret-square-right"></i></a>
					<a><i class="fas fa-caret-square-right"></i></a>
				</div>
				<div class="date__input"><!-- 빨리 찾기 기능...? -->
					<input type="date" id="date" value="${today }" />
				</div>
			</div>
			<div id="todo__list">date's todo-list
			</div>
		</div>
		<div class="heatmap__area">
			<h5>heatmap area</h5>
		</div>
	</div>
	<div class="modal__area"></div>
	<div class="modal__area"></div>
	

	<script type="text/javascript" src="/timewizard/js/personal_daily.js"></script>
	<script type="text/javascript" src="/timewizard/js/personal_daily-hashtag.js"></script>
	<script type="text/javascript">
	let pagedate = <%=date%>;
	let linkedUserNo = <%=linked.getUser_no()%>;
	const loginUserNo = <%=login.getUser_no()%>;
	window.addEventListener('DOMContentLoaded', () => {
		showDailyList(pagedate);
	});
	</script>
</body>
</html>