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

</head>
<body>

	<h1>공지사항 작성</h1>
	
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
	</form>

</body>
</html>