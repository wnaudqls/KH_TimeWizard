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
	/* input type=date를 넣을지 today 버튼을 넣을지? -> 그러면 달력 부분에 링크 걸어주면 보기 좋지 않을까? */
	Calendar cal = Calendar.getInstance();
	int today_year = cal.get(Calendar.YEAR);
	int today_month = cal.get(Calendar.MONTH) + 1;
	int today_day = cal.get(Calendar.DATE);
	String today = "" + today_year + (today_month<10 ? "0"+today_month : today_month) + (today_day<10 ? "0" + today_day : today_day);
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	int day = cal.get(Calendar.DATE);
	String date = "" + year + (month<10 ? "0"+month : month) + (day<10 ? "0" + day : day);
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
					<span class="mday"><%=day %> 일</span>
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
	let linkedUser = <%=linked.getUser_no()%>;
	const loginUser = <%=login.getUser_no()%>;
	window.addEventListener('DOMContentLoaded', () => {
		showDailyList(pagedate);
	});
	</script>
</body>
</html>