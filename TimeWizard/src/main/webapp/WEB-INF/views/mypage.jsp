<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>
</head>
<body>
	<h1>MyPage</h1>

	<div align="center">
		<a href="#">프로필 사진</a>
		<br>
		<br>
		<div>
			<input type="text" value="아이디" size=2 style="border: 0px; text-align:center ">
			<input type="text" name="" size=40 style="border-top: 0px; border-right: 0px; border-left: 0px"><br>
			<input type="text" value="비밀번호" size=4 style="border: 0px; text-align:center ">
			<input type="password" name="" size=40 style="border-top: 0px; border-right: 0px; border-left: 0px"><br>
			<input type="text" value="이름" size=2 style="border: 0px; text-align:center ">
			<input type="text" name="" size=40 style="border-top: 0px; border-right: 0px; border-left: 0px"><br>
			<input type="text" value="이메일" size=2 style="border: 0px; text-align:center ">
			<input type="email" name="" size=40 style="border-top: 0px; border-right: 0px; border-left: 0px">
		</div>
		<Br>
		<div style="margin-left: 300px">
			<input type="button" value="수정" onclick="location.href=''">
		</div>
	</div>
		<br> <br>
		<div>
			<h3>Timelapse</h3>
			<table border="1">
			<!-- 구현할때 사용하면 될듯!
				<c:choose>
					<c:when test="">
						<tr>
							<th>저장할 수 있는 timelapse가 없습니다.</th>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="" >
							<tr>
								<td>날짜 및 시간</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				-->
				<tr>
					<td>날짜 및 시간</td>
					<td><input type="button" value="저장"></td>
				</tr>
				<tr>
					<td>날짜 및 시간</td>
					<td><input type="button" value="저장"></td>
				</tr>
			</table>
		</div>
		
		<div>
			<h3>멤버쉽</h3>
			
			<table border="1">
				<tr>
					<td><h5>스트리밍 이용</h5></td>
					<td colspan="3" align="center">9,900원</td>
				</tr>
				<tr>
					<td align="center"><h5>timelapse</h5></td>
					<td align="center">1</td>
					<td align="center">5</td>
					<td align="center">10</td>
				</tr>
				<tr>
					<td>(남은 횟수)</td>
					<td>1000원</td>
					<td>5000원</td>
					<td>9000원</td>
				</tr>
			</table>
		</div>
		
		<div>
		
		</div>



</body>
</html>