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
	
	<%
	List<UserInfoDto> list = (List<UserInfoDto>)request.getAttribute("list");
	%>
	<div class="adminbox" id="userlist">
		<table border="0">
			<col width="100"/>
			<col width="100"/>
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
				</tr>
		<%
		if (list.size() == 0 ) {
		%>
				<tr>
					<td>-----회원 정보가 없습니다.-----</td>
				</tr>
		<%
		} else {
			for (UserInfoDto dto : list) {
		%>
				<tr>
					<td><%=dto.getUser_no() %></td>
					<td><%=dto.getUser_id() %></td>
					<td><%=dto.getUser_pw() %></td>
					<td><%=dto.getUser_name() %></td>
					<td><%=dto.getUser_email() %></td>
					<td><%=dto.getUser_active() %></td>
					<td><%=dto.getUser_role() %></td>
					<td><a href="adminrole" value="변경">${dto.getUser_id() }</a></td>
				</tr>
		<%
			}
		}
%>
		</table>

	<div class="admin_box" onclick="location.href='#'">
		<span>Block List</span>
	</div>
	</div>	

</body>
</html>