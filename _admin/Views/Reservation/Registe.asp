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
								<h2>예약 관리</h2>
							</div>
						</div>
						<div class="row">
						
						
							<div class="col-lg-12">
								<!-- col-lg-12 start here -->
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                        	<i class="fa fa-circle"></i> 회원 등록
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
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">시설명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="Facilities" name="Facilities">
                                                    	<option value="">구분을 선택하세요.</option>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">핸드폰</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="text" class="form-control input-mini" id="Hphone1" name="Hphone1" value="<%=Model.Hphone1%>" maxlength="4"> - 
                                                    <input type="text" class="form-control input-mini" id="Hphone2" name="Hphone2" value="<%=Model.Hphone2%>" maxlength="4"> - 
                                                    <input type="text" class="form-control input-mini" id="Hphone3" name="Hphone3" value="<%=Model.Hphone3%>" maxlength="4">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">사용 희망일</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <div class="input-daterange form-inline">
														<input type="text" class="form-control " name="UseDate" id="UseDate" value="<%=Model.UseDate%>" />
														~ 
														<input type="text" class="form-control " name="UseEndDate" id="UseEndDate" value="<%=Model.UseEndDate%>" />
													</div>
                                                </div>
                                            </div>
                                            <!--div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">사용 시간</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
													<select class="form-control input-small" id="Stime1" name="Stime1">
                                                    	<option value="">선택</option>
                                                    	<%for i=7 to 23%>
                                                    	<option value="<%=iif(i<10,"0"&i,i)%>" <%=iif(Stime1=cstr(iif(i<10,"0"&i,i)),"selected","")%>><%=iif(i<10,"0"&i,i)%></option>
                                                    	<%next%>
                                                    </select> : 
                                                    <select class="form-control input-small" id="Stime2" name="Stime2">
                                                    	<option value="">선택</option>
                                                    	<%for i=0 to 60 step 10%>
                                                    	<option value="<%=iif(i<10,"0"&i,i)%>" <%=iif(Stime2=cstr(iif(i<10,"0"&i,i)),"selected","")%>><%=iif(i<10,"0"&i,i)%></option>
                                                    	<%next%>
                                                    </select>
                                                    ~
                                                    <select class="form-control input-small" id="Etime1" name="Etime1">
                                                    	<option value="">선택</option>
                                                    	<%for i=7 to 23%>
                                                    	<option value="<%=iif(i<10,"0"&i,i)%>" <%=iif(Etime1=cstr(iif(i<10,"0"&i,i)),"selected","")%>><%=iif(i<10,"0"&i,i)%></option>
                                                    	<%next%>
                                                    </select> : 
                                                    <select class="form-control input-small" id="Etime2" name="Etime2">
                                                    	<option value="">선택</option>
                                                    	<%for i=0 to 60 step 10%>
                                                    	<option value="<%=iif(i<10,"0"&i,i)%>" <%=iif(Etime2=cstr(iif(i<10,"0"&i,i)),"selected","")%>><%=iif(i<10,"0"&i,i)%></option>
                                                    	<%next%>
                                                    </select>
                                                </div>
                                            </div-->
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이용목적</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Purpose" id="Purpose" rows="5"><%=Model.Purpose%></textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">비고</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <textarea class="form-control" name="Bigo" id="Bigo" rows="5"><%=Model.Bigo%></textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">상태</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <select class="form-control input-xlarge" id="State" name="State">
                                                    	<option value="">선택</option>
                                                    	<option value="1" <%=iif(Model.State="1","selected","")%>>예약</option>
                                                    	<option value="2" <%=iif(Model.State="2","selected","")%>>확정</option>
                                                    	<option value="0" <%=iif(Model.State="0","selected","")%>>지원완료</option>
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
window.onload=function(){
	SetFacilities( $('#Location').val() ,'<%=Model.Facilities%>');
	
	$('#Location').change(function(){
		if( $(this).val() == '' ){
			$('#Facilities').html('<option value="">구분을 선택하세요.</option>');
		}else{
			SetFacilities( $(this).val() ,'<%=Model.Facilities%>');
		}
	});
}

function reg_fm(){
	if( !$.trim( $('#Location').val() ) ){
		alert('구분을 선택해주세요');return false;
	}
	if( !$.trim( $('#Facilities').val() ) ){
		alert('시설명을 선택해주세요');return false;
	}
	if( !$.trim( $('#Hphone1').val() ) || !$.trim( $('#Hphone2').val() ) || !$.trim( $('#Hphone3').val() ) ){
		alert('핸드폰을 입력해주세요');return false;
	}
	if( !$.trim( $('#UseDate').val() ) ){
		alert('사용 희망일을 입력해주세요');return false;
	}
	if( !$.trim( $('#UseEndDate').val() ) ){
		alert('사용 희망일을 입력해주세요');return false;
	}
	if( !$('#State').val() ){
		alert('상태를 선택해주세요');return false;
	}
	
	/*
	if( $('#State').val() == '0' ){
		if( !$('#Stime1').val() || !$('#Stime2').val() || !$('#Etime1').val() || !$('#Etime2').val() ){
			alert('사용 시간을 선택해주세요');return false;
		}
	}
	*/
	
	$('#mForm').submit();
}
function del_fm(){
	if( confirm('삭제 하시겠습니까?') ){
		$('#ActionType').val('DELETE');
		$('#mForm').submit();
	}
}

function SetFacilities(Location,Facilities){
	if( !Location ){return false;}
	$.ajax({
		url : "?controller=Reservation&action=AjaxMenuList&partial=True&Location="+Location,
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("잠시후에 시도해 주세요.");
			console.log(jqxhr);
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '<option value="">선택</option>';
	
			$.each(json, function(key, value){
				html += '<option value="'+value.No+'" '+(Facilities==value.No?'selected':'')+'>'+value.Name+'</option>';
			});
			$('#Facilities').html(html);
		}
	});
}
</script>
<!--#include file="../inc/footer.asp" -->