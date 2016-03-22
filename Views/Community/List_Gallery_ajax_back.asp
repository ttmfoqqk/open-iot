<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Notice</h2>
			<div class="sub_title_description">Open-IoT <b>공지사항</b></div>
			<span class="sub_navigation">Community <span class="bar">></span> <b>Notice</b></span>
			
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
						<ul id="bbs_lists"></ul>
					</div>
					
					<%if BoardListModel.Types = "QNA" then %>
					<div style="margin-top:30px;text-align:right;">
						<button class="blue mini" onclick="location.href='<%=ViewData("ActionRegiste")%>';">질문하기</button>
					</div>
					<%end if%>
					
					<!--div class="more">
						<a href="#">MORE</a>
						<span><b>1</b>/2</span>
					</div-->
					
				</div>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
function callList(pageNo){
	var Title = $('#Title').val();
	$.ajax({
		url : "?controller=Community&action=AjaxList&Board=<%=Board%>&Title="+Title+"&pageNo="+pageNo+"&partial=True",
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
					image = '';
					image = !value.Image ? 'images/bg_no_image.png' : '/upload/Board/'+value.Image;
					html += ''+
					'<li>'+
						'<div class="item">'+
							'<a href="?controller=Community&action=Detail&Board=News&No='+value.No+'">'+
							'<div class="photo"><img class="trick"><img src="'+image+'"></div>'+
							'<div class="label"><p>'+value.Title+'</p></div>'+
							'</a>'+
						'</div>'+
					'</li>';
				});

				$('#bbs_lists').append(html);

				$('.bbs_list').find('.more a').unbind('click').click(function(e){
					e.preventDefault();
					if( json.T_PAGE > json.C_PAGE){
						callList(json.C_PAGE+1);
					}else{
						alert('마지막 페이지 입니다.');
					}
				});
				$('.bbs_list').find('.more span').html('<b>'+json.C_PAGE+'</b>/'+json.T_PAGE);
			}else{
				alert(json.MSG);
			}
		}
	});	
}
callList(1);
</script>