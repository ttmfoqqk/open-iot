<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Facility</h2>
			<div class="sub_title_description">오픈IoT의 <b>오픈랩 시설안내</b></div>
			<span class="sub_navigation">IoT OpenLab <span class="bar">></span> <b>Facility</b></span>
			
			<div class="sub_description">
				
				<div class="facility_tab">
					<a href="#" class="item active">판교</a>
					<a href="#" class="item">송도</a>
					<a href="#" class="reservation">예약현황</a>
				</div>
				
				
				<!-- * Daum 지도 - 지도퍼가기 -->
				<!-- 1. 지도 노드 -->
				<div id="daumRoughmapContainer1448443470157" class="root_daum_roughmap root_daum_roughmap_landing" style="height:350px;margin-bottom:50px;"></div>
				<!--
					2. 설치 스크립트
					* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
				-->
				<script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script>
				<!-- 3. 실행 스크립트 -->
				<script charset="UTF-8">
					var map_w = $('#daumRoughmapContainer1448443470157').width();
					new daum.roughmap.Lander({
						"timestamp" : "1448443470157",
						"key" : "6xut",
						"mapWidth" : map_w,
						"mapHeight" : "350"
					}).render();
				</script>
				
				
				<h2 class="sub_caption"><label></label>운영안내</h2>
				<ul class="blue_dot">
					<li>운영시간 : 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00)</li>
					<li>운 영 일 : 매주 월요일 ~ 금요일</li>
					<li>휴 무 일 : 토/일요일 및 법정 공휴일</li>
				</ul>
				
				<br><br>
								
				<h2 class="sub_caption"><label></label>시설안내</h2>
				<ul class="facility_photo">
					<li>
						<div class="item pLeft">
							<div class="photo"><img src="images/sample_img_01_02_01.jpg" ></div>
							<div class="label">Technology, Design, Business</div>
						</div>
					</li>
					<li>
						<div class="item pRight">
							<div class="photo"><img src="images/sample_img_01_02_02.jpg" ></div>
							<div class="label">Craft Space(작업공간)</div>
						</div>
					</li>
					
					<li>
						<div class="item pLeft">
							<div class="photo"><img src="images/sample_img_01_02_03.jpg" ></div>
							<div class="label">Device Boot Camp(교육실)</div>
						</div>
					</li>
					<li>
						<div class="item pRight">
							<div class="photo"><img src="images/sample_img_01_02_04.jpg" ></div>
							<div class="label">Idea Factory(회의실)</div>
						</div>
					</li>
					
					<li>
						<div class="item pLeft">
							<div class="photo"><img src="images/sample_img_01_02_05.jpg" ></div>
							<div class="label">Connecting the dots(네트워크 공간)</div>
						</div>
					</li>
					<li>
						<div class="item pRight">
							<div class="photo"><img src="images/sample_img_01_02_06.jpg" ></div>
							<div class="label">다용도 공간</div>
						</div>
					</li>
				</ul>
				

			</div>
			
		</div>
	</div>
</div>