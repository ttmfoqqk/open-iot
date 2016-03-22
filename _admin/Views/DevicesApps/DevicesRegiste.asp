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
								<h2>Devices 관리</h2>
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
                                        <form Id="mForm" class="form-horizontal group-border stripped" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                                        <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                                        <input type="hidden" id="Params" name="Params" value="<%=ViewData("Params")%>">
                                        <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                                        
                                        	<div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">아이디</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <p class="form-control-static"><%=Model.UserId%></p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이름</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <p class="form-control-static"><%=Model.UserName%></p>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">분류</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="MenuNo" name="MenuNo">
                                                    	<option value="">선택</option>
														<%if Not(IsNothing(DevicesMenuModel)) then
															For each MenuItem in DevicesMenuModel.Items
														%>
                                                    	<option value="<%=MenuItem.No%>" <%=iif(Model.MenuNo=MenuItem.No,"selected","")%>><%=MenuItem.Name%></option>
                                                    	<%
															Next
														end if%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">디바이스명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Name" name="Name" value="<%=Model.Name%>" placeholder="디바이스명">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">요약설명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents1" id="Contents1" rows="10" style="width:100%;"><%=Model.Contents1%></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">리스트 이미지 <p>권장사이즈 : 600px X 483px </p></label>
                                                <div class="col-lg-10 col-md-9">
                                                    <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <div style="height:120px;width:120px;margin:0px auto;">
	                                                    	<img style="height: 100%;width:0px;overflow:hidden;"><img src="<%=iif(IsNothing(Model.ImagesList) or Model.ImagesList="","../../images/bg_no_image.png","/upload/Devices/" &Model.ImagesList)%>" style="max-width:120px;max-height:120px;">
	                                                    </div>
	                                                    <br>
	                                                    <button type="button" class="add btn btn-default mr5 mb10" onclick="images_add($(this))">사진등록</button>
	                                                    <input id="ImagesList" name="ImagesList" type="file" style="width:0px;height:0px;overflow:hidden">
	                                                    <input id="ImagesList_old" name="ImagesList_old" type="hidden" value="<%=Model.ImagesList%>">
	                                                    
	                                                    <%if Not(IsNothing(Model.ImagesList)) then%>
	                                                    <center>
	                                                    <div class="checkbox-custom checkbox-inline" style="width:120px;">
															<input id="Del_ImagesList" name="Del_ImagesList" class="check" type="checkbox" value="1">
															<label for="Del_ImagesList">파일 삭제</label>
														</div>
														<center>
														<%end if%>
	                                                </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">상세 이미지 <p>권장사이즈 : 600px X 483px </p></label>
                                                <div class="col-lg-10 col-md-9">
                                                    <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <div style="height:120px;width:120px;margin:0px auto;">
	                                                    	<img style="height: 100%;width:0px;overflow:hidden;"><img src="<%=iif(IsNothing(Model.Images1) or Model.Images1="","../../images/bg_no_image.png","/upload/Devices/" &Model.Images1)%>" style="max-width:120px;max-height:120px;">
	                                                    </div>
	                                                    <br>
	                                                    <button type="button" class="add btn btn-default mr5 mb10" onclick="images_add($(this))">사진등록</button>
	                                                    <input id="images_files1" name="images_files1" type="file" style="width:0px;height:0px;overflow:hidden">
	                                                    <input id="images_files1_old" name="images_files1_old" type="hidden" value="<%=Model.Images1%>">
	                                                    
	                                                    <%if Not(IsNothing(Model.Images1)) then%>
	                                                    <center>
	                                                    <div class="checkbox-custom checkbox-inline" style="width:120px;">
															<input id="Del_images_files1" name="Del_images_files1" class="check" type="checkbox" value="1">
															<label for="Del_images_files1">파일 삭제</label>
														</div>
														<center>
														<%end if%>
	                                                </div>
	                                                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <div style="height:120px;width:120px;margin:0px auto;">
	                                                    	<img style="height: 100%;width:0px;overflow:hidden;"><img src="<%=iif(IsNothing(Model.Images2) or Model.Images2="","../../images/bg_no_image.png","/upload/Devices/" &Model.Images2)%>" style="max-width:120px;max-height:120px;">
	                                                    </div>
	                                                    <br>
	                                                    <button type="button" class="add btn btn-default mr5 mb10" onclick="images_add($(this))">사진등록</button>
	                                                    <input id="images_files2" name="images_files2" type="file" style="width:0px;height:0px;overflow:hidden">
	                                                    <input id="images_files2_old" name="images_files2_old" type="hidden" value="<%=Model.Images2%>">
	                                                    
	                                                    <%if Not(IsNothing(Model.Images2)) then%>
	                                                    <center>
	                                                    <div class="checkbox-custom checkbox-inline" style="width:120px;">
															<input id="Del_images_files2" name="Del_images_files2" class="check" type="checkbox" value="1">
															<label for="Del_images_files2">파일 삭제</label>
														</div>
														<center>
														<%end if%>
	                                                </div>
	                                                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <div style="height:120px;width:120px;margin:0px auto;">
	                                                    	<img style="height: 100%;width:0px;overflow:hidden;"><img src="<%=iif(IsNothing(Model.Images3) or Model.Images3="","../../images/bg_no_image.png","/upload/Devices/" &Model.Images3)%>" style="max-width:120px;max-height:120px;">
	                                                    </div>
	                                                    <br>
	                                                    <button type="button" class="add btn btn-default mr5 mb10" onclick="images_add($(this))">사진등록</button>
	                                                    <input id="images_files3" name="images_files3" type="file" style="width:0px;height:0px;overflow:hidden">
	                                                    <input id="images_files3_old" name="images_files3_old" type="hidden" value="<%=Model.Images3%>">
	                                                    
	                                                    <%if Not(IsNothing(Model.Images3)) then%>
	                                                    <center>
	                                                    <div class="checkbox-custom checkbox-inline" style="width:120px;">
															<input id="Del_images_files3" name="Del_images_files3" class="check" type="checkbox" value="1">
															<label for="Del_images_files3">파일 삭제</label>
														</div>
														<center>
														<%end if%>
	                                                </div>
	                                                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
	                                                    <div style="height:120px;width:120px;margin:0px auto;">
	                                                    	<img style="height: 100%;width:0px;overflow:hidden;"><img src="<%=iif(IsNothing(Model.Images4) or Model.Images4="","../../images/bg_no_image.png","/upload/Devices/" &Model.Images4)%>" style="max-width:120px;max-height:120px;">
	                                                    </div>
	                                                    <br>
	                                                    <button type="button" class="add btn btn-default mr5 mb10" onclick="images_add($(this))">사진등록</button>
	                                                    <input id="images_files4" name="images_files4" type="file" style="width:0px;height:0px;overflow:hidden">
	                                                    <input id="images_files4_old" name="images_files4_old" type="hidden" value="<%=Model.Images4%>">
	                                                    
	                                                    <%if Not(IsNothing(Model.Images4)) then%>
	                                                    <center>
	                                                    <div class="checkbox-custom checkbox-inline" style="width:120px;">
															<input id="Del_images_files4" name="Del_images_files4" class="check" type="checkbox" value="1">
															<label for="Del_images_files4">파일 삭제</label>
														</div>
														<center>
														<%end if%>
	                                                </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">상세설명 <p>권장사이즈 : 770px </p></label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents2" id="Contents2" rows="10" style="width:100%;"><%=Model.Contents2%></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">API설명 <p>권장사이즈 : 770px </p></label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Contents3" id="Contents3" rows="10" style="width:100%;"><%=Model.Contents3%></textarea>
                                                </div>
                                            </div>
                                            
                                                                                      
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">파일</label>
                                                <div class="col-lg-10 col-md-9">
                                                	<%
                                                	if Not(IsNothing(DevicesFilesModel)) then
                                                		For each obj in DevicesFilesModel.Items%>
                                                	<p class="form-control-static"><a href="/Utils/download.asp?pach=/upload/Devices/&file=<%=obj.Name%>"><%=obj.Name%></a> <button type="button" class="btn btn-xs btn-default ml10" onclick="del_file($(this),<%=obj.No%>)">삭제</button></p>
                                                	<%
                                                		Next
                                                	end if
                                                	%>
	                                                <div class="form-inline" id="file_area">
	                                                	<div class="mb10 file_item">
	                                                    	<input type="file" name="files" class="filestyle input-mini" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
	                                                    	<button type="button" class="btn btn-primary" onclick="row_controll($(this),'add')">+</button>
	                                                    	<button type="button" class="btn btn-danger" onclick="row_controll($(this),'remove')">-</button>
	                                                    </div>
	                                                </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">관련 어플리케이션</label>
                                                <div class="col-lg-10 col-md-9">
                                                	<%
                                                	if Not(IsNothing(RelationModel)) then
                                                		For each obj in RelationModel.Items%>
                                                	<p class="form-control-static"><%=obj.ProductName%> <button type="button" class="btn btn-xs btn-default ml10" onclick="del_relation($(this),<%=obj.No%>)">삭제</button></p>
                                                	<%
                                                		Next
                                                	end if
                                                	%>
                                            		<div class="form-inline" id="relation_area">
                                            			<div class="mb10 relation_item">
	                                                    	<select class="form-control input-xlarge" name="RelationMenu" onchange="call_relation($(this))">
		                                                    	<option value="">선택해주세요</option>
																<%if Not(IsNothing(ProductMenuModel)) then
																	For each MenuItem in ProductMenuModel.Items
																%>
				                                            	<option value="<%=MenuItem.No%>"><%=MenuItem.Name%></option>
				                                            	<%
																	Next
																end if%>
		                                                    </select>
		                                                    
		                                                    <select class="form-control input-xlarge" name="Relation">
		                                                    	<option value="">선택해주세요</option>
		                                                    </select>
	                                                    	<button type="button" class="btn btn-primary" onclick="row_relation_controll($(this),'add')">+</button>
	                                                    	<button type="button" class="btn btn-danger" onclick="row_relation_controll($(this),'remove')">-</button>
	                                                    </div>
                                                    </div>

                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">상태</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="State" name="State">
                                                    	<option value="">선택</option>
														<option value="0" <%=iif(Model.State="0","selected","")%>>승인</option>
														<option value="1" <%=iif(Model.State="1","selected","")%>>미승인</option>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="panel-body text-center">
                                            	<button type="button" class="btn btn-default btn-lg btn-alt pull-left" onclick="location.href='<%=ViewData("ActionList")%>';"> 목록 </button>
                                            	
												<button type="button" class="btn btn-primary btn-lg btn-alt" onclick="reg_fm()"> 등 록 </button>
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


function reg_fm(){
	oEditors.getById["Contents1"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["Contents2"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["Contents3"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var sContent1 = oEditors.getById["Contents1"].getIR(); 
	sContent1 = sContent1.replace(/\r/g, ''); 
	sContent1 = sContent1.replace(/[\n|\t]/g, ''); 
	sContent1 = sContent1.replace(/[\v|\f]/g, ''); 
	sContent1 = sContent1.replace(/<p><br><\/p>/gi, ''); 
	sContent1 = sContent1.replace(/<P>&nbsp;<\/P>/gi, ''); 
	sContent1 = sContent1.replace(/<br(\s)*\/?>/gi, ''); 
	sContent1 = sContent1.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); 
	sContent1 = sContent1.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var sContent2 = oEditors.getById["Contents2"].getIR(); 
	sContent2 = sContent2.replace(/\r/g, ''); 
	sContent2 = sContent2.replace(/[\n|\t]/g, ''); 
	sContent2 = sContent2.replace(/[\v|\f]/g, ''); 
	sContent2 = sContent2.replace(/<p><br><\/p>/gi, ''); 
	sContent2 = sContent2.replace(/<P>&nbsp;<\/P>/gi, ''); 
	sContent2 = sContent2.replace(/<br(\s)*\/?>/gi, ''); 
	sContent2 = sContent2.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); 
	sContent2 = sContent2.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var sContent3 = oEditors.getById["Contents3"].getIR(); 
	sContent3 = sContent3.replace(/\r/g, ''); 
	sContent3 = sContent3.replace(/[\n|\t]/g, ''); 
	sContent3 = sContent3.replace(/[\v|\f]/g, ''); 
	sContent3 = sContent3.replace(/<p><br><\/p>/gi, ''); 
	sContent3 = sContent3.replace(/<P>&nbsp;<\/P>/gi, ''); 
	sContent3 = sContent3.replace(/<br(\s)*\/?>/gi, ''); 
	sContent3 = sContent3.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); 
	sContent3 = sContent3.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	if( !$.trim( $('#MenuNo').val() ) ){
		alert('분류를 선택해주세요');return false;
	}
	if( !$.trim( $('#Name').val() ) ){
		alert('디바이스명을 입력해주세요');return false;
	}
	if( sContent1.length <= 0 ){
		alert('디바이스 요약설명을 입력해주세요');return false;
	}
	
	if( !$('#ImagesList').val() && !$('#ImagesList_old').val() ){
		alert('디바이스 리스트 이미지를 선택해주세요');return false;
	}
	
	if( (!$('#images_files1').val() && !$('#images_files1_old').val()) && (!$('#images_files2').val() && !$('#images_files2_old').val()) && (!$('#images_files3').val() && !$('#images_files3_old').val()) && (!$('#images_files4').val() && !$('#images_files4_old').val()) ){
		alert('디바이스 상세 이미지를 선택해주세요');return false;
	}
	
	if( sContent2.length <= 0 ){
		alert('디바이스 상세설명을 입력해주세요');return false;
	}
	if( sContent3.length <= 0 ){
		alert('API설명을 입력해주세요');return false;
	}
	if( !$.trim( $('#State').val() ) ){
		alert('상태를 선택해주세요');return false;
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
		url : "?controller=Devices&action=DelFile",
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




var $new_row_relation = $('#relation_area .relation_item').clone();
function row_relation_controll(obj,mode){
	var len     = $('#relation_area .relation_item').length;
	var parent  = obj.parent();
	var new_row = $new_row_relation.clone();
	
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

function del_relation(obj,No){
	if( !confirm('관련 어플리케이션을 삭제 하시겠습니까?') ){
		return false;
	}
	$.ajax({
		url : "?controller=Devices&action=DelRelation",
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

function images_add(obj){
	var parent = obj.parent();
	var input  = parent.find('input[type="file"]');
	var img    = parent.find('img');
	
	input.click();
	input.change(function(){
		readImage(this,img);
	});
}


function call_relation(obj){
	var parent = $(obj).parent();
	var input  = parent.find('select[name=Relation]');
	var menuNo = $(obj).val();
	
	if(!menuNo){
		input.html('<option value="">선택해주세요</option>');
		return false;
	}
	
	$.ajax({
		url : "?controller=Apps&action=AjaxAppsList&MenuNo="+menuNo+"&partial=True",
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("실패");
			console.log(jqxhr);
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '<option value="">선택해주세요</option>';
			$.each(json.LIST, function(key, value){
				html += '<option value="'+value.No+'">'+value.Name+'</option>';
			});
			input.html(html);
		}
	});
}
</script>
