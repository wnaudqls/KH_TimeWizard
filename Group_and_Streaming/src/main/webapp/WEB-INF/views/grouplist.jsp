<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/grouplist.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 id="title">
그룹 리스트
</h1>
<hr>
	<table border="1">
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td>아무것도 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${list }">
					<%-- <tr>
						<th>번호</th>
						<td>${dto.chat_no }</td>
					</tr> --%>
					<tr>
						<th>방이름</th>	
						<td>${dto.chat_title }</td>
					</tr>
					<tr>
						<th>아이디</th>	
						<td>${dto.user_id }</td>
					</tr>
					<%-- <tr>
						<th>내용</th>
						<td>${dto.chat_content }</td>
					</tr> --%>
					<tr>
						<td colspan="2" align="right">
							<input type="button" value="접속하기" onclick="location.href='joinroom/${dto.chat_title }'">
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<input type="button" value="만들기" onclick="location.href='newroom'">
	<div id="searchArea">
		<input type="text" id="search" placeholder="아이디 , 방이름을 입력하십시오." /> 
		<input type="button" id="searchBtn" value="검색하기" />
	</div>
</body>
<script type="text/javascript">

</script>
</body>
</html>