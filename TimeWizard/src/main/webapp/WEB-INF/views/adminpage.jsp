<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 로그아웃 후 뒤로가기 금지 -->
<% response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Cache-Control", "no-store"); 
	response.setDateHeader("Expires", 0L); 
%>
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
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="resources/css/adminpage.css">
<script src="resources/js/adminpage.js" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	
	<form action="admindelete" method="post">
	<div class="adminbox" id="userlist">
		<table>
		<colgroup>
			<col width="50"/>
			<col width="200"/>
			<col width="100"/>
			<col width="200"/>
			<col width="200"/>
			<col width="100"/>
			<col width="200"/>
			<col width="100"/>
			<col width="150"/>
			<col width="150"/>
		</colgroup>
				<tr>
					<td id="title" colspan="10">회원 목록 조회
				</tr>
				<tr>
					<td align="center">번    호</td>
					<td align="center">I   D</td>
					<td align="center">P   W</td>
					<td align="center">이     름</td>
					<td align="center">이 메 일</td>
					<td align="center">활 성 화</td>
					<td align="center">가입날짜</td>
					<td align="center">등     급</td>
					<td align="center">등급변경</td>
					<td align="center">강제탈퇴</td>
				</tr>
				<c:forEach var="dto" items="${list }">
				<tr>
					<td align="center">${dto.user_no }</td>
					<td align="center">${dto.user_id }</td>
					<td align="center">${dto.user_pw }</td>
					<td align="center">${dto.user_name }</td>
					<td align="center">${dto.user_email }</td>
					<td align="center">${dto.user_active }</td>
					<td align="center">${dto.user_regdate }</td>
					<td align="center">${dto.user_role }</td>
					<td align="center"><a href="adminrole?user_no=${dto.user_no }">등급변경</a></td>
					<c:choose>
						<c:when test="${dto.user_active eq 'N' }">
						<td align="center"><button type="button" name="disablebtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-value="${dto.user_no }" disabled="disabled">강제탈퇴</button></td>
						</c:when>
						<c:otherwise>
						<td align="center"><button type="button" name="disablebtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-value="${dto.user_no }">강제탈퇴</button></td>
						</c:otherwise>
					</c:choose>
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
	</form>
</body>
</html>