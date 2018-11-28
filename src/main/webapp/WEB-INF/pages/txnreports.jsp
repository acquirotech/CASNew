<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
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
 <div class="content-wrapper">
    <!-- Content Header (Page header) -->

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Generate Transaction Report</h3>
            </div>
            <form role="form" method="get" action="<c:url value='downloadCardTxnReport'/>" target="_blank">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Merchant Name</label>
                       <select name="merchantId" id="merchantId" onchange="return getorg();" class="form-control input-lg">
                       <option value="">Merchant Name</option>	                         
										    	<option value=""></option>select</option>
										 			<c:forEach var="RowData" items="${merchantList}">
										 			<!-- 	<option value="<c:out value="${RowData['merchantId']}"/>" <c:if test="${RowData['merchantId'] == param.merchantId}">selected="selected"</c:if> ><c:out value="${RowData['merchantName']}"/></option> --> 
										 			<option value="<c:out value="${RowData['merchantId']}"/>">
													<c:out value="${RowData['merchantName']}"/></option> 
										 			</c:forEach>
						</select>	
            		</div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Store Name</label>
                      <select name="orgId" id="orgId" onchange="return gettermnl();" class="form-control input-lg"> 
													<option value=""></option>select</option>
												 	<c:forEach var="RowData" items="${orgList}">
												 		<option value="<c:out value="${RowData['orgId']}"/>" <c:if test="${RowData['orgId'] == param.orgId}">selected="selected"</c:if>><c:out value="${RowData['orgName']}"/></option> 
												 	</c:forEach>
												</select>
                    </div>
                  </div>
                </div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Terminal Id</label>
                   <select name="StoreId" id="loginId" class="form-control input-lg">
											  		<option value=""></option>select</option>
												 	<c:forEach var="RowData" items="${terminalList}">
												 		<option value="<c:out value="${RowData['userId']}"/>"><c:out value="${RowData['loginId']}"/></option> 
												 	</c:forEach>
											  </select>
											  </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                   <div class="form-group">
                                            <label for="txnType">Transaction Type </label>
                                              <select name="txnType" id="txnType" class="form-control input-lg">
											  		<option value="">select</option>
												 	<option value="card">CARD</option>
												 	<option value="cashatpos">CASHATPOS</option>
													<option value="void">VOID</option>
													<option value="cvoid">CASHATPOSVOID</option>
													<option value="risk">RISK</option>
											  </select>
                                         </div>
                                         </div>
                                          <div class="col-md-1">&nbsp;</div>
                 							 <div class="col-md-5">
                                        <div class="form-group">
                                            <label for="fromDate11">From Date Filter <span class="required">*</span></label>
                                            <input type="text" name="fromDate" class="date-picker form-control input-lg" id="fromDate"  data-role="date" placeholder="From Date"/>                                 
                                         
                                        </div>
                                        </div>
                                        <div class="col-md-1">&nbsp;</div>
                 							 <div class="col-md-5">
                                        <div class="form-group">
                                            <label for="fromDate11">To Date Filter <span class="required">*</span></label>
                                         <input type="text" name="toDate" id="toDate" class="date-picker form-control input-lg" data-role="date" placeholder="To Date"/>                    
                                         
                                        </div>
                                        </div>
                </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" >Sign in</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
   <!-- Small modal -->
  <div class="modal fade bs-example-modal-sm" id="deleteConfirm">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Your Request Status</h4>
      </div>
       <div id="modal-body" class="modal-body">
                                                
      </div>
      <div class="modal-footer">
        <form id="id2DelFrm" method="GET">
          <input type="hidden" class="form-control" id="id2Delete" name="id2Delete">
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove"></i>Close</button>
        </form>
      </div>
    </div>
  </div>
</div>
  
<jsp:include page="/jsp/footer.jsp" />
