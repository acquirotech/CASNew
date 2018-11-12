<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3")||session.getAttribute("empRole").equals("7"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">

function onChangeAmexActivated() {
    var AmexActivated = $("#AmexActivated").val();
    if (AmexActivated == "NO"){
    	$("#div_mdrAmex").hide();
    	$("#div_amexTID").hide();
    	$("#div_amexMID").hide();    	      
   	}else{
   		$("#div_mdrAmex").show();
   		$("#div_amexTID").show();
   		$("#div_amexMID").show();
  	}
}

function submitDevice(){	
	$("#AddDeviceDetails").hide();
	$("#modal-body").html("<h2>In Process</h2>");
	var midTidEntryDate=$("#midTidEntryDate").val();
	var wlcmLtrSendDate=$("#wlcmLtrSendDate").val();
	var merchantId=$("#merchantId").val();
	var orgId=$("#orgId").val();
	var SerialNo=$("#SerialNo").val();
	var bankTid=$("#BankTid").val();
	var LoginId=$("#LoginId").val();
	var rmn=$("#rmn").val();
	var UserEmailId=$("#UserEmailId").val();
	var Name=$("#Name").val();
	var Rent=$("#Rent").val();
	var validTil=$("#validTil").val();
	var pendingRent=$("#pendingRent").val();
	var PaymentMode=$("#PaymentMode").val();
	var MdrDebit0=$("#MdrDebit0").val();
	var MdrDebit1=$("#MdrDebit1").val();
	var MdrDebit2=$("#MdrDebit2").val();
	var MdrCreditPre=$("#MdrCreditPre").val();
	var MdrCreditNpre=$("#MdrCreditNpre").val();
	var Other=$("#Other").val();
	var mdrCashAtPos=$("#mdrCashAtPos").val();
	var bankAccType=$("#bankAccType").val();
	var bankAccNumber=$("#bankAccNumber").val();
	var bankName=$("#bankName").val();
	var benefName=$("#benefName").val();
	var bankIfsc=$("#bankIfsc").val();
	var bankMicr=$("#bankMicr").val();
	var AmexActivated=$("#AmexActivated").val();
	var mdrAmex=$("#mdrAmex").val();
	var amexTID=$("#amexTID").val();
	var amexMID=$("#amexMID").val();
	var bankBranch=$("#bankBranch").val();
	var merchantType=$("#merchantType").val();	
	//var userType=$("#userType").val();
	var mobiKwik=$("#mobiKwik").val();
	var penaltyAmount=$("#penaltyAmount").val();
	var discount=$("#discount").val();
	var avgTxnAmount=$("#avgTxnAmount").val();
	var discountReason=$("#discountReason").val();
	var penaltyReason=$("#penaltyReason").val();
	var integrationKey=$("#integrationKey").val();
	var settlementCharges=$("#settlementCharges").val();	
	var planName=$("#planName").val();
	var feeModel=$("#feeModel").val();
	var feeAmount=$("#feeAmount").val();
	var feeDate=$("#feeDate").val();
	var feeRemarks=$("#feeRemarks").val();
	var switchType="AQR";
	if($("#rechargeServiceEnable").is(":checked") == true) {
		var rechargeServiceEnable = "1";
	}else{
		var rechargeServiceEnable = "0";
	}
	if($("#ppcServiceEnable").is(":checked") == true) {
		var ppcServiceEnable = "1";
	}else{
		var ppcServiceEnable = "0";
	}
	if($("#dmtServiceEnable").is(":checked") == true) {
		var dmtServiceEnable = "1";
	}else{
		var dmtServiceEnable = "0";
	}
	if($("#dthMobileServiceEnable").is(":checked") == true) {
		var dthMobileServiceEnable = "1";
	}else{
		var dthMobileServiceEnable = "0";
	}
	if($("#userType").is(":checked") == true) {
		var userType = "credit";
	}else{
		var userType = "notCredit";
	}

	var rechargeBal=$("#rechargeBal").val();
	var rechargeIncentive=$("#rechargeIncentive").val();
	var rechargeMonthlyRental=$("#rechargeMonthlyRental").val();
	
	var regex="^[0-9]{1,8}[\\.]{1}[0-9]{0,2}?$";
	
	if(rechargeServiceEnable!="0"){
	 if(rechargeBal==null||rechargeBal==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Balance</p>');
			$("#AddDeviceDetails").show();
			return false;
		}else if(rechargeBal<1||rechargeBal>13){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Recharge Balance</p>');
			$("#AddDeviceDetails").show();
			return false;
		}
	 if(rechargeIncentive==null||rechargeIncentive==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Incentive</p>');
			$("#AddDeviceDetails").show();
			return false;
		}else if(rechargeIncentive>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Recharge Incentive</p>');
			$("#AddDeviceDetails").show();
			return false;
		}
	 if(rechargeMonthlyRental==null||rechargeMonthlyRental==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Monthly Rental</p>');
			$("#AddDeviceDetails").show();
			return false;
		}else if(rechargeMonthlyRental>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Recharge Monthly Rental</p>');
			$("#AddDeviceDetails").show();
			return false;
		}
	}


	
	var maxValue = 100;
	if(merchantId==null||merchantId==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Merchant Name</p>');
		$("#AddDeviceDetails").show();
		return false;
	}else if(orgId==null||orgId==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Store Name</p>');
		$("#AddDeviceDetails").show();
		return false;
	}else if(userType==null||userType==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select User Type</p>');
		$("#AddDeviceDetails").show();
		return false;
	}
	if(userType=="wallet")
	{
	 if(mobiKwik==null||mobiKwik==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Wallet MDR</p>');
		$("#AddDeviceDetails").show();
		return false;
	}else if(mobiKwik>=maxValue){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Wallet MDR</p>');
		$("#AddDeviceDetails").show();
		return false;
	}
	}
	if(userType=="credit"){
		if(MdrDebit0==null||MdrDebit0==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit0</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit0>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit0</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit1==null||MdrDebit1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit1</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit1>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit1</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit2==null||MdrDebit2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit2</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit2>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit2</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditPre==null||MdrCreditPre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Credit Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditPre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditNpre==null||MdrCreditNpre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Credit Non Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditNpre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Non Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(Other==null||Other==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Other</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(Other>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Other</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(mdrCashAtPos==null||mdrCashAtPos==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter CashAtPos</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(AmexActivated==null||AmexActivated==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Choose Amex Activated</p>');
			$("#AddDeviceDetails").show();
			return false;
		}else if(SerialNo==null||SerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 and max 17 char');
			$("#AddDeviceDetails").show();
			return false;
		}else if(SerialNo.length<8||SerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 and max 17 char');
			$("#AddTerminalDetails").show();
			return false;
		}
		if(AmexActivated=="YES"){
			if(mdrAmex==null||mdrAmex==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Amex</p>');
				$("#AddDeviceDetails").show();
				return false;
			}else if(mdrAmex>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Amex</p>');
				$("#AddDeviceDetails").show();
				return false;
			}else if(amexTID==null&&amexTID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex TID</p></n>Length should be 8 digits');
				$("#AddDeviceDetails").show();
				return false;
			}else if(amexTID.length<8||amexTID.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex TID</p></n>Length should be 8 digits');
				$("#AddDeviceDetails").show();
				return false;
			}else if(amexMID==null&&amexMID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex MID</p></n>Length should be min 10 and max 45 char');
				$("#AddDeviceDetails").show();
				return false;
			}else if(amexMID.length<10||amexMID.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex MID</p></n>Length should be min 10 and max 45 char');
				$("#AddDeviceDetails").show();
				return false;
			}
		}
		
	}
	if(userType=="wallet/credit"){
		if(bankTid==null||bankTid==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank TID</p></n>Length should be 8 char');
			return false;
		}else if(bankTid.length<8||bankTid.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Tid</p></n>Length should be 8 char');
			return false;
		}else 
		if(MdrDebit0==null||MdrDebit0==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit0</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit0>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit0</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit1==null||MdrDebit1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit1</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}
		else if(MdrDebit1>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit1</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit2==null||MdrDebit2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit2</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrDebit2>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit2</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditPre==null||MdrCreditPre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Credit Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditPre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditNpre==null||MdrCreditNpre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Credit Non Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(MdrCreditNpre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Non Premium</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(Other==null||Other==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Other</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(mdrCashAtPos==null||mdrCashAtPos==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter CashAtPos</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(Other>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Other</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(mobiKwik==null||mobiKwik==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Wallet MDR</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(mobiKwik>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Wallet MDR</p></n>value must be less than 100');
			$("#AddDeviceDetails").show();
			return false;
		}else if(AmexActivated==null||AmexActivated==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Choose Amex Activated</p>');
			$("#AddDeviceDetails").show();
			return false;
		}else if(SerialNo==null||SerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 and max 17 char');
			$("#AddDeviceDetails").show();
			return false;
		}else if(SerialNo.length<8||SerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 and max 17 char');
			$("#AddDeviceDetails").show();
			return false;
		}		
		if(AmexActivated=="YES"){
			if(mdrAmex==null||mdrAmex==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Amex</p>');
				$("#AddDeviceDetails").show();
				return false;
			}
			else if(mdrAmex>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Amex</p>');
				$("#AddDeviceDetails").show();
				return false;
			}
			else if(amexTID==null&&amexTID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex TID</p></n>Length should be 8 digits');
				$("#AddDeviceDetails").show();
				return false;
			}
			else if(amexTID.length<8||amexTID.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex TID</p></n>Length should be 8 digits');
				$("#AddDeviceDetails").show();
				return false;
			}
			else if(amexMID==null&&amexMID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex MID</p></n>Length should be min 10 and max 45 char');
				$("#AddDeviceDetails").show();
				return false;
			}else if(amexMID.length<10||amexMID.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex MID</p></n>Length should be min 10 and max 45 char');
				$("#AddDeviceDetails").show();
				return false;
			}
		}
	}else if(LoginId==null||LoginId==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Login Id</p></n>Length should be 10 digits');
		$("#AddDeviceDetails").show();
		return false;
	}else if(LoginId.length<10||LoginId.length>10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Login Id</p></n>Length should be 10 digits');
		$("#AddDeviceDetails").show();
		return false;
	}
	else if(rmn==null||rmn==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter RMN</p></n>Length should be 10 digits');
		$("#AddDeviceDetails").show();
		return false;
	}else if(rmn.length<10||rmn.length>10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct RMN</p></n>Length should be 10 digits');
		$("#AddDeviceDetails").show();
		return false;
	}
	else if(UserEmailId!=null&&UserEmailId!=''&&UserEmailId.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length should be less than 100 char');
		$("#AddDeviceDetails").show();
		return false;
	}
	else if(Name==null||Name==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Name</p></n>Length should be min 2 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(Name.length<2||Name.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 2 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(validTil==null||validTil==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter valid till Date</p>');
		$("#AddDeviceDetails").show();
		return false;
	}else if(Rent==null||Rent==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Length should be min 1 and max 8 digits');
		$("#AddDeviceDetails").show();
		return false;
	}else if(Rent.length<1||Rent.length>8){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Rent</p></n>Length should be min 1 and max 8 digits');
		$("#AddDeviceDetails").show();
		return false;
	}else if(PaymentMode==null||PaymentMode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Payment Mode</p>');
		$("#AddDeviceDetails").show();
		return false;
	}else if(PaymentMode.length<=2||PaymentMode.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Payment Mode</p>');
		$("#AddDeviceDetails").show();
		return false;
	}else if(pendingRent==null||pendingRent==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Length should be min 1 and max 8 digits');
		$("#AddDeviceDetails").show();
		return false;
	}else if(pendingRent.length<1||pendingRent.length>8){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Rent</p></n>Length should be min 1 and max 8 digits');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankAccType==null||bankAccType==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Account Type</p></n>Length should be min 1 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankAccType.length<1||bankAccType.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Account Type</p></n>Length should be min 1 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankAccNumber==null||bankAccNumber==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Account Number</p></n>Length should be min 6 and max 30 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankAccNumber.length<6||bankAccNumber.length>30){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Account Number</p></n>Length should be min 6 and max 30 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankName==null||bankName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Name</p></n>Length should be min 1 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankName.length<1||bankName.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct  Bank Name</p></n>Length should be min 1 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(benefName==null||benefName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name</p></n>Length should be min 1 and max 45 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(benefName.length<1||benefName.length>45){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Beneficiary Name</p></n>Length should be min 1 and max 45 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankBranch==null||bankBranch==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Branch</p></n>Length should be min 1 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankBranch.length<1||bankBranch.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct  Bank Branch</p></n>Length should be min 1 and max 50 char');
		$("#AddDeviceDetails").show();
		return false;
	}
	else if(bankIfsc==null||bankIfsc==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank IFSC</p></n>Length should be 11 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankIfsc.length<11||bankIfsc.length>11){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank IFSC</p></n>Length should be 11 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankMicr==null||bankMicr==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank MICR</p></n>Length should be min 9 and max 15 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(bankMicr.length<9||bankMicr.length>15){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank MICR</p></n>Length should be min 9 and max 15 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(penaltyAmount!=null&&penaltyAmount!=''){
		if(penaltyAmount.length<1||penaltyAmount.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct penalty Amount</p></n>Length should be min 1 and max 8 digits');
			$("#AddDeviceDetails").show();
			return false;
		 }
	}else if(discount!=null&&discount!=''){
		if(discount.length<1||discount.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Discount</p></n>Length should be min 1 and max 8 digits');
			$("#AddDeviceDetails").show();
			return false;
		}
	}	
	if(avgTxnAmount==null||avgTxnAmount==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Average Transaction Amount </p></n>Length should be min 1 and max 11 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(avgTxnAmount.length<1||avgTxnAmount.length>11){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Transaction Amount</p></n>Length should be min 1 and max 11 char');
		$("#AddDeviceDetails").show();
		return false;
	}else if(integrationKey!=null&&integrationKey!=''&&integrationKey.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Integration Key</p></n>Length should be less than 100 char');
		$("#AddDeviceDetails").show();
		return false;
	}	
	if(planName==null||planName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Plan Name');
		$("#AddDeviceDetails").show();
		return false;
	}
	var frmData = new FormData();
	/*if(feeModel==null||feeModel==''||feeModel.length<2){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Fee Model');
		$("#AddDeviceDetails").show();
		return false;
	}if(feeAmount==null||feeAmount==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Fee Amount');
		$("#AddDeviceDetails").show();
		return false;
	}else(feeAmount.length<1||feeAmount.length>11){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Fee Amount</p></n>Length should be min 1 and max 11 char');
		$("#AddDeviceDetails").show();
		return false;
	}if(feeDate==null||feeDate==''||feeDate.length!=10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Correct Fee date</p>');
		$("#AddDeviceDetails").show();
		return false;
	}if(activationDate==null||activationDate==''||activationDate.length!=10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Correct Activation date</p>');
		$("#AddDeviceDetails").show();
		return false;
	}if(feeRemarks==null||feeRemarks==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Fee Remarks </p></n>Length should be min 1 and max 150 char');
		$("#AddDeviceDetails").show();
		return false;
	}else(feeRemarks.length<1||feeRemarks.length>150){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Fee Remarks </p></n>Length should be min 1 and max 150 char');
		return false;
	}*/
	
	var sendvalue={
			MerchantId:merchantId,OrgId:orgId,SerialNo:SerialNo,bankTid:bankTid,accountNo:bankAccNumber,bankName:bankName,
			accountType:bankAccType,bankIfsc:bankIfsc,bankMicr:bankMicr,validTil:validTil,rent:Rent,PaymentMode:PaymentMode,pendingRent:pendingRent,Name:Name,loginId:LoginId,
			rmn:rmn,EmailId:UserEmailId,MdrDebit1:MdrDebit1,MdrDebit2:MdrDebit2,MdrCreditPre:MdrCreditPre,
			MdrCreditNpre:MdrCreditNpre,MdrAmex:mdrAmex,Other:Other,mdrCashAtPos:mdrCashAtPos,amexActivated:AmexActivated,amexTID:amexTID,amexMID:amexMID,branchName:bankBranch,
			userType:userType,mdrMobiKwik:mobiKwik,penaltyAmount:penaltyAmount,discount:discount,avgTxnAmount:avgTxnAmount,benefName:benefName,penaltyReason:penaltyReason,discountReason:discountReason,integrationKey:integrationKey,
			MdrDebit0:MdrDebit0,planName:planName,feeModel:feeModel,feeAmount:feeAmount,feeDate:feeDate,feeRemarks:feeRemarks, switchType:switchType,midTidEntryDate:midTidEntryDate,wlcmLtrSendDate:wlcmLtrSendDate,settlementCharges:settlementCharges,rechargeServiceEnable:rechargeServiceEnable,
			rechargeBal:rechargeBal,rechargeIncentive:rechargeIncentive,rechargeMonthlyRental:rechargeMonthlyRental,ppcServiceEnable:ppcServiceEnable,dmtServiceEnable:dmtServiceEnable,dthMobileServiceEnable:dthMobileServiceEnable
			}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>User Terminal Added Successfully</h2>");  
                    window.location.reload();
                    $("#AddDeviceDetails").show();
                    $("#merchantId").val('');$("#orgId").val('');
                    $("#SerialNo").val('');$("#BankTid").val('');
                    $("#LoginId").val('');$("#rmn").val('');
                    $("#UserEmailId").val('');$("#Name").val('');
                    $("#Rent").val('');
                    $("#PaymentMode").val('');$("#MdrDebit1").val('');$("#MdrDebit2").val('');
                    $("#userType").val('');
                    $("#MdrCreditPre").val('');;$("#MdrCreditNpre").val('');
                    $("#Other").val('');$("#bankAccType").val('');$("#bankAccNumber").val('');
                    $("#bankName").val('');$("#bankIfsc").val('');
                    $("#bankMicr").val('');$("#AmexActivated").val('');$("#amexTID").val('');
                    $("#mdrAmex").val('');
                    $("#amexMID").val('');$("#bankBranch").val('');$("#pendingRent").val();
                    $("#penaltyAmount").val('');$("#discount").val('');$("#avgTxnAmount").val('');
                    $("#integrationKey").val('');
                    
                } else if (data.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (data.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");  
                    $("#AddDeviceDetails").show();                  
                }
                else if (obj.message.startsWith('Invalid')) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");
                    $("#AddDeviceDetails").show();                    
                }else if (obj.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>"); 
                    $("#AddDeviceDetails").show();      
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
                    $("#AddDeviceDetails").show();
                }
                
            },
            error: function (data, textStatus, errorThrown) {
                $(".loading").css("visibility","hidden");
                if(textStatus=="timeout"){
                	$("#modal-body").html("<h2>Connection Error</h2><p>Your Request Has Timed-Out. Please Try Again Later</p>");
                	$("#AddDeviceDetails").show();
                }else{
                	$("#modal-body").html("<h2>Connection Error</h2><p>"+ textStatus+"</p>");  
                	$("#AddDeviceDetails").show();
                }
            },
            url: "addDeviceDetail",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}

function onOffSamePhone() 
{
	if($("#sameUserId").is(":checked") == true) 
	{
		$('#rmn').val($('#LoginId').val());
	}
	else
	{
	 	$("#rmn").val('');
	}
}

function isAlphaNumericWithoutSpace(evt) {
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==37|| charCode==46|| charCode==45|| charCode==46|| charCode==47|| charCode==44|| charCode==38|| charCode==40|| charCode==41|| charCode==58|| charCode==95) {
	      return true;
	  }else{
	   return false;
	  }
	}catch (err) {
	 alert(err. Description);
	 }
	}
	function isAlphaNumeric(evt) { 
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==32|| charCode==37|| charCode==46|| charCode==45|| charCode==46|| charCode==47|| charCode==44|| charCode==38|| charCode==40|| charCode==41|| charCode==58|| charCode==95) {
	      return true;
	  }else{
	   return false;
	  }
	}catch (err) {
	 alert(err. Description);
	 }
	}
	function isDecimal(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( charCode == 46 || (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37)){
	  return false;
	 }
	}

function getorg(){
    	 var merchantId = $("#merchantId").val();
    	 document.location.href = "?merchantId="+merchantId+"";
    	}
function isAlphaNumericBankType(evt) { 
	 try{
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32|| charCode==46|| charCode==40|| charCode==41|| charCode==47|| charCode==8|| charCode==37){
	         return true;
	  } else{
	         return false;
	 }} catch (err) {
	     alert(err. Description);
	    }
	}
function isNumberKey(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37)){
	  return false;
	 }
	}
function isAlphaNumericName(evt) { 
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==37|| charCode==32|| charCode==46|| charCode==45|| charCode==46|| charCode==47|| charCode==44|| charCode==38|| charCode==40|| charCode==41) {
	      return true;
	  }else{
	   return false;
	  }
	     }catch (err) {
	        console.log('errerrerr: '+err);
	     alert(err. Description);
	    }
	}

function isFeeRemarks(evt){
	try {
		  evt = (evt) ? evt : window.event;
		  var charCode = (evt.which) ? evt.which : evt.keyCode;
		  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==46|| charCode==45|| charCode==46|| charCode==44|| charCode==40|| charCode==41|| charCode==95) {
		      return true;
		  }else{
		   return false;
		  }
		     }catch (err) {
		        console.log('errerrerr: '+err);
		     }
}
function onchangeUserType(){
   // var userType = $("#userType").val();
   var userType;
    if ($('#userType').is(":checked")){
    	$("#userType").val('credit');
    }else{
    	$("#userType").val('notCredit');
        }
  var userType = $("#userType").val();
    if(userType == "credit"){    	
    	$("#div_bankTid").show();
    	$("#div_MobiKwik").hide();
    	$("#div_Other").show();
    	$("#div_mdrCashAtPos").show();
    	$("#div_MdrCreditNpre").show();
    	$("#div_MdrCreditPre").show();
    	$("#div_MdrDebit2").show();
    	$("#div_MdrDebit1").show();
    	$("#div_MdrDebit0").show();
    	$("#div_americanExpress").show();
    	$("#div_SerialNo").show();
    	
    	//alert("credit");
    	var sendvalue={accessKey:'dummy'}
    	var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                	var list =  data.result;
	                	$("#SerialNo option:not([value=''])").remove();
		                for(var i=0;i<list.length;i++){

			                //console.log('mappppp: '+list[i]);
			                var x = document.getElementById("SerialNo");
			                var option = document.createElement("option");
			                option.text = list[i];
			                x.add(option);
			            }
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");
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
	            url: "dEviceLst",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
    	
   	}else if (userType == "wallet/credit"){
   		$("#div_bankTid").show();
   		$("#div_MobiKwik").show();
   		$("#div_Other").show();
   		$("#div_mdrCashAtPos").show();
   		$("#div_MdrCreditNpre").show();
   		$("#div_MdrCreditPre").show();
   		$("#div_MdrDebit2").show();
   		$("#div_MdrDebit1").show();
   		$("#div_americanExpress").show();
   		$("#div_SerialNo").show();
   		$("#div_MdrDebit0").show();
   		//alert("wallet/credit");
   		var sendvalue={accessKey:'dummy'}
    	var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                	var list =  data.result;
	                	$("#SerialNo option:not([value=''])").remove();
		                for(var i=0;i<list.length;i++){
			                var x = document.getElementById("SerialNo");
			                var option = document.createElement("option");
			                option.text = list[i];
			                x.add(option);
			            }
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");
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
	            url: "dEviceLst",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
  	}else if (userType == "wallet"){
  		$("#div_bankTid").hide();
  		$("#div_MobiKwik").show();
  		$("#div_Other").hide();
  		$("#div_mdrCashAtPos").hide();
  		$("#div_MdrCreditNpre").hide();
  		$("#div_MdrCreditPre").hide();
  		$("#div_MdrDebit2").hide();
  		$("#div_MdrDebit1").hide();
  		$("#div_americanExpress").hide();
  		$("#div_SerialNo").hide();  
  		$("#div_MdrDebit0").hide();
  	}else {
   		$("#div_bankTid").hide();
   		$("#div_MobiKwik").hide();
   		$("#div_Other").hide();
   		$("#div_mdrCashAtPos").hide();
   		$("#div_MdrCreditNpre").hide();
   		$("#div_MdrCreditPre").hide();
   		$("#div_MdrDebit2").hide();
   		$("#div_MdrDebit1").hide();
   		$("#div_americanExpress").hide();
   		$("#div_SerialNo").hide();
   		$("#div_MdrDebit0").hide();
   		//alert("wallet/credit");
  	}
}

function onChangeDeviceIds(){
	//console.log('11111111111111'+SerialNo);
	var SerialNo = $("#SerialNo").val();
	var sendvalue={serialNo:SerialNo}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                	var list =  data.result;               	
	                //$("#BankTid").val(list.bankTid);
                } else if (data.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (data.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");
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
            url: "getBankTid",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
	
	}

function setRechargeServiceStatus(){
	if ($('#rechargeServiceEnable').is(":checked")){
		$("#div_rechargeServiceDetails").show();
	}else{
		$("#div_rechargeServiceDetails").hide();
		}
}
</script> 

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>Add New Terminal</h3>
                         </div>
                     </div>
                  
                    <div class="row">
                    <form class="form-horizontal form-label-left">
                        <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->

<!-- ----------------------------------------------------------------Basic details----------------->
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Terminal Details</h2>
                                 	 <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                 
                                    <div class="form-group percent-100">
		                                   <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="rechargeServiceEnable" name="rechargeServiceEnable" onclick="return setRechargeServiceStatus();">Recharge Service Enable
									          </div>
                                           </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="dmtServiceEnable" name="dmtServiceEnable">DMT Service Enable
									          </div>
                                           </div>
                                              <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="ppcServiceEnable" name="ppcServiceEnable">PPC Service Enable
									          </div>
                                           </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="dthMobileServiceEnable" name="dthMobileServiceEnable">DTH/Mobile Service Enable
									          </div>
                                           </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="userType" name="userType" onchange="return onchangeUserType();">Credit/Debit Service Enable
									          </div>
                                           </div>
                            
                                 </div>
                                    
									  <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="merchantId">Merchant Name</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <select name="merchantId" id="merchantId" class="form-control" onchange="return getorg();">
                                                       <option value="">select</option>
														 <c:forEach var="RowData" items="${merchantList}">
														 <option value="<c:out value="${RowData['merchantId']}"/>" <c:if test="${RowData['merchantId'] == param.merchantId}">selected="selected"</c:if> ><c:out														
														value="${RowData['merchantName']}"/></option> 
														</c:forEach>        
                                                  </select>
                                             </div>
                                        </div>                                                            
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="orgId">Store Name<span class="required">*</span> </label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <select name="orgId" id="orgId" class="form-control">
													  <option value="">select</option>
														 <c:forEach var="RowData" items="${orgList}">
														 <option value="<c:out value="${RowData['orgId']}"/>" <c:if test="${RowData['orgId'] == param.orgId}">selected="selected"</c:if>><c:out value="${RowData['orgName']}"/></option> 
														 </c:forEach>
											</select>                                                    
                                          </div>
                                        </div>
                                      <!--  <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="userType">Terminal Type<span class="required">*</span> </label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <select data-clear-btn="true" name="userType"
											id="userType" required="true" class="form-control" onchange="return onchangeUserType();">
											<option value="">Choose	option</option>
											<option value="wallet"> Wallet</option>
											<option value="credit"> Credit</option>
											<option value="wallet/credit"> Wallet/Credit</option>
											</select>
                                            </div>
                                        </div> -->
                                        <!-- <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="switchType">Switch Type<span class="required">*</span> </label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <select data-clear-btn="true" name="switchType"
											id="switchType" required="true" class="form-control" >
											<option value="">Choose	option</option>
											<option value="AGS"> AGS</option>
											<option value="OGS"> OGS</option>
											</select>
                                            </div>
                                        </div> -->
                                        <div class="form-group percent-50" id="div_SerialNo" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12">Terminal Serial No<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            	<select data-clear-btn="true" name="SerialNo" id="SerialNo" required="true" class="form-control" >
                                            		<option value="">Select</option>
                                            	</select>
                                               <!--  <input type="text" class="form-control" data-clear-btn="true" name="SerialNo" id="SerialNo" required="true" minlength="8" maxlength="17" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" /> -->
                                            </div>
                                         </div>       
                                           <div class="form-group percent-50" id="div_bankTid" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="BankTid">Bank Tid<span class="required">*</span>
                                            </label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" name="BankTid" id="BankTid" required="true" minlength="0" maxlength="8"  onPaste="return false"/> 
                                            </div>
                                          </div> 
                                         </div>
                                        </div>
                                        
<!-- ---------------------------------------------------User Details----------------------------------------------------- -->                                                                  
 
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>User Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                    <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="LoginId">Login Id<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="LoginId" id="LoginId" required="true" minlength="10" maxlength="10" onkeypress='return isNumberKey(event)' digits="true"  onPaste="return false" />
                                          </div>
                                        </div>
                                    
                                     <div class="form-group percent-50">
                                               
                                           <label class="control-label col-md-12 col-sm-12 col-xs-12"for="rmn"><input type="checkbox" style="margin:0 !important;position:relative !important" id="sameUserId" name="sameUserId" onchange="onOffSamePhone();"> RMN Same As LoginId RMN<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="rmn" id="rmn" required="true" minlength="10" maxlength="10" onkeypress='return isNumberKey(event)' digits="true" onPaste="return false"  />
                                            </div>
                                     </div>
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="UserEmailId">Email Id</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="UserEmailId" id="UserEmailId" required="true" minlength="0" maxlength="100" email="true" onPaste="return false" />
                                            </div>
                                        </div> 
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="Name">Name Of User<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="Name" id="Name" required="true" minlength="1" maxlength="50" onkeypress="return isAlphaNumericName(event);" onPaste="return false"  />
                                            </div>
                                        </div> 
                                        
                                </div>
                            </div>                            
                
  <!------------------------------------------------------ Rent Details ----------------------------------------->
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Rent Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                      
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                            	<div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="validTil1">Valid till Date</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" name="validTil" id="validTil" onkeypress='return false;' readonly='true'/>
                                            </div>
                                        </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="Rent">Rent<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="Rent" id="Rent" required="true" minlength="1" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                  	<label class="control-label col-md-12 col-sm-12 col-xs-12" for="PaymentMode">Payment Mode<span class="required">*</span></label>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                            <select name="PaymentMode" id="PaymentMode" required="true" class="form-control">
                                            <option value="">select</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="quaterly">Quaterly</option>
                                            <option value="halfyearly">HalfYearly</option>
                                            <option value="yearly">Yearly</option>
                                            </select>
                                    </div>
                                </div>
                                 <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="pendingRent">Pending Rent<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="pendingRent" id="pendingRent" required="true" minlength="1" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                 <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="penaltyAmount">Penalty Amount<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="penaltyAmount" id="penaltyAmount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                 <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="penaltyReason">Penalty Reason<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="penaltyReason" id="penaltyReason" placeholder="NA" minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" onPaste="return false" />
                                            </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="discount">Discount<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="discount" id="discount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false" />
                                          </div>
                                </div>
                                 <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="discountReason">Discount Reason<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="discountReason" id="discountReason" placeholder="NA" required="true" minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);"  onPaste="return false"/>
                                            </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="avgTxnAmount">Avg Txn Amt<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="avgTxnAmount" id="avgTxnAmount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50" id="div_MdrDebit0" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="MdrDebit0">Mdr Debit <1000<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                             <input type="text" class="form-control" data-clear-btn="true" name="MdrDebit0" id="MdrDebit0" required="true" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/>
                                         </div>
                                          </div>
                                <div class="form-group percent-50" id="div_MdrDebit1" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="MdrDebit1">Mdr Debit (>1000 & <2000)<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                             <input type="text" class="form-control" data-clear-btn="true" name="MdrDebit1" id="MdrDebit1" required="true" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/>
                                         </div>
                                          </div>
                                
                                <div class="form-group percent-50" id="div_MdrDebit2" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="MdrDebit2">Mdr Debit >2000<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12" >
                                              <input type="text" class="form-control" data-clear-btn="true" name="MdrDebit2" id="MdrDebit2" required="true" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false" />
                                          </div>
                                </div>
                                        <div class="form-group percent-50" id="div_MdrCreditPre" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="MdrCreditPre">Mdr Credit Premium<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="MdrCreditPre" id="MdrCreditPre" required="true" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_MdrCreditNpre" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="MdrCreditNpre">Mdr Credit Card Non-Premium</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="MdrCreditNpre" id="MdrCreditNpre" required="true" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                        </div>
                                         <div class="form-group percent-50" id="div_Other" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="Other">International Card</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="Other" id="Other" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                        </div>
                                         <div class="form-group percent-50" id="div_mdrCashAtPos" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="mdrCashAtPos">CASHATPOS MDR</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mdrCashAtPos" id="mdrCashAtPos" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_MobiKwik" style="display:none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="mobiKwik">Wallet MDR</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mobiKwik" id="mobiKwik" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="settlementCharges">Fixed Settlement Charges<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="settlementCharges" id="settlementCharges" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                </div>
                            </div>
    <!-------------------------------------- Bank Details ---------------------------------->
            				<div class="x_panel">
                                <div class="x_title">
                                    <h2>Bank Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="bankAccType">Bank Account Type<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            	 <select name="bankAccType" id="bankAccType" class="form-control">
		                                            <option value="">select</option>
		                                            <option value="current">Current</option>
		                                            <option value="saving">Saving</option>
		                                            <option value="od">OD</option>
	                                            </select>      
                                                <!-- <input type="text" class="form-control" data-clear-btn="true" name="bankAccType" id="bankAccType"  minlength="1" maxlength="50" onkeypress="return isAlphaNumericBankType(event);" alphanumeric="true" /> -->
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="bankAccNumber">Bank Account Number<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="bankAccNumber" id="bankAccNumber"  minlength="6" maxlength="30" onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="bankName">Bank Name<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="bankName" id="bankName"  minlength="1" maxlength="50" onkeypress="return isAlphaNumericName(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="benefName">Beneficiary Name<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benefName" id="benefName"  minlength="1" maxlength="45" onkeypress="return isAlphaNumericName(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="bankBranch">Bank Branch<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="bankBranch" id="bankBranch"  minlength="1" maxlength="45" onkeypress="return isAlphaNumeric(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="bankIfsc">Bank IFSC<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="bankIfsc" id="bankIfsc"  minlength="11" maxlength="11" onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="bankMicr">Bank MICR<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="bankMicr" id="bankMicr"  minlength="9" maxlength="15" onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                                    
                                </div>
                            </div>                     
<!-------------------------------------- Fee Details ---------------------------------->
            				<div class="x_panel">
                                <div class="x_title">
                                    <h2>Fee Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="planName">Plan Name<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            	 <select name="planName" id="planName" class="form-control">
		                                            <option value="Life-Time">Life-Time</option>
		                                            <option value="Yearly">Yearly</option>
		                                            <option value="Half-Yearly">Half-Yearly</option>
		                                            <option value="Quarterly">Quarterly</option>
		                                            <option value="Monthly">Monthly</option>
	                                            </select>
                                                <!-- <input type="text" class="form-control" data-clear-btn="true" name="bankAccType" id="bankAccType"  minlength="1" maxlength="50" onkeypress="return isAlphaNumericBankType(event);" alphanumeric="true" /> -->
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="feeModel">Fee Mode<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            <select name="feeModel" id="feeModel" class="form-control">
                                            		<option value="Free">Free</option>
		                                            <option value="Neft">Neft</option>
		                                            <option value="Cheque">Cheque</option>
		                                            <option value="Cash">Cash</option>                                
	                                            </select>                                         
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="feeAmount">Fee Amount<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="feeAmount" id="feeAmount" value="0.0"  minlength="1" maxlength="8" onkeypress="return isDecimal(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="feeDate">Fee Date<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="feeDate" data-role="date" placeholder="Fee Date" value="01/01/2016" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="feeRemarks">Fee Remarks<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="feeRemarks" id="feeRemarks"  minlength="2" maxlength="150" value="NA" onkeypress="return isFeeRemarks(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                          
                                </div>
                            </div>                     
<!-- ----------------------------------------------American Express DETAIL -->
  							<div class="x_panel" id="div_americanExpress">
                                <div class="x_title">
                                    <h2>American Express Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                	<div>
                                    <br />                       
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="AmexActivated">Amex Activated<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <select name="AmexActivated" id="AmexActivated" onchange="return onChangeAmexActivated();"  class="form-control">
										            <option value="">Select</option>
										            <option value="NO">NO</option>
  													<option value="YES">YES</option>          
										          </select> 
                                            </div>
                                        </div>
                                       <div class="form-group percent-50" id="div_mdrAmex">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="mdrAmex">Mdr Amex</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mdrAmex" id="mdrAmex"  minlength="1" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/>
                                            </div>
                                      </div>
                                      <div class="form-group percent-50" id="div_amexTID">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="AmexTID">Amex Tid</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="amexTID" id="amexTID"  minlength="0" maxlength="8" onkeypress='return isAlphaNumeric(event);' number="true" onPaste="return false"/>
                                            </div>
                                      </div>
                                      <div class="form-group percent-50" id="div_amexMID">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="AmexMID">Amex Mid</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="amexMID" id="amexMID" minlength="0" maxlength="45" onkeypress='return isAlphaNumeric(event);' number="true" onPaste="return false"/>
                                            </div>
                                      </div>
                                    </div> 
                                      
                                </div>
                            </div>   
                            
<!-------------------------------------- Additional Details ---------------------------------->
            				<div class="x_panel">
                                <div class="x_title">
                                    <h2>Additional Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="midTidEntryDate">MID/TID Entry Date<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="midTidEntryDate" data-role="date" placeholder="MID/TID Entry Date" value="01/01/2016" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="wlcmLtrSendDate">Welcome Letter Send Date<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="wlcmLtrSendDate" data-role="date" placeholder="Welcome Letter Send Date" value="01/01/2016" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                                                                                                                                               
                                </div>
                            </div>                
                                                
       	<!-------------------------------------- Recharge Service Details ---------------------------------->
            				<div class="x_panel" id="div_rechargeServiceDetails" style="display: none">
                                <div class="x_title">
                                    <h2>Recharge Service Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                                                        
                                        
                                    
                                        <div class="form-group percent-50" >
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="rechargeBal">Recharge Balance</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="rechargeBal" id="rechargeBal"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div> 
                                         <div class="form-group percent-50" >
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12"  for="rechargeIncentive">Recharge incentive</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="rechargeIncentive" id="rechargeIncentive"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                         <div class="form-group percent-50" >
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12"  for="rechargeMonthlyRental">Recharge Monthly Rental</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="rechargeMonthlyRental" id="rechargeMonthlyRental"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div>
              
                                                                                                                                                                                  
                                </div>
                            </div>                     		
						                                   
                             
 <!-------------------------------------- Integration Details ---------------------------------->
            				<div class="x_panel">
                                <div class="x_title">
                                    <h2>Integration Field</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                                                        
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="integrationKey">Integration Key<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="integrationKey" id="integrationKey"  minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                                                
                                </div>
                                   <div class="form-group percent-100">
                                            <div class="col-md-12 col-sm-12 col-xs-12 col-md-offset-3">
                                <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return submitDevice();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddDeviceDetails" name="AddDeviceDetails">Submit</button>
                                            </div>
                                    </div></div>           
                                                
                            
<!----------------------------------- x-Panel End  ------------------------------------------------------------------>  
                            
                    </form>
                    </div>
				</div>
				
								<!-- Small modal -->
                                <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">X</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
                                            </div>
                                            <div id="modal-body" class="modal-body">
                                                
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn-cancel" data-dismiss="modal" >Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /modals -->
                    
                <!-- /page content -->

<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->