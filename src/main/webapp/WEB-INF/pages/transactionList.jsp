<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="/jsp/header.jsp" />
	
<script type="text/javascript">

function isDecimal(evt){
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (!( charCode == 46 || (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
		return false;
	}
}

function searchClickedTns(){
	var merchantname = $("#merchantName").val();
	var fromDate = $("#fromDate").val();
	var toDate = $("#toDate").val();
	var loginId = $("#loginId").val();
	var status = $("#status").val();
	var txnType = $("#txnType").val();
	var account = $("#account").val();
	var amount = $("#amount").val();
	
	
	var appendMe="";
	var regEx = /^\d{2}\/\d{2}\/\d{4}$/;
	

	
	if(status!=null&&status!=""){
		appendMe=appendMe.concat("&walletStatus="+status+"");
	}
	if(loginId!=null&&loginId!=""&&loginId.length==10){
		appendMe=appendMe.concat("&userPhone="+loginId+"");
	}
	if(txnType!=null&&txnType!=""){
		appendMe=appendMe.concat("&txnType="+txnType+"");
	}
	if(merchantname!=null&&merchantname!=""){
		appendMe=appendMe.concat("&merchantName="+merchantname+"")
	}
	if(toDate!=null&&toDate!=""&&(fromDate==null||fromDate==""||fromDate.length<10)){
		alert("Select From Date");
		return false;
	}if(fromDate!=null&&fromDate!=""&&(toDate==null||toDate=="")){
		appendMe=appendMe.concat("&fromDateTime="+fromDate+"")
	}
	if(fromDate!=null&&fromDate!=""&&toDate!=null&&toDate!=""){
		if(toDate.match(regEx) != null){
			appendMe=appendMe.concat("&fromDateTime="+fromDate+"&toDateTime="+toDate+"")
		}else{
			return false;
		}
	}if(account!=null&&account!=""){
		appendMe=appendMe.concat("&account="+account+"")
	}if(amount!=null&&amount!=""){
		appendMe=appendMe.concat("&amount="+amount+"")
	}
	
	document.location.href = "?page=1&txn=123654321"+appendMe;
}
function clearAllFillter(){
	 $("#merchantName").val('');
	 
	 $("#status").val('');
	 $("#loginId").val('');
	
	 $("#fromDate").val('');
	 $("#toDate").val('');
	 $("#txnType").val('');
	 $("#account").val('');
	 $("#amount").val('');
	
	 document.location.href = "?page=1"		 
}





function isNumberKey(evt){
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
	   return false;
	  }
	 }

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}


function setTxnDetails(mobileNo,bankName,clientRefId){
	//console.log('111111111111111111111111');
		$("#modal-body").html(" Mobile No : "+mobileNo+"<br> Bank Name : "+bankName+"<br> Client Ref Id : "+clientRefId+"<br>")
	
}

$(document).ready(function (){
	
	<c:if var="msg" test="${message!=null}">
		alert('<c:out value="${message}" />');
	</c:if>
	<c:if var="pg" test="${page!=null&&page!=''}">
		$("#pageNo").val('<c:out value="${page}" />');
	</c:if>
	<c:if var="searchtx" test="${searchText!=null&&searchText!=''}">
		$("#searchAll").val('<c:out value="${searchText}" />');
	</c:if>
	
	<c:if var="lct" test="${location!=null&&location!=''}">	
		//console.log('location '+${location});
		//alert('<c:out value="${location}" />');
		$("#storeLocation").val('<c:out value="${location}" />');
	</c:if>

	<c:if var="lct" test="${totalRows!=null&&totalRows!=''}">		
		$("#totRows").val('<c:out value="${totalRows}" />');
	</c:if>

	<c:if test="${fromDate != null&&fromDate!=''}"> 
		$("#dateUp").hide();
		$("#dateDown").show();
		$("#fromDate").show();
		$("#fromDate").val('<c:out value="${fromDate}" />');
	</c:if><c:if test="${toDate != null&&toDate!=''}"> 
	$("#toDate").show();
	$("#toDate").val('<c:out value="${toDate}" />');
	</c:if>
	var loginIddds = $("#loginIddd").val();
	var fromDateees=$("#fromDateee").val();
	var toDateees=$("#toDateee").val();
	
	var statussss=$("#statusss").val();
	
	var txnTypee=$("#txnTypee").val();
	var merchantNameee = $("#merchantNamee").val();
	
	var amount11=$("#amount1").val();
	var account11=$("#account1").val();
	


	if(amount11==undefined)
		amount11='%41';
	if(account11==undefined)
		account11='%41';

	
	if(txnTypee==undefined)
		txnTypee='%41';
	if(loginIddds==undefined)
		loginIddds='%41';
	
	if(fromDateees==undefined)
		fromDateees='%41';
	if(toDateees==undefined)
		toDateees='%41';
	
	if(statussss==undefined)
		statussss='%41';
	
	if(merchantNameee==undefined){
		merchantNameee='%41';
	}else{
		  merchantNameee = encodeURI(merchantNameee)
	  }
	
	$("#pageNo").change(function(){
		var pageNo = $("#pageNo").val();
				
		if(pageNo!=null&&pageNo!=""){
			document.body.innerHTML += '<form id="pageForm" action="<c:url value='transactionList' />"><input type="hidden" name="page" value='+pageNo+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="merchantName" value='+merchantNameee+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="txnType" value='+txnTypee+' /><input type="hidden" name="amount" value='+amount11+' /><input type="hidden" name="account" value='+account11+' /></form>';
			
			//document.body.innerHTML += '<form id="pageForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+pageNo+' /></form>';
			document.getElementById("pageForm").submit();
		}
	});	
	$("#first").click(function () {
		var page=1;
		$("#pageNo").val(page);
		var location = $("#storeLocation").val();
	
		document.body.innerHTML += '<form id="firstForm" action="<c:url value='transactionList' />"><input type="hidden" name="page" value="1" /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="merchantName" value='+merchantNameee+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="txnType" value='+txnTypee+' /><input type="hidden" name="amount" value='+amount11+' /><input type="hidden" name="account" value='+account11+' /></form>';
		//document.body.innerHTML += '<form id="firstForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value="1" /></form>';
		document.getElementById("firstForm").submit();	
	});
	$("#previous").click(function () {
		var page=$("#pageNo").val();
		if(page>1){
			$("#pageNo").val(page-1);
		}
		var previousPage=$("#pageNo").val();
	
		document.body.innerHTML += '<form id="previousForm" action="<c:url value='transactionList' />"><input type="hidden" name="page" value='+previousPage+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="merchantName" value='+merchantNameee+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="txnType" value='+txnTypee+' /><input type="hidden" name="amount" value='+amount11+' /><input type="hidden" name="account" value='+account11+' /></form>';
		//document.body.innerHTML += '<form id="previousForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+previousPage+' /></form>';
		document.getElementById("previousForm").submit();		
	});
	$("#next").click(function () {
		var page=parseInt($("#pageNo").val());
		var lastPage=$("#totRows").val();
		if(page<lastPage){
			$("#pageNo").val(page+1);
		}
		var nextPage=parseInt($("#pageNo").val());		
		document.body.innerHTML += '<form id="nextForm" action="<c:url value='transactionList' />"><input type="hidden" name="page" value='+nextPage+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="merchantName" value='+merchantNameee+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="txnType" value='+txnTypee+' /><input type="hidden" name="amount" value='+amount11+' /><input type="hidden" name="account" value='+account11+' /></form>';
		document.getElementById("nextForm").submit();
		
	});
	$("#last").click(function () {
		var lastPage=$("#totRows").val();
		document.body.innerHTML += '<form id="lastForm" action="<c:url value='transactionList' />"><input type="hidden" name="page" value='+lastPage+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="merchantName" value='+merchantNameee+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="txnType" value='+txnTypee+' /><input type="hidden" name="amount" value='+amount11+' /><input type="hidden" name="account" value='+account11+' /></form>';
				
		//document.body.innerHTML += '<form id="lastForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+lastPage+' /></form>';
		document.getElementById("lastForm").submit();
	});

	$("#buttonClass").click(function() {
	    getValueUsingClass();
	});
		
});
</script>
	 <!-- page content -->
            <div class="right_col" role="main">
                <div class="">                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>DMT Transaction List</h2>
                                    <button type="button" class="btn-filter nav navbar-right panel_toolbox" data-toggle="modal" data-target=".filter-detail-popup" <c:if test="${empRole == '12'}">style="display:none;"</c:if>><i class="fa fa-filter" aria-hidden="true"></i>Filters</button>                                    
                                    <div class="clearfix"></div>
                                    <strong>
                                    <c:if test="${loginId!=''&&loginId!=null&&loginId!='A'}"> Login Id:<c:out value="${loginId}"/><input type="hidden" id="loginIddd" value='<c:out value="${loginId}"/>'/></c:if>
                                    <c:if test="${merchantName!=''&&merchantName!=null&&merchantName!='A'}"> || Merchant Name:<c:out value="${merchantName}"/><input type="hidden" id="merchantNamee" value='<c:out value="${merchantName}"/>'/></c:if>
                                    <c:if test="${fromDate!=''&&fromDate!=null&&fromDate!='A'}"> || From Date:<c:out value="${fromDate}"/><input type="hidden" id="fromDateee" value='<c:out value="${fromDate}"/>'/></c:if>
                                    <c:if test="${toDate!=''&&toDate!=null&&toDate!='A'}">  || To Date:<c:out value="${toDate}"/><input type="hidden" id="toDateee" value='<c:out value="${toDate}"/>'/></c:if>
									<c:if test="${status!=''&&status!=null&&status!='A'}"> || Status:<c:out value="${status}"/><input type="hidden" id="statusss" value='<c:out value="${status}"/>'/></c:if>
                                    <c:if test="${txnType!=''&&txnType!=null&&txnType!='A'}"> || Txn Type:<c:out value="${txnType}"/><input type="hidden" id="txnTypee" value='<c:out value="${txnType}"/>'/></c:if>
                               		<c:if test="${amount!=''&&amount!=null&&amount!='A'}"> || Amount:<c:out value="${amount}"/><input type="hidden" id="amount1" value='<c:out value="${amount}"/>'/></c:if>
                               		<c:if test="${account!=''&&account!=null&&account!='A'}"> || Account:<c:out value="${account}"/><input type="hidden" id="account1" value='<c:out value="${account}"/>'/></c:if>
                              </strong>
                                <div class="clearfix"></div>
                                </div>
                                <div>
                                    <table class="table table-striped responsive-utilities jambo_table bulk_action">
                                        <thead>
                                            <tr class="headings">
                                            
                                            	<th class="column-title">Id</th>
                                              	<th class="column-title">Txn Type</th>
                                              	<th class="column-title">Customer Id</th>                                          
												<th class="column-title">IFSC</th>
												<th class="column-title">Recipient Name</th>
												<th class="column-title">Account No</th>
												<th class="column-title">Amount</th>
												<th class="column-title">DateTime</th>												
												<th class="column-title">Status</th>
												<th class="column-title">UserName</th>
												<th class="column-title">MerchantName</th>
												<th class=" no-link last" valign="middle" align="center"><span class="nobr">Action</span></th>
                                           		 
                                            </tr>
                                        </thead>
                                    <tbody>
                                    	<c:forEach var="allRowData" items="${txnList}">											
                                        	<tr class="even pointer">
                          
                                        	<td class=" "><c:out value="${allRowData['id']}"/></td>
                                            	<td class=" "><c:out value="${allRowData['txnType']}"/></td>                                            		
												<td class=" "><c:out value="${allRowData['customerId']}"/></td>
												<td class=" "><c:out value="${allRowData['ifsc']}"/></td>
												<td class=" "><c:out value="${allRowData['recepientName']}"/></td>
												<td class=" "><c:out value="${allRowData['accountNo']}"/></td>
												<td class=" "><c:out value="${allRowData['amount']}"/></td>
												<td class=" "><c:out value="${allRowData['dateTime']}"/></td>
												<td class=" "><c:out value="${allRowData['status']}"/></td>
												<td class=" "><c:out value="${allRowData['userName']}"/></td>
												<td class=" "><a href="merchantdetails?MerchantId=${allRowData.mid}" target="_blank" /><u><c:out value="${allRowData['merchantName']}"/></u></a></td>
												<td align="right"><button type="button" data-toggle="modal" data-target=".Transaction-detail-popup" class="btn-action" onclick='return setTxnDetails("${allRowData.mobileNo}","${allRowData.bankName}","${allRowData.clientRefId}")'>Details</button>
												</td>	
											 </tr>
											</c:forEach>
											<tr id="pagingTd">
											<td colspan="12" align="right"><a href="#" id="first">First</a>&nbsp;
												<a style="cursor: pointer;" id="previous">Previous</a>&nbsp;
												<input type="text" size="1.5" id="pageNo" style="height:20px;" maxlength="5" name="pageNo" onkeypress="return isNumber(event)" />&nbsp;
												<a style="cursor: pointer;" id="next">Next</a>&nbsp;
												<a style="cursor: pointer;" id="last">Last</a><input type="hidden" id="totRows"/>
												</td>
											</tr>
									</tbody>										
                                    </table>
                                </div>
                            </div>
                        </div>
						  <br />
                        <br />
                        <br />

                    </div>
                </div>
                <!-- /page content -->	
<!---------------------------------------------- Small modal ----------------------------------------------------------- -->

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

<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter From Date" class="date-picker form-control" value='<c:out value="${fromDate}"/>' id="fromDate">

<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter To Date" class="date-picker form-control" value='<c:out value="${toDate}"/>' id="toDate">
<select data-clear-btn="true" name="status" id="status"  value='<c:out value="${status}"/>' class="form-control">
<option value="" <c:if test="${status == ''}">Selected</c:if>>Transaction Status</option>
<option <c:if test="${status == 'success'}">Selected</c:if> value="success"> Success</option>
<option <c:if test="${status == 'failed'}">Selected</c:if> value="failed"> Failed</option>
<option <c:if test="${status == 'pending'}">Selected</c:if> value="pending"> Pending</option>
</select>
<select data-clear-btn="true" name="txnType" id="txnType" value='<c:out value="${txnType}"/>' class="form-control">
	<option value="" <c:if test="${txnType == ''}">Selected</c:if>>Transaction Type</option>
	<option <c:if test="${txnType == 'NEFT'}">Selected</c:if> value="NEFT"> NEFT</option>
	<option <c:if test="${txnType == 'IMPS'}">Selected</c:if> value="IMPS"> IMPS</option>
	
</select>
<input type="text" style="height: 30px;" maxlength="25" placeholder="Enter Account" id="account" value='<c:out value="${account}"/>' class="form-control" />
<input type="text" style="height: 30px;" maxlength="25" placeholder="Enter Amount" id="amount" value='<c:out value="${amount}"/>' class="form-control" />



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
                        
                        
<!---------------------------------- /modals ------------------------------------------------------>
	<jsp:include page="/jsp/footer.jsp" />
