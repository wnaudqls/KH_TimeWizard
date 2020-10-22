<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class = "container">
    <table class = "table table-striped">
        <thead>
        <tr>
            <th>번호</th>
            <th>방 이름</th>
            <th>입장버튼</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td> ${room.roomId}</td>
            <td >${room.name}</td>
            <td>
                <a class = "btn btn-primary" th:href = "@{/rooms/{id} (id = ${room.roomId})}"></a>
            </td>
        </tr>
        </tbody>
    </table>
    <a class = "btn btn-primary pull-right" href = "/new">새로 만들기</a>
</div>

</body>
</html>