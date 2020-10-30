<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>

<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap" rel="stylesheet">
<link href="resources/css/mypage.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="resources/js/mypage.js" defer></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>

<script type="text/javascript">

	const elImage = document.querySelector("#reviewImageFileOpenInput");
	elImage.addEventListener("change", (evt) => {
	  const image = evt.target.files[0];
	  if(!validImageType(image)) { 
	    console.warn("invalide image file type");
	    return;
	  }
	});
	
	function valideImageType(image) {
	  const result = ([ 'image/jpeg',
	                    'image/png',
	                    'image/jpg' ].indexOf(image.type) > -1);
	  return result;
	}
	
</script>

</head>
<body>
	
	<div class="mypagebox">
		<div class="mypagemenu" align="center">
			<div class="profile" onclick="">프로필 사진부분</div>
			
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="" size=20 readonly value="${login.user_id }"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="" size=20></td>
				</tr>
				<tr>
					<td>NAME</td>
					<td><input type="text" name="" size=20 readonly value="${login.user_name }"></td>
				</tr>
				<tr>
					<td>EMAIL</td>
					<td><input type="email" name="" size=20 value="${login.user_email }"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" class="submitbox" value="수정" onclick="" />
					</td>
				</tr>
			</table>
		</div>
	
		<div class="mypagemenu" align="center">
			<table>
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
					<td><a class="save"><i class="fas fa-save"></i></a></td>
				</tr>
				<tr>
					<td>날짜 및 시간</td>
					<td><a class="save"><i class="fas fa-save"></i></a></td>
				</tr>
			</table>
		</div>
		
		<div class="mypagemenu" align="center">
			<table>
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
	</div>


</body>
</html>