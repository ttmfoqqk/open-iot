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
								<h2>기업/OID 관리</h2>
							</div>
						</div>
						<div class="row">
						
						
							<div class="col-lg-12">
								<!-- col-lg-12 start here -->
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                        	<i class="fa fa-circle"></i> 기업/OID 관리
                                        </h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <form Id="mForm" class="form-horizontal group-border stripped" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                                        <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                                        <input type="hidden" id="Params" name="Params" value="<%=ViewData("Params")%>">
                                        <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                                        
                                        <input type="hidden" id="oldImgLogo" name="oldImgLogo" value="<%=Model.ImgLogo%>">
                                        <input type="hidden" id="oldImgBusiness" name="oldImgBusiness" value="<%=Model.ImgBusiness%>">
                                        
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">OID</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" name="Oid" name="Oid" value="<%=Model.Oid%>" placeholder="OID">
                                                </div>
                                            </div>
                                            
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
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">핸드폰</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="text" class="form-control input-mini" id="Hphone1" name="Hphone1" value="<%=Model.Hphone1%>" maxlength="4"> - 
                                                    <input type="text" class="form-control input-mini" id="Hphone2" name="Hphone2" value="<%=Model.Hphone2%>" maxlength="4"> - 
                                                    <input type="text" class="form-control input-mini" id="Hphone3" name="Hphone3" value="<%=Model.Hphone3%>" maxlength="4">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">기업명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Name" name="Name" value="<%=Model.Name%>" placeholder="기업명">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">회사메일</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Email" name="Email" value="<%=Model.Email%>" placeholder="회사메일">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">URL</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Url" name="Url" placeholder="URL" value="<%=Model.Url%>">
                                                    <p>전체주소 ex : https://www.google.co.kr</p>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">주소</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Addr" name="Addr" value="<%=Model.Addr%>" placeholder="주소">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">회사연락처</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="text" class="form-control input-mini" id="Phone1" name="Phone1" value="<%=Model.Phone1%>" maxlength="4"> - 
                                                    <input type="text" class="form-control input-mini" id="Phone2" name="Phone2" value="<%=Model.Phone2%>" maxlength="4"> - 
                                                    <input type="text" class="form-control input-mini" id="Phone3" name="Phone3" value="<%=Model.Phone3%>" maxlength="4">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">회사로고</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="file" class="filestyle input-mini" id="ImgLogo" name="ImgLogo" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
                                                    
                                                    <%if Model.ImgLogo <> "" then %>
                                                    <p class="form-control-static ml10"><a href="/Utils/download.asp?pach=/upload/Oid/&file=<%=Model.ImgLogo%>"><%=Model.ImgLogo%></a></p>
                                                    <div class="form-group ml10">
                                                    <div class="checkbox-custom">
															<input class="check" type="checkbox" id="dellImgLogo" name="dellImgLogo" value="1">
															<label for="dellImgLogo">파일삭제</label>
														</div>
													</div>
													<%end if%>
													<p>권장사이즈 : 148px X 120px</p>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">사업자 등록증</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="file" class="filestyle input-mini" id="ImgBusiness" name="ImgBusiness" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
                                                    
                                                    <%if Model.ImgBusiness <> "" then %>
                                                    <p class="form-control-static ml10"><a href="/Utils/download.asp?pach=/upload/Oid/&file=<%=Model.ImgBusiness%>"><%=Model.ImgBusiness%></a></p>
                                                    <div class="form-group ml10">
                                                    <div class="checkbox-custom">
															<input class="check" type="checkbox" id="dellImgBusiness" name="dellImgBusiness" value="1">
															<label for="dellImgBusiness">파일삭제</label>
														</div>
													</div>
													<%end if%>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">발급상태</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <select class="form-control" id="State" name="State">
                                                    	<option value="0" <%=iif(Model.State="0","selected","")%>>발급</option>
                                                    	<option value="1" <%=iif(Model.State="1","selected","")%>>미발급</option>
                                                    	<option value="2" <%=iif(Model.State="2","selected","")%>>기업</option>
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
<script type="text/javascript">
function reg_fm(){
	if( !$.trim( $('#Hphone1').val() ) || !$.trim( $('#Hphone2').val() ) || !$.trim( $('#Hphone3').val() ) ){
		alert('핸드폰 번호를 입력해주세요');return false;
	}
	if( !$.trim( $('#Name').val() ) ){
		alert('기업명을 입력해주세요');return false;
	}
	if( !$.trim( $('#Email').val() ) ){
		alert('회사메일을 입력해주세요');return false;
	}
	if( !$.trim( $('#Url').val() ) ){
		alert('Url을 입력해주세요');return false;
	}
	if( !$.trim( $('#Addr').val() ) ){
		alert('주소를 입력해주세요');return false;
	}
	if( !$.trim( $('#Phone1').val() ) || !$.trim( $('#Phone2').val() ) || !$.trim( $('#Phone3').val() ) ){
		alert('회사연락처를 입력해주세요');return false;
	}
	$('#mForm').submit();
}
function del_fm(){
	if( confirm('삭제 하시겠습니까?') ){
		$('#ActionType').val('DELETE');
		$('#mForm').submit();
	}
}
</script>
<!--#include file="../inc/footer.asp" -->