<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/3914a9940d.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="/timewizard/js/file_upload.js"></script>
</head>
<body>
<%
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
	int user_no = login.getUser_no();
%>
	<form:form action="file/upload" enctype="multipart/form-data" modelAttribute="FileUploadDto">
		<input type="file" name="file" accept="image/*" />
		<input type="hidden" name="user_no" value="<%=user_no%>" />
		<button type="button" value="send" onclick="uploadFile();">UPLOAD</button>
	</form:form>
	
	<div class="files__area"></div>
	
	<script type="text/javascript">
	let user_no = <%=user_no%>;
	window.addEventListener("DOMContentLoaded", ()=>{
		// selectList(user_no);
		selectOne(user_no);
	});
	</script>
</body>
</html>