<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			
			<form id="mForm" method="GET">
			<input type="hidden" name="Controller" value="<%=Controller%>">
			<input type="hidden" name="action" value="<%=action%>">
			
			<div class="DevicesApps_search">
				<div class="tab">
					
					<a href="?controller=DevicesApps&action=DevicesList" class="item <%=iif(action="DevicesList","active","")%>">Devices</a>
					<a href="?controller=DevicesApps&action=AppsList" class="item <%=iif(action="AppsList","active","")%>">Apps</a>
					<div class="search">
						<div class="input_wrap">
							<input type="text" placeholder="SEARCH" id="Name" name="Name" value="<%=Request("Name")%>">
						</div>
						<button class="submit"><span class="blind">검색</span></button>
					</div>
				</div>
				
				<div class="other">
					<select id="MenuNo" name="MenuNo">
						<option value="">선택</option>
						<%if Not(IsNothing(MenuModel)) then
							For each MenuItem in MenuModel.Items
						%>
                    	<option value="<%=MenuItem.No%>" <%=iif(Request("MenuNo")=Cstr(MenuItem.No),"selected","")%>><%=MenuItem.Name%></option>
                    	<%
							Next
						end if%>
					</select>
					
					<button class="white" type="button" onclick="location.href='<%=ViewData("ActionRegiste")%>';">Device 등록</button>
				</div>
			</div>
			
			</form>
			
			<div class="DevicesApps_list" id="DevicesApps_list">
				<ul>
					<!--li>
						<a href="?controller=DevicesApps&action=Detail&id=1">
							<div class="item pLeft">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="?controller=DevicesApps&action=Detail&id=2">
							<div class="item pCenter">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="?controller=DevicesApps&action=Detail&id=3">
							<div class="item pRight">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="?controller=DevicesApps&action=Detail&id=4">
							<div class="item pLeft">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="?controller=DevicesApps&action=Detail&id=5">
							<div class="item pCenter">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="?controller=DevicesApps&action=Detail&id=6">
							<div class="item pRight">
								<div class="photo"><img class="trick"><img src="images/sample_product_m.png" ></div>
								<div class="label">
									<p>
										<b>IoT 가스락</b>
										스마트폰으로 가스밸브를 확인하고 바로<br>
										잠글 수 있는 IoT 가스락으로 안심하세요
									</p>
								</div>
							</div>
						</a>
					</li-->
				</ul>
				<a href="#" class="more">더보기</a>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
$('#MenuNo').change(function(){
	$('#mForm').submit();
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
		//alert(1)
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

function callList(pageNo){
	var Name = $('#Name').val();
	var MenuNo = $('#MenuNo').val();
	$.ajax({
		url : "<%=ViewData("ActionAjaxUrl")%>&Name="+Name+"&MenuNo="+MenuNo+"&pageNo="+pageNo+"&rows=12&partial=True",
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("잠시 후 다시 시도해 주세요.");
			console.log(jqxhr);
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '';
			
			if(json.MSG == 'success'){
				$.each(json.LIST, function(key, value){
					html += ''+
						'<li class="_player">'+
							'<div class="item">'+
								'<a href="<%=ViewData("ActionDetail")%>&No='+value.No+'">'+
									'<div class="photo"><img class="trick"><img src="'+value.Images+'" ></div>'+
									'<div class="label">'+
										'<p>'+
											'<b>'+value.Name+'</b>'+
											value.Contents1 +
										'</p>'+
									'</div>'+
								'</a>'+
							'</div>'+
						'</li>';
				});
				$('#DevicesApps_list ul').append(html);
				$('#DevicesApps_list .more').unbind('click').click(function(e){
					e.preventDefault();
					if( json.T_PAGE > json.C_PAGE){
						callList(json.C_PAGE+1);
					}else{
						alert('마지막 페이지 입니다.');
					}
				});
				
				var _player = $('#DevicesApps_list ul li._player');
				TweenMax.set( _player, { opacity: 0,y:+100 } );
				tweenMotion(_player);
			}else{
				alert(json.MSG);
			}
		}
	});	
}
callList(1);
</script>