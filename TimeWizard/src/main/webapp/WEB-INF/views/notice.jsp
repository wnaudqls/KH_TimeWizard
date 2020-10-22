<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

</script>

</head>

<style>
	
	.notice_text {
		border-bottom: 1px solid black;
	}
	
	#paging_box {
		cursor: pointer;
		text-align: center;
	}

	#noticeBoard {
		width: 80%;
		margin-left: 10%;
	}
	
	#search_box {
		height: 30px;
		width: 290px;
		border: 1px solid black;
		margin-left: 41%;
	}
	
	#search_text {
		font-size: 16px;
		width: 225px;
		padding: 6px;
		border: 0px;
		outline: none;
		float: left;
	}
	
	#search_button {
		width: 52px;
		height: 100%;
		border: 0px;
		background: black;
		color: white;
		outline: none;
		float: left;
		cursor: pointer;
	}
	

</style>

<body>

	<h1>공지사항</h1>
	
	<br/><br/>
	
	<table id="noticeBoard">

		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<th colspan="4" class="notice_text">----------작성된 글이 없습니다----------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.myno }</td>
						<td>${dto.myname }</td>
						<td><a href="detail.do?myno=${dto.myno }">${dto.mytitle }</a></td>
						<td>${dto.mydate }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<tr>
			<td align="right">
				<input type="button" value="글 작성" onclick="location.href='insert.do'" />
			</td>
		</tr>
	</table>
	
	<br/><br/>
	
	<div id="search_box">
		<input type="text" placeholder="search.." id="search_text" />
		<button id="search_button">검색</button>
	</div>
	
	<br/>
	
	<!-- !페이징 부분! -->
	<div id="paging_box">
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





















