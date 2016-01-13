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
                                <h2>약관 관리</h2>
                                <span class="txt"> </span>
                            </div>
                        </div>
                        <!-- Start .row -->
                        <div class="row">
                            <div class="col-lg-12">
                            	
                            	
                            	<form id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" class="form-horizontal group-border stripped" role="form">
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">이용약관</h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <div class="form-group">
                                            <div class="col-lg-12 col-md-12">
                                                <textarea class="form-control" name="Policy1" id="Policy1" rows="10"><%=Model.Policy1%></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">개인정보취급방침</h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <div class="form-group">
                                            <div class="col-lg-12 col-md-12">
                                                <textarea class="form-control" name="Policy2" id="Policy2" rows="10"><%=Model.Policy2%></textarea>
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
	elPlaceHolder: "Policy1",
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


nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Policy2",
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
	oEditors.getById["Policy1"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["Policy2"].exec("UPDATE_CONTENTS_FIELD", []);
	
	$('#mForm').submit();
}
</script>
<!--#include file="../inc/footer.asp" -->