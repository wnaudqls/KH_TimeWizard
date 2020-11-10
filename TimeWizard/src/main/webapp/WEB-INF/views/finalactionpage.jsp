<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/timewizard/js/tap.js" defer></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<section class="sectionbar">
		<div class="main_box">
			<div class="tab_box">
				<div class="tap active" onclick="openTab(event, 'con1')">
					<a href="#">daily</a>
				</div>
				<div class="tap" onclick="openTab(event, 'con2')">
					<a href="#">weekly & monthly</a>
				</div>
			</div>
			<div class="content_box">

				<div id="con1" class="content on">
					<jsp:include page="/WEB-INF/views/personal_daily.jsp" flush="true"></jsp:include>
				</div>
				<div id="con2" class="content">
					<jsp:include page="/WEB-INF/views/personal_weekmonth.jsp" flush="true"></jsp:include>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="friendlist.jsp"></jsp:include>
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>










