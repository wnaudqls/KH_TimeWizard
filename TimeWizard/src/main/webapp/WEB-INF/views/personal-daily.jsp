<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div {
border: 1px;
}
</style>
</head>
<body>
	<h3>tab is here</h3>
	<h1>personal page</h1>
	<h5>list area</h5>
	<div class="list">
		<div>
			<div class="dateArea">
				<a>◀◀</a>
				<a>◁</a>
				<span class="month">${month }월 </span>
				<span class="mday">${date } 일</span>
				<a>▷</a>
				<a>▶▶</a>
			</div>
			<div class="inputDateArea">
				<input type="date" id="date">
			</div>
		</div>
		<div>date's todo-list
		
		</div>
	</div>
	<h5>heatmap area</h5>
	<div class="heatmap"></div>
	<script type="text/javascript">
	<!-- heatmap part -->
	<!-- 날짜를 클릭하면 불러오는 리스트 -->
	function dailylist(){
		const listxhr = new XMLHttpRequest();
		listxhr.open("POST", "daily/list")
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				let text = "";
				if (xhr.responseText != null || xhr.responseText != ""){
					text = JSON.parse(xhr.responseText);
				}
			} else {
				/* 로딩중 화면 */
			}
		}
	}
	<!-- 할일 목록을 클릭하면 불러옴 -->
	<!-- 등록 -->
	<!-- 수정 -->
	<!-- 삭제 confirm 띄우고서 삭제실행 -->
	</script>
</body>
</html>