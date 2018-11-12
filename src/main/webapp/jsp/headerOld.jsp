<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${pageContext.request.userPrincipal.name == null}">
   <% response.sendRedirect("login");%>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Acquiro-Central Acquiring System </title>
	<link rel="shortcut icon" href="resources/images/logo.png">
    <!-- Bootstrap core CSS -->
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="resources/css/animate.min.css" rel="stylesheet">
    <!-- Custom styling plus plugins -->
    <link href="resources/css/custom.css" rel="stylesheet">    
    <link rel="stylesheet" type="text/css" href="resources/css/maps/jquery-jvectormap-2.0.1.css" />
    <link href="resources/css/icheck/flat/green.css" rel="stylesheet" />
    <link href="resources/css/floatexamples.css" rel="stylesheet" type="text/css" />
    <link href="resources/css/datatables/tools/css/dataTables.tableTools.css" rel="stylesheet">
	<link rel="stylesheet" href="/resources/css/loaderstyle.css">
 	<link rel="stylesheet" href="/CAS/resources/css/loaderstyle.css">
    <!-- editor -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <link href="resources/css/editor/external/google-code-prettify/prettify.css" rel="stylesheet">
    <link href="resources/css/editor/index.css" rel="stylesheet">
    <script src="<c:url value="resources/js/acqcitystate.js" />"></script>
 	<script src="<c:url value="resources/js/businesscode.js" />"></script>
    <!-- select2 -->
    <link href="resources/css/select/select2.min.css" rel="stylesheet">
    <!-- switchery -->
    <link rel="stylesheet" href="resources/css/switchery/switchery.min.css" />
    <script src="resources/js/jquery.min.js"></script>
    <script src="resources/js/nprogress.js"></script>
    <script>
        NProgress.start();
    </script>
 </head>

<body class="nav-md">
    <div class="container body">
    <div class="custom-header">
    <div class="profile-img">
    <img src="resources/images/logo.png" alt="..." class="profile-img-thumb">
    </div>
    <div class="custom-quick-links">
        <ul>
            <li><a href="<c:url value='welcome' />"><i class="fa fa-home" aria-hidden="true"></i><span>Home</span></a></li>
              <% if(!(session.getAttribute("empRole").equals("12"))){	%>
              <li><a href="<c:url value='addmerchant' />"><i class="fa fa-user" aria-hidden="true"></i><span>Add Merchant</span></a></li>
              <%}%>
            <li><a href="<c:url value='list' />"><i class="fa fa-users" aria-hidden="true"></i><span>Merchant List</span></a></li> 
            <li><a href="<c:url value='walletList' />"><i class="fa fa-list" aria-hidden="true"></i><span>Transaction</span></a></li>
             <% if(!(session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("2"))){	%>
            <li><a href="<c:url value='settingHome' />"><i class="fa fa-cogs" aria-hidden="true"></i><span>Setting</span></a></li>
            <%}%>
            <li><a href="<c:url value='logout'/>"><i class="fa fa-sign-out" aria-hidden="true"></i><span>Sign Out</span></a></li>      
        </ul>       
    </div>
</div>
        <div class="main_container">
            <div class="col-md-3 left_col">
                <div class="left_col scroll-view">
                    <div class="navbar nav_title" style="border: 0;">
                        <a href="<c:url value='welcome' />" class="site_title"><span><center>Acquiro MMS</center></span></a>
                    </div>
                    <div class="clearfix"></div>
                    <!-- menu prile quick info -->
                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                        <div class="menu_section">
                             <ul class="nav side-menu">
                               <% if(session.getAttribute("empRole").equals("1")){	%>
                              					<jsp:include page="/jsp/adminHeader.jsp" /> 
                              	<%}%>                      
                                                           
                              	 
                              </ul>
                        </div>
                     </div>
                </div>
            </div>
            <!-- top navigation -->
            <div class="top_nav">
                <div class="nav_menu">
                    <nav class="" role="navigation">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <img src="resources/images/logo.png" alt=""><%= session.getAttribute("userName") %>
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                                   <li><a href="<c:url value='logout'/>"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <!-- /top navigation -->
