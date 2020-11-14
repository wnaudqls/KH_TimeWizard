<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="/timewizard/css/personal_daily.css"> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="/timewizard/css/personal_daily_hui.css">
<script src="https://d3js.org/d3.v5.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<!-- <script type="text/javascript" src="/timewizard/resources/js/sharekakao.js"></script> -->
<script type="text/javascript" src="/timewizard/js/personal_daily.js"></script>
<script type="text/javascript" src="/timewizard/js/personal_daily-hashtag.js"></script>


</head>
<body>
<%
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
%>

<button class="snssharebtn" id="kakao-link-btn" onclick="dailyLink()">daily share</button>
<a id="download" download="tiwi_daily.JPG">
<button class="snssharebtn" onClick="download()">Download</button>
</a>

<a href="javascript:genScreenshot()">스샷</a>
<a id="test"></a>
<div id="text">
가나다라마바사아
ㄴㅁ아ㅣ럼;니
ㄴ미아ㅓㄹ;ㅁㅇ나ㅓㄹ;ㅣㅁ
</div>
<div id="box1"></div>


	<div id="daily__part" style="background:gray;">
		<div class="daily__area">
			<div class="date__area">
				<div class="date__status">
					<div class="date__change"><i class="fas fa-caret-square-left"></i></div>
					<div class="date__change"><i class="far fa-caret-square-left"></i></div>
					<div class="date date__month">월</div>
					<div class="date date__day">일</div>
					<div class="date__change"><i class="far fa-caret-square-right"></i></div>
					<div class="date__change"><i class="fas fa-caret-square-right"></i></div>
				</div>
			</div>
			<div class="contents__area">
				<div class="list__area">
					<div id="todo__list">date's todo-list
					</div>
				</div>
				<div class="heatmap__area">
					<div id="heatmap"></div>
					<div id="tooltip__area"></div>
				</div>
			</div>
		</div>
		<div class="modals__area">
		    <div class="modal__area"></div>
			<div class="modal__area"></div>
		</div>
	</div>
	<script type="text/javascript">
	let linkedUserNo = <%=linked.getUser_no()%>;
	const loginUserNo = <%=login.getUser_no()%>;

	
	window.addEventListener("DOMContentLoaded",()=>{
		// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('f78bdb18545b23a910d70eec2950b2b7');
	
		// SDK 초기화 여부를 판단합니다.
		console.log(Kakao.isInitialized());
	
		/* 직접 만든 버튼으로 메시지 보내기 - Daily */
		function dailyLink(){
			Kakao.Link.sendDefault({
		  objectType: 'feed',
		  content: {
		    title: 'Time Wizard Daily',
		    description: '당신의 히트맵입니다!',
		    imageUrl:
		      'https://cdn.pixabay.com/photo/2016/06/01/06/26/open-book-1428428_1280.jpg',
		    link: {
		      mobileWebUrl: 'https://developers.kakao.com',
		      androidExecParams: 'test',
		    },
		  },
		  buttons: [
		    {
		      title: '웹으로 이동',
		      link: {
		        mobileWebUrl: 'https://developers.kakao.com',
		      },
		    },
		    {
		      title: '앱으로 이동',
		      link: {
		        mobileWebUrl: 'https://developers.kakao.com',
		      },
		    },
		  ]
		});
		};
	
		/* html2canvas - div 영역이 아닌 전체화면 스크린샷 */
		let area = document.getElementById("con1");
		html2canvas($("#daily__part")[0]).then(function(canvas) {
			console.log(canvas);
			canvas.setAttribute("id", "mycanvas");
			canvas.setAttribute("style", "display:none");
			document.body.appendChild(canvas);
			download();
		});
	
		/* html2canvas - div 영역 스크린샷 */
		/*html2canvas(document.querySelector("#daily__part")).then(function(canvas) {
			canvas.setAttribute("id", "mycanvas");
			canvas.setAttribute("style", "display:none");
			document.body.appendChild(canvas);
			download();
		});*/
	
		/* 이미지 다운로드 */
		function download() {
			var image = document.getElementById("mycanvas")
								.toDataURL("image/png")
								.replace("image/png", "image/octet-stream");
			var download = document.getElementById("download")
									.setAttribute("href", image);
									
		};
		
	});
	
	function genScreenshot() {
		html2canvas(document.body, {
			onrendered: function(canvas) {
				$('#box1').html("");
				$('#box1').append(canvas);
				
				$('#test').attr('href', canvas.toDataURL("image/png"));
				$('#test').attr('download', 'Test file.png');
				$('#test')[0].click();
			}
		});
	}
	
	
	

	</script>
</body>
</html>