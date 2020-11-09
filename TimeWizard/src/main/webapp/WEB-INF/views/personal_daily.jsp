<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/timewizard/css/personal_daily.css">
<script type="text/javascript" src="/timewizard/js/personal_daily.js"></script>
<script type="text/javascript" src="/timewizard/js/personal_daily-hashtag.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/timewizard/js/jquery.bpopup-0.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js"
	crossorigin="anonymous"></script>

</head>
<body>
<%
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
%>

	<div class="daily__part">
		<div class="list__area">
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
			<div id="todo__list">date's todo-list
			</div>
		</div>
		<div class="heatmap__area">
			<h5>heatmap area</h5>
		</div>
	</div>

	
	<!-- Element to pop up -->
	<div id="element_to_pop_up">
	    <a class="b-close"><i class="fas fa-times-circle"></i></a>
	    <div class="modal__area"></div>
		<div class="modal__area"></div>
	</div>

	<script type="text/javascript">
	let linkedUserNo = <%=linked.getUser_no()%>;
	const loginUserNo = <%=login.getUser_no()%>;
	
	// popup modal
	 $(function($) {
	        $(function() {
	            $('#todo__list').bind('click', function(e) {
	                e.preventDefault();
	                $('#element_to_pop_up').bPopup({
	                         옵션값 :'ex',
	                         speed:600,
	                         modalColor:'black'
	                });
	            });
	            
	         });
	     });
	
	</script>
</body>
</html>