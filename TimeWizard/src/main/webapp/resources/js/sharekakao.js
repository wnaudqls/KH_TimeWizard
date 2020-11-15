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
html2canvas($("#daily__area")[0]).then(function(canvas) {
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