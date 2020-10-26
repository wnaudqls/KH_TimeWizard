<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="resources/css/noticedetail.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>

</head>
<body>
	
	<h1>공지사항</h1>
	
	<br/>
	
	<table id="title">
		<colgroup>
			<col width="500" />
			<col width="100" />
			<col width="200" />
			<col width="100" />
			<col width="50" />
		</colgroup>
		<tr>
			<th>${dto.notice_title }</th>
			<th>운영자 YM</th>
			<th>${dto.notice_regdate }</th>
			<th>(조회수)</th>
			<th class="update" onclick="location.href='update?notice_no=${dto.notice_no }'"><i class="fas fa-wrench"></i></th>
		</tr>
	</table>
	
	<div id="content">
		${dto.notice_content }
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
						<td></td>
						<td>(작성자 ID)</td>
						<td></td>
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
















