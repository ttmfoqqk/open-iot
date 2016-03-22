<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">나의 Q&A</h2>
			<div class="sub_title_description">나의 <b>질문과답변</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>나의 Q&A</b></span>
			
			<div class="sub_description">
				<h2 class="sub_caption"><label></label>질문내용</h2>
				
				<form Id="mForm" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                <input type="hidden" id="No" name="No" value="<%=No%>">
                <input type="hidden" id="Code" name="Code" value="<%=Code%>">
                <input type="hidden" id="ProductNo" name="ProductNo" value="<%=ProductNo%>">
				
				<table class="form">
					<tr>
						<td>
							<div style="display:inline-block;width:122px;height:98px;border:1px solid #f4f4f4;background-color:#fcfcfc;overflow:hidden;text-align:center;vertical-align:middle;">
								<img class="trick" style="vertical-align:middle;"><img src="<%=ProductImages%>" style="max-width:95%;max-height:95%;vertical-align:middle;">
							</div>
						</td>
						<td colspan="2"><a href="<%=ProductLink%>" target="_blank" style="color:#0000ff;text-decoration:underline;"><%=ProductModel.Name%></a></td>
					</tr>
					<tr>
						<td class="title">등록일</td>
						<td><%=left(Model.InDate,10)%></td>
					</tr>
					<tr>
						<td class="title">작성자</td>
						<td><%=Model.UserName%></td>
					</tr>
					<tr>
						<td class="title">이메일</td>
						<td><%=Model.UserId%></td>
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
									<label>File</label><span class="file"><%=files.Name%></span>
									<button class="white" type="button" onclick="location.href='/Utils/download.asp?pach=/upload/DnABoard/&file=<%=files.Name%>';">다운로드</button>
								</div>
							<%next%>
							</div>
						</td>
					</tr>
					<%end if%>
				</table>
				
				<div style="text-align:right;">
					<button type="button" class="white mini" style="float:left;" onclick="location.href='<%=ViewData("ActionList")%>';">목록</button>
					<%if Model.AdminNo = "0" then%>
					<button type="button" class="white mini" onclick="location.href='<%=ViewData("ActionRegiste")%>';">수정</button>
					<button type="button" class="blue mini" onclick="del_fm()">삭제</button>
					<%end if%>
				</div>
				
				

			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
function del_fm(){
	if( confirm('삭제 하시겠습니까?') ){
		$('#ActionType').val('DELETE');
		$('#mForm').submit();
	}
}
</script>