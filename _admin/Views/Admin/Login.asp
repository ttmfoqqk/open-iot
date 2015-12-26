<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>OPEN-IOT</title>
        <!-- Mobile specific metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1 user-scalable=no">
        <!-- Force IE9 to render in normal mode -->
        <!--[if IE]><meta http-equiv="x-ua-compatible" content="IE=9" /><![endif]-->
        <meta name="author" content="" />
        <meta name="description" content="" />
        <meta name="keywords" content="" />
        <meta name="application-name" content="" />
        <!-- Import google fonts - Heading first/ text second -->
        <link href='http://fonts.googleapis.com/css?family=Quattrocento+Sans:400,700' rel='stylesheet' type='text/css'>
        <!-- Css files -->
        <!-- Icons -->
        <link href="./Views/css/icons.css" rel="stylesheet" />
        <!-- Bootstrap stylesheets (included template modifications) -->
        <link href="./Views/css/bootstrap.css" rel="stylesheet" />
        <!-- Plugins stylesheets (all plugin custom css) -->
        <link href="./Views/css/plugins.css" rel="stylesheet" />
        <!-- Main stylesheets (template main css file) -->
        <link href="./Views/css/main.css" rel="stylesheet" />
        <!-- Custom stylesheets ( Put your own changes here ) -->
        <link href="./Views/css/custom.css" rel="stylesheet" />
        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="./Views/img/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="./Views/img/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="./Views/img/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="./Views/img/ico/apple-touch-icon-57-precomposed.png">
        <link rel="icon" href="./Views/img/ico/favicon.ico" type="image/png">
        <!-- Windows8 touch icon ( http://www.buildmypinnedsite.com/ )-->
        <meta name="msapplication-TileColor" content="#3399cc" />
    </head>
    <body class="login-page">
        <!-- Start login container -->
        <div class="container login-container">
            <div class="login-panel panel panel-default plain animated bounceIn">
                <!-- Start .panel -->
                <div class="panel-heading">
                    <h4 class="panel-title text-center">
                        <img id="logo" src="./Views/img/logo-dark.png" alt="Dynamic logo">
                    </h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal mt0" method="POST" action="<%=ViewData("ActionForm")%>" id="login-form" role="form">
                    <input type="hidden" name="goUrl" value="<%=ViewData("GoUrl")%>">
                        <div class="form-group">
                            <div class="col-lg-12">
                                <div class="input-group input-icon">
                                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                    <input type="text" name="Id" id="Id" class="form-control" value="<%=ViewData("SaveId")%>" placeholder="Your id">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <div class="input-group input-icon">
                                    <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                    <input type="password" name="Pwd" id="Pwd" class="form-control" value="" placeholder="Your password">
                                </div>
                                 
                            </div>
                        </div>
                        <div class="form-group mb0">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-8">
                                <div class="checkbox-custom">
                                    <input type="checkbox" name="saveId" id="saveId" value="on" <%=ViewData("SaveIdChecked")%>>
                                    <label for="saveId">Remember me ?</label>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-4 mb25">
                                <button class="btn btn-default pull-right" type="submit">Login</button>
                            </div>
                        </div>
                    </form>
                    
                </div>
                
            </div>
            <!-- End .panel -->
        </div>
        <!-- End login container -->
        <div class="container">
            <div class="footer">
                <p class="text-center">KETI © 2014 ALL RIGHTS RESERVED</p>
            </div>
        </div>
        <!-- Javascripts -->
        <!-- Important javascript libs(put in all pages) -->
        <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script>
        window.jQuery || document.write('<script src="assets/js/libs/jquery-2.1.1.min.js">\x3C/script>')
        </script>
        <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <script>
        window.jQuery || document.write('<script src="assets./Views/js/libs/jquery-ui-1.10.4.min.js">\x3C/script>')
        </script>
        <!--[if lt IE 9]>
		  <script type="text/javascript" src="./Views/js/libs/excanvas.min.js"></script>
		  <script type="text/javascript" src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		  <script type="text/javascript" src="./Views/js/libs/respond.min.js"></script>
		<![endif]-->
        <!-- Bootstrap plugins -->
        <script src="./Views/js/bootstrap/bootstrap.js"></script>
        <!-- Form plugins -->
        <script src="./Views/plugins/forms/validation/jquery.validate.js"></script>
        <script src="./Views/plugins/forms/validation/additional-methods.min.js"></script>
        <!-- Init plugins olny for this page -->
        
    </body>
</html>