<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<meta charset="UTF-8">
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8" />
<title>채팅 서비스</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	
<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>

	<div class="container">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>방 이름</th>
					<th>입장버튼</th>
				</tr>
			</thead>

			<tbody>

				<tr>
					<c:choose>
						<c:when test="${empty rooms }">

							<Td>비어있습니다</Td>

						</c:when>
						<c:otherwise>
							<c:forEach var="room" items="${rooms }">
								<tr>
									<td>${room.name}</td>


									<%-- <td><a class="btn btn-primary"
										th:href="@{/timewizard/rooms/{id} (id = ${room.roomId})}"></a>
									</td> --%>

									<td>
									<a class="btn btn-primary" href="/timewizard/joinroom/${room.roomid }" >대충 버튼</a>
										
										</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
			</tbody>
		</table>
		<a class="btn btn-primary pull-right" href="/timewizard/new">새로
			만들기</a>
	</div>


</body>
</html>