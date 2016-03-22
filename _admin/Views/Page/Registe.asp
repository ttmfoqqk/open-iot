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
                        <!-- Start .page-content-inner -->
                        <div id="page-header" class="clearfix">
                            <div class="page-header">
                                <h2>페이지 관리</h2>
                                <span class="txt"><p class="text-danger">샘플 데이터는 inc/css/iot.css 를 활용중. 수정/추가시 참조 하거나 에디터 활용으로 작성<p></span>
                            </div>
                        </div>
                        <!-- Start .row -->
                        <div class="row">
                            <div class="col-lg-12">
                            	
                            	
                            	<form id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" class="form-horizontal group-border stripped" role="form" enctype="multipart/form-data">
                            	<input type="hidden" name="No" value="<%=Model.No%>">
                            	<input type="hidden" name="action" value="<%=action%>">
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><%=ViewData("PageName")%></h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <div class="form-group">
                                            <div class="col-lg-12 col-md-12">
                                                <textarea class="form-control" name="Contents" id="Contents" rows="25" style="width:100%;"><%=Model.Contents%></textarea>
                                            </div>
                                        </div>
                                       
                                       
                                        <%if Not(IsNothing(FilesModel)) then %>
                                        <div class="form-group">
                                            <label class="col-lg-2 col-md-3  control-label" for="">첨부된 파일</label>
                                            <div class="col-lg-10 col-md-9 ">
                                            	<%For each obj in FilesModel.Items%>
                                            	<p class="form-control-static"><a href="/Utils/download.asp?pach=/upload/Page/&file=<%=obj.Name%>"><%=obj.Name%></a> <button type="button" class="btn btn-xs btn-default ml10" onclick="del_file($(this),<%=obj.No%>)">삭제</button></p>
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
                                        
                                        
                                        <div class="form-group">
                                            <div class="col-lg-12 text-center">
                                                <button class="btn btn-primary btn-lg btn-alt" type="button" onclick="form_submit()"> 등 록 </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </form>
                                
                                
                                
                            </div>
                            <!-- col-lg-12 end here -->
                        </div>
                        <!-- End .row -->
                    </div>
                    <!-- End .page-content-inner -->
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

function form_submit(){
	oEditors.getById["Contents"].exec("UPDATE_CONTENTS_FIELD", []);
	$('#mForm').submit();
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
		url : "?controller=Page&action=DelFile",
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
