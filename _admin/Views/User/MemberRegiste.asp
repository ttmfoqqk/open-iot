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
								<h2>회원 관리</h2>
							</div>
						</div>
						<div class="row">
						
						
							<div class="col-lg-12">
								<!-- col-lg-12 start here -->
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                        	<i class="fa fa-circle"></i> 회원 정보
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
                                                	<input type="text" class="form-control" id="Id" name="Id" value="<%=Model.Id%>" placeholder="아이디" maxlength="320">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이름</label>
                                                <div class="col-lg-10 col-md-9">
                                                	<input type="text" class="form-control" id="Name" name="Name" value="<%=Model.Name%>" placeholder="이름" maxlength="50">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">비밀번호</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="password" class="form-control input-xlarge" id="Pwd" name="Pwd" value="" placeholder="비밀번호">
                                                    <span class="text-danger"> * 변경시 작성</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">핸드폰 뒷자리</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control input-medium" id="Phone3" name="Phone3" value="<%=Model.Phone3%>" maxlength="4">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이메일 인증</label>
                                                <div class="col-lg-10 col-md-9">
                                                	<select class="form-control input-medium" id="State" name="State">
                                                    	<option value="0" <%=iif(Model.State="0","selected","")%>>인증</option>
                                                    	<option value="1" <%=iif(Model.State="1","selected","")%>>미인증</option>
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
var _reg_mail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,10}$/i;

function reg_fm(){
	if( !$.trim( $('#Id').val() ) ){
		alert('아이디를 입력해주세요.');return false;
	}
	
	if( !_reg_mail.test( $('#Id').val() ) ){
		alert('잘못된 이메일 형식 입니다.');return false;
	}
	
	if( !$.trim( $('#Name').val() ) ){
		alert('이름을 입력해주세요.');return false;
	}
	
	
	if( !$.trim( $('#Phone3').val() ) ){
		alert('핸드폰 뒷자리를 입력해주세요');return false;
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