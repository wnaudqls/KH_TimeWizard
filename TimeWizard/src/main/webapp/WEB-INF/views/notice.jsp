<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
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
	<div style="display:block; text-align: center;" id="searchpaging">
		<c:if test="${paging.startpage != 1}">
			<a href="notice?nowpage=${paging.startpage-1}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="p">
			<!-- when은 choose안에 꼭 들어가 있어야 한다. choose안에 otherwise는 없어도 된다. -->
			<c:choose>
				<c:when test="${p == paging.nowpage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p != paging.nowpage}">
					<a href="notice?nowpage=${p}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}">${p}</a>
				</c:when>
			</c:choose>
		</c:forEach>
			<c:if test="${paging.endpage != paging.lastpage}">
				<a href="notice?nowpage=${paging.endpage+1}&cntPerpage=${paging.cntPerpage}&searchType=${searchType }&search_text=${search_text}">&gt;</a>
			</c:if>
	</div>
	<!-- !페이징 부분! -->
	<div style="display:block; text-align: center;" id="paging">
		<c:if test="${paging.startpage != 1}">
			<a href="notice_list?nowpage=${paging.startpage-1}&cntPerpage=${paging.cntPerpage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="p">
			<!-- when은 choose안에 꼭 들어가 있어야 한다. choose안에 otherwise는 없어도 된다. -->
			<c:choose>
				<c:when test="${p == paging.nowpage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p != paging.nowpage}">
					<a href="notice_list?nowpage=${p}&cntPerpage=${paging.cntPerpage}">${p}</a>
				</c:when>
			</c:choose>
		</c:forEach>
			<c:if test="${paging.endpage != paging.lastpage}">
				<a href="notice_list?nowpage=${paging.endpage+1}&cntPerpage=${paging.cntPerpage}">&gt;</a>
			</c:if>
	</div>

</body>
</html>





















