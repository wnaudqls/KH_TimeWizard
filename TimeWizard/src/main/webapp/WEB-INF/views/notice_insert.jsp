<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 로그아웃 후 뒤로가기 금지 -->
<% response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Cache-Control", "no-store"); 
	response.setDateHeader("Expires", 0L); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
	<style>
		h2 {
			margin-top: 5rem;
		}
		form {
			margin-top: 3rem;
		}
		.spacebottom {
			margin-bottom: 2rem;
		}
		.spacetop {
			margin-top: 3rem;
		}
		.write {
			 margin: auto;
			 width: 60%;
		}
	
	
	@media screen and (max-width: 1140px) {
		body, html {
			margin: 0;
		}
		.write {
			width: 90%;
		}
		.spacetop {
			margin-bottom: 3rem;
		}
	}
	
	</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<div class="writebox">
		<h2 style="text-align: center;">공지사항 작성</h2>
		
		<div class="write">
			<form method="post" action="./insertres">
				<input type="hidden" name="nowpage" value="${paging.nowpage }">
				<input type="hidden" name="cntPerpage" value="${paging.cntPerpage }">
				<input type="text" name="notice_title" style="width: 100%;" placeholder="제목" class="spacebottom"/>
				<textarea id="summernote" name="notice_content"></textarea>
				<input type="submit" value="글 작성" style="float: right;" class="spacetop" />
			</form>
		</div>
	</div>
<script src="/timewizard/js/summernote.js"></script>
</body>
</html>