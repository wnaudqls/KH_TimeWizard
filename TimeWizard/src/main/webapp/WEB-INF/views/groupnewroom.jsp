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



	<form action="createres" method= "post">
			<div id="box" class="createbox">
				<div class="createtitle">채팅방 이름</div>
	       		<input type="text" name="group_title" id="name" placeholder="채팅방 제목을 입력해주세요" required autofocus>
	       	</div>
	       	
	       	 	<input type="hidden" name="user_id" id="name" placeholder="이름을 입력해주세요" value="${login.user_id }">
	       	
	       	<div class="createbox">
	       		<div class="createpublic">접근제한 설정</div>
	       		<!-- <input type="radio" name="group_public" id="name" value="공개">
	       		공개
	       		<input type="radio" name="group_public" id="name" value="비공개">
	       		비공개 -->
	       		<select name="group_public">
	       			<option value="공개">공개</option>
	       			<option value="비공개">비공개</option>
	       		</select>
	       	</div>
	       	<div class="createbox">
	       		<div class="createtitle">내용</div>
		       	<input type="text" name="group_content" id="name" placeholder="내용을 입력해주세요">
	       	</div>
	       	<div class="createbox">
	       		<div class="createtitle">비밀번호</div>
		       	<input type="text" name="group_pw" id="name" placeholder="비밀번호를 입력해주세요(최대 10자)" maxlength="10">
	       	</div>
	       <div class="createbox">
	       		<div class="createtitle">인원수</div>
		       	<input type="number" name="group_su" id="name" placeholder="인원수" min="1" max="10" value="1">
	       	</div>
	       	
	        <div class="createbox">
		        <button type="submit">생성하기</button>
		        <button onclick="location.href='grouplist'">돌아가기</button>
		    </div>
    </form>

</body>
</html>