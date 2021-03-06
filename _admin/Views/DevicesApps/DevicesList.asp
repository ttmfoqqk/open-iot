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
											<i class="fa fa-circle"></i> 목록
										</h4>
									</div>
									<div class="panel-body">
										<!-- 검색 -->
										<form class="form-horizontal" method="GET">
										<input type="hidden" name="controller" value="<%=controller%>">
										<input type="hidden" name="action" value="<%=action%>">
										
											<div class="form-group col-lg-12 col-md-12">
												<label class="col-lg-2 col-md-2 control-label" for="">등록일</label>
												<div class="col-lg-6 col-md-6">
													<div class="input-daterange input-group">
														<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
														<input type="text" class="form-control" name="sDate" id="sDate" value="<%=Request("sDate")%>" />
														<span class="input-group-addon">to</span>
														<input type="text" class="form-control" name="eDate" id="eDate" value="<%=Request("eDate")%>"/>
													</div>
												</div>
												<div class="col-lg-4 col-md-4 hidden-xs hidden-sm">
													<button type="button" class="btn btn-sm btn-primary btn-alt" onclick="set_btn_datepicker($('#sDate'),$('#eDate'),0);">오늘</button>
													<button type="button" class="btn btn-sm btn-primary btn-alt" onclick="set_btn_datepicker($('#sDate'),$('#eDate'),-7);">7일</button>
													<button type="button" class="btn btn-sm btn-primary btn-alt" onclick="set_btn_datepicker($('#sDate'),$('#eDate'),-30);">30일</button>
													<button type="button" class="btn btn-sm btn-primary btn-alt" onclick="set_btn_datepicker($('#sDate'),$('#eDate'),null);">날짜초기화</button>
												</div>
											</div>
											
											<div class="form-group col-lg-12 col-md-12">
												<label class="col-lg-2 col-md-2 control-label" for="">아이디</label>
												<div class="col-lg-3 col-md-3">
													<input type="text" class="form-control" id="UserId" name="UserId" placeholder="아이디" value="<%=Request("UserId")%>">
												</div>
			
												<label class="col-lg-2 col-md-2 control-label" for="">이름</label>
												<div class="col-lg-3 col-md-3">
													<input type="text" class="form-control" id="UserName" name="UserName" placeholder="이름" value="<%=Request("UserName")%>">
												</div>
											</div>
											
											<div class="form-group col-lg-12 col-md-12">
												<label class="col-lg-2 col-md-2 control-label" for="">분류</label>
												<div class="col-lg-3 col-md-3">
													<select class="form-control" name="MenuNo">
														<option value="">선택</option>
														<%if Not(IsNothing(DevicesMenuModel)) then
															Dim MenuItem
															For each MenuItem in DevicesMenuModel.Items
														%>
                                                    	<option value="<%=MenuItem.No%>" <%=iif(Request("MenuNo")=Cstr(MenuItem.No),"selected","")%>><%=MenuItem.Name%></option>
                                                    	<%
															Next
														end if%>
                                                    </select>
												</div>
												
												<label class="col-lg-2 col-md-2 control-label" for="">상태</label>
												<div class="col-lg-3 col-md-3">
													<select class="form-control" name="State">
														<option value="">선택</option>
														<option value="0" <%=iif(Request("State")="0","selected","")%>>승인</option>
														<option value="1" <%=iif(Request("State")="1","selected","")%>>미승인</option>
                                                    </select>
												</div>
											</div>
											
											<div class="form-group col-lg-12 col-md-12">
												<label class="col-lg-2 col-md-2 control-label" for="">디바이스명</label>
												<div class="col-lg-8 col-md-8">
													<input type="text" class="form-control" id="Name" name="Name" placeholder="디바이스명" value="<%=Request("Name")%>">
												</div>
												<div class="col-lg-2 col-md-2">
													<button type="submit" class="btn btn-primary btn-alt mr5 mb10">검 색</button>
												</div>
											</div>

										</form>
										<!-- 검색 -->
			
										<form id="mForm" action="<%=ViewData("ActionForm")%>" method="post" class="form-horizontal group-border stripped" role="form" enctype="multipart/form-data">
										<input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                                        <input type="hidden" id="Params" name="Params" value="<%=ViewData("Params")%>">
											
											<a href="<%=ViewData("ActionExcel")%>" class="btn btn-primary mr5 mb10">엑셀 다운로드</a>
											<table class="table table-bordered" id="tabletools">
												<thead>
													<tr>
														<th style="width: 45px;">
															<div class="checkbox-custom">
																<input class="check-all" type="checkbox" id="masterCheck" value="option1">
																<label for="masterCheck"></label>
															</div>
														</th>
														<th class="per20">분류</th>
														<th>디바이스명</th>
														<th>아이디</th>
														<th>이름</th>
														<th>등록일</th>
														<th class="per5">상태</th>
													</tr>
												</thead>
												<tbody>

												<%if IsNothing(Model) then %>
													<tr>
														<td colspan="7">등록된 내용이 없습니다.</td>
													</tr>
												<%else
													Dim obj,anchor
													For each obj in Model.Items
													
													anchor = ViewData("ActionRegiste") & "&No=" & obj.No
												%>
													<tr>
														<td>
															<div class="checkbox-custom">
																<input id="No" name="No" class="check" type="checkbox" value="<%=obj.No%>">
																<label for="check"></label>
															</div>
														</td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.MenuName%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.Name%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.UserId%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.UserName%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.Indate%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=iif(obj.State="0","승인","<span class=""text-danger"">미승인</span>")%></a></td>
													</tr>
												<%
													Next
												end if%>
												
											</tbody>
											</table>
			
											<div class="panel-body" style="text-align: center;"><%=ViewData("pagination")%></div>
											<div class="panel-body text-center">
												<!--button type="button" class="btn btn-primary btn-lg btn-alt" onclick="location.href='<%=ViewData("ActionRegiste")%>';"> 등 록 </button-->
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
function del_fm(){
	var fm = $('#mForm');
	if( $(":checkbox[name='No']:checked").length==0 ){
		alert("삭제할 항목을 하나이상 체크해주세요.");
		return;
	}
	fm.submit();
}
</script>
<!--#include file="../inc/footer.asp" -->