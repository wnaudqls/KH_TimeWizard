<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<link href="resources/css/notice.css" rel="stylesheet">
<script src="resources/js/notice.js" defer></script>
<script>
	$(document).ready(function(){
		<c:if test="${search_text == null}">
			$("#searchpaging").css("display", "none");
			$("#paging").css("display", "block");
		</c:if>
		<c:if test="${search_text != null}">
			$("#searchpaging").css("display", "block");
			$("#paging").css("display", "none");
		</c:if>
	});
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<%
	UserInfoDto UDto = (UserInfoDto)session.getAttribute("login");
	System.out.println("user role in header : " + UDto.getUser_role());
%>


	<div class="top">
		<h1>공지사항</h1>
		<div class="home"><a href="main"><i class="fab fa-tumblr-square"></i></a></div>
	</div>
	
	<br/><br/>
	
	<table id="noticeBoard">
	<%
		//로그인 되어있고 ADMIN일 때만 보이게!
		if(UDto != null){
			if(UDto.getUser_role().equals("ADMIN")){
	%>
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
					<th colspan="4" class="notice_text">----------작성된 글이 없습니다----------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.notice_no }</td>
						<td><a href="./detail?notice_no=${dto.notice_no }&nowpage=${paging.nowpage }&cntPerpage=${paging.cntPerpage }">${dto.notice_title }</a></td>
						<td>${dto.notice_regdate }</td>
						<td class="trash" onclick="location.href='./delete?notice_no=${dto.notice_no }&nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage }'"><i class="fas fa-trash-alt"></i></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	<%
		} else {
	%>
		<colgroup>
			<col width="50" />
			<col width="300" />
			<col width="100" />
		</colgroup>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<th colspan="4" class="notice_text">----------작성된 글이 없습니다----------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.notice_no }</td>
						<td><a href="./detail?notice_no=${dto.notice_no }&nowpage=${paging.nowpage }&cntPerpage=${paging.cntPerpage }">${dto.notice_title }</a></td>
						<td>${dto.notice_regdate }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	<%
			}
		}
	%>	
		
		<%
			//로그인 되어있고 ADMIN일 때만 보이게!
			if(UDto != null){
				if(UDto.getUser_role().equals("ADMIN")){
		%>
			<tr>
				<th class="write" colspan="4" align="right">
					<i class="fas fa-edit" onclick="location.href='insert?&nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage }'"></i>
				</th>
			</tr>
		<%
			} else {
		%>
			<tr>
				<th class="write" colspan="4" align="right"></th>
			</tr>
		<%
				}
			}
		%>
	</table>
	
	<br/><br/>
	
	<!-- 글 검색 기능 -->
	<!-- title, content 검색 가능 -->
	<div id="search">
		<form action="notice" method="post">
			<select class="searchType" name="searchType">
				<option value="nt_title">제목</option>
				<option value="nt_content">내용</option>
			</select>
			<div id="search_box"> 
				<input type="text" placeholder="search.." id="search_text" class="search_text" name="search_text"/>
				<button type="submit" id="search_button" name="btnSearch"><a><i class="fas fa-search"></i></a></button>
			</div>
		</form>
	</div>

	<br/>
	
	<!-- search 후 페이징 -->
	<div class="pagingdesign">
		<nav aria-label="Page navigation">
			<ul style="display:block; text-align:center;" id="searchpaging" class="pagination">
				<li>
					<c:if test="${paging.startpage != 1}">
						<a href="notice?nowpage=${paging.startpage-1}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
					</c:if>
				</li>
				<li>
					<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="p">
						<!-- when은 choose안에 꼭 들어가 있어야 한다. choose안에 otherwise는 없어도 된다. -->
						<c:choose>
							<c:when test="${p == paging.nowpage}">
								<a href="notice?nowpage=${p}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}">${p}</a>
							</c:when>
							<c:when test="${p != paging.nowpage}">
								<a href="notice?nowpage=${p}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}">${p}</a>
							</c:when>
						</c:choose>
					</c:forEach>
				</li>
				<li>
					<c:if test="${paging.endpage != paging.lastpage}">
						<a href="notice?nowpage=${paging.endpage+1}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</c:if>
				</li>
			</ul>
		</nav>
	</div>
	
	<!-- !페이징 부분! -->
	<div class="pagingdesign">
		<nav aria-label="Page navigation">
			<ul style="display:block; text-align:center;" id="paging" class="pagination">
				<li>
					<c:if test="${paging.startpage != 1}">
						<a href="notice_list?nowpage=${paging.startpage-1}&cntPerpage=${paging.cntPerpage}" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</c:if>
				</li>
				<li>
					<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="p">
						<!-- when은 choose안에 꼭 들어가 있어야 한다. choose안에 otherwise는 없어도 된다. -->
						<c:choose>
							<c:when test="${p == paging.nowpage}">
								<a href="notice_list?nowpage=${p}&cntPerpage=${paging.cntPerpage}">${p}</a>
							</c:when>
							<c:when test="${p != paging.nowpage}">
								<a href="notice_list?nowpage=${p}&cntPerpage=${paging.cntPerpage}">${p}</a>
							</c:when>
						</c:choose>
					</c:forEach>
				</li>
				<li>
					<c:if test="${paging.endpage != paging.lastpage}">
						<a href="notice_list?nowpage=${paging.endpage+1}&cntPerpage=${paging.cntPerpage}" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</c:if>
				</li>
			</ul>
		</nav>
	</div>
	

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>



