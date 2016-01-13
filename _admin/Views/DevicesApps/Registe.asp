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
                                        	<i class="fa fa-circle"></i> 내용
                                        </h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <form class="form-horizontal group-border stripped" method="POST">
                                        	<div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">작성자</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" name="default">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">분류</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control">
                                                    	<option>선택</option>
                                                    	<option>선택</option>
                                                    	<option>선택</option>
                                                    	<option>선택</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for=""><%=ViewData("PageName")%>명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" name="default">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">요약설명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents1" id="Contents1" rows="10"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">이미지</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <img src="../../images/bg_no_image.png" >
	                                                    <br><br><button type="button" class="btn btn-default mr5 mb10">사진등록</button>
	                                                </div>
	                                                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <img src="../../images/bg_no_image.png" >
	                                                    <br><br><button type="button" class="btn btn-default mr5 mb10">사진등록</button>
	                                                </div>
	                                                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <img src="../../images/bg_no_image.png" >
	                                                    <br><br><button type="button" class="btn btn-default mr5 mb10">사진등록</button>
	                                                </div>
	                                                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <img src="../../images/bg_no_image.png" >
	                                                    <br><br><button type="button" class="btn btn-default mr5 mb10">사진등록</button>
	                                                </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">상세설명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents2" id="Contents2" rows="10"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">API설명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents3" id="Contents3" rows="10"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">파일</label>
                                                <div class="col-lg-10 col-md-9">
                                                	<div class="col-xs-8" style="padding-left:0px;">
                                                    	<input type="file" class="filestyle col-md-9" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
                                                    </div>
                                                    <div class="col-xs-4">
                                                    	<button type="button" class="btn btn-primary">+</button>
                                                    	<button type="button" class="btn btn-danger">-</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">관련 어플리케이션</label>
                                                <div class="col-lg-10 col-md-9">
                                                	<div class="col-xs-8" style="padding-left:0px;">
                                                    	<select class="form-control">
	                                                    	<option>선택</option>
	                                                    	<option>선택</option>
	                                                    	<option>선택</option>
	                                                    	<option>선택</option>
	                                                    </select>
                                                    </div>
                                                    <div class="col-xs-4">
                                                    	<button type="button" class="btn btn-primary">+</button>
                                                    	<button type="button" class="btn btn-danger">-</button>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="panel-body text-center">
                                            	<button type="button" class="btn btn-default btn-lg btn-alt pull-left" onclick="location.href='<%=ViewData("ActionList")%>';"> 목록 </button>
                                            	
												<button type="submit" class="btn btn-primary btn-lg btn-alt"> 등 록 </button>
												<button type="button" class="btn btn-danger btn-lg btn-alt"> 삭 제 </button>
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
<script type="text/javascript">
var oEditors = [];

// 추가 글꼴 목록 
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents1",
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

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents2",
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

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents3",
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
</script>
<!--#include file="../inc/footer.asp" -->