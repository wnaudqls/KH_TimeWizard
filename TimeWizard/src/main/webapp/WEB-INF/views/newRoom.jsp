<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 만들기</title>
</head>
<body>
<h1>방만들기</h1>
	<form action="createres" method= "post">
        <h2>새로운 채팅방 생성</h2>
       	 채팅방 이름<input type="text" name="chat_title" id="name" placeholder="채팅방 제목을 입력해주세요" required autofocus>
       	 <input type="hidden" name="user_id" id="name" placeholder="이름을 입력해주세요" value="${login.user_id }">
       	 접근 제한 <input type="text" name="chat_public" id="name" placeholder="공용or비공용" required autofocus>
       	 비밀번호<input type="text" name="chat_password" id="name" placeholder="비밀번호를 입력해주세요">
        <br>
        <button type="submit">생성하기</button>
        <button onclick="location.href='grouplist'">돌아가기</button>
    </form>
</body>
</html>