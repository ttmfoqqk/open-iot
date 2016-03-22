<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">

			<div class="Detail_full">
				<div class="rows">
					<div class="area_images">
						<div class="big_img">
							<img class="trick"><img src="<%=iif( IsNothing(Images) or Images="","/images/bg_no_image.png","/upload/Apps/"&Images )%>" id="big_img">
						</div>
						<div class="small_img">
							<ul>
								<%if Not(IsNothing(Model.Images1)) then %>
								<li><a href="#" class="active"><img class="trick"><img src="<%="/upload/Apps/"& Model.Images1%>" class="thumbnail"></a></li>
								<%end if%>
								<%if Not(IsNothing(Model.Images2)) then %>
								<li><a href="#"><img class="trick"><img src="<%="/upload/Apps/"& Model.Images2%>" class="thumbnail"></a></li>
								<%end if%>
								<%if Not(IsNothing(Model.Images3)) then %>
								<li><a href="#"><img class="trick"><img src="<%="/upload/Apps/"& Model.Images3%>" class="thumbnail"></a></li>
								<%end if%>
								<%if Not(IsNothing(Model.Images4)) then %>
								<li><a href="#"><img class="trick"><img src="<%="/upload/Apps/"& Model.Images4%>" class="thumbnail"></a></li>
								<%end if%>
							</ul>
						</div>
						<h2 class="title"><%=Model.Name%></h2>
						<div class="caption"><%=Model.Contents1%></div>
					</div>
					
					<%if Not(IsNothing(OidModel)) then
						'if OidModel.State = "0" then 
					%>
					<!-- oid 발급기업 정보 -->
					<div class="area_oid_box">
						<div class="inner">
							<div class="img">
								<a href="<%=iif(IsNothing(OidModel.Url) or OidModel.Url="","javascript:;",OidModel.Url)%>" target="blank">
									<img class="trick" style="max-height:100%;"><img src="<%=iif( IsNothing(OidModel.ImgLogo) or OidModel.ImgLogo="","/images/bg_no_image.png","/upload/Oid/"&OidModel.ImgLogo )%>">
								</a>
							</div>
							<div class="text">
								<p>
								<%=OidModel.Name%><br>
								<%=OidModel.Email%><br>
								<%if OidModel.Phone1 <> "" then%>
									<%=OidModel.Phone1%>-<%=OidModel.Phone2%>-<%=OidModel.Phone3%><br>
								<%end if%>
								</p>
							</div>
						</div>
					</div>
					<%
						'end if
					end if%>
					
				</div>
				
				<div class="rows">
					<div class="area_description">
						<h2 class="title">App Information</h2>
						<div class="caption"><%=Model.Contents2%></div>
					</div>
				</div>
				
				<div class="rows">
					<div class="area_description">
						<h2 class="title">API Information</h2>
						<div class="caption"><%=Model.Contents3%></div>
					</div>
				</div>
				
				<%if Not(IsNothing(FilesModel)) then%>
				<div class="rows">
					<h2 class="area_files_title">File Download</h2>
					<div class="area_files">
						<%For each obj in FilesModel.Items%>
						<div class="row">
							<label>File</label><span class="file"><%=obj.Name%></span>
							<button class="white" type="button" onclick="location.href='/Utils/download.asp?pach=/upload/Apps/&file=<%=obj.Name%>';">다운로드</button>
						</div>
						<%next%>
					</div>
				</div>
				<%end if%>
				
				<%if Not(IsNothing(RelationModel)) then%>
				<div class="rows">
					<div class="area_related" id="slider1">
						<h2 class="title">Related Devices</h2>
						<div class="caption">
							<a href="#" class="prev"><span class="blind">이전</span></a>
							<a href="#" class="next"><span class="blind">이전</span></a>
							
							<div class="items">
								<div class="list">
									<ul id="sliderList1">
										<%For each obj in RelationModel.Items
										'Images = obj.Images1
										'Images = iif( IsNothing(Images) or Images="",obj.Images2,Images )
										'Images = iif( IsNothing(Images) or Images="",obj.Images3,Images )
										'Images = iif( IsNothing(Images) or Images="",obj.Images4,Images )
										
										Images = obj.ImagesList
										%>
										<li>
											<div class="item pRight">
											<a href="?controller=DevicesApps&action=DevicesDetail&No=<%=obj.ProductNo%>">
												<div class="photo"><img class="trick"><img src="<%=iif( IsNothing(Images) or Images="","/images/bg_no_image.png","/upload/Devices/"&Images )%>" ></div>
												<div class="label">
													<p>
														<b><%=obj.ProductName%></b>
														<%=HtmlTagRemover(obj.ProductContents,50)%>
													</p>
												</div>
											</a>
											</div>
										</li>
										<%next%>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%end if%>
				
				<div class="rows">
					<div class="area_bbs">
					
						<div class="tab">
							<div style="float:left;width:50%;">
								<a href="QNA" class="item active"><span class="border">Q&A</span></a>
							</div>
							<div style="float:left;width:50%;">
								<a href="FAQ" class="item">FAQ</a>
							</div>
						</div>
						
						<div class="lists">
							
							<div class="bbs_search">
								<div class="input_wrap">
									<input type="text" id="Title" name="Title" placeholder="SEARCH">
								</div>
								<button type="button" class="submit"><span class="blind">검색</span></button>
							</div>
							
							<div class="bbs_list">
								<div id="bbs_lists"></div>
								
								<div style="margin-top:30px;text-align:right;" id="ActionRegiste">
									<button class="blue mini" onclick="location.href='?controller=Mypage&action=Qna&mode=Registe&Code=Apps&ProductNo=<%=No%>';">질문하기</button>
								</div>
								
								<!--div class="more">
									<a href="#">MORE</a>
									<span><b>1</b>/2</span>
								</div-->
							</div>
							
						</div>
						
					</div>
				</div>
				
			</div>
			
			
			
		</div>
	</div>
</div>



<script type="text/javascript">
$(function(){
	$('.area_bbs .tab a').click(function(e){
		e.preventDefault();

		var $this = $(this);
		var Types = $this.attr('href');
		
		$('#bbs_lists').html('');
		$('#Title').val('');
		$('.area_bbs .tab a').removeClass('active');
		$this.addClass('active');
		callList(Types,1);
		
		var btn = $('#ActionRegiste');
		if( Types == 'QNA' ){
			btn.show();
		}else{
			btn.hide();
		}
	});
	
	$('.small_img a').click(function(e){
		e.preventDefault();
		var src = $(this).find('img.thumbnail').attr('src');
		$('#big_img').attr('src',src);
		
		$('.small_img a').removeClass('active');
		$(this).addClass('active');
	});
	
	var slider1_html = $('#slider1').html();
	slider_setting('slider1',"sliderList1",slider1_html);
	$(window).resize(function(){
		slider_setting('slider1',"sliderList1",slider1_html);
	});
	
	$("#Title").keydown(function (key) {
        if (key.keyCode == 13) {
        	var Types = $('.area_bbs .tab a.active').attr('href');
            callList(Types,1);
        }
    });
});
function slider_setting(containerID,slideID,htmls){
	$('#'+containerID).html(htmls);
	
	var itemCnt = $('#'+containerID).find('li').length;
	var limit= 3;
	
	if(window.innerWidth >= 1650 ){
		limit= 5;
	}else if( window.innerWidth >= 1326 && window.innerWidth < 1650 ){
		limit= 4;
	}
	
	if( itemCnt > limit ){
		fn_rollToEx(containerID,slideID,"",1,false);
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


function toggleContetns(obj){
	$('.bbs_list .rows a').click(function(e){
		e.preventDefault();

		if($(this).hasClass('active')){
			$(this).removeClass('active');
			$(this).next('.bbs_detail').stop().slideUp();
			$(this).find('.icon .img').animate({'rotate': '180'}, 200, 'linear');
		}else{
			$('.bbs_list .rows a.active').find('.icon .img').animate({'rotate': '0'}, 200, 'linear');
			
			$('.bbs_list .rows a').removeClass('active');
			$(this).addClass('active');
			
			$('.bbs_list .rows .bbs_detail').stop().slideUp();
			$(this).next('.bbs_detail').stop().slideDown().queue(function(){
				var top=$(this).prev().offset().top;
				$("html,body").animate({"scrollTop":top-50}, 500);
				
				$(this).prev().find('.icon .img').animate({'rotate': '135'}, 200, 'linear');
				$(this).dequeue();
			});
		}
	});
	
	$('.bbs_list .rows a').hover(
		function(){
			if( !$(this).hasClass('active') ){
				$(this).find('.icon .img').stop().animate({'rotate': '180'}, 200, 'linear');
			}
		},function(){
			if( !$(this).hasClass('active') ){
				$(this).find('.icon .img').stop().animate({'rotate': '0'}, 200, 'linear');
			}
		}
	);
}
function callList(Types,pageNo){
	var pageNo = !pageNo ? 1 : pageNo;
	var Title  = $('#Title').val();
	var No = '<%=No%>';

	$.ajax({
		url : "?controller=DevicesAppsBoard&action=AjaxList&Code=Apps&Types="+Types+"&ProductNo="+No+"&Title="+Title+"&pageNo="+pageNo+"&partial=True",
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("잠시 후 다시 시도해 주세요.");
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '';
			
			if(json.MSG == 'success'){
				$.each(json.LIST, function(key, value){

					var label = '';
					if(Types == 'QNA'){
						label='question';
					}else if(Types == 'FAQ'){
						label='faq';
					}
					
					file_html = '';
					$.each(value.files, function(fkey, fvalue){
						file_html += '<div class="row"><label>File</label><span class="file">'+fvalue.Name+'</span>'+
						'<button class="white" type="button" onclick="location.href=\'/Utils/download.asp?pach=/upload/DnABoard/&file='+fvalue.Name+'\'">다운로드</button></div>';
					});
					if(value.files.length>0){
						file_html = '<div class="area_files" style="margin:0px;">'+ file_html + '</div>';
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
						'<a href="#">'+
							'<label class="'+label+'"></label>'+
							'<span class="title"><span style="margin-left:'+margin+'px;">'+nbsp + value.Title+'</span></span>'+
							'<span class="icon">'+value.Indate+'<span class="img"></span></span>'+
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
					//$('#bbs_lists').append(html);
					$('#bbs_lists').html(html);
				}
				
				toggleContetns();

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
callList('QNA',1);
</script>