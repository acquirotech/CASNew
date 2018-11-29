<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<script type="text/javascript">
function setupdateMdr(txnId,AcqMdr,bankMdr){
	$("#txnId").val(txnId);
	$("#AcqMdr").val(AcqMdr);
	$("#bankMdr").val(bankMdr);
}

function updateMdr(){
	var maxValue=100;	
	var txnId = $("#txnId").val();
	var AcqMdr = $("#AcqMdr").val();
	var bankMdr = $("#bankMdr").val();
	if(AcqMdr!=null&&AcqMdr!=''){
		if(AcqMdr>=maxValue){
		   $("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct AcqMDR </p></n>value must be less than 100');
		   return false;
		}
	}if(bankMdr!=null&&bankMdr!=''){
		if(bankMdr>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct BankMDR </p></n>value must be less than 100');
			return false;
		}
	}
	
	$(".update_mdr_popup").hide();
	if((bankMdr!=null&&bankMdr!="")||(AcqMdr!=null&&AcqMdr!="")){
	$(".update_mdr_popup").hide();
	$("#modal-body1").html("<h2>In Process</h2>");  
	//console.log(txnId+";;;"+AcqMdr+";;;"+bankMdr);
		var sendvalue={txnId:txnId,AcqMdr:AcqMdr,bankMdr:bankMdr}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body1").html("<h2>Mdr Details Updated Successfully</h2>"); 
	                    location.reload(); 
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==101||data.message=='Not Found') {
	                    $("#modal-body1").html("<h2><p>Transaction not found for update or batch is setteled</p></h2>");
	                    //   alert(data.message);
	                  //  location.reload(); 
	                }else if (data.status==100) {
	                    $("#modal-body1").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body1").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
	                }
	            },
	            error: function (data, textStatus, errorThrown) {
	                $(".loading").css("visibility","hidden");
	                if(textStatus=="timeout"){
	                	$("#modal-body1").html("<h2>Connection Error</h2><p>Your Request Has Timed-Out. Please Try Again Later</p>");
	                }else{
	                	$("#modal-body1").html("<h2>Connection Error</h2><p>"+ textStatus+"</p>");  
	                }
	            },
	            url: "updateMdr",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}else{
		$("#modal-body1").html("<h2>AcqMdr And BankMdr Can Not Be Blank</h2>");  
		}
	}
function addRisk(txnId,txnType){
	if (confirm("Do you want to hold txn ?") == true) {
		$("#modal-body1").html("<h2>In Process</h2>");
		var sendvalue={txnId:txnId,txnType:txnType}		
		var opts = {
				 type: "POST",
		            success: function (data) {
		            	 $(".loading").css("visibility","hidden");
		                if (data.status == 0&&data.message=='OK') {
		                	$("#modal-body1").html("<h2>Transaction Hold Successfully </h2>");
			               // alert("Txn Added Successfully In Risk");
			                location.reload(); 
		                   $('#merchantId').prop('selectedIndex',0);		    
		                } else if (data.status==111) {
		                    $("body").attr("onload","noBack();");
		                    $("body").attr("onpageshow","if (event.persisted) noBack();");
		                    $("body").attr("onunload","");
		                    window.location.href="logout.jsp";
		                }else if (data.status==101) {
		                	$("#modal-body1").html("<h2><p>"+data.message+"</p></h2>");
			             //   alert(data.message);
			                location.reload(); 
		                } else {
		                    $(".loading").css("visibility", "hidden");
		                    $("#modal-body1").html("<h2><p>"+data.message+"</p></h2>");
		                  //  alert(data.message);
		                    location.reload(); 
		                }
		            },
		            error: function (data, textStatus, errorThrown) {
		                $(".loading").css("visibility","hidden");
		                if(textStatus=="timeout"){
		                	$("#modal-body").html("<h2>Connection Error</h2><p>Your Request Has Timed-Out. Please Try Again Later</p>");
		                }else{
		                	$("#modal-body").html("<h2>Connection Error</h2><p>"+ textStatus+"</p>");  
		                }
		            },
		            url: "addRisk",
		            data: sendvalue
		        }; 
	        $.ajax(opts);
	        return false;

	}else{
		$("#modal-body1").html("<h2>Transaction not Hold</h2>"); 
		return false;
	}
}

function setTxnDetails(orgName,userName,txnId,emailId,amount,status,datetime,phoneno,statusDesc,txnType,cardHolderName,cardPanNo,cardType,cardExpDate,rrNo,referenceNo,terminalId,batchNo,authCode,issuerAuthCode,ipAddress,imeiNo,latitude,longitude,stan,payoutStatus,payoutDateTime,merchantName,AcqMdr,bankMdr){
	if(txnType=='CARD'||txnType=='VOID'|| txnType=='CASHATPOS'|| txnType=='CVOID'){
		$("#modal-body").html(" Merchant Name : "+merchantName+"<br> Store Name : "+orgName+"<br> Terminal Id : "+userName+"<br> Invoice No : "+txnId+"<br> Email Id : "+emailId+"<br> Amount : "+amount+"<br> Status : "+status+"<br> Description : "+statusDesc+"<br> Date Time : "+datetime+"<br> Phone No : "+phoneno+"<br> Txn Type : "+txnType+"<br> Card HolderName : "+cardHolderName+"<br> CardPanNo : "+cardPanNo+"<br> Card Type : "+cardType+"<br> RR No : "+rrNo+"<br> Terminal Id : "+terminalId+"<br> Batch No : "+batchNo+"<br> Auth Code : "+authCode+"<br> IP Address : "+ipAddress+"<br> IMEI No : "+imeiNo+"<br> Latitude : "+latitude+"<br> Longitude : "+longitude+"<br> Stan : "+stan+"<br> Payout Status : "+payoutStatus+"<br> Payout DateTime : "+payoutDateTime+"<br>MDR : "+AcqMdr+"<br>BankMDR : "+bankMdr+"<br>")
	}else{
		$("#modal-body").html(" Merchant Name : "+merchantName+"<br> Store Name : "+orgName+"<br> Terminal Id : "+userName+"<br> Invoice No : "+txnId+"<br> Email Id : "+emailId+"<br> Amount : "+amount+"<br> Status : "+status+"<br> Description : "+statusDesc+"<br> Date Time : "+datetime+"<br> Phone No : "+phoneno+"<br> Txn Type : "+txnType+"<br> Payout Status : "+payoutStatus+"<br> Payout DateTime : "+payoutDateTime+"<br>MDR : "+AcqMdr+"<br>BankMDR : "+bankMdr+"<br>")
	}
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
                <h3 class="box-title">Transaction List</h3>
                <div class="box-tools">
                <a class="btn btn-block btn-primary btn-sm"><i class="fa fa-filter"></i> Filters</a>
                 <strong>
                                    <c:if test="${loginId!=''&&loginId!=null&&loginId!='A'}"> Login Id:<c:out value="${loginId}"/><input type="hidden" id="loginIddd" value='<c:out value="${loginId}"/>'/></c:if>
                                    <c:if test="${merchantName!=''&&merchantName!=null&&merchantName!='A'}"> || Merchant Name:<c:out value="${merchantName}"/><input type="hidden" id="merchantNamee" value='<c:out value="${merchantName}"/>'/></c:if>
                                    <c:if test="${orgName!=''&&orgName!=null&&orgName!='A'}"> || Org Name:<c:out value="${orgName}"/><input type="hidden" id="orgNamee" value='<c:out value="${orgName}"/>'/></c:if>
                                    <c:if test="${custPhone!=''&&custPhone!=null&&custPhone!='A'}"> || Customer Phone:<c:out value="${custPhone}"/><input type="hidden" id="custPhoneee" value='<c:out value="${custPhone}"/>'/></c:if>
                                    <c:if test="${fromDate!=''&&fromDate!=null&&fromDate!='A'}"> || From Date:<c:out value="${fromDate}"/><input type="hidden" id="fromDateee" value='<c:out value="${fromDate}"/>'/></c:if>
                                    <c:if test="${toDate!=''&&toDate!=null&&toDate!='A'}">  || To Date:<c:out value="${toDate}"/><input type="hidden" id="toDateee" value='<c:out value="${toDate}"/>'/></c:if>
									<c:if test="${txnId!=''&&txnId!=null&&txnId!='A'}"> || Transaction Id:<c:out value="${txnId}"/><input type="hidden" id="txnIddd" value='<c:out value="${txnId}"/>'/></c:if>
                                    <c:if test="${status!=''&&status!=null&&status!='A'}"> || Status:<c:out value="${status}"/><input type="hidden" id="statusss" value='<c:out value="${status}"/>'/></c:if>
                                    <c:if test="${walletEmail!=''&&walletEmail!=null&&walletEmail!='A'}"> || Email:<c:out value="${walletEmail}"/><input type="hidden" id="walletEmailll" value='<c:out value="${walletEmail}"/>'/></c:if>
                              		<c:if test="${txnType!=''&&txnType!=null&&txnType!='A'}"> || Txn Type:<c:out value="${txnType}"/><input type="hidden" id="txnTypee" value='<c:out value="${txnType}"/>'/></c:if>
                               		<c:if test="${amount!=''&&amount!=null&&amount!='A'}"> || Amount:<c:out value="${amount}"/><input type="hidden" id="amount1" value='<c:out value="${amount}"/>'/></c:if>
                               		<c:if test="${account!=''&&account!=null&&account!='A'}"> || Account:<c:out value="${account}"/><input type="hidden" id="account1" value='<c:out value="${account}"/>'/></c:if>
                              		<c:if test="${authcode!=''&&authcode!=null&&authcode!='A'}"> || Auth Code:<c:out value="${authcode}"/><input type="hidden" id="authcode1" value='<c:out value="${authcode}"/>'/></c:if>    
                               </strong>
                </div>
              </div>
              
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table table-bordered">
                  <tbody>
                    <tr>
                   <th>Invoice No</th>
                                              	<th>Date Time</th>
                                              	<th>Amount</th>
                                              	<th>Account</th>
												<th>Merchant Name</th>
												<th>Txn Type</th>
												<th>Status</th>
												<th class=" no-link last" valign="middle" align="center"><span class="nobr">Action</span></th>
                  </tr>
                  <?php 
                  for ($x = 0; $x <= 8; $x++) {?>
                    <c:forEach var="allRowData" items="${walletList}">											
                                        	<tr class="even pointer">
                                        	<td class=" "><c:out value="${allRowData['id']}"/></td>
                                            	<%-- <td class=" "><a style="text-decoration: underline;" target="_blank" href='signReceipt?signImage=${allRowData.id}'><c:out value="${allRowData['id']}"/></a></td>
                                            	 --%><td class=" "><c:out value="${allRowData['dateTime']}"/></td>                                            		
												<td class=" "><c:out value="${allRowData['amount']}"/></td>
												<td class=" "><c:out value="${allRowData['cardPanNo']}"/></td>
												<td class=" "><a href="merchantdetails?MerchantId=${allRowData.mid}" target="_blank" /><u><c:out value="${allRowData['merchantName']}"/></u></a></td>
												<td class=" "><c:out value="${allRowData['txnType']}"/></td>	
												<td class=" "><c:out value="${allRowData['status']}"/></td>
												<td align="right"><button type="button" data-toggle="modal" data-target=".Transaction-detail-popup" class="btn btn-success btn-xs" onclick='return setTxnDetails("${allRowData.orgName}","${allRowData.userName}","${allRowData.id}","${allRowData.custEmail}","${allRowData.amount}","${allRowData.status}","${allRowData.dateTime}","${allRowData.custPhone}","${allRowData.statusDescription}","${allRowData.txnType}","${allRowData.cardHolderName}","${allRowData.cardPanNo}","${allRowData.cardType}","${allRowData.cardExpDate}","${allRowData.rrNo}","${allRowData.referenceNo}","${allRowData.terminalId}","${allRowData.batchNo}","${allRowData.authCode}","${allRowData.issuerAuthCode}","${allRowData.ipAddress}","${allRowData.imeiNo}","${allRowData.latitude}","${allRowData.longitude}","${allRowData.stan}","${allRowData.payoutStatus}","${allRowData.payoutDateTime}","${allRowData.merchantName}","${allRowData.AcqMdr}","${allRowData.bankMdr}")'><i class="fa fa-fw fa-eye"></i>Details</button>
												<button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn btn-success btn-xs" onclick='return addRisk("${allRowData.id}","${allRowData.txnType}")'>Hold</button><button type="button" data-toggle="modal" data-target=".update_mdr_popup" class="btn btn-success btn-xs" onclick='return setupdateMdr("${allRowData.id}","${allRowData.AcqMdr}","${allRowData.bankMdr}")'>Update</button></td>	
											</tr>
											</c:forEach>
											<tr id="pagingTd">
											<td colspan="9" align="right"><a href="#" id="first">First</a>&nbsp;
												<a style="cursor: pointer;" id="previous">Previous</a>&nbsp;
												<input type="text" size="1.5" id="pageNo" style="height:20px;" maxlength="5" name="pageNo" onkeypress="return isNumber(event)" />&nbsp;
												<a style="cursor: pointer;" id="next">Next</a>&nbsp;
												<a style="cursor: pointer;" id="last">Last</a><input type="hidden" id="totRows"/>
												</td>
											</tr>
                  <?php } ?>
                  </tbody>
                </table>
              </div>
              
              <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#">«</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">»</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>

  
<!--Delete confirmation Popup Begin -->
	<div class="modal fade filter-detail-popup filter-form" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel22">Set Filters</h4>
				</div>
				<div id="modal-body2" class="modal-body">
<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Terminal Id" id="loginId" value='<c:out value="${loginId}"/>' class="form-control" onkeypress='return isNumberKey(event)' digits="true"/>
<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter Merchant Name" id="merchantName" value='<c:out value="${merchantName}"/>' class="form-control" />
<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter Org Name" id="orgName" value='<c:out value="${orgName}"/>' class="form-control" />

<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter From Date" class="date-picker form-control" value='<c:out value="${fromDate}"/>' id="fromDate">

<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter To Date" class="date-picker form-control" value='<c:out value="${toDate}"/>' id="toDate">

<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Invoice No" id="txnId" value='<c:out value="${txnId}"/>' class="form-control" onkeypress='return isNumberKey(event)' digits="true"/>

<input type="text" style="height: 30px;" maxlength="11" placeholder="Enter Auth Code" id="authcode" value='<c:out value="${authcode}"/>' class="form-control" onkeypress='return isNumberKey(event)' digits="true"/>

<select data-clear-btn="true" name="status" id="status"  value='<c:out value="${status}"/>' class="form-control">
<option value="" <c:if test="${status == ''}">Selected</c:if>>Transaction Status</option>
<option <c:if test="${status == 'success'}">Selected</c:if> value="success"> Success</option>
<option <c:if test="${status == 'failed'}">Selected</c:if> value="failed"> Failed</option>
</select>

<select data-clear-btn="true" name="txnType" id="txnType" value='<c:out value="${txnType}"/>' class="form-control">
	<option value="" <c:if test="${txnType == ''}">Selected</c:if>>Transaction Type</option>
	<option <c:if test="${txnType == 'card'}">Selected</c:if> value="card"> Card</option>
	<option <c:if test="${txnType == 'cashatpos'}">Selected</c:if> value="cashatpos"> CASHATPOS</option>
	<option <c:if test="${txnType == 'wallet'}">Selected</c:if> value="wallet">All Wallet</option>
	<option <c:if test="${txnType == 'Mobikwik'}">Selected</c:if> value="Mobikwik"> Mobikwik</option>
	<option <c:if test="${txnType == 'PayUMoney'}">Selected</c:if> value="PayUMoney"> PayUMoney</option>
	<option <c:if test="${txnType == 'Freecharge'}">Selected</c:if> value="Freecharge"> Freecharge</option>
	<option <c:if test="${txnType == 'Citrus Wallet'}">Selected</c:if> value="Citrus Wallet"> Citrus</option>
	<option <c:if test="${txnType == 'Airtel Money'}">Selected</c:if> value="Airtel Money"> Airtel Money</option>
	<option <c:if test="${txnType == 'CASH'}">Selected</c:if> value="CASH"> Cash</option>
	<option <c:if test="${txnType == 'CASHVOID'}">Selected</c:if> value="CASHVOID"> CashVoid</option>
	<option <c:if test="${txnType == 'void'}">Selected</c:if> value="void"> Void</option>
<option <c:if test="${txnType == 'cvoid'}">Selected</c:if> value="cvoid"> CVoid</option>
</select>

<input type="text" style="height: 30px;" maxlength="25" placeholder="Enter Card Pan / Wallet Id" id="account" value='<c:out value="${account}"/>' class="form-control" />
<input type="text" style="height: 30px;" placeholder="Enter Amount" id="amount" value='<c:out value="${amount}"/>' class="form-control" />

<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter Email" id="walletEmail" value='<c:out value="${walletEmail}"/>' class="form-control" email="true"/>
<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Customer Phone" id="custPhone" value='<c:out value="${custPhone}"/>' class="form-control" onkeypress='return isNumberKey(event)' digits="true"/>


<button type="button" class="btn-submit" onclick="return searchClickedTns();">Search</button>
<button type="button" class="btn-cancel" onclick="return clearAllFillter();">Clear All Filter</button>				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>                              
 </div>
 <div class="modal fade Transaction-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">Transaction Details</h4>
				</div>
				<div id="modal-body" class="modal-body">
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>                              
 </div>
 <!-- Small modal -->
                                <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">X</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel21">Your Request Status</h4>
                                            </div>
                                            <div id="modal-body1" class="modal-body">
                                                
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        <!-- /modals -->
                         <!-- ---------------------------------------------- Update Mdr Popup -------------------------------------------------------->


                                <div class="modal fade update_mdr_popup" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">X</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel">Update Mdr Detail</h4>
                                            </div>
                                            <div class="modal-body12">
                                               <form class="form-horizontal form-label-left"> 
                                                <input type="hidden" id="txnId" name="txnId" value="">
                                               <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Bank MDR<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" name="bankMdr" id="bankMdr" onkeypress='return isDecimal(event)' minlength="0" maxlength="6" number="true" />
											 </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4 col-xs-12" for="AcqMdr"> MDR<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                        <input type="text" class="form-control" data-clear-btn="true" name="AcqMdr" id="AcqMdr" onkeypress='return isDecimal(event)' minlength="0" maxlength="6" number="true" />
									</div>  </div>
                                       
                                    </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn-success" data-toggle="modal" data-target=".bs-example-modal-sm"
													onclick="return updateMdr();" id="updateMdr" name="updateMdr">Update</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                        
                        

<div class="modal fade" id="deleteConfirm">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Are you sure you want to remove the merchant.<br> You can't undo this action.</h4>
      </div>
      <div class="modal-footer">
        <form id="id2DelFrm" method="GET">
          <input type="hidden" class="form-control" id="id2Delete" name="id2Delete">
          <button type="button" class="btn btn-default" data-dismiss="modal">Keep It</button>
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove"></i>Delete</button>
        </form>
      </div>
    </div>
  </div>
</div>
<!--Delete confirmation Popup End -->

      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<jsp:include page="/jsp/footer.jsp" />