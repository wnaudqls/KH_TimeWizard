<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Electrolize&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript">

	var time = 0;
	var starFlag = true;
	$(document).ready(function(){
	  buttonEvt();
	});
	
	function init(){
	  document.getElementById("time").innerHTML = "00:00:00";
	}
	
	function buttonEvt(){
	  var hour = 0;
	  var min = 0;
	  var sec = 0;
	  var timer;
	
	  // start btn
		$("#startbtn").click(function(){
	
	    if(starFlag){
	      $(".fas").css("color","#FAED7D")
	      this.style.color = "#4C4C4C";
	      starFlag = false;
	
	      if(time == 0){
	          init();
	      }
	
	      timer = setInterval(function(){
	    	time++;
	
	        min = Math.floor(time/60);
	        hour = Math.floor(min/60);
	        sec = time%60;
	        min = min%60;
	
	
	
	        var th = hour;
	        var tm = min;
	        var ts = sec;
	        if(th<10){
	          th = "0" + hour;
	        }
	        if(tm < 10){
	          tm = "0" + min;
	        }
	        if(ts < 10){
	          ts = "0" + sec;
	        }
	
	        document.getElementById("time").innerHTML = th + ":" + tm + ":" + ts;
	    	}, 1000);
	    }
	
		});
	
	  // pause btn
	  $("#pausebtn").click(function(){
	    if(time != 0){
	        $(".fas").css("color","#FAED7D")
	        this.style.color = "#4C4C4C";
	        clearInterval(timer);
	        starFlag = true;
	    }
	  });
	
	  // stop btn
	  $("#stopbtn").click(function(){
	    if(time != 0){
	      $(".fas").css("color","#FAED7D")
	      this.style.color = "#4C4C4C";
	      clearInterval(timer);
	      starFlag = true;
	      time = 0;
	      init();
	    }
	
	  });
	}

</script>

</head>

<style>

	#stopwatch_box {
		width: 250px;
		height: 150px;
		border: 1px solid black;
	}
	
	#stopwatch_time {
		width: 250px;
		height: 50px;
	}
	
	#time {
		font-size: 40px;
		text-align: center;
		margin-top: 30px;
		font-family: 'Electrolize';
	}
	
	#stopwatch_menu {
		width: 250px;
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
			<div id="time" class="time">00:00:00</div>
		</div>
		<div id="stopwatch_menu">
			<a><i id="startbtn" class="fas fa-play-circle"></i></a>
			<a><i id="pausebtn" class="fas fa-pause-circle"></i></a>
			<a><i id="stopbtn" class="fas fa-stop-circle"></i></a>
		</div>
	</div>

</body>
</html>





















