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
						
						<button class="white" type="button" style="font-size:16px;" onclick="call_pop_registe();">Device / App 등록</button>
					</div>
				</div>
				</form>
				

				<div class="DevicesApps_list" id="DevicesApps_list">
					<ul>
						<!--li>
							<div class="item">
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
						</li-->
					</ul>
					<a href="#" class="more">더보기</a>
				</div>
				

			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
$('#MenuNo').change(function(){
	$('#mForm').submit();
});

function itemCover(){
	$('.DevicesApps_list .item').hover(
		function(){
			$(this).find('.cover').show();
		},
		function(){
			$(this).find('.cover').hide();
		}
	);
}

function deleteProduct(No){
	if( confirm('삭제 하시겠습니까?') ){
		location.href='<%=ViewData("ActionDelete")%>&No='+No;
	}
}

function callList(pageNo){
	var Name = $('#Name').val();
	var MenuNo = $('#MenuNo').val();
	$.ajax({
		url : "<%=ViewData("ActionAjaxUrl")%>&MenuNo="+MenuNo+"&pageNo="+pageNo+"&partial=True",
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
						'<li>'+
							'<div class="item">'+
								'<div class="photo"><img class="trick"><img src="'+value.Images+'" ></div>'+
								'<div class="label">'+
									'<p><b>'+value.Name+'</b>'+value.Contents1+'</p>'+
								'</div>'+
								'<div class="cover">'+
									'<div class="inner">'+
										'<button type="button" class="white mini" onclick="location.href=\'<%=ViewData("ActionBoard")%>&ProductNo='+value.No+'&Types=QNA\'">Q&A 관리</button><br>'+
										'<button type="button" class="white mini" onclick="location.href=\'<%=ViewData("ActionBoard")%>&ProductNo='+value.No+'&Types=FAQ\'">FAQ 관리</button><br>'+
										'<button type="button" class="white mini" onclick="location.href=\'<%=ViewData("ActionDetail")%>&No='+value.No+'\'">상품상세</button><br>'+
										'<button type="button" class="white mini" onclick="location.href=\'<%=ViewData("ActionRegiste")%>&No='+value.No+'\'">상품수정</button><br>'+
										'<button type="button" class="white mini" onclick="deleteProduct('+value.No+')">상품삭제</button><br>'+
									'</div>'+
								'</div>'+
							'</div>'+
						'</li>';
				});
				$('#DevicesApps_list ul').append(html);
				itemCover();
				$('#DevicesApps_list .more').unbind('click').click(function(e){
					e.preventDefault();
					if( json.T_PAGE > json.C_PAGE){
						callList(json.C_PAGE+1);
					}else{
						alert('마지막 페이지 입니다.');
					}
				});
			}else{
				alert(json.MSG)
			}
		}
	});	
}
callList(1);
</script>