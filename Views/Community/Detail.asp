<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue"><%=ViewData("PageTitle")%></h2>
			<div class="sub_title_description"><%=ViewData("PageSubTitle")%></div>
			<span class="sub_navigation">Community <span class="bar">></span> <b><%=ViewData("PageName")%></b></span>
			
			<div class="sub_description">
				<!--h2 class="sub_caption"><label></label>기본정보</h2-->
				
				<form Id="mForm" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                <input type="hidden" name="Board" value="<%=Board%>">
				
				<table class="form">
					<tr>
						<td class="title">등록일</td>
						<td><%=left(Model.InDate,10)%></td>
					</tr>
					<tr>
						<td class="title">제목</td>
						<td><%=Model.Title%></td>
					</tr>
					<tr>
						<td class="title">내용</td>
						<td><div style="min-height:300px;"><%=Model.Contents%></div></td>
					</tr>
					<%if Not( IsNothing(BoardFilesModel) ) then%>
					<tr>
						<td colspan="2" style="margin:0px;padding:0px;border-bottom:0px;">
							<div class="area_files">
							<%For each files in BoardFilesModel.Items%>
								<div class="row">
									<label>File</label><span class="file"><%=files.Name%></span><button class="white" type="button" onclick="location.href='/Utils/download.asp?pach=/upload/Board/&file=<%=files.Name%>';">다운로드</button>
								</div>
							<%next%>
							</div>
						</td>
					</tr>
					<%end if%>
				</table>
				
				<div style="text-align:right;">
					<button type="button" class="white mini" style="float:left;" onclick="location.href='<%=ViewData("ActionList")%>';">목록</button>
				</div>
				
				

			</div>
			
		</div>
	</div>
</div>