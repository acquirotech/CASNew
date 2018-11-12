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

    <title>Acquiro ERP </title>
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

    <!-- editor -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <link href="resources/css/font-awesome.css" rel="stylesheet">
    <link href="resources/css/editor/external/google-code-prettify/prettify.css" rel="stylesheet">
    <link href="resources/css/editor/index.css" rel="stylesheet">
    <script src="<c:url value="resources/js/ezcitystate.js" />"></script>
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
        <div class="main_container">
            <div class="col-md-3 left_col">
                <div class="left_col scroll-view">
                    <div class="navbar nav_title" style="border: 0;">
                        <a href="<c:url value='welcome' />" class="site_title"><span><center>Acquiro ERP</center></span></a>
                    </div>
                    <div class="clearfix"></div>
                    <!-- menu prile quick info -->
                    <div class="profile">
                        <div class="profile_pic">
                            <img src="resources/images/logo.png" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                            <span>Welcome,</span>
                            <h2><%= session.getAttribute("userName") %></h2>
                        </div>
                      </div>
                    <!-- /menu prile quick info -->
                    <br />
                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                        <div class="menu_section">
                           <br clear="all">
                              <ul class="nav side-menu">
                               <% if(session.getAttribute("empRole").equals("1")){	%>
                              
                              <li><a href="<c:url value='welcome' />"><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                                </li>
                                 <li><a href="<c:url value='beneficiaryHome' />"><i class="fa fa-desktop"></i>Beneficiary File <span class="fa fa-chevron-down"></span></a>
                                </li>
                                 <li><a><i class="fa fa-edit"></i> PayOut Process <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     	<li><a href="<c:url value='walletPayOutHome' />">Wallet PayOut</a></li>
                                     	<li><a href="<c:url value='cardPayoutHome' />">Card PayOut</a></li>
                                     	<li><a href="<c:url value='payoutHistory' />">PayOut History</a></li>
                                     	<li><a href="<c:url value='merchantPayoutMail' />">Send PayOut</a></li>
                                     	<li><a href="<c:url value='dailyMerchantStatment' />">Send Payout Statementnew</a></li>
                                   </ul>
                                 </li> 
                                  <%-- <li><a><i class="fa fa-edit"></i>Wallet PayOut Process<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     	<li><a href="<c:url value='walletPayOutHome' />">Wallet PayOut</a></li>
                                     	<!-- <li><a href="<c:url value='cardPayoutHome' />">Card PayOut</a></li> -->
                                     	<li><a href="<c:url value='payoutHistory' />">Wallet PayOut History</a></li>
                                     	<li><a href="<c:url value='dailyMerchantStmthome' />">Wallet Payout Statement</a></li>
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i>Card PayOut Process<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     	<li><a href="<c:url value='viewTodaysPayoutLanding' />" onclick="clickAndDisable(this);">Card Payout</a></li>
                                     	<li><a href="<c:url value='cardNodalPayoutProcess' />" >Card Nodal Payment Process</a></li>
                                     	
                                     	<li><a href="<c:url value='cardPayoutHistoryDetails' />">Card Payout History</a></li>  
                                		<li><a href="<c:url value='dailyMerchantStmthomeNew' />">Card Payout Statement</a></li>
                                   		<li><a href="<c:url value='payoutCommissionReportProcedure' />">Payout Commission Report</a></li> 
           							  <li><a href="<c:url value='cardPayoutMdrProcedure' />">Payout MDR Report</a></li> 
           							  <li><a href="<c:url value='nodalCardPayoutHistoryList' />">Nodal Payment History List</a></li>     
                                  </ul>
                                 </li> --%>
                                 <li><a><i class="fa fa-edit"></i> Manage Merchant <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='list' />">Merchant List</a></li> 
                                     <li><a href="<c:url value='addmerchant' />">Add New Merchant</a></li>
 									 <li><a href="<c:url value='addOrg' />">Add Organization</a>     
 									 <li><a href="<c:url value='addDeviceDetail' />">Add Device Detail</a></li>
 									 <li><a href="<c:url value='tidAndMerchantList?bankTid=&merchantName=' />">Send Merchant Notifications</a></li>                                                                      
                                   </ul>                             
                                 </li>
                                 <li><a href="<c:url value='settingHome' />"><i class="fa fa-edit"></i> Settings <span class="fa fa-chevron-down"></span></a>
                                 </li>
                                 <li><a href="<c:url value='walletList' />"><i class="fa fa-edit"></i> Transaction List <span class="fa fa-chevron-down"></span></a>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Wallet Transaction Report <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='wallettTxnReport' />">Transaction Report</a></li>
           							  <li><a href="<c:url value='walletMdrHome' />">MDR Report</a>     
           							  <li><a href="<c:url value='walletCommissionReport' />">Commission Report</a></li>                                                         
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Card Transaction Report <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='cardTxnReport' />">Transaction Report</a></li>
           							  <li><a href="<c:url value='cardMdrReport' />">MDR Report</a>     
           							  <li><a href="<c:url value='cardCommissionReport' />">Commission Report</a></li>                                                         
                                   </ul>
                                 </li>
                              <li><a href="<c:url value='cashTxnReport' />"><i class="fa fa-edit"></i> Cash Transaction Report <span class="fa fa-chevron-down"></span></a>
                                 </li>
                                 <li><a><i class="fa fa-edit"></i> Lead-(Self Register) <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='leadList' />">List</a>        
                                        </li>                     
                                   </ul>                                  
                                 </li>
                                 <li><a><i class="fa fa-edit"></i>Bill Management <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='generateBill' />">Generate Bill</a></li>
                                     <li><a href="<c:url value='postBillDetails' />"> Bill Details</a></li>   
                                      <li><a href="<c:url value='manualBill' />"> Generate First Bill</a></li> 
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Manage Employee <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='addEmployee' />">Add Employee</a></li>
                                     <li><a href="<c:url value='emplockunlock' />">Lock/Unlock Employee</a></li>    
                                   </ul>
                                 </li>  
                                <li><a><i class="fa fa-edit"></i> Device Inventory<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='inventoryAddDevice' />">Add Device</a></li>
                                     <li><a href="<c:url value='InventoryDeviceList' />">Device List</a></li>
                                   </ul>
                                 </li>
                                 <li><a><i class="fa fa-edit"></i> Risk Management<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='riskManagementList' />">Card Transaction List</a></li>
                                     <li><a href="<c:url value='walletRiskManagementList' />">Wallet Transaction List</a></li>
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Switch Mdr Update <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='cardMdrHome' />">Switch Mdr Update</a>        
                                        </li>                     
                                   </ul>                                  
                                 </li> 
                                 <li><a href="<c:url value='serverLog' />"><i class="fa fa-edit"></i> Server Log <span class="fa fa-chevron-down"></span></a>
                                 </li>
                                 <li><a href="<c:url value='wholeTxnList' />"><i class="fa fa-edit"></i> All Transaction List <span class="fa fa-chevron-down"></span></a></li>                               
                                 <%}%>
                                 <% if(session.getAttribute("empRole").equals("2")){%>
                               <li><a href="<c:url value='welcome' />"><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                                </li>
                              <!--     <li><a href="<c:url value='beneficiaryHome' />"><i class="fa fa-desktop"></i>Beneficiary File <span class="fa fa-chevron-down"></span></a>
                                </li>  -->
                                
                                 <li><a><i class="fa fa-edit"></i> Manage Merchant <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='list' />">Merchant List</a></li> 
                                     <li><a href="<c:url value='addmerchant' />">Add New Merchant</a></li>
 									 <li><a href="<c:url value='addOrg' />">Add Organization</a>     
 									 <li><a href="<c:url value='addDeviceDetail' />">Add Device Detail</a></li>                                                                      
                                   </ul>                                  
                                 </li>                             
                                <li><a><i class="fa fa-edit"></i> Lead-(Self Register) <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='leadList' />">List</a>        
                                        </li>                     
                                   </ul>                                  
                                 </li> 
                                  <li><a><i class="fa fa-edit"></i> Manage Employee <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                    <li><a href="<c:url value='empChangePassword' />">Change Employee</a></li>    
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Device Inventory<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='inventoryAddDevice' />">Add Device</a></li>
                                     <li><a href="<c:url value='InventoryDeviceList' />">Device List</a></li>
                                   </ul>
                                 </li>                           
                                 <%}%>
                                 <% if(session.getAttribute("empRole").equals("3")){	%>
                               <li><a href="<c:url value='welcome' />"><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                                </li>
                                 <li><a href="<c:url value='beneficiaryHome' />"><i class="fa fa-desktop"></i>Beneficiary File <span class="fa fa-chevron-down"></span></a>
                                </li>
                                <li><a><i class="fa fa-edit"></i> PayOut Process <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     	<li><a href="<c:url value='walletPayOutHome' />">Wallet PayOut</a></li>
                                     	<li><a href="<c:url value='cardPayoutHome' />">Card PayOut</a></li>
                                     	<li><a href="<c:url value='payoutHistory' />">PayOut History</a></li>
                                     	<li><a href="<c:url value='merchantPayoutMail' />">Send PayOut</a></li>
                                     	<!-- <li><a href="<c:url value='list' />">Card PayOut</a></li>  -->                                                                                            
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Manage Merchant <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='list' />">Merchant List</a></li> 
                                     <li><a href="<c:url value='addmerchant' />">Add New Merchant</a></li>
 									 <li><a href="<c:url value='addOrg' />">Add Organization</a>     
 									 <li><a href="<c:url value='addDeviceDetail' />">Add Device Detail</a></li>                                                                      
                                   </ul>                                  
                                 </li> 
                              <li><a href="<c:url value='walletList' />"><i class="fa fa-edit"></i> Transaction List <span class="fa fa-chevron-down"></span></a>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Wallet Transaction Report <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='wallettTxnReport' />">Transaction Report</a></li>
							           <li><a href="<c:url value='walletMdrHome' />">MDR Report</a>     
							           <li><a href="<c:url value='walletCommissionReport' />">Commission Report</a></li>                                                         
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Card Transaction Report <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='cardTxnReport' />">Transaction Report</a></li>
							           <li><a href="<c:url value='cardMdrReport' />">MDR Report</a>     
							           <li><a href="<c:url value='cardCommissionReport' />">Commission Report</a></li>                                                         
                                   </ul>
                                 </li>      
                                 <li><a href="<c:url value='cashTxnReport' />"><i class="fa fa-edit"></i> Cash Transaction Report <span class="fa fa-chevron-down"></span></a>
                                 </li>                   
                                 <li><a><i class="fa fa-edit"></i> Lead-(Self Register) <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='leadList' />">List</a>        
                                        </li>                     
                                   </ul>                                  
                                 </li>
                                 <li><a><i class="fa fa-edit"></i>Bill Management <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='generateBill' />">Generate Bill</a></li>
                                     <li><a href="<c:url value='postBillDetails' />"> Bill Details</a></li>  
                                      <li><a href="<c:url value='manualBill' />"> Generate First Bill</a></li>  
                                   </ul>
                                 </li>
                                <li><a><i class="fa fa-edit"></i> Manage Employee <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                    <li><a href="<c:url value='empChangePassword' />">Change Employee</a></li>    
                                   </ul> 
                                   </li>  
                                      <li><a><i class="fa fa-edit"></i> Device Inventory<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='inventoryAddDevice' />">Add Device</a></li>
                                     <li><a href="<c:url value='InventoryDeviceList' />">Device List</a></li>
                                   </ul>
                                 </li>
                                 <li><a><i class="fa fa-edit"></i> Risk Management<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='riskManagementList' />">Card Transaction List</a></li>
                                     <li><a href="<c:url value='walletRiskManagementList' />">Wallet Transaction List</a></li>
                                   </ul>
                                 </li>         
                                <li><a><i class="fa fa-edit"></i> Switch Mdr Update <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='cardMdrHome' />">Switch Mdr Update</a>        
                                        </li>                     
                                   </ul>                                  
                                 </li>       
                                 <li><a href="<c:url value='wholeTxnList' />"><i class="fa fa-edit"></i> All Transaction List <span class="fa fa-chevron-down"></span></a></li>                                            
                                 <%}%>
                                 <% if(session.getAttribute("empRole").equals("4")){	%>
                              	 <li><a href="<c:url value='welcome' />"><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                                </li>
                                <li><a href="<c:url value='walletList' />"><i class="fa fa-edit"></i> Transaction List <span class="fa fa-chevron-down"></span></a>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Wallet Transaction Report <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='wallettTxnReport' />">Transaction Report</a></li>
							           <li><a href="<c:url value='walletMdrHome' />">MDR Report</a>     
							           <li><a href="<c:url value='walletCommissionReport' />">Commission Report</a></li>                                                         
                                   </ul>
                                 </li>
                                  <li><a><i class="fa fa-edit"></i> Card Transaction Report <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='cardTxnReport' />">Transaction Report</a></li>
							           <li><a href="<c:url value='cardMdrReport' />">MDR Report</a>     
							           <li><a href="<c:url value='cardCommissionReport' />">Commission Report</a></li>                                                         
                                   </ul>
                                 </li>  
                                 <li><a><i class="fa fa-edit"></i> Lead-(Self Register) <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                      <li><a href="<c:url value='leadList' />">List</a>        
                                        </li>                     
                                   </ul>                                  
                                 </li>  
                                  <li><a><i class="fa fa-edit"></i> Manage Employee <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                    <li><a href="<c:url value='empChangePassword' />">Change Employee</a></li>    
                                   </ul> 
                                   </li>  
                                    <li><a><i class="fa fa-edit"></i> Risk Management<span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='riskManagementList' />">Card Transaction List</a></li>
                                     <li><a href="<c:url value='walletRiskManagementList' />">Wallet Transaction List</a></li>
                                   </ul>
                                 </li>                                      
                                 <li><a href="<c:url value='wholeTxnList' />"><i class="fa fa-edit"></i> All Transaction List <span class="fa fa-chevron-down"></span></a></li>                        
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
                                    <li>
                                        <a href="#">Help</a>
                                    </li>
                                    <li><a href="<c:url value='logout'/>"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <!-- /top navigation -->
