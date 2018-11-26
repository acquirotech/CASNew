<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!session.getAttribute("empRole").equals("1")){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">

<c:if var="msg" test="${message!=null}">
alert('<c:out value="${message}" />');	
</c:if>

function isDecimal(evt){
	var serviceTax = $("#serviceTax").val().to;
	var mdrDebit0 = $("#mdrDebit0").val();
	var mdrDebit1 = $("#mdrDebit1").val();
	var mdrDebit2 = $("#mdrDebit2").val();
	var mdrCr = $("#mdrCr").val();
	var mdrCrpn = $("#mdrCrpn").val();
	var mdrAmex = $("#mdrAmex").val();
	var other = $("#other").val();
	var mdrCashAtPos =$("#mdrCashAtPos").val();
	var cardPayoutAc =$("#cardPayoutAc").val();
	var cashAtPosServiceTax =$("#cashAtPosServiceTax").val();
	var neftFees =$("#neftFees").val();
	var systemUtilityFees =$("#systemUtilityFees").val();
	var systemUtilityAmount =$("#systemUtilityAmount").val();	
	
if (!( charCode == 46 || (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
	return false;
}
}
function callValidations(){

	var regex="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$";

	var mdrDebit0 = $("#mdrDebit0").val();
	var serviceTax = $("#serviceTax").val();
	var mdrDebit1 = $("#mdrDebit1").val();
	var mdrDebit2 = $("#mdrDebit2").val();
	var mdrCr = $("#mdrCr").val();
	var mdrCrpn = $("#mdrCrpn").val();
	var mdrAmex = $("#mdrAmex").val();
	var other = $("#other").val();
	var mdrCashAtPos=$("#mdrCashAtPos").val();
	var cardPayoutAc =$("#cardPayoutAc").val();
	var payoutEmail =$("#payoutEmail").val();
	var cashAtPosServiceTax =$("#cashAtPosServiceTax").val();
	
	if(cashAtPosServiceTax.match(regex) == null){
		alert("CashAtPos Service Fee Should be in proper format (xx.xxx)");
		return false;
	}
	if(serviceTax.match(regex) == null){
		alert("GST Should be in proper format (xx.xxx)");
		return false;
	}
	if(mdrDebit0.match(regex) == null)
	{
		alert("MdrDebit<1000 Should be in proper format (xx.xxx)");
		return false;
	}
	if(mdrDebit1.match(regex) == null)
	{
		alert("MdrDebit<2000 Should be in proper format (xx.xxx)");
		return false;
	}if(mdrDebit2.match(regex) == null)
	{
		alert("MdrDebit>2000 Should be in proper format (xx.xxx)");
		return false;
	}if(mdrCr.match(regex) == null)
	{
		alert("MdrCr Should be in proper format (xx.xxx)");
		return false;
	}if(mdrCrpn.match(regex) == null)
	{
		alert("MdrCrpn Should be in proper format (xx.xxx)");
		return false;
	}
	if(other.match(regex) == null)
	{
		alert("Other Should be in proper format (xx.xxx)");
		return false;
	}
	if(mdrCashAtPos.match(regex) == null){
		alert("Mdr CashAtPos Should be in proper format (xx.xxx)");
		return false;
	}
	if(mdrAmex.match(regex) == null){
		alert("MdrAmex Should be in proper format (xx.xxx)");
		return false;
	}
	if(serviceTax>=100){
		alert("Service Fee Should be < 100");
		$("#serviceTax").val('');
		return false;
	}if(mdrDebit0>=100){
		alert("MDR Debit<1000 Should be < 100");
		$("#mdrDebit1").val('');
		return false;
	}if(mdrDebit1>=100){
		alert("MDR Debit<2000 Should be < 100");
		$("#mdrDebit1").val('');
		return false;
	}if(mdrDebit2>=100){
		alert("MDR Debit>2000 Should be < 100");
		$("#mdrDebit2").val('');
		return false;
	}if(mdrCr>=100){
		alert("MDR Cr Should be < 100");
		$("#mdrCr").val('');
		return false;
	}if(mdrCrpn>=100){
		alert("MDR Crpn Should be < 100");
		$("#mdrCrpn").val('');
		return false;
	}if(mdrAmex>=100){
		alert("MDR Amex Should be < 100");
		$("#mdrAmex").val('');
		return false;
	}
	if(other>=100){
		alert("other Should be < 100");
		$("#other").val('');
		return false;
	if(cardPayoutAc.length<=5||cardPayoutAc.length>20){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Card Payout A/C</p></n>Length should be min 6 and max 20 char');
		return false;
	}
	if(payoutEmail!=null&&payoutEmail!=''){
		var re = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
		console.log('re.test(payoutEmail): '+re.test(payoutEmail));
		if(payoutEmail.length>100){
			console.log("Email length is > 100");
			alert("Enter Correct Payout EmailId");
			return false;
		}else if(re.test(payoutEmail)==false){			
			alert("Enter Correct Payout EmailId,Length should be less than 100 char");
			return false;
	    }
	}
	
	if (confirm("Do you want change settings?") == true) {       
    } else {
       return false;
    }
}
function isAlphaNumericWithoutSpace(event) {
	 try {
	     if (window.event) {
	         var charCode = window.event.keyCode;
	     }else if (e) {
	          var charCode = e.which;
	     }else { return true; }
	             if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58)
	                 return true;
	             else
	                 return false;
	    }
	    catch (err) {
	     alert(err. Description);
	    }
	}
</script> 
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                    <form class="form-horizontal form-label-left" id="MerchantDetailsForm" action="<c:url value='settingUpdate' />" method='POST' onsubmit="return callValidations()">
                     <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->

<!--- panel Organization ---------------------------------------------------------->                          
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Settings</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                     </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                   <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serviceTax">GST</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" name="serviceTax" id="serviceTax" value='<c:out value="${serviceTax}" />' required="true" minlength="1" maxlength=6 onkeypress='return isDecimal(event);' number="true"/> 
        									 </div>
                                   </div>                                        
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">MDR DEBIT<1000<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" name="mdrDebit0" id="mdrDebit0" value='<c:out value="${mdrDebit0}" />' required="true" minlength="1" maxlength=6 onkeypress='return isDecimal(event);' number="true"/>  </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">MDR DEBIT(>1000 & <2000)<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" name="mdrDebit1" id="mdrDebit1" value='<c:out value="${mdrDebit1}" />' required="true" minlength="1" maxlength=6 onkeypress='return isDecimal(event);' number="true"/>  </div>
                                        </div>
                                     
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="mdrDebit2">MDR DEBIT>2000<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <input type="text" class="form-control" name="mdrDebit2" id="mdrDebit2" value='<c:out value="${mdrDebit2}" />' required="true" minlength="1" maxlength=6 onkeypress='return isDecimal(event)' number="true"/> 
        								    </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mdrCr">MDR CREDIT NON-PREMIUM<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" name="mdrCr" id="mdrCr" value='<c:out value="${mdrCr}" />' required="true" minlength="1" onkeypress='return isDecimal(event)' number="true" maxlength=6 /> 
       										 </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mdrCrpn">MDR CREDIT PREMIUM<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <input type="text" class="form-control" name="mdrCrpn" id="mdrCrpn" value='<c:out value="${mdrCrpn}" />' required="true" minlength="1" onkeypress='return isDecimal(event)' number="true" maxlength=6 /> 
       									    </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mdrAmex">MDR AMEX<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                           		 <input type="text" class="form-control" name="mdrAmex" id="mdrAmex" value='<c:out value="${mdrAmex}" />' required="true" minlength="1" oncopy="return false" oncut="return false" onkeypress='return isDecimal(event)' number="true" onpaste="return false" maxlength=6 /> 
      										 </div>
                                  		</div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="AddOrgPinCode">OTHER<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              	<input type="text" class="form-control" name="other" id="other" value='<c:out value="${other}" />' required="true" minlength="1" onkeypress='return isDecimal(event)' number="true" maxlength=6 /> 
       										 </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mdrCashAtPos">MDR CashAtPos<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              	<input type="text" class="form-control" name="mdrCashAtPos" id="mdrCashAtPos" value='<c:out value="${mdrCashAtPos}" />' required="true" minlength="1" onkeypress='return isDecimal(event)' number="true" maxlength=6 /> 
       										 </div>
                                        </div>                                      
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cardPayoutAc">Card Payout A/C<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              	<input type="text" class="form-control" name="cardPayoutAc" id="cardPayoutAc" value='<c:out value="${cardPayoutAc}" />' required="true" minlength="6" onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" maxlength=20 /> 
       										 </div>
                                        </div>                                  
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="payoutEmail">Payout EmailId</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="payoutEmail" id="payoutEmail" value='<c:out value="${payoutEmail}" />' required="true" minlength="0" maxlength="100" email="true"  />
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cashAtPosServiceTax">CashAtPos Service Fee</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" name="cashAtPosServiceTax" id="cashAtPosServiceTax" value='<c:out value="${cashAtPosServiceTax}" />' required="true" minlength="1" maxlength=6 onkeypress='return isDecimal(event);' number="true"/> 
        									 </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">NEFT Fees<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" name="neftFees" id="neftFees" value='<c:out value="${neftFees}" />' required="true" minlength="0" maxlength=6 onkeypress='return isDecimal(event);' number="true"/>  </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">System Utilty Fees<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" name="systemUtilityFees" id="systemUtilityFees" value='<c:out value="${systemUtilityFees}" />' required="true" minlength="0" maxlength=6 onkeypress='return isDecimal(event);' number="true"/>  </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">System Utility Amount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" name="systemUtilityAmount" id="systemUtilityAmount" value='<c:out value="${systemUtilityAmount}" />' required="true" minlength="0" maxlength=6 onkeypress='return isDecimal(event);' number="true"/>  </div>
                                        </div>                                     
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="maintenanceMode">App Maintenance Mode</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
	                                            <select data-clear-btn="true" name="maintenanceMode" id="maintenanceMode"  value='<c:out value="${maintenanceMode}"/>' class="form-control">
													<option <c:if test="${maintenanceMode == 'ON'}">Selected</c:if> value="ON">ON</option>
													<option <c:if test="${maintenanceMode == 'OFF'}">Selected</c:if> value="OFF">OFF</option>
												</select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="maintenanceReason">Maintenance Reason</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" name="maintenanceReason" id="maintenanceReason" value='<c:out value="${maintenanceReason}" />' required="true" minlength="2" maxlength=50 /> 
        									 </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="appVersion">App Version</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" name="appVersion" id="appVersion" value='<c:out value="${appVersion}" />' required="true" minlength="1" maxlength=8 /> 
        									 </div>
                                        </div>                                       
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                                <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                 <button type="submit" class="btn-submit"  id="AddMerchantDetails" name="AddMerchantDetails">Update Settings</button>
                                            </div>
                                        </div>                                       
                                </div>
                            </div>                            
<!-- ----------------------------------------------------------------panels end----------------->
                        </div>
                    </form>
                    </div>
				</div>				
<!----------------------------------------- Small modal ------------------------------->
                                <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span>
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
<!-------------------------------------- /modals ------------------------------------------->
                <!-- /page content -->
<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->