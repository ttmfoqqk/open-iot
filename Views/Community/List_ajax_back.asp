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
					<div id="bbs_lists"></div>
					
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
function toggleContetns(obj){
	bbs_lists = $('#bbs_lists');
	bbs_lists.find('.bbs_detail').stop().slideUp();
	obj.next().stop().slideDown();
	
	bbs_lists.find('label').removeClass('active');
	obj.find('label').addClass('active');
}
function callList(pageNo){
	var pageNo = !pageNo ? 1 : pageNo;
	var Title = $('#Title').val();
	var Board = '<%=Board%>';
	var UserNo = '<%=UserNo%>';

	$.ajax({
		url : "?controller=Community&action=AjaxList&Board="+Board+"&UserNo="+UserNo+"&Title="+Title+"&pageNo="+pageNo+"&partial=True",
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

					var label = '';
					if(Board == 'Notice'){
						label='notice';
					}else if(Board == 'Inquiry'){
						label='question';
					}else if(Board == 'Forum'){
						label='forum';
					}
					
					file_html = '';
					$.each(value.files, function(fkey, fvalue){
						file_html += '<div class="row"><label>File</label><span class="file">'+fvalue.Name+'</span>'+
						'<button class="white" type="button" onclick="location.href=\'/Utils/download.asp?pach=/upload/Board/&file='+fvalue.Name+'\'">다운로드</button></div>';
					});
					if(value.files.length>0){
						file_html = '<div class="area_files">'+ file_html + '</div>';
					}
					
					var nbsp = '';
					var margin = 0;
					if(value.DepthNo > 0){
						margin = (value.DepthNo-1) * 30;
						nbsp = '<img src="/images/bg_icon_reply.png" style="margin-right:10px;"> ';
						label='anser';
					}

					html += ''+
					'<div class="rows">'+
						'<a href="javascript:;" onclick="toggleContetns($(this))">'+
							'<label class="'+label+'"></label>'+
							'<span class="title"><span style="margin-left:'+margin+'px;">'+nbsp + value.Title+'</span></span>'+
							'<span class="icon">'+value.Indate+'</span>'+
						'</a>'+
						'<div class="bbs_detail">'+
							'<div class="detail">'+value.Contents+'</div>'+
							file_html+
						'</div>'+
					'</div>';
				});
				if(pageNo==1 && json.LIST <=0 ){
					$('#bbs_lists').html('<div style="text-align:center;margin-top:50px;">등록된 내용이 없습니다.</div>');
				}else{
					$('#bbs_lists').append(html);
				}

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