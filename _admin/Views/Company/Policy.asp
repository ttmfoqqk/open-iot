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
                        <!-- Start .page-content-inner -->
                        <div id="page-header" class="clearfix">
                            <div class="page-header">
                                <h2>약관 관리</h2>
                                <span class="txt"> </span>
                            </div>
                        </div>
                        <!-- Start .row -->
                        <div class="row">
                            <div class="col-lg-12">
                            	
                            	
                            	<form id="validate" method="POST" action="<%=ViewData("ActionForm")%>" class="form-horizontal group-border stripped" role="form">
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">이용약관</h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <div class="form-group">
                                            <div class="col-lg-12 col-md-12">
                                                <textarea class="form-control" name="Policy1" id="Policy1" rows="10"><%=Model.Policy1%></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-primary">
                                    <!-- Start .panel -->
                                    <div class="panel-heading">
                                        <h4 class="panel-title">개인정보취급방침</h4>
                                    </div>
                                    <div class="panel-body pt0 pb0">
                                        <div class="form-group">
                                            <div class="col-lg-12 col-md-12">
                                                <textarea class="form-control" name="Policy2" id="Policy2" rows="10"><%=Model.Policy2%></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12 text-center">
                                                <button class="btn btn-primary btn-lg btn-alt" type="submit"> 등 록 </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </form>
                                
                                
                                
                            </div>
                            <!-- col-lg-12 end here -->
                        </div>
                        <!-- End .row -->
                    </div>
                    <!-- End .page-content-inner -->
                </div>
                <!-- / page-content-wrapper -->
            </div>
            <!-- / page-content -->
        </div>
<!--#include file="../inc/footer.asp" -->