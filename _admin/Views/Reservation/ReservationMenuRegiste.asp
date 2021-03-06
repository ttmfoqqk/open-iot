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
								<h2>시설 관리</h2>
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
                                        <form Id="mForm" class="form-horizontal group-border stripped" action="<%=ViewData("ActionForm")%>" method="POST">
                                        <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                                        <input type="hidden" id="Params" name="Params" value="<%=ViewData("Params")%>">
                                        <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                                        
                                        	<div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">구분</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="Location" name="Location">
                                                    	<option value="">선택</option>
                                                    	<%if AdminModel.Level = "1" then %>
                                                    	<option value="1" <%=iif(Model.Location="1","selected","")%>>판교</option>
                                                    	<%elseif AdminModel.Level = "2" then %>
                                                    	<option value="2" <%=iif(Model.Location="2","selected","")%>>송도</option>
                                                    	<%elseif AdminModel.Level = "3" then %>
                                                    	<option value="3" <%=iif(Model.Location="3","selected","")%>>TTA IoT 시험소</option>
                                                    	<%else%>
                                                    	<option value="1" <%=iif(Model.Location="1","selected","")%>>판교</option>
                                                    	<option value="2" <%=iif(Model.Location="2","selected","")%>>송도</option>
                                                    	<option value="3" <%=iif(Model.Location="3","selected","")%>>TTA IoT 시험소</option>
                                                    	<%end if%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이름</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Name" name="Name" value="<%=Model.Name%>" placeholder="분류명">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">순서</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control input-mini" id="OrderNo" name="OrderNo" value="<%=Model.OrderNo%>" placeholder="순서">
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
	if( !$.trim( $('#Location').val() ) ){
		alert('구분을 선택해주세요');return false;
	}
	if( !$.trim( $('#Name').val() ) ){
		alert('분류명을 입력해주세요');return false;
	}
	if( !$.trim( $('#OrderNo').val() ) ){
		alert('순서를 입력해주세요');return false;
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