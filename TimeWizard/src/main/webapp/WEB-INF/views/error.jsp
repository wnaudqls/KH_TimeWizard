<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/3914a9940d.js" crossorigin="anonymous"></script>
</head>
<body>
	
	<h1><i class="fas fa-exclamation-triangle"></i></h1>
	<p>${message }</p>
	<script type="text/javascript">
		window.addEventListener('DOMContentLoaded', () => {
			window.setTimeout(showMessage(), 2500);
			window.setTimeout(goToIndex, 5000);
		});
		function showMessage(){
			let message = document.createElement("p");
			message.setAttribute("style","color:slateblue");
			message.textContent = "잠시 후 인덱스 화면으로 이동합니다...";
			document.querySelector("p").appendChild(message);
		}
		function goToIndex(){
			location.href="http://localhost:8787/timewizard";
		}
	</script>
</body>
</html>