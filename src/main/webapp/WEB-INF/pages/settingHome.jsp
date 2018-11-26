<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
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
	</script>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Settings</h3>
            </div>
            <form role="form" id="MerchantDetailsForm" action="<c:url value='settingUpdate' />" method='POST' onsubmit="return callValidations()">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">GST</label>
                      <input type="number" class="form-control input-lg" id="serviceTax" value='<c:out value="${serviceTax}"/>'>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MdrDebit < 1000</label>
                         <input type="number" class="form-control input-lg" id="mdrDebit0" value='<c:out value="${mdrDebit0}"/>'>
                   
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MDR DEBIT(>1000 & <2000)</label>
                         <input type="number" class="form-control input-lg" id="mdrDebit1" value='<c:out value="${mdrDebit1}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MDR DEBIT<2000</label>
                         <input type="number" class="form-control input-lg" id="mdrDebit2" value='<c:out value="${mdrDebit2}"/>'>
                   
                    </div>
                  </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MDR CashAtPos</label>
                         <input type="number" class="form-control input-lg" id="mdrCashAtPos" value='<c:out value="${mdrCashAtPos}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">CashAtPosServiceFee</label>
                         <input type="number" class="form-control input-lg" id="cashAtPosServiceTax" value='<c:out value="${cashAtPosServiceTax}"/>'>
                   
                    </div>
                  </div>
                  </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">NeftFees</label>
                         <input type="number" class="form-control input-lg" id="neftFees" value='<c:out value="${neftFees}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">SystemUtilityFees</label>
                         <input type="number" class="form-control input-lg" id="systemUtilityFees" value='<c:out value="${systemUtilityFees}"/>'>
                   
                    </div>
                  </div>
                  </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">SystemUtilityAmount</label>
                         <input type="number" class="form-control input-lg" id="systemUtilityAmount" value='<c:out value="${systemUtilityAmount}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MDR DEBIT<2000</label>
                         <select data-clear-btn="true" name="maintenanceMode" id="maintenanceMode"  value='<c:out value="${maintenanceMode}"/>' class="form-control input-lg">
													<option <c:if test="${maintenanceMode == 'ON'}">Selected</c:if> value="ON">ON</option>
													<option <c:if test="${maintenanceMode == 'OFF'}">Selected</c:if> value="OFF">OFF</option>
												</select>
                   
                    </div>
                  </div>
                  </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MDR CREDIT NON-PREMIUM</label>
                         <input type="number" class="form-control input-lg" id="mdrCr" value='<c:out value="${mdrCr}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MDR CREDIT PREMIUM</label>
                         <input type="number" class="form-control input-lg" id="mdrCrpn" value='<c:out value="${mdrCrpn}"/>'>
                   
                    </div>
                  </div>
                  </div>
                                    <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MaintenanceReason</label>
                         <input type="number" class="form-control input-lg" id="maintenanceReason" value='<c:out value="${maintenanceReason}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">AppVersion</label>
                         <input type="number" class="form-control input-lg" id="appVersion" value='<c:out value="${appVersion}"/>'>
                   
                    </div>
                  </div>
                  </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Mdr Amex</label>
                         <input type="number" class="form-control input-lg" id="mdrAmex" value='<c:out value="${mdrAmex}"/>'>
                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Other</label>
                         <input type="number" class="form-control input-lg" id="other" value='<c:out value="${other}"/>'>
                   
                    </div>
                  </div>
                </div>
              </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right">Sign in</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<jsp:include page="/jsp/footer.jsp" />