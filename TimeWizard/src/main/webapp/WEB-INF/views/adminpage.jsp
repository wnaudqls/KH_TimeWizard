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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/adminpage.css">
<script src="resources/js/adminpage.js" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div class="adminbox">
		<h1>관리자 페이지</h1>
		<a href="main?user_no=${login.user_no }">돌아가기</a>
	</div>
	
	<form action="admindelete" method="post">
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
					<td><a href="adminrole?user_no=${dto.user_no }">등급변경</a></td>
					<td><button type="button" name="disablebtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-value="${dto.user_no }">강제탈퇴</button></td>
				</tr>
				</c:forEach>
		</table>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">회원 강제탈퇴</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		        </div>
		        <div class="modal-body">
		        	회원 아이디를 비활성화 하겠습니까?
		        	<input type="hidden" id="userdelete" name="user_no">
		        </div>
		      <div class="modal-footer">
		      	<input id="disbtn" class="btn" type="submit" value="비활성화 " />
		       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>