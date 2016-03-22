<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue"><%=ViewData("PageTitle")%></h2>
			<div class="sub_title_description"><%=ViewData("PageSubTitle")%></div>
			<span class="sub_navigation">Community <span class="bar">></span> <b><%=ViewData("PageName")%></b></span>
			
			<div class="sub_description">
				<form method="get">
				<input type="hidden" name="controller" value="<%=controller%>">
				<input type="hidden" name="action" value="<%=action%>">
				<input type="hidden" name="Board" value="<%=Board%>">
					<div class="bbs_search">
						<div class="input_wrap">
							<input type="text" id="Title" name="Title" value="<%=Request("Title")%>" placeholder="SEARCH">
						</div>
						<button class="submit submit2"><span class="blind">검색</span></button>
					</div>
				</form>
				
				<div class="bbs_list">
					<div class="gallery" >
						<%if Not( IsNothing(Model) ) then%>
						<ul id="bbs_lists">
							<%For each obj in Model.Items
								image = iif(obj.Image="" or IsNothing(obj.Image),"images/bg_no_image.png","/upload/Board/"&obj.Image)
							%>
							<li class="_player">
								<div class="item">
									<a href="?controller=Community&action=Detail&Board=News&No=<%=obj.No%>">
									<div class="photo"><img class="trick"><img src="<%=image%>"></div>
									<div class="label"><p><%=obj.Title%></p></div>
									</a>
								</div>
							</li>
							<%next%>
						</ul>
						<%else%>
							<div style="text-align:center;margin-top:50px;">등록된 내용이 없습니다.</div>
						<%end if%>
					</div>
					
					<%if BoardListModel.Types = "QNA" then %>
					<div style="margin-top:30px;text-align:right;">
						<button class="blue mini" onclick="location.href='<%=ViewData("ActionRegiste")%>';">질문하기</button>
					</div>
					<%end if%>
					

				</div>
			</div>
			
		</div>
	</div>
</div>



<script type="text/javascript">
$(function(){
	var _player = $('.bbs_list ul li._player');
	TweenMax.set( _player, { opacity: 0,y:+100 } );
	tweenMotion(_player);
	
	$(window).scroll(function(event){
		var scrollTop = $(this).scrollTop();
		var winhowHwight = $(window).height();
		if( scrollTop == 0 ){
			$('.bbs_list ul li').addClass('_player');
			TweenMax.set( $('.bbs_list ul li._player'), { opacity: 0,y:+100 } );
		}
	});

	$('.bbs_list ul li').hover( 
		function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1.3, ease:Quad.easeOut});
		},function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1, ease:Quad.easeOut});
	  }
	)
	
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
</script>