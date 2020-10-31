// 버튼 클릭할 시 캡처한 내용 body에 붙이기
$('#saveImg').click((e) => {
	html2canvas(document.querySelector("#capture")).then(canvas => {
		document.body.appendChild(canvas)
	});
});

/* html2canvas - 흰 화면 그대로 저장 */
/*function download(){
	var download = document.getElementById("download");
	var image = document.getElementById("myCanvas").toDataURL("image/png")
	    .replace("image/png", "image/octet-stream");
	download.setAttribute("href", image);
	//download.setAttribute("download","archive.png");
}*/

/* html2canvas - div 영역이 아닌 전체화면 스크린샷 */
/*html2canvas(document.body).then(function(canvas) {
	canvas.setAttribute("id", "mycanvas");
	canvas.setAttribute("style", "display:none");
	document.body.appendChild(canvas);
	download();
});*/

/* html2canvas - div 영역 스크린샷 */
html2canvas(document.querySelector("#test")).then(function(canvas) {
	canvas.setAttribute("id", "mycanvas");
	canvas.setAttribute("style", "display:none");
	document.body.appendChild(canvas);
	download();
});

function download() {
	var image = document.getElementById("mycanvas")
						.toDataURL("image/png")
						.replace("image/png", "image/octet-stream");
	var download = document.getElementById("download")
							.setAttribute("href", image);
							
}