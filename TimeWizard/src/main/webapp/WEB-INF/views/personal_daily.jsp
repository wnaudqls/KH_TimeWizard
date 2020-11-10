<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="/timewizard/css/personal_daily.css"> -->
<link rel="stylesheet" href="/timewizard/css/personal_daily_hui.css">
<script type="text/javascript" src="/timewizard/js/personal_daily.js"></script>
<script type="text/javascript" src="/timewizard/js/personal_daily-hashtag.js"></script>


</head>
<body>
<%
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
%>
	<div id="daily__part">
		<div class="daily__area">
			<div class="date__area">
				<div class="date__status">
					<div class="date__change"><i class="fas fa-caret-square-left"></i></div>
					<div class="date__change"><i class="far fa-caret-square-left"></i></div>
					<div class="date date__month">월</div>
					<div class="date date__day">일</div>
					<div class="date__change"><i class="far fa-caret-square-right"></i></div>
					<div class="date__change"><i class="fas fa-caret-square-right"></i></div>
				</div>
			</div>
			<div class="contents__area">
				<div class="list__area">
					<div id="todo__list">date's todo-list
					</div>
				</div>
				<div class="heatmap__area">
					<h5>heatmap area</h5>
					<div class="heatmap"></div>
				</div>
			</div>
		</div>
		<div class="modals__area">
		    <div class="modal__area"></div>
			<div class="modal__area"></div>
		</div>
	</div>
	<script type="text/javascript">
	let linkedUserNo = <%=linked.getUser_no()%>;
	const loginUserNo = <%=login.getUser_no()%>;

	</script>
</body>
</html>