<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			
			<form id="mForm" method="GET">
			<input type="hidden" name="Controller" value="<%=Controller%>">
			<input type="hidden" name="action" value="<%=action%>">
			
			<div class="DevicesApps_search">
				<div class="tab">
					
					<a href="?controller=DevicesApps&action=DevicesList" class="item <%=iif(action="DevicesList","active","")%>">Devices</a>
					<a href="?controller=DevicesApps&action=AppsList" class="item <%=iif(action="AppsList","active","")%>">Services</a>
					<div class="search">
						<div class="input_wrap">
							<input type="text" placeholder="SEARCH" id="Name" name="Name" value="<%=Request("Name")%>">
						</div>
						<button class="submit"><span class="blind">검색</span></button>
					</div>
					
					<div id="tab_line" class="line"></div>
				</div>
				
				<div class="other">
					<select id="MenuNo" name="MenuNo" style="width:320px;">
						<option value="">선택</option>
						<%if Not(IsNothing(MenuModel)) then
							For each MenuItem in MenuModel.Items
						%>
                    	<option value="<%=MenuItem.No%>" <%=iif(Request("MenuNo")=Cstr(MenuItem.No),"selected","")%>><%=MenuItem.Name%></option>
                    	<%
							Next
						end if%>
					</select>
					
					<button class="white" type="button" onclick="location.href='<%=ViewData("ActionRegiste")%>';">신규등록</button>
				</div>
			</div>
			
			</form>
			
			<div class="DevicesApps_list" id="DevicesApps_list">
				<%if Not( IsNothing(Model) ) then%>
				<ul>
					<%For each obj in Model.Items
						if action = "DevicesList" then
							ImagesPath = "/upload/Devices/"
						elseif action = "AppsList" then
							ImagesPath = "/upload/Apps/"
						end if
						'Images = obj.Images1
						'Images = iif( IsNothing(Images) or Images="",obj.Images2,Images )
						'Images = iif( IsNothing(Images) or Images="",obj.Images3,Images )
						'Images = iif( IsNothing(Images) or Images="",obj.Images4,Images )
						'Images = iif( IsNothing(Images) or Images="","/images/bg_no_image.png",ImagesPath & Images )
						
						Images = obj.ImagesList
						Images = iif( IsNothing(Images) or Images="","/images/bg_no_image.png",ImagesPath & Images )
					%>
					<li class="_player">
						<div class="item">
							<a href="<%=ViewData("ActionDetail")%>&No=<%=obj.No%>">
								<div class="photo"><img class="trick"><img src="<%=Images%>" ></div>
								<div class="label">
									<p>
										<b><%=obj.Name%></b>
										<%=HtmlTagRemover(obj.Contents1,50)%>
									</p>
								</div>
							</a>
						</div>
					</li>
					<%next%>
				</ul>
				<%else%>
				<div style="text-align:center;">등록된 내용이 없습니다.</div>
				<%end if%>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	var _player = $('#DevicesApps_list ul li._player');
	TweenMax.set( _player, { opacity: 0,y:+100 } );
	tweenMotion(_player);
	
	$(window).scroll(function(event){
		var scrollTop = $(this).scrollTop();
		var winhowHwight = $(window).height();
		if( scrollTop == 0 ){
			$('#DevicesApps_list ul li').addClass('_player');
			TweenMax.set( $('#DevicesApps_list ul li._player'), { opacity: 0,y:+100 } );
		}
	});
	
	$('#MenuNo').change(function(){
		$('#mForm').submit();
	});
	
	
	$('#DevicesApps_list ul li').hover( 
		function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1.3, ease:Quad.easeOut});
		},function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1, ease:Quad.easeOut});
	  }
	)
	
	var item_active = $('.DevicesApps_search a.active');
	line_move( item_active );
	$('.DevicesApps_search a.item').mouseover(function(){
		line_move( $(this) );
	});
	$('.DevicesApps_search a.item').mouseout(function(){
		line_move( item_active );
	});
});

function tweenMotion(o){
	var scrollTop = $(this).scrollTop();
	var winhowHwight = $(window).height();
	
	o.each(function(index){
		var offset = $(this).offset().top;
		if( offset < (winhowHwight+scrollTop) ){
			TweenMax.to($(this), 0.5, {y:0,opacity: 1, ease:Sine.easeOut});
			$(this).removeClass('_player');
		}
	});
	
	$(window).unbind().scroll(function(event){
		var scrollTop = $(this).scrollTop();
		var winhowHwight = $(window).height();

		
		
		o.each(function(){
			var offset = $(this).offset().top;
			if( offset < (winhowHwight+scrollTop) ){
				TweenMax.to($(this), 0.5, {y:0,opacity: 1, ease:Sine.easeOut});
				$(this).removeClass('_player');
			}
		});
	});
}


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