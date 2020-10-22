<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript">

	

</script>

</head>

<style>

	#stopwatch_box {
		width: 400px;
		height: 150px;
		border: 1px solid black;
	}
	
	#stopwatch_time {
		width: 200px;
		height: 50px;
	}
	
	#timer {
		font-size: 40px;
		text-align: center;
		margin-top: 20px;
	}
	
	#stopwatch_menu {
		width: 200px;
		text-align: center;
	}
	
	#stopwatch_menu a {
		text-decoration: none;
		font-size: 30px;
		cursor: pointer;
	}
	
	
</style>

<body>

	<h1>STOPWATCH</h1>
	
	<div id="stopwatch_box">
		<div id="stopwatch_time">
			<div id="timer" class="timer">00:00:00</div>
		</div>
		<div id="stopwatch_menu">
			<a><i class="fas fa-play-circle"></i></a>
			<a><i class="fas fa-pause-circle"></i></a>
			<a><i class="fas fa-stop-circle"></i></a>
		</div>
	</div>

</body>
</html>





















