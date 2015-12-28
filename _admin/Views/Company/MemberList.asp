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
											<i class="fa fa-circle"></i> 사원목록
										</h4>
									</div>
									<div class="panel-body">
										<!-- 검색 -->
										<form class="form-horizontal" method="GET">
										<input type="hidden" name="controller" value="<%=controller%>">
										<input type="hidden" name="action" value="<%=action%>">
										
											<div class="form-group col-lg-12 col-md-12">
												<label class="col-lg-2 col-md-2 control-label" for="">등록기간</label>
												<div class="col-lg-6 col-md-6">
													<div class="input-daterange input-group">
														<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
														<input type="text" class="form-control" name="sData" id="sData" value="" />
														<span class="input-group-addon">to</span>
														<input type="text" class="form-control" name="eData" id="eData" value=""/>
													</div>
												</div>
												<div class="col-lg-4 col-md-4 hidden-xs hidden-sm">
													<button type="button" class="btn btn-sm btn-primary btn-alt" id="sToday">오늘</button>
													<button type="button" class="btn btn-sm btn-primary btn-alt" id="sWeek">7일</button>
													<button type="button" class="btn btn-sm btn-primary btn-alt" id="sMonth">30일</button>
													<button type="button" class="btn btn-sm btn-primary btn-alt" id="sReset">날짜초기화</button>
												</div>
											</div>
											
											<div class="form-group col-lg-12 col-md-12">
												<label class="col-lg-2 col-md-2 control-label" for="">아이디</label>
												<div class="col-lg-3 col-md-3">
													<input type="text" class="form-control" id="name" name="name" placeholder="이름" value="">
												</div>
			
												<label class="col-lg-2 col-md-2 control-label" for="">이름</label>
												<div class="col-lg-3 col-md-3">
													<input type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰번호" value="">
												</div>
												
												<div class="col-lg-2 col-md-2">
													<button type="submit" class="btn btn-primary btn-alt mr5 mb10">검 색</button>
												</div>
											</div>

										</form>
										<!-- 검색 -->
			
										<form id="member-form-list" action="<?echo $action_url;?>" method="post" class="form-horizontal group-border stripped" role="form">
										<input type="hidden" name="action_type" id="action_type" value="">
										<input type="hidden" name="parameters" id="parameters" value="<?echo $parameters;?>">
											
											<table class="table table-bordered" id="tabletools">
												<thead>
													<tr>
														<th style="width: 45px;">
															<div class="checkbox-custom">
																<input class="check-all" type="checkbox" id="masterCheck" value="option1">
																<label for="masterCheck"></label>
															</div>
														</th>
														<th>아이디</th>
														<th>이름</th>
														<th class="per15">등록일자</th>
													</tr>
												</thead>
												<tbody>

												<%if IsNothing(Model) then %>
													<tr>
														<td colspan="4">등록된 내용이 없습니다.</td>
													</tr>
												<%else
													Dim obj,anchor
													For each obj in Model.Items
													
													anchor = ViewData("ActionRegiste") & "&No=" & obj.No
												%>
													<tr>
														<td>
															<div class="checkbox-custom">
																<input id="no" name="no" class="check" type="checkbox" value="<%=obj.No%>">
																<label for="check"></label>
															</div>
														</td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.Id%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.Name%></a></td>
														<td><a href="<%=anchor%>" class="text-normal"><%=obj.Indate%></a></td>
													</tr>
												<%
													Next
												end if%>
												
											</tbody>
											</table>
			
											<div class="panel-body" style="text-align: center;">pagination</div>
											<div class="panel-body text-center">
												<button type="button" class="btn btn-primary btn-lg btn-alt" onclick="location.href='<%=ViewData("ActionRegiste")%>';"> 등 록 </button>
												<button type="button" class="btn btn-danger btn-lg btn-alt" onclick="alert('준비중')"> 삭 제 </button>
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