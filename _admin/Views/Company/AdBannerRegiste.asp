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
								<h2>베너 관리</h2>
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
                                        <input type="hidden" id="Position" name="Position" value="Main">
                                        <input type="hidden" id="OrderNo" name="OrderNo" value="0">
                                        	
                                        	
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이름</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Name" name="Name" placeholder="제목" value="<%=Model.Name%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">URL</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Url" name="Url" placeholder="URL" value="<%=Model.Url%>">
                                                    <p>전체주소 ex : https://www.google.co.kr</p>
                                                </div>
                                            </div>
                                            
                                            
                                            <input type="hidden" id="oldImage" name="oldImage" value="<%=Model.Image%>">
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이미지</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="file" class="filestyle input-mini" id="Image" name="Image" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
                                                    
                                                    <%if Model.Image <> "" then %>
                                                    <p class="form-control-static ml10"><%=Model.Image%></p>
                                                    <div class="form-group ml10">
	                                                    <div class="checkbox-custom">
															<input class="check" type="checkbox" id="dellImage" name="dellImage" value="1">
															<label for="dellImage">파일삭제</label>
														</div>
													</div>
													<%end if%>
													<p>권장사이즈 : 297px X 296px</p>
                                                </div>
                                            </div>

                                            <div class="panel-body text-center">
                                            	<!--button type="button" class="btn btn-default btn-lg btn-alt pull-left" onclick="location.href='<%=ViewData("ActionList")%>';"> 목록 </button-->
												<button type="button" class="btn btn-primary btn-lg btn-alt" onclick="reg_fm()"> 등 록 </button>
												<!--button type="button" class="btn btn-danger btn-lg btn-alt" onclick="del_fm()"> 삭 제 </button-->
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
function reg_fm(){
	if( !$.trim( $('#Name').val() ) ){
		alert('제목을 입력해주세요');return false;
	}
	if( !$.trim( $('#Url').val() ) ){
		alert('Url을 입력해주세요');return false;
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