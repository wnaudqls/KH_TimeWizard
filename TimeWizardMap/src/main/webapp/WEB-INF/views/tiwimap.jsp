<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">



</style>

</head>
<body>

	<section>
		<div id="map_header">
		<h2>Study Room Map</h2>
		</div>
		<div class="map_middle">
			<div id="map"></div> <!-- 지도영역 -->
			<div id="menu"> <!-- 검색 결과 출력 영역 -->
				<ul id="studyRoomList"></ul> <!-- 검색결과 목록 -->
				<div id="mapPaging"></div> <!-- 검색결과 페이징 -->
			</div>
		</div>
		<div id="map_footer">
		</div>
	</section>

</body>
</html>