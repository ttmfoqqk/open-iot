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
					<%if Not( IsNothing(Model) ) then
						For each obj in Model.Items
						if Board = "Notice" then 
							label="notice"
						elseif Board = "Inquiry" then
							label="question"
						elseif Board = "Forum" then
							label="forum"
						end if
						
						
						nbsp = ""
						margin = 0
						if obj.DepthNo > 0 then 
							margin = (obj.DepthNo-1) * 30
							nbsp = "<img src=""/images/bg_icon_reply.png"" style=""margin-right:10px;""> "
							label="anser"
						end if 
						
						set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",obj.No)
					%>
					<div class="rows">
						<a href="#" id="link_<%=obj.No%>">
							<label class="<%=label%>"></label>
							<span class="title"><span style="margin-left:<%=margin%>px;"><%=nbsp & obj.Title%></span></span>
							<span class="icon"><%=left(obj.Indate,10)%><span class="img"></span></span>
						</a>
						<div class="bbs_detail">
							<div class="detail"><%=obj.Contents%></div>
							<%if Not( IsNothing(BoardFilesModel) ) then%>
							<div class="area_files">
								<%For each files in BoardFilesModel.Items%>
								<div class="row"><label>File</label><span class="file"><%=files.Name%></span>
								<button class="white" type="button" onclick="location.href='/Utils/download.asp?pach=/upload/Board/&file=<%=files.Name%>'">다운로드</button></div>
								<%next%>
							</div>
							<%end if%>
						</div>
					</div>
					<%
						next
					else%>
						<div style="text-align:center;margin-top:50px;">등록된 내용이 없습니다.</div>
					<%end if%>
					
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
	
	var No = '<%=Request("No")%>';
	if( No ){
		$('#link_'+No).click();
	}
});

</script>