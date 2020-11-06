<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="resources/js/summernote-lite.js"></script>
<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
<script src="resources/js/noticeinsert.js"></script>
<link href="resources/css/summernote-lite.css" rel="stylesheet" >
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<link href="resources/css/summernote/font/*" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

	<script>
	
		$(document).ready(function() {
			  $('#summernote').summernote({
		 	    	placeholder: 'content',
			        minHeight: 370,
			        maxHeight: null,
			        focus: true, 
			        lang : 'ko-KR'
			  });
			});
		
		
		
	</script>

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

	<%-- 	<h1>공지사항 작성</h1>
	
	<form action="./insertres" method="post">
		<input type="hidden" name="nowpage" value="${paging.nowpage }">
		<input type="hidden" name="cntPerpage" value="${paging.cntPerpage }">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="notice_title" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="notice_content" style="resize:none"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="button" value="취소" onclick="location.href='notice?nowpage=${paging.nowpage}&cntPerpage=${paging.cntPerpage}'" />
					<input type="submit" value="작성" />
				</td>
			</tr>
			
		</table>
	</form>
	
	<form method="post">
		<textarea id="summernote" name="editordata"></textarea>
	</form> --%>
	
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