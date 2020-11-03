<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
<title>글쓰기</title>

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
	}


@media screen and (max-width: 1140px) {
	
	body, html {
		margin: 0;
	}
	
	.spacetop {
		margin-bottom: 3rem;
	}
}

</style>

</head>
<body>
	
	<div class="writebox">
		<h2 style="text-align: center;">공지사항 작성</h2>
		
		<div style="width: 60%;" class="write">
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