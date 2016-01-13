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
                            	
                            	
                            	<form id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" class="form-horizontal group-border stripped" role="form">
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
                                                <textarea class="form-control" name="Contents" id="Contents" rows="25"><%=Model.Contents%></textarea>
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
</script>
<!--#include file="../inc/footer.asp" -->