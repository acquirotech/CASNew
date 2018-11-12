<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("3")||session.getAttribute("empRole").equals("4"))){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">
function getorg()
{
	var merchantId = $("#merchantId").val();
	document.location.href = "?merchantId="+merchantId+"";
}
function gettermnl()
{
	var orgId = $("#orgId").val();
	var merchantId = $("#merchantId").val();
	document.location.href = "?merchantId="+merchantId+"&orgId="+orgId+"";
}
</script>
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                   <div class="row">
                    <form method="get" action="<c:url value='downloaddmtReport' />" target="_blank" class="form-horizontal form-label-left"> 
	     			 <div class="col-md-12 col-sm-12 col-xs-12">
<!-- ----------------------------------------------------------------panels start----------------->
<!--- panel Summary ---------------------------------------------------------->                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Generate DMT Summary</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                   <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="merchantId">Merchant Name</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select name="merchantId" id="merchantId" onchange="return getorg();" class="form-control">
										    	<option value=""></option>select</option>
										 			<c:forEach var="RowData" items="${merchantList}">
										 				<option value="<c:out value="${RowData['merchantId']}"/>" <c:if test="${RowData['merchantId'] == param.merchantId}">selected="selected"</c:if> ><c:out value="${RowData['merchantName']}"/></option> 
										 			</c:forEach>
											</select>										                                             
										</div>
                                        </div>                                       
                                     <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Store Name</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select name="orgId" id="orgId" onchange="return gettermnl();" class="form-control"> 
													<option value=""></option>select</option>
												 	<c:forEach var="RowData" items="${orgList}">
												 		<option value="<c:out value="${RowData['orgId']}"/>" <c:if test="${RowData['orgId'] == param.orgId}">selected="selected"</c:if>><c:out value="${RowData['orgName']}"/></option> 
												 	</c:forEach>
												</select>
                                            </div>
                                        </div>
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="loginId">Terminal Id <span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <select name="StoreId" id="loginId" class="form-control">
											  		<option value=""></option>select</option>
												 	<c:forEach var="RowData" items="${terminalList}">
												 		<option value="<c:out value="${RowData['userId']}"/>"><c:out value="${RowData['loginId']}"/></option> 
												 	</c:forEach>
											  </select>
                                          </div>
                                        </div>
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txnType">Service Type </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <select name="txnType" id="txnType" class="form-control">
											  		<option value="">select</option>
												 	<option value="Mobile">Mobile</option>
												 	<option value="DTH">DTH</option>
											  </select>
                                            </div>
                                         </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="fromDate11">Date Filter <span class="required">*</span></label>
                                            <div class="col-md-3 col-sm-3 col-xs-12">
                                            <input type="text" name="fromDate" class="date-picker form-control" id="fromDate"  data-role="date" placeholder="From Date"/>                                 
                                          </div>
                                            <div class="col-md-3 col-sm-3 col-xs-12">
                                            <input type="text" name="toDate" id="toDate" class="date-picker form-control" data-role="date" placeholder="To Date"/>                    
                                          </div>
                                        </div>
                                         <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                                <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="Submit" class="btn-submit" id="AddOrgSub" name="AddOrgSub">Generate Recharge Summary</button>
                                            </div>
                                        </div>                                      
                                </div>
                            </div>                            
<!------------------------------------------------------------------panels end----------------->
                        </div>
                    </form>
                    </div>
				</div>				
<!-- Small modal -->
                                <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
                                            </div>
                                            <div id="modal-body" class="modal-body">
                                                
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /modals -->                   
<!-- /page content -->
<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->