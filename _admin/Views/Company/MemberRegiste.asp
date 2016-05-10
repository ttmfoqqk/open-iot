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
								<h2>사원 관리</h2>
							</div>
						</div>
						<div class="row">
						
						
							<div class="col-lg-12">
								<!-- col-lg-12 start here -->
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                        	<i class="fa fa-circle"></i> 사원등록
                                        </h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <form Id="mForm" class="form-horizontal group-border stripped" action="<%=ViewData("ActionForm")%>" method="POST">
                                        <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                                        <input type="hidden" id="Params" name="Params" value="<%=ViewData("Params")%>">
                                        <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                                        
                                        
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">아이디</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Id" name="Id" value="<%=Model.Id%>" <%=iif(ViewData("ActionType")="UPDATE","readonly","")%> placeholder="아이디">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">비밀번호</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Pwd" name="Pwd" value="<%=Model.Pwd%>" placeholder="비밀번호">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이름</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Name" name="Name" value="<%=Model.Name%>" placeholder="이름">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이메일</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" id="Email" name="Email" value="<%=Model.Email%>" placeholder="이메일">
                                                </div>
                                            </div>
                                            
                                             <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">권한</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="Level" name="Level">
                                                    	<option value="">선택</option>
                                                    	<option value="0" <%=iif(Model.Level="0","selected","")%>>전체 관리</option>
                                                    	<option value="1" <%=iif(Model.Level="1","selected","")%>>판교 관리</option>
                                                    	<option value="2" <%=iif(Model.Level="2","selected","")%>>송도 관리</option>
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
	if( !$.trim( $('#Id').val() ) ){
		alert('아이디를 입력해주세요');return false;
	}
	if( !$.trim( $('#Pwd').val() ) ){
		alert('비밀번호를 입력해주세요');return false;
	}
	if( !$.trim( $('#Name').val() ) ){
		alert('이름을 입력해주세요');return false;
	}
	if( !$.trim( $('#Email').val() ) ){
		alert('이메일을 입력해주세요');return false;
	}
	if( !$.trim( $('#Level').val() ) ){
		alert('권한을 선택해주세요');return false;
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