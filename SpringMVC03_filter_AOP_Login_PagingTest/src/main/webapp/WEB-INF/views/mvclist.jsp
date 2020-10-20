<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>List..💥</h1>
	<table border="1">
	<col width="50">
	<col width="100">
	<col width="500">
	<col width="300">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<th colspan="4" align="center">------글이 없다!------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td align="center">${dto.myno }</td>
						<td align="center">${dto.myname }</td>
						<td align="center"><a href="detail.do?myno=${dto.myno }&nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage}">${dto.mytitle }</a></td>
						<td align="center">${dto.mydate }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<tr>
			<td colspan="4" align="right">
				<input type="button" value="글작성" onclick="location.href='insert.do?nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage}'">
			</td>
		</tr>
	</table>
	
	<div style="display:block; text-align: center;">
		<c:if test="${paging.startpage != 1}">
			<a href="list.do?nowpage=${paging.startpage-1}&cntPerpage=${paging.cntPerpage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="p">
			<!-- when은 choose안에 꼭 들어가 있어야 한다. choose안에 otherwise는 없어도 된다. -->
			<c:choose>
				<c:when test="${p == paging.nowpage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p != paging.nowpage}">
					<a href="list.do?nowpage=${p}&cntPerpage=${paging.cntPerpage}">${p}</a>
				</c:when>
			</c:choose>
		</c:forEach>
			<c:if test="${paging.endpage != paging.lastpage}">
				<a href="list.do?nowpage=${paging.endpage+1}&cntPerpage=${paging.cntPerpage}">&gt;</a>
			</c:if>
	</div>
	
</body>
</html>