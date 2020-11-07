<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 만들기</title>

<link href="/timewizard/css/newroom.css" rel="stylesheet">>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">

</head>
<body>

<!-- 
int group_no;
	int group_su;
	int group_client;
	String user_id;
	String group_title;
	String group_content;
	String group_public;
	Date group_regdate;
	String group_hashtag;

	String group_pw;
	String group_anyone;

 -->


	<form action="createres" method= "post">
			<div id="box" class="createbox">
				<div class="createtitle">채팅방 이름</div>
	       		<input type="text" name="group_title" id="name" placeholder="채팅방 제목을 입력해주세요" required autofocus>
	       	</div>
	       	
	       	 	<input type="hidden" name="user_id" id="name" placeholder="이름을 입력해주세요" value="${login.user_id }">
	       	
	       	<div class="createbox">
	       		<div class="createtitle">접근제한 설정</div>
	       		<input type="text" name="group_public" id="name" placeholder="공개or비공개" required autofocus>
	       	</div>
	       	<div class="createbox">
	       		<div class="createtitle">내용</div>
		       	<input type="text" name="group_content" id="name" placeholder="내용">
	       	</div>
	       	<div class="createbox">
	       		<div class="createtitle">비밀번호</div>
		       	<input type="text" name="group_pw" id="name" placeholder="비밀번호를 입력해주세요">
	       	</div>
	       <div class="createbox">
	       		<div class="createtitle">인원수</div>
		       	<input type="number" name="group_su" id="name" placeholder="인원수">
	       	</div>
	       	
	        <div class="createbox">
		        <button type="submit">생성하기</button>
		        <button onclick="location.href='grouplist'">돌아가기</button>
		    </div>
    </form>

</body>
</html>