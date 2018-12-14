<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="/jsp/header.jsp" />	
	
<script type="text/javascript">


function downloadFile(){
	var fromDate1 = $("#fromDate1").val();
	var toDate1 = $("#toDate1").val();
	document.body.innerHTML += '<form id="downloadForm" action="<c:url value='downloadRiskDetails' />"><input type="hidden" name="fromDate" value='+fromDate1+' /><input type="hidden" name="toDate" value='+toDate1+' /></form>';
	document.getElementById("downloadForm").submit();
	setTimeout(function(){ location.reload(); }, 3000);	
}
function closeModel(){
	location.reload();
}

function searchClickedTns(){
	var fromDate = $("#fromDate").val();
	var toDate = $("#toDate").val();
	var loginId = $("#loginId").val();
	var custPhone = $("#custPhone").val();
	var txnId = $("#txnId").val();
	var status = $("#status").val();
	var walletEmail = $("#walletEmail").val();
	var txnType = $("#txnType").val();
	
	var appendMe="";
	var regEx = /^\d{2}\/\d{2}\/\d{4}$/;
	

	if(walletEmail!=null&&walletEmail!=""){
		appendMe=appendMe.concat("&walletEmail="+walletEmail+"")
	}
	if(status!=null&&status!=""){
		appendMe=appendMe.concat("&walletStatus="+status+"");
	}
	if(txnId!=null&&txnId!=""){
		appendMe=appendMe.concat("&walletTxnId="+txnId+"");
	}
	
	if(loginId!=null&&loginId!=""&&loginId.length==10){
		appendMe=appendMe.concat("&userPhone="+loginId+"");
	}
	if(custPhone!=null&&custPhone!=""&&custPhone.length==10){
		appendMe=appendMe.concat("&custPhone="+custPhone+"");
	}
	if(txnType!=null&&txnType!=""){
		appendMe=appendMe.concat("&txnType="+txnType+"");
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
	}
	document.location.href = "?page=1&txn=123654321"+appendMe;
}
function clearAllFillter(){
	var txnId = $("#txnId").val('');
	var walletEmail = $("#walletEmail").val('');
	var status = $("#status").val('');
	var loginId = $("#loginId").val('');
	var custPhone = $("#custPhone").val('');
	var fromDate = $("#fromDate").val('');
	var toDate = $("#toDate").val('');
	var txnType = $("#txnType").val('');
	 document.location.href = "?page=1"
}



function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}


function updateStatus(riskId,txnType){
	if (confirm("Do you want to update Status ?") == true) {
		$("#modal-body1").html("<h2>In Process</h2>");
		var sendvalue={riskId:riskId,txnType:txnType}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body1").html("<h2>Risk Status Updated Successfully</h2>"); 
	               //     alert('Risk Status Updated Successfully');
	                    location.reload(); 
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
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
	            url: "updateRiskStatus",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}else{
		$("#modal-body1").html("<h2>Transaction not updated for risk</h2>"); 
		return false;
	}
}


function setTxnDetails(merchantName,orgName,userName,txnId,emailId,amount,status,datetime,phoneno,statusDesc,txnType,cardHolderName,cardPanNo,cardType,cardExpDate,rrNo,referenceNo,terminalId,batchNo,authCode,issuerAuthCode,ipAddress,imeiNo,latitude,longitude,stan,riskDescription){
	//console.log('111111111111111111111111');
	if(txnType=='CARD'||txnType=='CASHATPOS'){
		$("#modal-body").html(" Merchant Name : "+merchantName+"<br> Store Name : "+orgName+"<br> Terminal Id : "+userName+"<br> Invoice No : "+txnId+"<br> Email Id : "+emailId+"<br> Amount : "+amount+"<br> Status : "+status+"<br> Description : "+statusDesc+"<br> Date Time : "+datetime+"<br> Phone No : "+phoneno+"<br> Txn Type : "+txnType+"<br> Card HolderName : "+cardHolderName+"<br> CardPanNo : "+cardPanNo+"<br> Card Type : "+cardType+"<br> RR No : "+rrNo+"<br> Terminal Id : "+terminalId+"<br> Batch No : "+batchNo+"<br> Auth Code : "+authCode+"<br> IP Address : "+ipAddress+"<br> IMEI No : "+imeiNo+"<br> Latitude : "+latitude+"<br> Longitude : "+longitude+"<br> Stan : "+stan+"<br> Risk Description :"+riskDescription+"<br>")
	}else{
		$("#modal-body").html(" Merchant Name : "+merchantName+"<br> Store Name : "+orgName+"<br> Terminal Id : "+userName+"<br> Invoice No : "+txnId+"<br> Email Id : "+emailId+"<br> Amount : "+amount+"<br> Status : "+status+"<br> Description : "+statusDesc+"<br> Date Time : "+datetime+"<br> Phone No : "+phoneno+"<br> Txn Type : "+txnType+"<br> Risk Description :"+riskDescription+"<br>")
	}
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
	var custPhoneees=$("#custPhoneee").val();
	var fromDateees=$("#fromDateee").val();
	var toDateees=$("#toDateee").val();
	var txnIddds=$("#txnIddd").val();
	var statussss=$("#statusss").val();
	var walletEmaillls=$("#walletEmailll").val();
	var txnTypee=$("#txnTypee").val();
	if(txnTypee==undefined)
		txnTypee='%41';
	if(loginIddds==undefined)
		loginIddds='%41';
	if(custPhoneees==undefined)
		custPhoneees='%41';
	if(fromDateees==undefined)
		fromDateees='%41';
	if(toDateees==undefined)
		toDateees='%41';
	if(txnIddds==undefined)
		txnIddds='%41';
	if(statussss==undefined)
		statussss='%41';
	if(walletEmaillls==undefined)
		walletEmaillls='%41';
	
	$("#pageNo").change(function(){
		var pageNo = $("#pageNo").val();
				
		if(pageNo!=null&&pageNo!=""){
			document.body.innerHTML += '<form id="pageForm" action="<c:url value='riskManagementList' />"><input type="hidden" name="page" value='+pageNo+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="custPhone" value='+custPhoneees+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletTxnId" value='+txnIddds+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="walletEmail" value='+walletEmaillls+' /><input type="hidden" name="txnType" value='+txnTypee+' /></form>';
			document.getElementById("pageForm").submit();
		}
	});	
	$("#first").click(function () {
		var page=1;
		$("#pageNo").val(page);
		var location = $("#storeLocation").val();
	
		document.body.innerHTML += '<form id="firstForm" action="<c:url value='riskManagementList' />"><input type="hidden" name="page" value="1" /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="custPhone" value='+custPhoneees+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletTxnId" value='+txnIddds+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="walletEmail" value='+walletEmaillls+' /><input type="hidden" name="txnType" value='+txnTypee+' /></form>';
		document.getElementById("firstForm").submit();	
	});
	$("#previous").click(function () {
		var page=$("#pageNo").val();
		if(page>1){
			$("#pageNo").val(page-1);
		}
		var previousPage=$("#pageNo").val();
	
		document.body.innerHTML += '<form id="previousForm" action="<c:url value='riskManagementList' />"><input type="hidden" name="page" value='+previousPage+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="custPhone" value='+custPhoneees+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletTxnId" value='+txnIddds+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="walletEmail" value='+walletEmaillls+' /><input type="hidden" name="txnType" value='+txnTypee+' /></form>';
		document.getElementById("previousForm").submit();		
	});
	$("#next").click(function () {
		var page=parseInt($("#pageNo").val());
		var lastPage=$("#totRows").val();
		if(page<lastPage){
			$("#pageNo").val(page+1);
		}
		var nextPage=parseInt($("#pageNo").val());		
		document.body.innerHTML += '<form id="nextForm" action="<c:url value='riskManagementList' />"><input type="hidden" name="page" value='+nextPage+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="custPhone" value='+custPhoneees+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletTxnId" value='+txnIddds+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="walletEmail" value='+walletEmaillls+' /><input type="hidden" name="txnType" value='+txnTypee+' /></form>';
		document.getElementById("nextForm").submit();
		
	});
	$("#last").click(function () {
		var lastPage=$("#totRows").val();
		document.body.innerHTML += '<form id="lastForm" action="<c:url value='riskManagementList' />"><input type="hidden" name="page" value='+lastPage+' /><input type="hidden" name="txn" value="123654321" /><input type="hidden" name="userPhone" value='+loginIddds+' /><input type="hidden" name="custPhone" value='+custPhoneees+' /><input type="hidden" name="fromDateTime" value='+fromDateees+' /><input type="hidden" name="toDateTime" value='+toDateees+' /><input type="hidden" name="walletTxnId" value='+txnIddds+' /><input type="hidden" name="walletStatus" value='+statussss+' /><input type="hidden" name="walletEmail" value='+walletEmaillls+' /><input type="hidden" name="txnType" value='+txnTypee+' /></form>';
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
                                    <h2>Card Risk Transaction List</h2>
                                    <button type="button" class="btn-filter nav navbar-right panel_toolbox" data-toggle="modal" data-target=".filter-detail-popup" <c:if test="${empRole == '12'}">style="display:none;"</c:if>>Filters</button>                                    
                                     <button type="button" class="btn-filter nav navbar-right panel_toolbox" data-toggle="modal" data-target=".download-detail-popup">Download File</button>&nbsp;&nbsp; 
                                   
                                    <div class="clearfix"></div>
                                    <strong>
                                    <c:if test="${loginId!=''&&loginId!=null&&loginId!='A'}"> Login Id:<c:out value="${loginId}"/><input type="hidden" id="loginIddd" value='<c:out value="${loginId}"/>'/></c:if>
                                     <c:if test="${custPhone!=''&&custPhone!=null&&custPhone!='A'}"> || Customer Phone:<c:out value="${custPhone}"/><input type="hidden" id="custPhoneee" value='<c:out value="${custPhone}"/>'/></c:if>
                                      <c:if test="${fromDate!=''&&fromDate!=null&&fromDate!='A'}"> || From Date:<c:out value="${fromDate}"/><input type="hidden" id="fromDateee" value='<c:out value="${fromDate}"/>'/></c:if>
                                       <c:if test="${toDate!=''&&toDate!=null&&toDate!='A'}">  || To Date:<c:out value="${toDate}"/><input type="hidden" id="toDateee" value='<c:out value="${toDate}"/>'/></c:if>
									 <c:if test="${txnId!=''&&txnId!=null&&txnId!='A'}"> || Transaction Id:<c:out value="${txnId}"/><input type="hidden" id="txnIddd" value='<c:out value="${txnId}"/>'/></c:if>
                                    <c:if test="${status!=''&&status!=null&&status!='A'}"> || Status:<c:out value="${status}"/><input type="hidden" id="statusss" value='<c:out value="${status}"/>'/></c:if>
                                    <c:if test="${walletEmail!=''&&walletEmail!=null&&walletEmail!='A'}"> || Email:<c:out value="${walletEmail}"/><input type="hidden" id="walletEmailll" value='<c:out value="${walletEmail}"/>'/></c:if>
                              		<c:if test="${txnType!=''&&txnType!=null&&txnType!='A'}"> || Txn Type:<c:out value="${txnType}"/><input type="hidden" id="txnTypee" value='<c:out value="${txnType}"/>'/></c:if>
                               </strong>
                                <div class="clearfix"></div>
                                </div>
                                <div>
                                    <table class="table table-striped responsive-utilities jambo_table bulk_action">
                                        <thead>
                                            <tr class="headings">
                                            	<th class="column-title">Invoice No</th>
                                              	<th class="column-title">Date Time</th>
                                              	<th class="column-title">Amount</th>
                                              	<th class="column-title">Cust Phone</th>
                                              	<th class="column-title">Merchant Name</th>
												<th class="column-title">Card Pan No</th>
												<th class="column-title">Status</th>
												<th class=" no-link last"><span class="nobr">Action</span></th>
                                           		<th class="bulk-actions" colspan="8"><a class="antoo" style="color:#fff; font-weight:500;"><span id="deleteBulkItems" class="glyphicon glyphicon-trash" aria-hidden="true"></span>(<span class="action-cnt"></span>) <i class="fa fa-chevron-down"></i></a>
                                              </th>
                                            </tr>
                                        </thead>
                                    <tbody>
                                    	<c:forEach var="allRowData" items="${riskManagementList}">											
                                        	<tr class="even pointer">
                                            	<td class=" "><c:out value="${allRowData['id']}"/></td>
                                            	<td class=" "><c:out value="${allRowData['dateTime']}"/></td>                                            		
												<td class=" "><c:out value="${allRowData['amount']}"/></td>
												<td class=" "><c:out value="${allRowData['custPhone']}"/></td>
												<td class=" "><c:out value="${allRowData['merchantName']}"/></td>
												<td class=" "><c:out value="${allRowData['cardPanNo']}"/></td>	
												<td class=" "><c:out value="${allRowData['status']}"/></td>
												<td><button type="button" data-toggle="modal" data-target=".Transaction-detail-popup" class="btn-action" onclick='return setTxnDetails("${allRowData.merchantName}","${allRowData.orgName}","${allRowData.userName}","${allRowData.id}","${allRowData.custEmail}","${allRowData.amount}","${allRowData.status}","${allRowData.dateTime}","${allRowData.custPhone}","${allRowData.statusDescription}","${allRowData.txnType}","${allRowData.cardHolderName}","${allRowData.cardPanNo}","${allRowData.cardType}","${allRowData.cardExpDate}","${allRowData.rrNo}","${allRowData.referenceNo}","${allRowData.terminalId}","${allRowData.batchNo}","${allRowData.authCode}","${allRowData.issuerAuthCode}","${allRowData.ipAddress}","${allRowData.imeiNo}","${allRowData.latitude}","${allRowData.longitude}","${allRowData.stan}","${allRowData.riskDescription}")'>View Details</button>	
												 <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-action" onclick='return updateStatus("${allRowData.riskId}","${allRowData.txnType}");'>Update</button></td>	
										
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
<!---------------------------------------------- Small modal ------------------------------------------------------------->
 	<div class="modal fade filter-detail-popup filter-form" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel22">Set Filters</h4>
				</div>
				<div id="modal-body2" class="modal-body">
 <input type="text" style="height: 30px;" maxlength="10" placeholder="Enter login Id" id="loginId" value='<c:out value="${loginId}"/>' class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/>
<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Customer Phone" id="custPhone" value='<c:out value="${custPhone}"/>' class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/>
<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Invoice No" id="txnId" value='<c:out value="${txnId}"/>' class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/>

<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter Email" id="walletEmail" value='<c:out value="${walletEmail}"/>' class="form-control" email="true"/>
<select data-clear-btn="true" name="txnType" id="txnType"  value='<c:out value="${txnType}"/>' class="form-control">
	<option value="" <c:if test="${txnType == ''}">Selected</c:if>>Select</option>
	<option <c:if test="${txnType == 'card'}">Selected</c:if> value="card"> Card</option>
</select>
<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter From Date" class="date-picker form-control" value='<c:out value="${fromDate}"/>' id="fromDate">
<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter To Date" class="date-picker form-control" value='<c:out value="${toDate}"/>' id="toDate">
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
						<span aria-hidden="true">×</span>
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
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
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
                         <!---------------------------------------------- Small modal ------------------------------------------------------------->
 <div class="modal fade download-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<!--  <span aria-hidden="true">×</span> -->
					</button>
					<h4 class="modal-title" id="myModalLabel21">Download File</h4>
				</div>
				<div id="modal-body" class="modal-body">
					<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter From Date" class="date-picker form-control" id="fromDate1"><br/>
					<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter To Date" class="date-picker form-control"  id="toDate1"><br/>				
				    <button type="button" class="btn-submit" onclick="return downloadFile();">Search</button>
			        <button type="button" class="btn-cancel" onclick="return closeModel();">Close</button>			
				</div>
				<div class="modal-footer">
					<!--  <button type="button" class="btn btn-default" id="close" >Close</button>-->
				</div>
			</div>
		</div>                              
 </div>
<!---------------------------------- /modals ------------------------------------------------------>
	<jsp:include page="/jsp/footer.jsp" />
