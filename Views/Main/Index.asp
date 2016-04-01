<div class="main_visual">
	<div class="mask_dot"></div>
	<div class="max_width_wrap">
		<div class="box_black">
			<h1>개방형 IoT 환경은 누구든지 서비스를 만들어내고<br>
			사용할 수 있는 개방형 서비스</h1>
		</div>
		<div class="box_white">
			<h3>Device <span><%=DevicesCount%></span>개 App <span><%=AppsCount%></span>개 OID <span><%=OidCount%></span>개</h3>
		</div>
	</div>
</div>

<div class="max_width_wrap">
	<div class="main_contents">
		
		<div class="products">
			<div class="tab">
				<a href="#Devices_tab" class="item active">Devices</a>
				<a href="#Apps_tab" class="item">Services</a>
				
				<a href="?controller=DevicesApps&action=DevicesList" class="more"><span class="blind">more</span></a>
				<a href="?controller=DevicesApps&action=AppsList" class="more" style="display:none;"><span class="blind">more</span></a>
				<!--div class="arrow">
					<a href="#" class="prev"><span class="blind">이전</span></a>
					<a href="#" class="next"><span class="blind">다음</span></a>
				</div-->
				
				<div id="tab_line" class="line"></div>
			</div>
			
			
			<div class="DevicesApps_list" id="Devices_tab">
				<div style="float:left;width:100%;height:1260px;overflow:hidden;">
					<%if Not( IsNothing(DevicesModel) ) then%>
					<ul>
						<%For each Devices in DevicesModel.Items
						'Images = Devices.Images1
						'Images = iif( IsNothing(Images) or Images="",Devices.Images2,Images )
						'Images = iif( IsNothing(Images) or Images="",Devices.Images3,Images )
						'Images = iif( IsNothing(Images) or Images="",Devices.Images4,Images )
						'Images = iif( IsNothing(Images) or Images="","/images/bg_no_image.png","/upload/Devices/"&Images )
						
						Images = Devices.ImagesList
						Images = iif( IsNothing(Images) or Images="","/images/bg_no_image.png","/upload/Devices/"&Images )
						%>
						<li>
							<div class="item">
							<a href="?controller=DevicesApps&action=DevicesDetail&No=<%=Devices.No%>">
								<div class="photo"><img class="trick"><img src="<%=Images%>"></div>
								<div class="label">
									<p>
										<b><%=Devices.Name%></b>
										<%=HtmlTagRemover(Devices.Contents1,50)%>
									</p>
								</div>
							</a>
							</div>
							
						</li>
						<%next%>
					</ul>
					<%else%>
					<div style="text-align:center;">등록된 Devices 가 없습니다.</div>
					<%end if%>
				</div>
			</div>
			
			<div class="DevicesApps_list" id="Apps_tab" style="display:none;">
				<div style="float:left;width:100%;height:1260px;overflow:hidden;">
					<%if Not( IsNothing(AppsModel) ) then%>
					<ul>
						<%For each Apps in AppsModel.Items
						'Images = Apps.Images1
						'Images = iif( IsNothing(Images) or Images="",Apps.Images2,Images )
						'Images = iif( IsNothing(Images) or Images="",Apps.Images3,Images )
						'Images = iif( IsNothing(Images) or Images="",Apps.Images4,Images )
						'Images = iif( IsNothing(Images) or Images="","/images/bg_no_image.png","/upload/Apps/"&Images )
						
						Images = Apps.ImagesList
						Images = iif( IsNothing(Images) or Images="","/images/bg_no_image.png","/upload/Apps/"&Images )
						%>
						<li>
							<div class="item">
							<a href="?controller=DevicesApps&action=AppsDetail&No=<%=Apps.No%>">
								<div class="photo"><img class="trick"><img src="<%=Images%>"></div>
								<div class="label">
									<p>
										<b><%=Apps.Name%></b>
										<%=HtmlTagRemover(Apps.Contents1,50)%>
									</p>
								</div>
							</a>
							</div>
							
						</li>
						<%next%>
					</ul>
					<%else%>
					<div style="text-align:center;">등록된 Apps 가 없습니다.</div>
					<%end if%>
				</div>
			</div>
			
		</div>
		
		
		
		<div class="board notice">
			<div class="title">
				<span>Notice</span>
				<a href="?controller=Community&action=List&Board=Notice" class="more"><span class="blind">more</span></a>
			</div>
			<ul>
				<%if Not( IsNothing(NoticeModel) ) then
					For each obj in NoticeModel.Items
				%>
				<li><a href="?controller=Community&action=List&Board=Notice&No=<%=obj.No%>"><%=obj.Title%></a></li>
				<%
					next
				else%>
				<li><a>등록된 내용이 없습니다.</a></li>
				<%end if%>
			</ul>
		</div>
		<div class="board news">
			<div class="title">
				<span>News</span>
				<a href="?controller=Community&action=List&Board=News" class="more"><span class="blind">more</span></a>
			</div>
			<ul>
				<%if Not( IsNothing(NewsModel) ) then
					For each obj in NewsModel.Items
				%>
				<li><a href="?controller=Community&action=Detail&Board=News&No=<%=obj.No%>"><%=obj.Title%></a></li>
				<%
					next
				else%>
				<li><a>등록된 내용이 없습니다.</a></li>
				<%end if%>
			</ul>
		</div>
		<div class="board forum">
			<div class="title">
				<span>Forum</span>
				<a href="?controller=Community&action=List&Board=Forum" class="more"><span class="blind">more</span></a>
			</div>
			<ul>
				<%if Not( IsNothing(ForumModel) ) then
					For each obj in ForumModel.Items
				%>
				<li><a href="?controller=Community&action=List&Board=Forum&No=<%=obj.No%>"><%=obj.Title%></a></li>
				<%
					next
				else%>
				<li><a>등록된 내용이 없습니다.</a></li>
				<%end if%>
			</ul>
		</div>
		
		<%if Not( IsNothing(AdBannerModel) ) then
			Image = iif( IsNothing(AdBannerModel.Image) or AdBannerModel.Image="","/images/bg_no_image.png","/upload/AdBanner/"&AdBannerModel.Image )
		%>
		<div class="ad"><img class="trick"><a href="<%=AdBannerModel.Url%>" target="_blank"><img src="<%=Image%>"></a></div>
		<%end if%>
		
		
		<div class="logos" id="slider1">
			<div class="title">
				<span>디바이스 식별자 발급 기업</span>
				<div class="arrow">
					<a href="#" class="prev"><span class="blind">이전</span></a>
					<a href="#" class="next"><span class="blind">다음</span></a>
				</div>
			</div>
			<div class="items">
				<%if Not( IsNothing(OidModel) ) then%>
				<ul id="sliderList1">
					<%For each Oid in OidModel.Items
					Images = iif( IsNothing(Oid.ImgLogo) or Oid.ImgLogo="","/images/bg_no_image.png","/upload/Oid/"&Oid.ImgLogo )
					%>
					<li>
						<div class="cover">
							<div class="img"><img class="trick"><img src="<%=Images%>"></div>
							<div class="logoName"><%=Oid.Name%></div>
						</div>
					</li>
					<%next%>
				</ul>
				<%end if%>
			</div>
		</div>
		
		<div class="logos" id="slider2">
			<div class="title">
				<span>관련 기관</span>
				<div class="arrow">
					<a href="#" class="prev" id="left"><span class="blind">이전</span></a>
					<a href="#" class="next" id="right"><span class="blind">다음</span></a>
				</div>
			</div>
			<div class="items">
				<%if Not( IsNothing(AgencieModel) ) then%>
				<ul id="sliderList2">
					<%For each Agencie in AgencieModel.Items
					Images = iif( IsNothing(Agencie.Images) or Agencie.Images="","/images/bg_no_image.png","/upload/Agencie/"&Agencie.Images )
					%>
					<li>
						<div class="cover">
							<div class="img"><a href="<%=iif(Agencie.Url="","javascript:;",Agencie.Url)%>" target="blank"><img class="trick"><img src="<%=Images%>"></a></div>
							<div class="logoName"><a href="<%=iif(Agencie.Url="","javascript:;",Agencie.Url)%>" target="blank"><%=Agencie.Name%></a></div>
						</div>
					</li>
					<%next%>
				</ul>
				<%end if%>
			</div>
		</div>
		
	</div>
</div>

<script type="text/javascript">
$(function(){
	var item_active = $('.products .tab a.active');
	$('.products .tab a.item').mouseover(function(){
		line_move( $(this) );
	});
	$('.products .tab a.item').mouseout(function(){
		line_move( item_active );
	});
	
	$('.products .tab a.item').click(function(e){
		e.preventDefault();
		$('.products .tab a.item').removeClass('active');
		$(this).addClass('active');
		
		var i = $(this).index();
		var m = $(this).parent().find('a.more');
		m.hide();
		m.filter(':eq('+i+')').show();
		
		var activeDiv = $($(this).attr('href'));
		$('.DevicesApps_list').hide();
		activeDiv.show();
		
		var item_active = $('.products .tab a.active');
		$('.products .tab a.item').mouseout(function(){
			line_move( item_active );
		});
	});
	
	var slider1_html = $('#slider1').html();
	var slider2_html = $('#slider2').html();
	
	slider_setting('slider1',"sliderList1",slider1_html);
	slider_setting('slider2',"sliderList2",slider2_html);
	
	$(window).resize(function(){
		slider_setting('slider1',"sliderList1",slider1_html);
		slider_setting('slider2',"sliderList2",slider2_html);
	});
	
	
	$('.DevicesApps_list ul li').hover( 
		function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1.3, ease:Quad.easeOut});
		},function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1, ease:Quad.easeOut});
	  }
	)
});

function slider_setting(containerID,slideID,htmls){
	$('#'+containerID).html(htmls);
	
	var itemCnt = $('#'+containerID).find('li').length;
	var limit= 5;
	
	if(window.innerWidth >= 1650 ){
		limit= 9;
	}else if( window.innerWidth >= 1326 && window.innerWidth < 1650 ){
		limit= 7;
	}
	
	if( itemCnt > limit ){
		fn_rollToEx(containerID,slideID,"",1,true);
	}else{
		$('#'+containerID).find('.prev').unbind().click(function(e){
			e.preventDefault();
			alert('첫 페이지입니다.');
		});
		$('#'+containerID).find('.next').unbind().click(function(e){
			e.preventDefault();
			alert('마지막 페이지입니다.');
		});
	}
}


/*
 * 상단 메뉴 active bar 모션
 */
function line_move(t){
	var t = t;
	var o = $("#tab_line");
	if( t.length <= 0 ){
		TweenMax.to(o, 0.25, {width:0, ease:Sine.easeOut});
		return false;
	}
	o.show();
	var w = t.width();
	var p = t.position().left;	
	TweenMax.to(o, 0.25, {width:w, x:p , ease:Sine.easeOut});
}

</script>