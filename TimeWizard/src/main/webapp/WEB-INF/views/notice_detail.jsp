<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="resources/css/noticedetail.css" rel="stylesheet">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap.min.js"></script> -->
<script src="js/notice_reply.js"></script>

<script src="js/insertreply.js"></script>

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
	
	
<%--   <div id="comment_state">
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
						<td>${dto.notice_no }</td>
						<td>(작성자 ID)</td>
						<td></td>
						<td><a>X</a></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<br/>
	
	<form class="" method="post" action="/reply/replylist">
	<div id=comment>
		<div id="comment_box">
			<input type="text" placeholder="※욕설이나 비방 등 게시판 운영정책에 어긋나는 게시물 등록시 게시물 삭제 및 글쓰기 제한등의 불이익을 받을 수 있습니다."
			 id="comment_text" />
			<button id="comment_button"><a class="textOn">Comment</a><a class="imgOn"><i class="fas fa-check"></i></a></button>
		</div>
	</div> --%>
	</form>
		<div style="margin-top : 20px">
			<button type="button" class="btn btn-sm btn-primary" id="btnUpdate">수정</button>
			<button type="button" class="btn btn-sm btn-primary" id="btnDelete">삭제</button>
			<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
		</div>

		<!-- Reply Form {s} -->

		<form action="">
		|<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px"> 
			<form:form name="form" id="form" role="form" modelAttribute="replyDto" method="post">
			<form:hidden path="notice_no" id="notice_no"/>
				<div class="row">
					<div class="col-sm-10">
						<form:textarea path="reply_content" id="reply_content" class="form-control" rows="4" cols="70" placeholder="※욕설이나 비방 등 게시판 운영정책에 어긋나는 게시물 등록시 게시물 삭제 및 글쓰기 제한등의 불이익을 받을 수 있습니다."></form:textarea>
					</div>

					<div class="col-sm-2">

						<form:input path="user_no" class="form-control" id="user_no"></form:input>

						<button type="button" class="btn btn-sm btn-primary" id="insertReplyBtn" style="width: 100%; margin-top: 10px" align="right">댓글 저장 </button>

					</div>

				</div>

				</form:form>

			 </div>
			</form>
			

			<!-- Reply Form {e} -->

			

			<!-- Reply List {s}-->

			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">

				<h6 class="border-bottom pb-2 mb-0">Reply list</h6>

				<div id="replyList"></div>

			</div> 

			<!-- Reply List {e}-->

		</div>		

	</article>
	
</body>
</html>


















