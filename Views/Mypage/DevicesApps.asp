<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents mypage">
		<div class="inner">
			<h2 class="sub_title_blue">Devices & Apps 관리</h2>
			<div class="sub_title_description">Devices & Apps <b>상품 및 고객관리</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>Devices & Apps 관리</b></span>
			
			<div class="sub_description">
				
				<form id="mForm" method="GET">
				<input type="hidden" name="Controller" value="<%=Controller%>">
				<input type="hidden" name="action" value="<%=action%>">
				<input type="hidden" name="mode" value="<%=mode%>">
				
				<div class="DevicesApps_search">
					<div class="tab">
						<a href="?controller=Mypage&action=DevicesApps&mode=Devices" class="item <%=iif(mode="Devices","active","")%>">Devices</a>
						<a href="?controller=Mypage&action=DevicesApps&mode=Apps" class="item <%=iif(mode="Apps","active","")%>">Apps</a>
					</div>
					<div class="other">
						<select id="MenuNo" name="MenuNo" style="width:353px;">
							<option value="">선택</option>
							<%if Not(IsNothing(MenuModel)) then
								For each MenuItem in MenuModel.Items
							%>
	                    	<option value="<%=MenuItem.No%>" <%=iif(Request("MenuNo")=Cstr(MenuItem.No),"selected","")%>><%=MenuItem.Name%></option>
	                    	<%
								Next
							end if%>
						</select>
						
						<button class="white" type="button" style="font-size:16px;" onclick="call_pop_registe();">신규등록</button>
					</div>
				</div>
				</form>
				

				<div class="DevicesApps_list" id="DevicesApps_list">
				<%if Not( IsNothing(Model) ) then%>
					<ul>
						<%For each obj in Model.Items
							if mode = "Devices" then
								ImagesPath = "/upload/Devices/"
							elseif mode = "Apps" then
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
						<li>
							<div class="item">
								<div class="photo"><img class="trick"><img src="<%=Images%>" ></div>
								<div class="label">
									<p>
										<b><%=obj.Name%></b>
										<%=HtmlTagRemover(obj.Contents1,50)%>
									</p>
								</div>
								<div class="cover">
									<div class="inner">
										<button type="button" class="white mini" onclick="location.href='<%=ViewData("ActionBoard")%>&ProductNo=<%=obj.No%>&Types=QNA';">Q&A 관리</button><br>
										<button type="button" class="white mini" onclick="location.href='<%=ViewData("ActionBoard")%>&ProductNo=<%=obj.No%>&Types=FAQ';">FAQ 관리</button><br>
										<button type="button" class="white mini" onclick="location.href='<%=ViewData("ActionDetail")%>&No=<%=obj.No%>';">상품상세</button><br>
										<button type="button" class="white mini" onclick="location.href='<%=ViewData("ActionRegiste")%>&No=<%=obj.No%>';">상품수정</button><br>
										<button type="button" class="white mini" onclick="deleteProduct(<%=obj.No%>)">상품삭제</button><br>
									</div>
								</div>
							</div>
						</li>
						<%next%>
					</ul>
				</div>
				<%else%>
					<div style="text-align:center;">등록된 내용이 없습니다.</div>
				<%end if%>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">

$(function(){
	$('#MenuNo').change(function(){
		$('#mForm').submit();
	});

	$('.DevicesApps_list .item').hover(
		function(){
			$(this).find('.cover').show();
		},
		function(){
			$(this).find('.cover').hide();
		}
	);
	
	$('.DevicesApps_list ul li').hover( 
		function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1.3, ease:Quad.easeOut});
		},function() {
			TweenLite.to( $(this).find('.photo img'), .4, {scale:1, ease:Quad.easeOut});
	  }
	)
});


function deleteProduct(No){
	if( confirm('삭제 하시겠습니까?') ){
		location.href='<%=ViewData("ActionDelete")%>&No='+No;
	}
}
</script>