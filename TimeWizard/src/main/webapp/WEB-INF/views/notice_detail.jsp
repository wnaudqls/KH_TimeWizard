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

	#title {
		border-bottom: 2px solid black;
		width: 80%;
		margin-left: 10%;
	}
	
	#content {
		border-bottom: 2px solid black;
		width: 80%;
		height: 300px;
		margin-left: 10%
	}
	
	#comment_state {
		width: 70%;
		margin-left: 15%;
		margin-bottom: 10px;
	}
	
	#comment_total {
		float: left;
	}
	
	#comment_toggle {
		float: right;
		cursor: pointer;
	}
	
	#commentlist_box {
		width: 70%;
		height: 150px;
		border: 1px solid black;
		margin-left: 15%;
	}
	
	#comment_box {
		width: 70%;
		height: 30px;
		border: 1px solid black;
		margin-left: 15%;
	}
	
	#comment_text {
		font-size: 16px;
		width: 85%;
		padding: 6px;
		border: 0px;
		outline: none;
		float: left;
	}
	
	#comment_button {
		width: 13%;
		height: 100%;
		border: 0px;
		background: black;
		color: white;
		outline: none;
		float: right;
		cursor: pointer;
	}

</style>

<body>
	
	<h1>공지사항</h1>
	
	<br/>
	
	<table id="title">
		<colgroup>
			<col width="500" />
			<col width="100" />
			<col width="200" />
			<col width="100" />
		</colgroup>
		<tr>
			<th>(공지사항 제목)</th>
			<th>(운영자)</th>
			<th>(작성일)</th>
			<th>(조회수)</th>
		</tr>
	</table>
	
	<div id="content">
		(내용)
	</div>
	
	<br/>
	
	<div id="comment_state">
		<div id="comment_total">전체 댓글 ()개</div>
		<div id="comment_toggle">댓글 창 닫기▲</div>
	</div>
	
	<br/>
	
	<table id="commentlist_box">
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<th colspan="4">----------작성된 댓글이 없습니다----------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.mycontent }</td>
						<td>${dto.myname }</td>
						<td>${dto.mydate }</td>
						<td><a>X</a></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<br/>
	
	<div id="comment_box">
		<input type="text" placeholder="※욕설이나 비방 등 게시판 운영정책에 어긋나는 게시물 등록시 게시물 삭제 및 글쓰기 제한등의 불이익을 받을 수 있습니다."
		 id="comment_text" />
		<button id="comment_button">등록</button>
	</div>
	
</body>
</html>
















