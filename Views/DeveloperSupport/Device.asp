<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Device Developer</h2>
			<div class="sub_title_description"><b>개발자 지원</b></div>
			<span class="sub_navigation">Developer Support <span class="bar">></span> <b>Device Developer</b></span>
			
			<div class="sub_description">
				<%=Model.Contents%>
			</div>
			
			<%if Not(IsNothing(FilesModel)) then%>
				<br><br><br>
				<h2 class="sub_caption"><label></label>File Download</h2>
				<div class="area_files" style="margin:0px;">
					<%For each obj in FilesModel.Items%>
					<div class="row">
						<label>File</label><span class="file"><%=obj.Name%></span>
						<button class="white" type="button" onclick="location.href='/Utils/download.asp?pach=/upload/Page/&file=<%=obj.Name%>';">다운로드</button>
					</div>
					<%next%>
				</div>
			<%end if%>
			
		</div>
	</div>
</div>