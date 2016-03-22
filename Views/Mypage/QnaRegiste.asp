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
						<td class="title"><span class="red">＊</span>제목</td>
						<td>
							<div class="input_wrap"><input type="text" id="Title" name="Title" value="<%=TagDecode(Model.Title)%>"></div>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>내용</td>
						<td>
							<textarea rows="20" name="Contents" id="Contents" style="width:85%;padding:0px;margin:0px;"><%=Model.Contents%></textarea>
						</td>
					</tr>
					
					<tr>
						<td class="title">파일</td>
						<td>
							<div class="input_wrap" id="file_area">
								<%if Not( IsNothing(BoardFilesModel) ) then%>
								<%For each files in BoardFilesModel.Items%>
								<div style="margin-bottom:10px;">
									<span style="margin-right:10px;"><a href="/Utils/download.asp?pach=/upload/DnABoard/&file=<%=files.Name%>"><%=files.Name%></a></span>
									<button type="button" class="white" style="width:50px;height:20px;border:2px solid #007acc;font-size:12px;" onclick="del_file($(this),<%=files.No%>)">삭제</button>
								</div>
								<%next%>
								<%end if%>
								<div class="file_item" style="position:relative;margin-bottom:10px;margin-right:230px;">
									<input type="text" style="background-color:#ffffff;" readonly disabled>
									
									
									<div style="position:absolute;top:0px;right:-250px;">
										<label class="files" style="margin-right:10px;">
											파일첨부
											<input type="file" id="files" name="files" onchange="files_add($(this))">
										</label>
										<button class="gray" type="button" style="width:40px;" onclick="row_controll($(this),'add')">+</button>
										<button class="gray" type="button" style="width:40px;" onclick="row_controll($(this),'remove')">-</button>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</table>
				
				<div style="text-align:right;">
					<button type="button" class="white mini" style="float:left;" onclick="location.href='<%=ViewData("ActionList")%>';">목록</button>
					<%if ViewData("ActionType") = "UPDATE" then%>
					<button type="button" class="white mini" onclick="reg_fm()">수정</button>
					<%elseif ViewData("ActionType") = "INSERT" then %>
					<button type="button" class="white mini" onclick="reg_fm()">저장</button>
					<%end if%>
				</div>
				
				

			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents",
	sSkinURI: "../Utils/SE2.8.2.O12056/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//
	},
	fCreator: "createSEditor2"
});


function files_add(obj){
	var parent = obj.parent().parent().parent();
	var text   = parent.find('input[type="text"]');
	text.val( obj.val() );
}


function reg_fm(){
	oEditors.getById["Contents"].exec("UPDATE_CONTENTS_FIELD", []);
	var sContent = oEditors.getById["Contents"].getIR(); 
	sContent = sContent.replace(/\r/g, ''); 
	sContent = sContent.replace(/[\n|\t]/g, ''); 
	sContent = sContent.replace(/[\v|\f]/g, ''); 
	
	//1. 먼저, 빈 라인 처리 . 
	sContent = sContent.replace(/<p><br><\/p>/gi, ''); 
	sContent = sContent.replace(/<P>&nbsp;<\/P>/gi, ''); 
	
	//2. 빈 라인 이외에 linebreak 처리. 
	sContent = sContent.replace(/<br(\s)*\/?>/gi, ''); 
	sContent = sContent.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent = sContent.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	
	sContent = sContent.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent = sContent.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	
	sContent = sContent.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); //HTML태그 없애는 정규식 
	sContent = sContent.replace(/^\s\s*/, '').replace(/\s\s*$/, ''); //빈공백 없애는 정규식 
	
	if( !$.trim( $('#Title').val() ) ){
		alert('제목을 입력해주세요');return false;
	}
	
	if( sContent.length <= 0 ){
		alert('내용을 입력해주세요');return false;
	}

	$('#mForm').submit();
}
function del_fm(){
	if( confirm('삭제 하시겠습니까?') ){
		$('#ActionType').val('DELETE');
		$('#mForm').submit();
	}
}

var $new_row = $('#file_area .file_item').clone();
function row_controll(obj,mode){
	var len     = $('#file_area .file_item').length;
	var parent  = obj.parent().parent();
	var new_row = $new_row.clone();
	
	if( mode == 'add' ){
		$(new_row).insertAfter(parent);
	}else if( mode == 'remove' ){
		if(len <= 1){
			alert('삭제할수 없습니다.');
			return false;
		}else{
			parent.remove();
		}
	}
}

function del_file(obj,No){
	if( !confirm('첨부파일을 삭제 하시겠습니까?') ){
		return false;
	}
	$.ajax({
		url : "?controller=DevicesAppsBoard&action=DelFile",
		type : "POST",
		data : {
			No : No,
			partial:'True'
		},
		error : function(jqxhr, status, errorMsg){
			alert("실패");
			console.log(jqxhr);
		},
		success : function(res){
			obj.parent().remove();
		}
	});	
}

</script>