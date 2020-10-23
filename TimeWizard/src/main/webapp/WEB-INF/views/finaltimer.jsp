<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Electrolize&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	var Hcount = 0;
	var Mcount = 0;
	var Htime = 0;
	var Mtime = 0;
	var min = "";
	var sec = "";
	
	function hours() {
		var hourtime = 3600;
		Hcount++;
		Htime = Hcount*hourtime;
		
		console.log(Hcount);
		console.log(Htime);
		
		document.getElementById("timer_setting").innerHTML = "Time Limit : " + ((Htime/60)+(Mtime/60)) + "m";
		
	}
	
	function mins() {
		var mintime = 600;
		Mcount++;
		Mtime = Mcount*mintime;
		
		console.log(Mcount);
		console.log(Mtime);
		
		document.getElementById("timer_setting").innerHTML = "Time Limit : " + ((Htime/60)+(Mtime/60)) + "m";
		
	}
	
	function start() {
		var time = Htime+Mtime;
		var x = setInterval(function () {
			min = parseInt(time/60);
			sec = time%60;
			
			$('#timer_start').attr('disabled', true);
			$('#timer_hour').attr('disabled', true);
			$('#timer_min').attr('disabled', true);
			document.getElementById("timer").innerHTML = min + "m " + sec + "s";
			time--;
			
			if (time < 0) {
				alert("종료되었습니다")
				clearInterval(x);
				document.getElementById("timer").innerHTML = "타이머를 다시 맞춰주세요";
			}
		}, 1000);
		
		if (time == 0) {
			alert("시간을 설정하세요");
			clearInterval(x);
			document.getElementById("timer").innerHTML = "0m 0s";
		}
		
		// 타이머가 시작되면 "시작"을 "일시정지"로 바꿈
		// 일시정지 누르면 "시작"으로 바꿔야함
		// document.getElementById("timer_start").innerHTML = "RE";
		
		$(document).ready(function() {
	    	$("#timer_reset").click(function() {
	            clearInterval(x);
	            document.getElementById("timer").innerHTML = "0m 0s";
	            
	        });
	    })
	}
	
	function reset() {
		Hcount = 0;
		Mcount = 0;
		Htime = 0;
		Mtime = 0;
		document.getElementById("timer_setting").innerHTML = "Time Limit : 0m";
		$('#timer_start').attr('disabled', false);
		$('#timer_hour').attr('disabled', false);
		$('#timer_min').attr('disabled', false);
	}

</script>

</head>

<style>

	body {
		font-family: 'Electrolize';
	}
	
	#timer_box {
		width: 400px;
		border: 2px solid black;
		background-color: #273c75;
		color: white;
	}
	
	#timer {
		font-size: 40px;
		font-weight: bold;
		text-align: center;
		margin-top: 50px;
	}

	#timer_time {
		width: 400px;
		height: 100px;
	}
	
	#timer_limit {
		width: 400px;
		height: 25px;
	}
	
	#timer_setting {
		margin-left: 3%;
	}
	
	#timer_menu {
		width: 400px;
		height: 50px;
		background-color: #192a56;
	}
	
	.timer_button {
		width: 20%;
		margin-left: 3%;
		margin-top: 15px;
		cursor: pointer;
		background-color: #192a56;
		color: white;
		border: 2px solid white;
	}

</style>

<body>

	<h1>TIMER</h1>
	
	<div id="timer_box">
		<div id="timer_time">
			<div id="timer">0m 0s</div>
		</div>
		<div id="timer_limit">
			<div id="timer_setting">Time Limit :</div>
		</div>
		<div id="timer_menu">
			<button id="timer_hour" class="timer_button" onclick="hours()">+60m</button>
			<button id="timer_min" class="timer_button" onclick="mins()">+10m</button>
			<button id="timer_start" class="timer_button" onclick="start()">START</button>
			<button id="timer_reset" class="timer_button" onclick="reset()">RESET</button>
		</div>
	</div>
	
</body>
</html>
















