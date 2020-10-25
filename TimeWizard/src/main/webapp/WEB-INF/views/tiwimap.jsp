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
		<h2>Time Wizard Map</h2>
		</div>
	<div class="chart__wrap">
		<div class="map_wrap">
			<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden; color: black; border-radius: 30px;" ></div>
			<div id="menu_wrap" class="bg_white">
			    <div class="option">
			        <div>
			        	<form onsubmit="searchPlaces()">
			        	<input type="text" value="스터디룸" id="keyword" size="15"> 
			        	<button type="submit">Study Room</button>
			        	</form>
                    </div>
        	    </div>
            </div>
        </div>
    </div>
    </section>

	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=112d3ea1d6f9c231c512b356cb5c03ce"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=112d3ea1d6f9c231c512b356cb5c03ce&libraries=services"></script>

</body>
</html>