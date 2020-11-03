<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script src="http://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/adminpage.css">
<script src="resources/js/adminpage.js" defer></script>
</head>
<body>

	<div class="adminbox">
		<h1>관리자 페이지</h1>
	</div>

	<div class="adminbox" id="userlist">
		<table border="1">
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
				<tr>
					<td id="title" colspan="10">회원 목록 조회
				</tr>
				<tr>
					<td>번    호</td>
					<td>I   D</td>
					<td>P   W</td>
					<td>이     름</td>
					<td>이 메 일</td>
					<td>활 성 화</td>
					<td>가입날짜</td>
					<td>등     급</td>
					<td>등급변경</td>
					<td>강제탈퇴</td>
				</tr>
				<c:forEach var="dto" items="${list }">
				<tr>
					<td>${dto.user_no }</td>
					<td>${dto.user_id }</td>
					<td>${dto.user_pw }</td>
					<td>${dto.user_name }</td>
					<td>${dto.user_email }</td>
					<td>${dto.user_active }</td>
					<td>${dto.user_regdate }</td>
					<td>${dto.user_role }</td>
					<!-- 아래 부분 수정해서 버튼 누를 때
					로그인한 관리자의 data가 아니라
					클릭되는 유저의 data를 가져가야 함 -->
					<td><a href="adminrole?${dto.user_no}">등급변경</a></td>
					<td><a href="admindelete?${dto.user_no}">강제탈퇴</a></td>
				</tr>
				</c:forEach>
		</table>

	<div class="admin_box" onclick="location.href='#'">
		<span>Block List</span>
	</div>
	</div>	

</body>
</html>