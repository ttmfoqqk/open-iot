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
								<h2>OID 관리</h2>
							</div>
						</div>
						<div class="row">
						
						
							<div class="col-lg-12">
								<!-- col-lg-12 start here -->
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                        	<i class="fa fa-circle"></i> OID 관리
                                        </h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <form class="form-horizontal group-border stripped" method="POST">
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">OID</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" name="default">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">아이디</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <p class="form-control-static">아이디</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">이름</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <p class="form-control-static">이름</p>
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3  control-label" for="">핸드폰</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <p class="form-control-static">010-1111-1111</p>
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">기업명</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <p class="form-control-static">기업명</p>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">회사메일</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" name="default">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">주소</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="text" class="form-control" name="default">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">회사연락처</label>
                                                <div class="col-lg-10 col-md-9 form-inline">
                                                    <input type="text" class="form-control input-mini" name="default"> - 
                                                    <input type="text" class="form-control input-mini" name="default"> - 
                                                    <input type="text" class="form-control input-mini" name="default">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">회사로고</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="file" class="filestyle" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-lg-2 col-md-3 control-label" for="">사업자 등록증</label>
                                                <div class="col-lg-10 col-md-9">
                                                    <input type="file" class="filestyle" data-buttonText="Find file" data-buttonName="btn-danger" data-iconName="fa fa-plus">
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
<!--#include file="../inc/footer.asp" -->