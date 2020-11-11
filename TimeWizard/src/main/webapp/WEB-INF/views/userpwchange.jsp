<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<link href="/timewizard/css/userpwchange.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="resources/css/userpwchange.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<section id="container">
			<form action="userpwchangeres" method="post">
			<input type="hidden" name="user_no" value="${dto.user_no}">
				<div class="pwchangebox">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="user_id" name="user_id" value="${dto.user_id }" readonly="readonly"/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="userPass">패스워드</label>
					<input class="form-control" type="password" id="user_pw" name="user_pw" />
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="user_name" name="user_name" value="${dto.user_name }" readonly="readonly"/>
				</div>
				<div class="pwchangebox">
					<button type="button" id="modalopen" data-toggle="modal" data-value="${dto.user_no }">암호 변경하기</button>
					<button type="button" onclick="location.href='mypage'">취소</button>
				</div>
			<div>
				<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
				</c:if>
			</div>
			
			<!-- Modal -->
			<div class="modal fade" id="modal" tabindex="-1" role="dialog"
					aria-labelledby="modalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title" id="modalLabel">회원 비밀번호 변경</h4>
							</div>
							<div class="modal-body">
								새 비밀번호 : <input type="text" id="newpw"><br/>
					        	새 비밀번호 확인 : <input type="text" id="newpwagain"><br/>
					        	비밀번호를 변경하시겠습니까?<br/>
					        	<input type="hidden" id="usernewpw" name="user_no">
			        		</div>
							<div class="modal-footer">
								<input id="disbtn" class="btn" type="submit" value="변경하기 " />
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
				
			</form>
		</section>
		
<script type="text/javascript">
document.getElementById("modalopen").onclick = function() {
    document.getElementById("modal").style.display="block";
}
</script>
		
		<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>