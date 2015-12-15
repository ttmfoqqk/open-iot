<style>
.DevicesApps_search .tab{border-left:1px solid #b7b7b7;}
.DevicesApps_search .tab a.item{border-top:1px solid #b7b7b7;}
.DevicesApps_search .other select{left:0px;}
.DevicesApps_search .other button{right:0px;}

.DevicesApps_list{width:100%;}
.DevicesApps_list ul li{width:50%;}
</style>

<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Devices & Apps 관리</h2>
			<div class="sub_title_description">Devices & Apps <b>상품 및 고객관리</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>Devices & Apps 관리</b></span>
			
			<div class="sub_description">
				
				
				<div class="DevicesApps_search">
					<div class="tab">
						<a href="#" class="item active">Devices</a>
						<a href="#" class="item">Apps</a>
					</div>
					<div class="other">
						<select>
							<option>선택</option>
							<option>선택</option>
							<option>선택</option>
							<option>선택</option>
						</select>
						
						<button class="white" style="font-size:16px;" onclick="call_pop_registe();">Device / App 등록</button>
					</div>
				</div>
				

				<div class="DevicesApps_list">
					<ul>
						<li>
							<div class="item pLeft">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
								<div class="cover">
									<div class="inner">
										<button class="white mini">Q&A 관리</button><br>
										<button class="white mini">FAQ 관리</button><br>
										<button class="white mini">상품상세</button><br>
										<button class="white mini">상품수정</button><br>
										<button class="white mini">상품삭제</button><br>
									</div>
								</div>
							</div>
							
						</li>
						<li>
							<div class="item pRight">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
								<div class="cover">
									<div class="inner">
										<button class="white mini">Q&A 관리</button><br>
										<button class="white mini">FAQ 관리</button><br>
										<button class="white mini">상품상세</button><br>
										<button class="white mini">상품수정</button><br>
										<button class="white mini">상품삭제</button><br>
									</div>
								</div>
							</div>
						</li>
						<li>
							<div class="item pLeft">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
								<div class="cover">
									<div class="inner">
										<button class="white mini">Q&A 관리</button><br>
										<button class="white mini">FAQ 관리</button><br>
										<button class="white mini">상품상세</button><br>
										<button class="white mini">상품수정</button><br>
										<button class="white mini">상품삭제</button><br>
									</div>
								</div>
							</div>
						</li>
						<li>
							<div class="item pRight">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
								<div class="cover">
									<div class="inner">
										<button class="white mini">Q&A 관리</button><br>
										<button class="white mini">FAQ 관리</button><br>
										<button class="white mini">상품상세</button><br>
										<button class="white mini">상품수정</button><br>
										<button class="white mini">상품삭제</button><br>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<a href="#" class="more">더보기</a>
				</div>
				

			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	/*
	* 상품 디테일 관리 레이어 
	*/
	$('.DevicesApps_list .item').hover(
		function(){
			$(this).find('.cover').show();
		},
		function(){
			$(this).find('.cover').hide();
		}
	);
});
</script>