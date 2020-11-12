<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&display=swap" rel="stylesheet">
<link href="resources/css/fullpageTemplate.css" rel="stylesheet">
<link href="resources/css/fullpage.css" rel="stylesheet" defer>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/2.6.6/jquery.fullPage.js" crossorigin="anonymous"></script>
<!-- <script src="resources/js/main.js"></script> -->
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>

</head>
<body>

	<div id="fullpage">
		<div class="section" id="p1">
			<div class="textbox">
				<span class="underline"><a>TIME WIZARD 1ST PLANNER</a></span>
			</div>
			<div class="bounce animated arrowbox">
				<a><i class="fas fa-arrow-alt-circle-down"></i></a>
			</div>
		</div>
		
		<div class="section" id="p2" style="background-image:url(resources/image/bg1.jpg)">
			<div class="start">
				<a class="title">플래너의 시작, TIWI와 함께</a>
				<a href="login/loginform" class="loginform">시작하러 가기</a>
			</div>
			<div class="middle">
				<a>하루의 시작 일주일의 스케줄 한달의 계획 모두 TIWI에서 도와드립니다</a>
			</div>
		</div>
		

		<div class="section" id="p3"">
			<div class="backimg" style="background-image:url(resources/image/bg2.jpg)"></div>
			<p class="p3title">
				TIWI STORY
			</p>
			<p class="p3main">
				Have you ever had a failure in what you planned?<br/>
				Or is it difficult to know what kind of plan should I approach the goals I have set?<br/>
				We thought. Magic to solve this problem!<br/>
				Time wizard presents effective plans to save and not waste your time.<br/>
				Start your perfect life with Time Wizard using the services and programs provided!
			</p>
			<div class="p3box">
				<a href="login/loginform" class="p3btn">
					GO TIWI
				</a>
			</div>
		</div>
		
		<div class="section" id="p4">
			<div class="minibeanbox">
				<div class="minibean"><a>박진희</a></div>
				<div class="minibean"><a>배민경</a></div>
				<div class="minibean"><a>김산희</a></div>
			</div>
			<div class="minibeanbox">
				<div class="minibean"><a>정형빈</a></div>
				<div class="minibean"><a>주명빈</a></div>
				<div class="minibean"><a>윤용민</a></div>
			</div>

		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	  
	  // fullpage customization
	  $('#fullpage').fullpage({
	    sectionSelector: '.section',
	    navigation: true,
	    slidesNavigation: true,
	    css3: true,
	    controlArrows: false    
	  });

	 /*  $("#btn").on("click", function(event){
	    var offset = $("#p2").offset();
	    $("html body").animate({scrollTop:offset.top}, 1000);

	  $('div').remove('#fp-nav');


	  });
	 */
	  $('#p2').hover(function() {
	    $('.arrowbox').removeClass('bounce animated');
	  });

	  $('#p1').hover(function() {
	    $('.arrowbox').addClass('bounce animated');
	  });


	});


</script>

<style>

:root {
    --text-color: #f0f4f5;
    --background-color: #263343;
	--accent-color: #ff6b6b;
	--color: #E0E0E0;
}

body {
}

a {
	text-decoration: none;
}

#p1 {
	background-color: var(--background-color);
	color: #E0E0E0;
	letter-spacing: 10px;
	font-size: 50px;
	font-family: 'Josefin Sans';
	text-align: center;
	display: flex;
}

.textbox {
	margin-top: 45vh;
}

.arrowbox {
	margin-top: 35vh;
}

.arrowbox a {
	cursor: pointer;
}

/*base code*/
.animated {
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
}
.animated.infinite {
  -webkit-animation-iteration-count: infinite;
  animation-iteration-count: infinite;
}
.animated.hinge {
  -webkit-animation-duration: 2s;
  animation-duration: 2s;
}
/*the animation definition*/
@-webkit-keyframes bounce {
  0%, 100%, 20%, 53%, 80% {
    -webkit-transition-timing-function: cubic-bezier(0.215, .61, .355, 1);
    transition-timing-function: cubic-bezier(0.215, .61, .355, 1);
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0)
  }
  40%,
  43% {
    -webkit-transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    -webkit-transform: translate3d(0, -30px, 0);
    transform: translate3d(0, -30px, 0)
  }
  70% {
    -webkit-transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    -webkit-transform: translate3d(0, -15px, 0);
    transform: translate3d(0, -15px, 0)
  }
  90% {
    -webkit-transform: translate3d(0, -4px, 0);
    transform: translate3d(0, -4px, 0)
  }
}
@keyframes bounce {
  0%, 100%, 20%, 53%, 80% {
    -webkit-transition-timing-function: cubic-bezier(0.215, .61, .355, 1);
    transition-timing-function: cubic-bezier(0.215, .61, .355, 1);
    -webkit-transform: translate3d(0, 0, 0);
    -ms-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0)
  }
  40%,
  43% {
    -webkit-transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    -webkit-transform: translate3d(0, -30px, 0);
    -ms-transform: translate3d(0, -30px, 0);
    transform: translate3d(0, -30px, 0)
  }
  70% {
    -webkit-transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    transition-timing-function: cubic-bezier(0.755, .050, .855, .060);
    -webkit-transform: translate3d(0, -15px, 0);
    -ms-transform: translate3d(0, -15px, 0);
    transform: translate3d(0, -15px, 0)
  }
  90% {
    -webkit-transform: translate3d(0, -4px, 0);
    -ms-transform: translate3d(0, -4px, 0);
    transform: translate3d(0, -4px, 0)
  }
}
.bounce {
  -webkit-animation-name: bounce;
  animation-name: bounce;
  -webkit-transform-origin: center bottom;
  -ms-transform-origin: center bottom;
  transform-origin: center bottom
}



.underline {
	position: relative;
	justify-content: center;
	align-items: center;
}

.underline:after {
	content: "";
	position: absolute;
	left: 0;
	bottom: -10px;
	width: 0px;
	height: 2px;
	margin: 5px 0 0;
	transition: all 0.2s ease-in-out;
	transition-duration: 1s;
	opacity: 0;

}

.underline:hover:after {
	width: 100%;
	opacity: 1;
	background-color: #ff6b6b;
}

#p2 {
	background-repeat: no-repeat;
	background-size: cover;
	color: #E0E0E0;
}

#p3 {
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	color: white;
}

#p4 {
	background-color: var(--background-color);
}

.backimg {
	position: fixed;
	width: 100%;
	height: 100vh;
	filter: brightness(50%);
	z-index: -999;
	background-repeat: no-repeat;
	background-size: cover;
}

.p3title {
	font-size: 50px;
	font-weight: bold;
	font-family: 'Josefin Sans';
	margin-top: 13rem;
	letter-spacing: 10px;
}


.p3title:after {
    content: "";
    display: flex;
    width: 10%;
	border-top: 3px solid var(--accent-color);
	margin: auto;
	margin-top: 2rem;
}

.p3main {
	color: #E0E0E0;
}

.p3box {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 2rem;
}

.p3btn {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 10%;
	height: 5vh;
	background-color: var(--accent-color);
	border-radius: 10px;
	color: white;
	cursor: pointer;
}

.start {
	display: flex;
	margin-left: 3rem;
}

.title {
	font-size: 30px;
	font-weight: bold;
}

.loginform {
	display: flex;
	border: 3px solid #0984e3;
	border-radius: 10px;
	width: 10%;
	margin-left: 3%;
	background-color: white;
	color: black;
	font-weight: bold;
	font-size: 20px;
	cursor: pointer;
	justify-content: center;
	align-items: center;
	transition: 0.4s;
}

.loginform:hover {
	background-color: #0984e3;
	color: #E0E0E0;
}

.middle {
	margin-top: 1vh;
	margin-left: 3rem;
}

.minibeanbox {
	display: flex;
	margin-left: 15%;
}

.minibean {
	border-radius: 10px;
	width: 25%;
	height: 40vh;
	margin: 1rem;
	background-color: white;
	cursor: pointer;

	text-align: center;

}

.minibean:hover {
	background-color: var(--accent-color);
	color: white;
}


@media screen and (max-width: 1140px) {
	#p1 {
		font-size: 18px;
	}

	.start {
		display: block;
		margin-left: 1rem;
	}

	.title {
		font-size: 24px;
	}

	.loginform {
		display: block;
		width: 40%;
		text-align: center;
		margin-top: 2vh;
	}

	.middle {
		margin-top: 20vh;
		margin-left: 1rem;
	}
		.minibeanbox {
		margin-left: 0;
	}

	.minibean {
		border: 1px solid black;
		height: 40vh;
	}


	.p3title {
		margin-top: 7rem;
		font-size: 34px;
	}

	.p3title:after {
		width: 30%;
	}

	.p3main {
		width: 90%;
		margin-left: 5%;
	}

	.p3btn {
		width: 30%;
		height: 7vh;
	}

}

/**
 * fullPage 2.6.6
 * https://github.com/alvarotrigo/fullPage.js
 * MIT licensed
 *
 * Copyright (C) 2013 alvarotrigo.com - A project by Alvaro Trigo
 */
html.fp-enabled,
.fp-enabled body {
    margin: 0;
    padding: 0;
    overflow:hidden;

    /*Avoid flicker on slides transitions for mobile phones #336 */
    -webkit-tap-highlight-color: rgba(0,0,0,0);
}
#superContainer {
    height: 100%;
    position: relative;

    /* Touch detection for Windows 8 */
    -ms-touch-action: none;

    /* IE 11 on Windows Phone 8.1*/
    touch-action: none;
}
.fp-section {
    position: relative;
    -webkit-box-sizing: border-box; /* Safari<=5 Android<=3 */
    -moz-box-sizing: border-box; /* <=28 */
    box-sizing: border-box;
}
.fp-slide {
    float: left;
}
.fp-slide, .fp-slidesContainer {
    height: 100%;
    display: block;
}
.fp-slides {
    z-index:1;
    height: 100%;
    overflow: hidden;
    position: relative;
    -webkit-transition: all 0.3s ease-out; /* Safari<=6 Android<=4.3 */
    transition: all 0.3s ease-out;
}
.fp-section.fp-table, .fp-slide.fp-table {
    display: table;
    table-layout:fixed;
    width: 100%;
}
.fp-tableCell {
    display: table-cell;
    vertical-align: middle;/* 글씨 가운데 정렬됨 */
    width: 100%;
    height: 100%;
}
.fp-slidesContainer {
    float: left;
    position: relative;
}
.fp-controlArrow {
    position: absolute;
    z-index: 4;
    top: 50%;
    cursor: pointer;
    width: 0;
    height: 0;
    border-style: solid;
    margin-top: -38px;
    -webkit-transform: translate3d(0,0,0);
    -ms-transform: translate3d(0,0,0);
    transform: translate3d(0,0,0);
}
.fp-controlArrow.fp-prev {
    left: 15px;
    width: 0;
    border-width: 38.5px 34px 38.5px 0;
    border-color: transparent #fff transparent transparent;
}
.fp-controlArrow.fp-next {
    right: 15px;
    border-width: 38.5px 0 38.5px 34px;
    border-color: transparent transparent transparent #fff;
}
.fp-scrollable {
    overflow: scroll;
}
.fp-notransition {
    -webkit-transition: none !important;
    transition: none !important;
}
#fp-nav {
    position: fixed;
    z-index: 100;
    margin-top: -32px;
    top: 50%;
    opacity: 1;
	-webkit-transform: translate3d(0,0,0);
	
}
#fp-nav.right {
	right: 17px;
}
#fp-nav.left {
    left: 17px;
}
.fp-slidesNav{
    position: absolute;
    z-index: 4;
    left: 50%;
    opacity: 1;
}
.fp-slidesNav.bottom {
    bottom: 17px;
}
.fp-slidesNav.top {
    top: 17px;
}
#fp-nav ul,
.fp-slidesNav ul {
  margin: 0;
  padding: 0;
}
#fp-nav ul li,
.fp-slidesNav ul li {
    display: block;
    width: 14px;
    height: 13px;
    margin: 7px;
    position:relative;
}
.fp-slidesNav ul li {
    display: inline-block;
}
#fp-nav ul li a,
.fp-slidesNav ul li a {
    display: block;
    position: relative;
    z-index: 1;
    width: 100%;
    height: 100%;
    cursor: pointer;
	text-decoration: none;
}
#fp-nav ul li a.active span,
.fp-slidesNav ul li a.active span,
#fp-nav ul li:hover a.active span,
.fp-slidesNav ul li:hover a.active span{
    height: 12px;
    width: 12px;
    margin: -6px 0 0 -6px;
    border-radius: 100%;
 }
#fp-nav ul li a span,
.fp-slidesNav ul li a span {
    border-radius: 50%;
    position: absolute;
    z-index: 1;
    height: 4px;
    width: 4px;
    border: 0;
    left: 50%;
    top: 50%;
    background-color: #E0E0E0;  /* 인디케이터 색깔 */
    margin: -2px 0 0 -2px;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -o-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;
}

#fp-nav ul li:hover a span,
.fp-slidesNav ul li:hover a span{
    width: 10px;
    height: 10px;
    margin: -5px 0px 0px -5px;
}
#fp-nav ul li .fp-tooltip {
    position: absolute;
    top: -2px;
    color: #fff;
    font-size: 14px;
    font-family: arial, helvetica, sans-serif;
    white-space: nowrap;
    max-width: 220px;
    overflow: hidden;
    display: block;
    opacity: 0;
    width: 0;
}
#fp-nav ul li:hover .fp-tooltip,
#fp-nav.fp-show-active a.active + .fp-tooltip {
    -webkit-transition: opacity 0.2s ease-in;
    transition: opacity 0.2s ease-in;
    width: auto;
    opacity: 1;
}
#fp-nav ul li .fp-tooltip.right {
    right: 20px;
}
#fp-nav ul li .fp-tooltip.left {
    left: 20px;
}

</style>

</html>