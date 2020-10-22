<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Time Wizard Map</title>
<link rel="stylesheet" type="text/css" href="resources/css/tiwimap.css">
<script src="resources/js/tiwimap.js" defer></script>
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
				<div id="pagination"></div> <!-- 검색결과 페이징 -->
			</div>
		</div>
		<div id="map_footer">
		</div>
	</section>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=112d3ea1d6f9c231c512b356cb5c03ce"></script>
	<script>
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 3
			};
	
			var map = new kakao.maps.Map(container, options);
	</script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=112d3ea1d6f9c231c512b356cb5c03ce&libraries=services"></script>

</body>
</html>