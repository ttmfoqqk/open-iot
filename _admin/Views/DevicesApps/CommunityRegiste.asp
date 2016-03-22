<!--#include file="../inc/header.asp" -->
        <!-- / page-navbar -->
        <!-- #wrapper -->
        <div id="wrapper">
            <!--#include file="../inc/side.asp" -->
            <!-- .page-content -->
			<div class="page-content sidebar-page clearfix">
				<!-- .page-content-wrapper -->
				<div class="page-content-wrapper">
					<div class="page-content-inner">
						<!-- .page-content-inner -->
						<div id="page-header" class="clearfix">
							<div class="page-header">
								<h2><%=ViewData("PageName")%></h2>
							</div>
						</div>
						<div class="row">
						
						
							<div class="col-lg-12">
								<!-- col-lg-12 start here -->
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                        	<i class="fa fa-circle"></i> 글작성
                                        </h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <form Id="mForm" class="form-horizontal group-border stripped" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                                        <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                                        <input type="hidden" id="Params" name="Params" value="<%=ViewData("Params")%>">
                                        <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                                        <input type="hidden" name="BoardCode" value="<%=Code%>">
										<input type="hidden" name="BoardType" value="<%=Types%>">
                                        
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">작성자</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <p class="form-control-static"><%=Model.UserName%> [<%=Model.UserId%>]</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for=""><%=ViewData("ProductLabel")%></label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="ProductNo" name="ProductNo">
                                                    	<option value="">선택</option>
														<%if Not(IsNothing(ProductModel)) then
															Dim MenuItem
															For each MenuItem in ProductModel.Items
														%>
                                                    	<option value="<%=MenuItem.No%>" <%=iif(Model.ProductNo=MenuItem.No,"selected","")%>><%=MenuItem.Name%></option>
                                                    	<%
															Next
														end if%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">제목</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Title" name="Title" placeholder="제목" value="<%=TagDecode(Model.Title)%>">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">내용</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents" id="Contents" rows="10" style="width:100%;"><%=Model.Contents%></textarea>
                                                </div>
                                            </div>
                                            
                                            <%if Not(IsNothing(DevicesAppsBoardFilesModel)) then %>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">첨부된 파일</label>
                                                <div class="col-lg-10 col-md-9 ">
                                                	<%For each obj in DevicesAppsBoardFilesModel.Items%>
                                                	<p class="form-control-static"><a href="/Utils/download.asp?pach=/upload/DnABoard/&file=<%=obj.Name%>"><%=obj.Name%></a> <button type="button" class="btn btn-xs btn-default ml10" onclick="del_file($(this),<%=obj.No%>)">삭제</button></p>
                                                	<%Next%>
                                                </div>
                                            </div>
                                            <%end if%>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">파일</label>
                                                <div class="col-lg-10 col-md-9 form-inline" id="file_area">
                                                	<div class="mb10 file_item">
                                                    	<input type="file" name="files" class="filestyle input-mini" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
                                                    	<button type="button" class="btn btn-primary" onclick="row_controll($(this),'add')">+</button>
                                                    	<button type="button" class="btn btn-danger" onclick="row_controll($(this),'remove')">-</button>
                                                    </div>
                                                    
                                                </div>
                                            </div>

                                            <div class="panel-body text-center">
                                            	<button type="button" class="btn btn-default btn-lg btn-alt pull-left" onclick="location.href='<%=ViewData("ActionList")%>';"> 목록 </button>
                                            	
												<button type="button" class="btn btn-primary btn-lg btn-alt" onclick="reg_fm()"> 등 록 </button>
												<%if ViewData("ActionType") = "UPDATE" AND ViewData("BoardType") = "QNA" then %>
												<button type="button" class="btn btn-default btn-lg btn-alt" onclick="location.href='<%=ViewData("ActionReply")%>';"> 답 글 </button>
												<%end if%>
												<button type="button" class="btn btn-danger btn-lg btn-alt" onclick="del_fm()"> 삭 제 </button>
											</div>
                                        </form>
                                    </div>
                                </div>
                                <!-- End .panel -->
							</div>
			
						
						
						
						
						</div>
						
						<!-- End .row -->
					</div>
					<!-- / .page-content-inner -->
				</div>
				<!-- / page-content-wrapper -->
			</div>
			<!-- / page-content -->
        </div>

<!--#include file="../inc/footer.asp" -->
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
	
	//alert("컨텐츠 내용 : ["+sContent +"]"); 
	//alert("컨텐츠 길이 : ["+sContent.length +"]"); 
	
	if( !$.trim( $('#ProductNo').val() ) ){
		alert('디바이스 또는 어플을 선택해주세요');return false;
	}
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
	var parent  = obj.parent();
	var new_row = $new_row.clone();
	
	if( mode == 'add' ){
		$(new_row).insertAfter(parent);
		// 파일 스타일 적용
		$(new_row).find('.filestyle').each(function() {
			var $this = $(this), options = {

				'input' : $this.attr('data-input') === 'false' ? false : true,
				'icon' : $this.attr('data-icon') === 'false' ? false : true,
				'buttonBefore' : $this.attr('data-buttonBefore') === 'true' ? true : false,
				'disabled' : $this.attr('data-disabled') === 'true' ? true : false,
				'size' : $this.attr('data-size'),
				'buttonText' : $this.attr('data-buttonText'),
				'buttonName' : $this.attr('data-buttonName'),
				'iconName' : $this.attr('data-iconName')
			};
			$this.filestyle(options);
		});
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