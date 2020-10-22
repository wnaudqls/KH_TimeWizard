<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>방만들기</h1>
	<form class="form-signing" action="create.do" method= "post">
        <h2 class="form-signing-heading">새로운 채팅방 생성</h2>
        <label for="title" class="sr-only">채팅방 이름</label>
        <input type="text" id="user_id" class="form-control" placeholder="채팅방 이름을 입력해주세요" required autofocus>
        <br>
        <button class="btn btn-primary" type="submit">생성하기</button>
        <button class="btn btn-danger" onclick = "location.href='/'">돌아가기</button>
    </form>
</body>
</html>