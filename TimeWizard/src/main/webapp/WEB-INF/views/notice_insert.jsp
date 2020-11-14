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
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script src="/timewizard/summernote/js/summernote-lite.js"></script>
<script src="/timewizard/summernote/js/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/timewizard/summernote/css/summernote-lite.css">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script src="/timewizard/js/summernote.js"></script>
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

</body>
</html>