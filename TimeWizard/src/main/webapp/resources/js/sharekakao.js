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
    description: 'Time Wizard가 시간관리를 도와드립니다!',
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

$(function(){
$("#shot").on("click", function(){
// 캡쳐 라이브러리를 통해서 canvas 오브젝트를 받고 이미지 파일로 리턴한다.
html2canvas(document.querySelector("#daily__part")).then(canvas => {
saveAs(canvas.toDataURL('image/png'),"timewizard_daily.png");
});
});
function saveAs(uri, filename) {
// 캡쳐된 파일을 이미지 파일로 내보낸다.
var link = document.createElement('a');
if (typeof link.download === 'string') {
link.href = uri;
link.download = filename;
document.body.appendChild(link);
link.click();
document.body.removeChild(link);
} else {
window.open(uri);
}
}
});