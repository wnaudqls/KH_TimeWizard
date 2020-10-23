//현재 위치 정보를 허용했을 때
if (navigator.geolocation) {

	// GeoLocation을 이용해서 접속 위치를 얻기
	navigator.geolocation.getCurrentPosition(function getLocation(position) {

				var latitude = position.coords.latitude; // 위도
				var longitude = position.coords.longitude; // 경도
				
				// 마커를 담을 배열
				var markers = [];

				var mapContainer = document.getElementById('map'), // 맵 컨테이너

				mapOption = {
					center : new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표 : 위에서 얻은 현재 위치의 위도와 경도가 입력됨
					level : 4 // 지도의 확대 레벨
				};

				// 지도 생성
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 마우스 휠과 모바일 터치를 이용한 지도 확대/축소 금지
				map.setZoomable(false);

				// 지도에 확대/축소 컨트롤 생성
				var zoomControl = new kakao.maps.ZoomControl();

				// 지도의 우측에 확대/축소 컨트롤 추가
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
				
				/* 현재 위치 재 설정시작 */
				// 버튼 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위 재설정
				var points = new kakao.maps.LatLng(latitude, longitude)

				// 지도 재설정할 범위정보를 가진 LatLngBounds 객체를 생성
				var bounds = new kakao.maps.LatLngBounds();

				var marker = new kakao.maps.Marker({
					position : points
				});

				marker.setMap(map);
				bounds.extend(points);
				
				// 현재위치 재설정 버튼
				var current = document.createElement('button');
				var currentClick = document.createTextNode('현재위치 재설정');
				
				// 스터디룸 버튼
				var study = document.createElement('button');
				var studyClick = document.createTextNode('스터디룸');
				
				var mapHeader = document.getElementById('map_header');
				current.appendChild(currentClick);
				mapHeader.appendChild(current);
				study.appendChild(studyClick);
				mapHeader.appendChild(study);
				
				// 현재위치 재설정 버튼을 클릭했을 때 seBounds() 호출
				current.addEventListener('click', function() {
					setBounds();
				})

				function setBounds() {
					// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정
					map.setBounds(bounds);
				}
				/* 현재 위치 재 설정 끝 */
				
				// 스터디룸 버튼 클릭했을 때 뿌려진 JSON 데이터 출력
				study.addEventListener('click', function(){
					setStudyroom();
				})
				
				function setStudyroom(){
				
					var dt = [
						
						[37.536737, 126.882202,"<a href='http://www.beautifulstore.org'><div class='all'>🚞아름다운가게(목동)🚞</div></a>" ]
						
					]
					
					for (var i = 0; i < dt.length; i++) {
						
						//지도에 마커를 생성하고 표시한다.
						var marker = new kakao.maps.Marker({
							position : new kakao.maps.LatLng(dt[i][0], dt[i][1],dt[i][2],dt[i][3]), //마커의 좌표
							// 마커를 표시할 지도 객체
							map : map
						});
						// 인포윈도우를 생성합니다
						var infowindow = new kakao.maps.InfoWindow({
							content : dt[i][2]
						});
						// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
						infowindow.open(map, marker);
						
					}
				}

			});

} else { //현재 위치 서비스를 지원하지 않을 때 
	console.log("현재 위치 서비스를 지원하지 않는 브라우저입니다.");
}
