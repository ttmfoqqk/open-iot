<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue"><%=ViewData("PageTitle")%></h2>
			<div class="sub_title_description"><%=ViewData("PageSubTitle")%></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b><%=ViewData("PageName")%></b></span>
			
			<div class="sub_description">
				<h2 class="sub_caption"><label></label>질문내용</h2>
				
				<form Id="mForm" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                <input type="hidden" name="Board" value="<%=Board%>">
				
				<table class="form">
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
				</form>
				
				<div style="text-align:right;">
					<button type="button" class="white mini" style="float:left;" onclick="location.href='<%=ViewData("ActionList")%>';">목록</button>
					<%if ViewData("ActionType") = "UPDATE" then%>
					<button type="button" class="white mini" onclick="reg_fm()">수정</button>
					<button type="button" class="blue mini" onclick="del_fm()">삭제</button>
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

// 추가 글꼴 목록 
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents",
	sSkinURI: "../Utils/SE2.8.2.O12056/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
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
		url : "?controller=Community&action=DelFile",
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
			obj.parent().remove()
		}
	});	
}

</script>