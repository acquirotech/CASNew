<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${pageContext.request.userPrincipal.name == null}">
   <% response.sendRedirect("login");%>
</c:if>
                              
                             <li><a href="<c:url value='welcome' />"><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                                </li>
                                  <li><a><i class="fa fa-edit"></i> List <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='walletList' />">Credit/Debit List</a></li> 
                                     <li><a href="<c:url value='rechargeList' />">Recharge List</a></li>
 									 <li><a href="<c:url value='transactionList' />">DMT List</a>     
 									 <li><a href="<c:url value='wholeTxnList' />">All Credit/Debit List</a></li>
 								 </ul>                             
                                 </li> 
                                 <li><a><i class="fa fa-edit"></i> Reports <span class="fa fa-chevron-down"></span></a>                                
                                   <ul class="nav child_menu" style="display: none">
                                     <li><a href="<c:url value='cardTxnReport' />">Credit/Debit Report</a></li> 
                                     <li><a href="<c:url value='rechargeReport' />">Recharge Report</a></li>
 									 <li><a href="<c:url value='dmtReport' />">DMT Report</a>     
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
                                 <li><a><i class="fa fa-edit"></i> Settings <span class="fa fa-chevron-down"></span></a>                                
                                   	<ul class="nav child_menu" style="display: none">
                                    	<li><a href="<c:url value='settingHome' />">Acquiro Settings</a></li>
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
                                   </ul>
                                 </li>
                                