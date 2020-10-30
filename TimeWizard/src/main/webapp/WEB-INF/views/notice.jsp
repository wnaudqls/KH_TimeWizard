<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="resources/css/notice.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).on('click', '#search_button', function(e){
	var url="${pageContext.request.contextPath}/notice";
	url = url+"?searchType="+$('#searchType').val();
	url = url+"&keyword="+$('#search_text').val();
	url = url+"&nowpage="+${paging.nowpage}+"&cntPerpage="+${paging.cntPerpage};
	location.href=url;
	console.log(url);
	
});
</script>

</head>
<body>

	<h1>공지사항</h1>
	
	<br/><br/>
	
	<table id="noticeBoard">
		<colgroup>
			<col width="50" />
			<col width="300" />
			<col width="100" />
			<col width="50" />
		</colgroup>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th></th>
		</tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<th colspan="3" class="notice_text">----------작성된 글이 없습니다----------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<th>${dto.notice_no }</th>
						<th><a href="./detail?notice_no=${dto.notice_no }&nowpage=${paging.nowpage }&cntPerpage=${paging.cntPerpage }">${dto.notice_title }</a></th>
						<th>${dto.notice_regdate }</th>
						<th class="trash" onclick="location.href='./delete?notice_no=${dto.notice_no }&nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage }'"><i class="fas fa-trash-alt"></i></th>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<tr>
			<td class="write" colspan="4" align="right">
				<i class="fas fa-edit" onclick="location.href='insert?&nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage }'"></i>
			</td>
		</tr>
	</table>
	
	<br/><br/>
	
	<div id="search">
		<select name="searchType">
			<option value="nt_title" selected>제목</option>
			<option value="nt_content">내용</option>
		</select>
		<div id="search_box">
			<input type="text" placeholder="search.." id="search_text" />
			<button id="search_button" name="btnSearch"><a><i class="fas fa-search"></i></a></button>
		</div>
	</div>
	
	<br/>
	
	<!-- !페이징 부분! -->
	<div style="display:block; text-align: center;">
		<c:if test="${paging.startpage != 1}">
			<a href="notice?nowpage=${paging.startpage-1}&cntPerpage=${paging.cntPerpage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="p">
			<!-- when은 choose안에 꼭 들어가 있어야 한다. choose안에 otherwise는 없어도 된다. -->
			<c:choose>
				<c:when test="${p == paging.nowpage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p != paging.nowpage}">
					<a href="notice?nowpage=${p}&cntPerpage=${paging.cntPerpage}">${p}</a>
				</c:when>
			</c:choose>
		</c:forEach>
			<c:if test="${paging.endpage != paging.lastpage}">
				<a href="notice?nowpage=${paging.endpage+1}&cntPerpage=${paging.cntPerpage}">&gt;</a>
			</c:if>
	</div>

</body>
</html>





















