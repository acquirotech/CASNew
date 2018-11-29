<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3")||session.getAttribute("empRole").equals("4")||session.getAttribute("empRole").equals("7")||session.getAttribute("empRole").equals("9")||session.getAttribute("empRole").equals("10"))){	
	response.sendRedirect("welcome");
}%>
<script src="<c:url value="/resources/js/Acqcitystate.js" />"></script>
<!----------------------------------------------jsFunction----------------------------------------------------------->
<script type="text/javascript">
var srNo;
function setDeviceDetails(deviceId,bankTId,serialNo,validTil,rent,paymentMode,pendingRent,penaltyAmount,discount,avgTxnAmount,userName,userPhoneNo,rmn,userEmail,mdrDebit1,mdrDebit2,mdrCreditPre,mdrCreditNpre,mdrAmex,other,mdrCashAtPos,amexCreated,amexTID,amexMID,bankAccName,bankAccNo,bankName,bankIfsc,bankMicr,bankBranch,mdrMobiKwik,userType,userStatus,benefName,penaltyReason,discountReason,loyaltyStatus,closeWalletStatus,txnSmsStatus,integrationKey,empRole1,loanstatus,loantype,loandedAmount,loanBankName,loanBankAcc,loanBankIfsc,mdrzero,mdrDebit0,activationDate,planName,feeMode,feeAmount,feeDate,feeRemark,switchType,midTidEntryDate,wlcmLtrSendDate,settlementCharges,rechargeServiceEnable,rechargeBal,rechargeIncentive,rechargeMonthlyRental,ppcServiceEnable,dmtServiceEnable,dthMobileServiceEnable
		){

	srNo =serialNo;
	$("#userStatus").val(userStatus);
	if(rechargeServiceEnable=="0"){
		  $("#rechargeServiceEnable").prop( "checked", false );		
		  $("#div_rechargeServiceDetails").hide();
	}else{
		  $("#rechargeServiceEnable").prop( "checked", true );	
		  $("#div_rechargeServiceDetails").show();	
	}
	$('#rechargeBal').val(rechargeBal);
	$('#rechargeIncentive').val(rechargeIncentive);
	$('#rechargeMonthlyRental').val(rechargeMonthlyRental);
	if(mdrzero=="0"){
		  $("#mdrZero").prop( "checked", false );			  
	}else{
		  $("#mdrZero").prop( "checked", true );		
	}

	if(ppcServiceEnable=="0"){
		  $("#ppcServiceEnable").prop( "checked", false );			  
	}else{
		  $("#ppcServiceEnable").prop( "checked", true );		
	}if(dmtServiceEnable=="0"){
		  $("#dmtServiceEnable").prop( "checked", false );			  
	}else{
		  $("#dmtServiceEnable").prop( "checked", true );		
	}if(dthMobileServiceEnable=="0"){
		  $("#dthMobileServiceEnable").prop( "checked", false );			  
	}else{
		  $("#dthMobileServiceEnable").prop( "checked", true );		
	}if(userType=="notCredit"){
		  $("#userType").prop( "checked", false );			  
	}else{
		  $("#userType").prop( "checked", true );		
	}
	var d=$('#userStatus').val();
	if($('#userStatus').val()=="0"){
		  $("#userStatus").prop( "checked", true );			  
	}else{
		  $("#userStatus").prop( "checked", false );		
	}
	if(loanstatus=="0"){
		  $("#loanStatus").prop( "checked", false );
		  $("#div_loanDetails").hide();
	}else{
		  $("#loanStatus").prop( "checked", true );
		  $("#div_loanDetails").show();
		  if(loantype == "fixed"){
		  	$("#div_loanAmount").show();
		  	$("#div_loanAmount1").show();
		  	$("#div_loanPercentage").hide();
		  }else if(loantype == "percentage"){
		  	$("#div_loanAmount").show();
		  	$("#div_loanAmount1").hide();
		  	$("#div_loanPercentage").show();
		  }else{
		  	$("#div_loanPercentage").hide();
		  	$("#div_loanAmount").hide();	
		  }		
	}

	$("#settlementCharges").val(settlementCharges);
	$("#settlementCharges1").val(settlementCharges);
	$("#wlcmLtrSendDate").val(wlcmLtrSendDate);
		$("#midTidEntryDate").val(midTidEntryDate);
		
	$("#loanType").val(loantype);
	$("#loanDedAmount").val(loandedAmount);
	//$("#loanAmountPayout").val(loanamountPayout);
	$("#loanBankName").val(loanBankName);
	$("#loanAccount").val(loanBankAcc);
	$("#loanIfsc").val(loanBankIfsc);
	$("#loyaltyStatus").val(loyaltyStatus);
	$("#closeWalletStatus").val(closeWalletStatus);

	$("#txnSmsStatus").val(txnSmsStatus);
	if($('#loyaltyStatus').val()=="1"){
		  $("#loyaltyStatus").prop( "checked", true );
	}else{
		  $("#loyaltyStatus").prop( "checked", false );
	}
	if($('#closeWalletStatus').val()=="1"){
		  $("#closeWalletStatus").prop( "checked", true );
	}else{
		  $("#closeWalletStatus").prop( "checked", false );
	}
	if($('#txnSmsStatus').val()=="0"){
		  $("#txnSmsStatus").prop( "checked", true );
	}else{
		  $("#txnSmsStatus").prop( "checked", false );
	}
	
	$("#SerialNo").empty();
	$("#DeviceID").val(deviceId);	
	$("#penaltyReason").val(penaltyReason);
	$("#discountReason").val(discountReason);
	$("#penaltyReason1").val(penaltyReason);
	$("#discountReason1").val(discountReason);	
	$("#BankTid").val(bankTId);
	$("#SerialNo").append($("<option>").attr("value", serialNo).text(serialNo));
	$("#validTil").val(validTil);
	$("#Rent").val(rent);
	$('#PaymentMode option[value="' + paymentMode + '"]').prop('selected', true);
	$("#pendingRent").val(pendingRent);
	$("#penaltyAmount").val(penaltyAmount);
	$("#discount").val(discount);
	$("#avgTxnAmount").val(avgTxnAmount);
	$("#validTil1").val(validTil);
	$("#Rent1").val(rent);
	$('#PaymentMode1 option[value="' + paymentMode + '"]').prop('selected', true);
	$("#pendingRent1").val(pendingRent);
	$("#penaltyAmount1").val(penaltyAmount);
	$("#discount1").val(discount);
	$("#avgTxnAmount1").val(avgTxnAmount);
	$("#DName").val(userName);
	$("#DLoginId").val(userPhoneNo);
	$("#rmn").val(rmn);
	$("#UserEmailId").val(userEmail);
	$("#Password").val("password");
	$("#MdrDebit00").val(mdrDebit0);
	$("#MdrDebit11").val(mdrDebit1);
	$("#MdrDebit21").val(mdrDebit2);
	$("#MdrCreditPre1").val(mdrCreditPre);
	$("#MdrCreditNpre1").val(mdrCreditNpre);
	$("#mdrAmex1").val(mdrAmex);
	$("#Other1").val(other);	
	$("#mdrCashAtPos1").val(mdrCashAtPos);
	$("#MdrDebit0").val(mdrDebit0);
	$("#MdrDebit1").val(mdrDebit1);
	$("#MdrDebit2").val(mdrDebit2);
	$("#MdrCreditPre").val(mdrCreditPre);
	$("#MdrCreditNpre").val(mdrCreditNpre);
	$("#mdrAmex").val(mdrAmex);
	$("#Other").val(other);	
	$("#mdrCashAtPos").val(mdrCashAtPos);
	$("#bankAccType1").val(bankAccName);
	$("#bankAccNumber1").val(bankAccNo);
	$("#bankName1").val(bankName);
	$("#benefName1").val(benefName);
	$("#bankIfsc1").val(bankIfsc);
	$("#bankMicr1").val(bankMicr);
	$("#bankBranch1").val(bankBranch);
	$("#mobiKwik1").val(mdrMobiKwik);
	$('#AmexActivated option[value="' + amexCreated + '"]').prop('selected', true);
	$("#amexTID").val(amexTID);
	$("#amexMID").val(amexMID);
	$("#bankAccType").val(bankAccName);
	$("#bankAccNumber").val(bankAccNo);
	$("#bankName").val(bankName);
	$("#benefName").val(benefName);
	$("#bankIfsc").val(bankIfsc);
	$("#bankMicr").val(bankMicr);
	$("#bankBranch").val(bankBranch);
	$("#mobiKwik").val(mdrMobiKwik);
	$("#integrationKey").val(integrationKey);
	$('#userType option[value="' + userType + '"]').prop('selected', true);
	
	$('#upPlanName option[value="' + planName + '"]').prop('selected', true);
	$('#upFeeMode option[value="' + feeMode + '"]').prop('selected', true);
	$("#upFeeAmount").val(feeAmount);
	$("#upActivationDate").val(activationDate);
	$("#upFeeDate").val(feeDate);
	$("#upswitchType").val(switchType);
	
	if(userType=="wallet")
	{
		$("#div_bankTid").hide();
		$("#div_MdrDebit0").hide();
		$("#div_MdrDebit1").hide();
		$("#div_MdrDebit2").hide();
		$("#div_MdrCreditPre").hide();
		$("#div_MdrCreditNpre").hide();
		$("#div_Other").hide();	
		$("#div_mdrCashAtPos").hide();
		$("#div_mobiKwikMdr").show();	
		$("#div_americanExpress").hide();	
		$("#div_SerialNo").hide();
		$("#div_bankTid1").hide();
		$("#div_MdrDebit11").hide();
		$("#div_MdrDebit21").hide();
		$("#div_MdrCreditPre1").hide();
		$("#div_MdrCreditNpre1").hide();
		$("#div_Other1").hide();	
		$("#div_mdrCashAtPos1").hide();
		$("#div_mobiKwikMdr1").show();	
		$("#div_americanExpress1").hide();	
		$("#div_SerialNo1").hide();
		
	}
	else if(userType=="credit")
	{
		$("#div_bankTid").show();
		$("#div_MdrDebit1").show();
		$("#div_MdrDebit2").show();
		$("#div_MdrCreditPre").show();
		$("#div_MdrCreditNpre").show();
		$("#div_Other").show();	
		$("#div_mdrCashAtPos").show();
		$("#div_mobiKwikMdr").hide();	
		$("#div_americanExpress").show();	
		$("#div_SerialNo").show();
		$("#div_MdrDebit0").show();
		$("#div_bankTid1").show();
		$("#div_MdrDebit11").show();
		$("#div_MdrDebit21").show();
		$("#div_MdrCreditPre1").show();
		$("#div_MdrCreditNpre1").show();
		$("#div_Other1").show();	
		$("#div_mdrCashAtPos1").show();
		$("#div_mobiKwikMdr1").hide();	
		$("#div_americanExpress1").show();	
		$("#div_SerialNo1").show();

	}
	else if(userType=="wallet/credit")
	{
		$("#div_bankTid").show();
		$("#div_MdrDebit0").show();
		$("#div_MdrDebit1").show();
		$("#div_MdrDebit2").show();
		$("#div_MdrCreditPre").show();
		$("#div_MdrCreditNpre").show();
		$("#div_Other").show();	
		$("#div_mdrCashAtPos").show();
		$("#div_mobiKwikMdr").show();	
		$("#div_americanExpress").show();
		$("#div_SerialNo").show();

		$("#div_bankTid1").show();
		$("#div_MdrDebit11").show();
		$("#div_MdrDebit21").show();
		$("#div_MdrCreditPre1").show();
		$("#div_MdrCreditNpre1").show();
		$("#div_Other1").show();	
		$("#div_mdrCashAtPos1").show();
		$("#div_mobiKwikMdr1").show();	
		$("#div_americanExpress1").show();
		$("#div_SerialNo1").show();
	}
	if(amexCreated=="NO")	
		{
		$("#div_mdrAmex").hide();
		$("#div_amexTID").hide();
		$("#div_amexMID").hide();
		}
	else if(amexCreated=="YES")	
	{
	$("#div_mdrAmex").show();
	$("#div_amexTID").show();
	$("#div_amexMID").show();
	}	
	$('#userType option[value="' + userType + '"]').prop('selected', true);
	if($('#rmn').val()==$('#DLoginId').val()){
		  $("#sameUserId").prop( "checked", true );
	}else{
		  $("#sameUserId").prop( "checked", false );
	}
	var sendvalue={accessKey:'dummy'}
 	var opts = {
    	type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                 var list =  data.result;
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
}



$(function () {
    $("#appCheckStatus").change(function () {
          var checkStatus = $("#appCheckStatus").val();
          if ($("#appCheckStatus").val() == "Yes") {
        	   var dd = new Date();
        	   var dd1 = dd.getDate();
               var mm = dd.getMonth()+1; //January is 0!
              var yyyy = dd.getFullYear();
              if(dd1<10){
            	  dd1='0'+dd1;
              } 
              if(mm<10){
                  mm='0'+mm;
              } 
              var today = dd1+'/'+mm+'/'+yyyy;
              console.log("1111:::"+today)
            $("#appReceiptDate").val(today); 
          }else{
        	  $("#appReceiptDate").val(''); 
              }           
    });
});
function updOrgDetails(){
	$("#modal-body").html("In Process");  
	var updOrgId = $("#UpdOrgId").val();
	var updOrgName = $("#updOrgName").val();
	var updOrgAddress1 = $("#updOrgAddress1").val();
	var updOrgAddress2 = $("#updOrgAddress2").val();
	var orgstate = $("#updOrgbusinessstate").val();
	var orgcity = $("#updOrgbusinesscity").val();
	var updCountry = $("#updCountry").val();
	var updOrgPinCode = $("#updOrgPinCode").val();
	
	if(updOrgName==null||updOrgName==''){
			$("#modal-body").html('Validation Error<p>Enter Store Name</p></n>Length should be min 3 and max 50 char');
			return false;
		}else if(updOrgName.length<=2||updOrgName.length>50){
			$("#modal-body").html('Validation Error<p>Enter Correct Store Name</p></n>Length should be min 3 and max 50 char');
			return false;
		}else if(updOrgAddress1==null||updOrgAddress1==''){
			$("#modal-body").html('Validation Error<p>Enter Address Line1</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(updOrgAddress1.length<4||updOrgAddress1.length>100){
			$("#modal-body").html('Validation Error<p>Enter Correct Address Line1</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(updOrgAddress2==null||updOrgAddress2==''){
			$("#modal-body").html('Validation Error<p>Enter Address Line2</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(updOrgAddress2.length<4||updOrgAddress2.length>100){
			$("#modal-body").html('Validation Error<p>Enter Correct Address Line2</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(orgstate==null||orgstate==''){
			$("#modal-body").html('Validation Error<p>Enter Store State</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(orgstate.length<2||orgstate.length>50){
			$("#modal-body").html('Validation Error<p>Enter Correct Store State</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(orgcity==null||orgcity==''){
			$("#modal-body").html('Validation Error<p>Enter Store City</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(orgcity.length<=2||orgcity.length>50){
			$("#modal-body").html('Validation Error<p>Enter Correct Store City</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(updOrgPinCode==null||updOrgPinCode==''){
			$("#modal-body").html('Validation Error<p>Enter Store PinCode</p></n>Length should be 6 digits');
			return false;
		}else if(updOrgPinCode.length!=6){
			$("#modal-body").html('Validation Error<p>Enter Correct Store PinCode</p></n>Length should be 6 digits');
			return false;
		}else if(updCountry==null||updCountry==''){
			$("#modal-body").html('Validation Error<p>Enter Country</p>');
			return false;
		}else if(updCountry!='INDIA'){
			$("#modal-body").html('Validation Error<p>Enter Correct Country</p>');
			return false;
		}
	var sendvalue={UpdOrgId:updOrgId,UpdOrgName:updOrgName,UpdOrgAddress1:updOrgAddress1,UpdOrgAddress2:updOrgAddress2,UpdOrgCity:orgcity,UpdOrgState:orgstate,UpdOrgCountry:updCountry,UpdOrgPinCode:updOrgPinCode}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("Store Details Updated Successfully"); 
	                    location.reload(); 
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("Server Side Validation Failed<p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("Connection Error<p>Your Request Could Not Be Processed. Please Try Again Later</p>");
	                }
	            },
	            error: function (data, textStatus, errorThrown) {
	                $(".loading").css("visibility","hidden");
	                if(textStatus=="timeout"){
	                	$("#modal-body").html("Connection Error<p>Your Request Has Timed-Out. Please Try Again Later</p>");
	                }else{
	                	$("#modal-body").html("Connection Error<p>"+ textStatus+"</p>");  
	                }
	            },
	            url: "updateOrg",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}
	
function setOrgDetails(UpdOrgId,UpdOrgName,UpdOrgAddress1,UpdOrgAddress2,UpdOrgCity,UpdOrgState,UpdOrgCountry,UpdOrgPinCode){
	$("#UpdOrgId").val(UpdOrgId);
	$("#updOrgName").val(UpdOrgName);
	$("#updOrgAddress1").val(UpdOrgAddress1);
	$("#updOrgAddress2").val(UpdOrgAddress2);	
	$("#updOrgbusinessstate").val(UpdOrgState);
	$("#updOrgbusinesscity").val(UpdOrgCity);
	$("#updCountry").val(UpdOrgCountry);
	$("#updOrgPinCode").val(UpdOrgPinCode);		
}

function onOffSameAddress() {
	if($("#sameStateCity").is(":checked") == true) {
	  	var address1=$("#BusinessAddress1").val();
		var address2=$("#BusinessAddress2").val();
		$("#UserAddress1").val(address1);
		$("#UserAddress2").val(address2);
  		var businessstate = $('#businessstate').val();
  		$('#userstate').val(businessstate); 
  		var businesscity = $('#businesscity').val();
  		$('#usercity').val(businesscity);
  		$('#UserPinCode').val($('#BusinessPinCode').val());
	}else{
	 	$("#UserAddress1").val('');
	  	$("#UserAddress2").val('');
	  	$("#userstate").val('');
	  	$("#usercity").val('');
	  	$("#UserPinCode").val('');
	}
}


var selectedFileAdd;
function onFileSelected(event) {
	selectedFileAdd = event.target.files[0];
    if (selectedFileAdd.name.split(".")[1].toUpperCase() == "PDF"||selectedFileAdd.name.split(".")[1] == "pdf"){
        var reader = new FileReader();
        var imgtag = document.getElementById("pdfFile");
        imgtag.title = selectedFileAdd.name;
        reader.onload = function(event) {
            imgtag.src = event.target.result;
        };
        reader.readAsDataURL(selectedFileAdd);      
    } else {
    	$("#pdfFile").val('');
        alert("please select valid pdf.");
    }           
}

 function updMerchant(){
	 $("#modal-body").html("In Process");
	var merchantId=$("#merchantId").val();
	var merchantName=$("#Name").val();
	var businessType=$("#BusinessType").val();
	var merchantType="wallet/credit";
	var executiveName=$("#executiveName").val();
	var directorsName=$("#DirectorsName").val();
	var authorizedSignatory=$("#AuthorizedSignatory").val();
	var businessNature=$("#BusinessNature").val();
	var businessCode=$("#BusinessCode").val();
	var marketingName=$("#MarketingName").val();
	var businessAddress1=$("#BusinessAddress1").val();
	var businessAddress2=$("#BusinessAddress2").val();
	var businessState=$("#businessstate").val();
	var businessCity=$("#businesscity").val();
	var businessPinCode=$("#BusinessPinCode").val();
	var personalAddress1=$("#UserAddress1").val();
	var personalAddress2=$("#UserAddress2").val();
	var neftAmount =$("#neftAmount").val();
	var neftDate =$("#neftDate").val();
	var neftchequeNo =$("#neftchequeNo").val();
	var neftRefNo =$("#neftRefNo").val();
	var personalState=null;
	var personalCity=null;
	var	personalState=$("#userstate").val();
	var	personalCity=$("#usercity").val();
	var personalPinCode=$("#UserPinCode").val();
	var country=$("#Country").val();
	var phoneNo=$("#PhoneNo").val();
	var webSiteUrl=$("#Websiteurl").val();
	var emailId=$("#EmailId").val();
	var tinNo=$("#TinNo").val();
	var bankMid=$("#bankMid").val();
	var serviceTaxNo=$("#ServiceTaxNo").val();
	var note=$("#Note").val();
	var verificationStatus=$("#VerificationStatus").val();
	var swipeAmount =$("#swipeAmount").val();
	var SwipeDate =$("#SwipeDate").val();
	var swipeTerminal =$("#swipeTerminal").val();
	var chequeNo =$("#chequeNo").val();
	var chequeAmount =$("#chequeAmount").val();
	var chequeDate =$("#chequeDate").val();
	var chequeDepositDate =$("#chequeDepositDate").val();
	var chequeBank =$("#chequeBank").val();
	var cashAmount =$("#cashAmount").val();
	var cashDate =$("#cashDate").val();
	var modeofpayment =$("#modeofpayment").val();
	var cubMerchant ="NA";
	var appReceiptDate = $("#appReceiptDate").val();
	var typeOfSale = $("#typeOfSale").val();
	var amName = $("#amName").val();
	var tsoName = $("#tsoName").val();
	var onBoardEmpName = $("#onBoardEmpName").val();
	var onBoardingStatus = $("#onBoardingStatus").val();
	var verificationEntryDate = $("#verificationEntryDate").val();
	var agreementRcvdDate = $("#agreementRcvdDate").val();
	var appCheckStatus = $("#appCheckStatus").val();
	
	var fileName;
	if (selectedFileAdd != undefined) {
		fileName=selectedFileAdd;
	}	
	var regex="^[0-9]{1,8}[\\.]{1}[0-9]{0,2}?$";
	if(typeOfSale==null||typeOfSale==''){
		$("#modal-body").html('Validation Error<p>Select Type Of Sale</p>');
		$("#AddMerchantDetails").show();
		return false;
	}if(onBoardingStatus==null||onBoardingStatus==''){
		$("#modal-body").html('Validation Error<p>Select OnBoarding Status</p>');
		$("#AddMerchantDetails").show();
		return false;
	}if(verificationEntryDate==null||verificationEntryDate==''){
		$("#modal-body").html('Validation Error<p>Select Verification Entry Date</p>');
		$("#AddMerchantDetails").show();
		return false;
	}

	
	if(merchantName==null||merchantName==""){
		$("#modal-body").html('Validation Error<p>Enter Merchant Name</p></n>Length should be min 2 and max 60 char');
		return false;
	}else if(merchantName.length<2||merchantName.length>60){
		$("#modal-body").html('Validation Error<p>Enter Merchant Correct Format</p></n>Length should be min 2 and max 60 char');
		return false;
	}else if(businessType=='Business Type'){
		$("#modal-body").html('Validation Error<p>Select Business Type</p>');
		return false;
	}else if(businessType=='Others'){
	var other=$("#other").val();
	if(other==null||other==''){
		$("#modal-body").html('Validation Error<p>Enter Business Type Other</p>');
		return false;
	}else if(other.length<2||other.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Business Type</p></n>Length should be min 2 and max 50 char');
		   return false;
	}
	}else if(merchantType==''){
		$("#modal-body").html('Validation Error<p>Select Merchant Type</p>');
		return false;
	}
	if(executiveName!=null&&executiveName!='' ){
		if(executiveName.length<2||executiveName.length>100){
		$("#modal-body").html('Validation Error<p>Enter Executive Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}
	}
	
	else if(directorsName==null||directorsName==''){
		$("#modal-body").html('Validation Error<p>Enter Proprietor/Director/Partner Name</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(directorsName.length<2||directorsName.length>100){
		$("#modal-body").html('Validation Error<p>Enter Correct Proprietor/Director/Partner Name</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(authorizedSignatory==null||authorizedSignatory==''){
		$("#modal-body").html('Validation Error<p>Enter Authorized Signatory</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(authorizedSignatory.length<2||directorsName.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Authorized Signatory</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(businessNature==null||businessNature==''){
		$("#modal-body").html('Validation Error<p>Enter Business Nature</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(businessNature.length<2||businessNature.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Business Nature</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(BusinessCode==null||BusinessCode==''){
		$("#modal-body").html('Validation Error<p>Enter Business Code</p>');
		return false;
	}else if(MarketingName==null||MarketingName==''){
		$("#modal-body").html('Validation Error<p>Enter Marketing Name</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(MarketingName.length<2||MarketingName.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Marketing Name</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(businessAddress1==null||businessAddress1==''){
		$("#modal-body").html('Validation Error<p>Enter Business Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessAddress1.length<2||businessAddress1.length>100){
		$("#modal-body").html('Validation Error<p>Enter Correct Business Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessAddress2==null||businessAddress2==''){
		$("#modal-body").html('Validation Error<p>Enter Business Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessAddress2.length<2||businessAddress2.length>100){
		$("#modal-body").html('Validation Error<p>Enter Correct Business Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessState==null||businessState==''){
		$("#modal-body").html('Validation Error<p>Select Business State</p>');
		return false;
	}else if(businessState.length<2||businessState.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Business State</p>');
		return false;
	}else if(businessCity==null||businessCity==''){
		$("#modal-body").html('Validation Error<p>Select Business City</p>');
		return false;
	}else if(businessCity.length<2||businessCity.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Business City</p>');
		return false;
	}else if(businessPinCode==null||businessPinCode==''){
		$("#modal-body").html('Validation Error<p>Enter Business PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(businessPinCode.length!=6){
		$("#modal-body").html('Validation Error<p>Enter Correct Business PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(personalAddress1==null||personalAddress1==''){
		$("#modal-body").html('Validation Error<p>Enter Personal Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalAddress1.length<2||personalAddress1.length>100){
		$("#modal-body").html('Validation Error<p>Enter Correct Personal Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalAddress2==null||personalAddress2==''){
		$("#modal-body").html('Validation Error<p>Enter Personal Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalAddress2.length<2||personalAddress2.length>100){
		$("#modal-body").html('Validation Error<p>Enter Correct Personal Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalState==null||personalState==''){
		$("#modal-body").html('Validation Error<p>Enter Personal State</p>');
		return false;
	}else if(personalState.length<2||personalState.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Personal State</p>');
		return false;
	}else if(personalCity==null||personalCity==''){
		$("#modal-body").html('Validation Error<p>Enter Personal City</p>');
		return false;
	}else if(personalCity.length<2||personalCity.length>50){
		$("#modal-body").html('Validation Error<p>Enter Correct Personal City</p>');
		return false;
	}else if(personalPinCode==null||personalPinCode==''){
		$("#modal-body").html('Validation Error<p>Enter Personal PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(personalPinCode.length!=6){
		$("#modal-body").html('Validation Error<p>Enter Correct Personal PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(country==null||country==''){
		$("#modal-body").html('Validation Error<p>Enter Country</p>');
		return false;
	}else if(country!='INDIA'){
		$("#modal-body").html('Validation Error<p>Enter Correct Country</p>');
		return false;
	}else if(phoneNo==null||phoneNo==''){
		$("#modal-body").html('Validation Error<p>Enter Phone No</p></n>Phone No Length should be 10 digits');
		return false;
	}else if(phoneNo.length<10||phoneNo.length>54){
		$("#modal-body").html('Validation Error<p>Enter Correct Phone No</p></n>Phone No Length should be 10 digits</n>Add Many Phone No with comma(,) Separeted');
		return false;
	}else if(webSiteUrl!=null&&webSiteUrl!=''){
		var re = /(http(s)?:\\)?([\w-]+\.)+[\w-]+[.com|.in|.org]+(\[\?%&=]*)?/
		if(webSiteUrl.length>=100){
			$("#modal-body").html('Validation Error<p>Enter Correct WebSite Url</p></n>Length should be less than 100 char');
			return false;
		}else if(re.test(webSiteUrl)==false){
			 $("#modal-body").html('Validation Error<p>website url Should be in proper format</p>');
			  return false;
		}
	}else if(emailId!=null&&emailId!=''){
		var re =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(emailId.length>100){
			console.log("email length is > 100");
			$("#modal-body").html('Validation Error<p>Enter Correct EmailId</p>');
			return false;
		}else if(re.test(emailId)==false){			
			$("#modal-body").html('Validation Error<p>Enter Correct EmailId</p></n>Length should be less than 100 char');
			return false;
	    }
	}else if(tinNo!=null&&tinNo!=''&&tinNo.length!=11){
		$("#modal-body").html('Validation Error<p>Enter Correct Tin No</p></n>Length should be 11 digits');
		return false;
	}else if(serviceTaxNo!=null&&serviceTaxNo!=''&&serviceTaxNo.length!=15){
		$("#modal-body").html('Validation Error<p>Enter Correct Service Tax No</p></n>Length should be 15 digits');
		return false;
	}else if(note!=null&&note!=''&&note>200){
		$("#modal-body").html('Validation Error<p>Enter Correct Note</p></n>Length should be less than 200 char');
		return false;
	}else if(verificationStatus==null||verificationStatus==''){
		$("#modal-body").html('Validation Error<p>Select Verification Status</p>');
		return false;
	}else if(verificationStatus.length<3||verificationStatus.length>25){
		$("#modal-body").html('Validation Error<p>Enter Correct Verification Status</p>');
		return false;
	}
	if(modeofpayment=="Swipe")
	{
		if(swipeAmount==null||swipeAmount==''){
			$("#modal-body").html('Validation Error<p>Enter swipeAmount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(swipeAmount.length<1||swipeAmount.length>11){
			$("#modal-body").html('Validation Error<p>Enter Correct Swipe Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(swipeAmount.match(regex) == null){
			$("#modal-body").html('Validation Error<p>Swipe Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}else if(SwipeDate==null||SwipeDate==''){
			$("#modal-body").html('Validation Error<p>Enter SwipeDate</p>');
			return false;
		}else if(swipeTerminal==null||swipeTerminal==''){
			$("#modal-body").html('Validation Error<p>Enter swipeTerminal</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(swipeTerminal.length<2||swipeTerminal.length>50){
			$("#modal-body").html('Validation Error<p>Enter Correct Swipe Terminal</p>');
			return false;
		}
	}
	else if(modeofpayment=="Cheque")
	{
		if(chequeNo==null||chequeNo==''){
			$("#modal-body").html('Validation Error<p>Enter chequeNo</p></n>Length should be min 1 and max 10 char');
			return false;
		}else if(chequeNo.length<1||chequeNo.length>10){
			$("#modal-body").html('Validation Error<p>Enter Correct Cheque No</p></n>Length should be min 1 and max 10 char');
			return false;
		}else if(chequeAmount==null||chequeAmount==''){
			$("#modal-body").html('Validation Error<p>Enter cheque Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(chequeAmount.length<1||chequeAmount.length>11){
			$("#modal-body").html('Validation Error<p>Enter Correct Cheque Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(chequeAmount.match(regex) == null){
			$("#modal-body").html('Validation Error<p>Cheque Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}else if(chequeDate==null||chequeDate==''){
			$("#modal-body").html('Validation Error<p>Enter chequeDate</p>');
			return false;
		}else if(chequeDepositDate==null||chequeDepositDate==''){
			$("#modal-body").html('Validation Error<p>Enter chequeDepositDate</p>');
			return false;
		}else if(chequeBank==null||chequeBank==''){
			$("#modal-body").html('Validation Error<p>Enter cheque Bank Name</p></n>Length should be min 1 and max 50 char');
			return false;
		}else if(chequeBank.length<1||chequeBank.length>50){
			$("#modal-body").html('Validation Error<p>Enter Correct Cheque Bank Name</p></n>Length should be min 1 and max 50 char');
			return false;
		}
	}
else if(modeofpayment=="Cash")
	{
		if(cashDate==null||cashDate==''){
			$("#modal-body").html('Validation Error<p>Enter cash Date</p>');
			return false;
		}else if(cashAmount==null||cashAmount==''){
			$("#modal-body").html('Validation Error<p>Enter cash Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(cashAmount.length<1||cashAmount.length>11){
			$("#modal-body").html('Validation Error<p>Enter Correct Cash Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(cashAmount.match(regex) == null){
			$("#modal-body").html('Validation Error<p>Cash Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}
	}else if(modeofpayment=="NEFT"){
		if(neftAmount==null||neftAmount==''){
			$("#modal-body").html('Validation Error<p>Enter neft Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(neftAmount.length<1||neftAmount.length>11){
			$("#modal-body").html('Validation Error<p>Enter Correct neft Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(neftAmount.match(regex) == null){
			$("#modal-body").html('Validation Error<p>neft Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}else if(neftDate==null||neftDate==''){
			$("#modal-body").html('Validation Error<p>Enter neft Date</p>');
			return false;
		}else if(neftchequeNo==null&&neftRefNo==null){
			$("#modal-body").html('Validation Error<p>Enter Neft chequeNo OR Ref chequeNo</p></n>Length should be min 1 and max 10 char');
			return false;
		}else if(neftchequeNo==""&&neftRefNo==""){
			$("#modal-body").html('Validation Error<p>Enter Neft chequeNo OR Ref chequeNo</p></n>Length should be min 1 and max 10 char');
			return false;
		}
	}
// if(merchantType=="credit")

if((merchantType=="credit"|| merchantType=="wallet/credit")&&verificationStatus=="Activated"){
	if(bankMid==null&&bankMid==''){
		$("#modal-body").html('Validation Error<p>Enter Bank MId</p></n>Length should be min 15 and max 45 char');
		return false;
	}else if(bankMid.length<15||bankMid.length>45){
		$("#modal-body").html('Validation Error<p>Enter Correct Bank Mid</p></n>Length should be min 15 and max 45 char');
		return false;
	}
}

 	var frmData = new FormData();
 	frmData.append("merId", merchantId);
 	frmData.append("Name", merchantName);
 	frmData.append("executiveEmail",executiveName);
 	frmData.append("BusinessType", businessType);
 	frmData.append("DirectorsName",directorsName);
 	frmData.append("AuthorizedSignatory",authorizedSignatory);
 	frmData.append("BusinessNature",businessNature);
 	frmData.append("BusinessCode",businessCode);
 	frmData.append("MarketingName",marketingName);
 	frmData.append("BusinessAddress1",businessAddress1);
 	frmData.append("BusinessAddress2",businessAddress2);
 	frmData.append("BusinessState",businessState);
 	frmData.append("BusinessCity",businessCity);
 	frmData.append("BusinessPincode",businessPinCode);
 	frmData.append("PersonalUserAddress1",personalAddress1);
	frmData.append("PersonalUserAddress2",personalAddress2);
	frmData.append("PersonalUserState",personalState);
	frmData.append("PersonalUserCity",personalCity);
	frmData.append("PersonalUserPincode",personalPinCode);
	frmData.append("Country",country);
	frmData.append("PhoneNo",phoneNo);
	frmData.append("WebsiteUrl",webSiteUrl);
	frmData.append("EmailId",emailId);
	frmData.append("TinNo",tinNo);
	frmData.append("ServiceTaxNo",serviceTaxNo);
	frmData.append("bankMid",bankMid);
	frmData.append("Note",note);
	frmData.append("VerificatonStatus",verificationStatus);	
	frmData.append("swipeAmount",swipeAmount);
	frmData.append("SwipeDate",SwipeDate);	
	frmData.append("swipeTerminal",swipeTerminal);	
	frmData.append("chequeNo",chequeNo);
	frmData.append("chequeAmount",chequeAmount);	
	frmData.append("chequeDate",chequeDate);	
	frmData.append("chequeDepositDate",chequeDepositDate);	
	frmData.append("chequeBank",chequeBank);	
	frmData.append("cashAmount",cashAmount);	
	frmData.append("cashDate",cashDate);	
	frmData.append("modeofpayment",modeofpayment);	
	frmData.append("merchantType",merchantType);
	frmData.append("cubMerchant",cubMerchant);
	if (selectedFileAdd != undefined) {
		frmData.append("file", selectedFileAdd);
	}
	frmData.append("neftAmount",neftAmount);
	frmData.append("neftDate",neftDate);
	frmData.append("neftchequeNo",neftchequeNo);
	frmData.append("neftRefNo",neftRefNo); 	
	frmData.append("appReceiptDate",appReceiptDate);
	frmData.append("typeOfSale",typeOfSale);
	frmData.append("amName",amName);
	frmData.append("tsoName",tsoName);
	frmData.append("onBoardEmpName",onBoardEmpName);
	frmData.append("onBoardingStatus",onBoardingStatus);
	frmData.append("verificationEntryDate",verificationEntryDate);
		frmData.append("agreementRcvdDate",agreementRcvdDate);	
		frmData.append("appCheckStatus",appCheckStatus);
		/*var sendvalue={
		merId:merchantId,Name:merchantName,BusinessType:businessType,DirectorsName:directorsName,
		AuthorizedSignatory:authorizedSignatory,BusinessNature:businessNature,BusinessCode:businessCode,
    	MarketingName:marketingName,BusinessAddress1:businessAddress1,BusinessAddress2:businessAddress2,
    	BusinessState:businessState,BusinessCity:businessCity,BusinessPincode:businessPinCode,
    	PersonalUserAddress1:personalAddress1,PersonalUserAddress2:personalAddress2,PersonalUserState:personalState,PersonalUserCity:personalCity,
    	PersonalUserPincode:personalPinCode,Country:country,PhoneNo:phoneNo,WebsiteUrl:webSiteUrl,
    	EmailId:emailId,TinNo:tinNo,ServiceTaxNo:serviceTaxNo,DeviceSerialNo:deviceSerialNo,
    	bankMid:bankMid,Note:note,VerificatonStatus:verificationStatus,swipeAmount:swipeAmount,SwipeDate:SwipeDate,swipeTerminal:swipeTerminal,chequeNo:chequeNo,
		chequeAmount:chequeAmount,chequeDate:chequeDate,chequeDepositDate:chequeDepositDate,chequeBank:chequeBank,
	    cashAmount:cashAmount,cashDate:cashDate,modeofpayment:modeofpayment,merchantType:merchantType,
	    neftAmount:neftAmount,neftDate:neftDate,neftchequeNo:neftchequeNo,neftRefNo:neftRefNo,file:fileName
	    
	}*/
	//console.log("hello "+frmData);
	var opts = {
			type: "POST",
            success: function (data) {
                   var obj = JSON.parse(data);
               if (obj.status == 0&&obj.message=='OK') {
                    $("#modal-body").html("Merchant Updated Successfully");  
                    location.reload(); 
                } else if (data.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (obj.message.startsWith('Invalid')) {
                    $("#modal-body").html("Server Side Validation Failed<p>"+obj.message+"</p>");                    
                }else if (obj.status==100) {
                    $("#modal-body").html("Server Side Validation Failed<p>"+obj.message+"</p>");                    
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("Connection Error<p>Your Request Could Not Be Processed. Please Try Again Later</p>");
                }
            },
            error: function (data, textStatus, errorThrown) {
                $(".loading").css("visibility","hidden");
                if(textStatus=="timeout"){
                	$("#modal-body").html("Connection Error<p>Your Request Has Timed-Out. Please Try Again Later</p>");
                }else{
                	$("#modal-body").html("Connection Error<p>"+ textStatus+"</p>");  
                }
            },
            mimeType:"multipart/form-data",
		    contentType: false,
	      	cache: false,
	       	processData:false,
	       	url: "updatemerchant",
            data: frmData           
        }; 
        $.ajax(opts);
        return false;
}


</script>
 
<script type="text/javascript">



function callMeForHide() {
    var merchantType = $("#merchantType").val();
    if (merchantType == "wallet"){
    	$("#div_merchant").hide();   
    }else if(merchantType == "credit"){
   		$("#div_merchant").show();   
    }else if(merchantType == "wallet/credit"){
   		$("#div_merchant").show();   
    }
}
$(document).ready ( function(){
 if(
  $("#UserAddress1").val()==$("#BusinessAddress1").val()&&$("#UserAddress2").val()==$("#BusinessAddress2").val()&&
  $('#userstate').val() == $('#businessstate').val()&&$('#usercity').val() == $('#businesscity').val()&&
    $('#UserPinCode').val()==$('#BusinessPinCode').val()){
  $("#sameStateCity").prop( "checked", true );
 }else{
  $("#sameStateCity").prop( "checked", false );
}

   $("#loanStatus").click(function () {
	   console.log("111111111111::::::");
	 if($("#loanStatus").prop('checked') == true){
		 $("#div_loanDetails").show();
	 }else{
		 $("#div_loanDetails").hide();
		 } 	
	});

 
 });
<c:out value="${allMerchantDetails['merchantId']}"/>
var merchantState = '<c:out value="${allMerchantDetails['businessState']}" />'
$('select option[value="1"]').attr("selected",true);

</script>

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
  <div class="content-wrapper">
  
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title"> Merchant Details</h3>
            </div>
            <form role="form">
            <input type="hidden" name="merchantId" id="merchantId"
					value="${allMerchantDetails['merchantId']}" />
					<input type="hidden" name="acquirerCode" id="acquirerCode" class="form-control input-lg"  value="${allMerchantDetails['acquirerCode']}" />
					
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="name">Merchant Name</label>
                      <input type="text" class="form-control input-lg" id="name" value="${allMerchantDetails['merchantName']}" placeholder="Enter Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="email">Business Type</label>
                       <select data-clear-btn="true" name="BusinessType" id="BusinessType" required="true" class="form-control input-lg">
												<option value="" <c:if test="${allMerchantDetails['businessType'] == ''}">Selected</c:if>>Choose option</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '1'}">Selected</c:if> value="1"> Proprietor</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '2'}">Selected</c:if> value="2"> Joint Proprietor</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '3'}">Selected</c:if> value="3"> LLP</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '4'}">Selected</c:if> value="4"> Public Ltd</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '5'}">Selected</c:if> value="5"> Trust</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '6'}">Selected</c:if> value="6"> HUF</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '7'}">Selected</c:if> value="7"> Others</option>
												<option <c:if test="${allMerchantDetails['businessType'] == '8'}">Selected</c:if> value="8"> Partnership</option>
                                      		    <option <c:if test="${allMerchantDetails['businessType'] == '9'}">Selected</c:if> value="9"> Private Ltd</option>
                                       
                                       </select>
                                       <div id="dvOther" style="display: none">
											<div class="form-group percent-50">	
												<input type="text" class="form-control input-lg" id="other" />
											</div>
										</div>
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Proprietor /Partner Name /Director /Trustee Name</label>
                      <input type="text" class="form-control input-lg" name="DirectorsName" id="DirectorsName" required="true"
										value="${allMerchantDetails['directorsName']}" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Authorized Signatory</label>
                      <input type="text" class="form-control input-lg" name="AuthorizedSignatory" id="AuthorizedSignatory"
										value="${allMerchantDetails['authorizedSignatory']}">
                    </div>
                  </div>
</div>

<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Business Nature</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['businessNature']}"
										name="BusinessNature" id="BusinessNature">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">MCC Code</label>
                      <select data-clear-btn="true" name="BusinessCode"
										id="BusinessCode" required="true" class="form-control input-lg">
										<option value=""
											<c:if test="${allMerchantDetails['businessCode'] == ''}">Selected</c:if>>Choose
											option</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5691'}">Selected</c:if> value="5691"> MENS AND WOMENS CLOTHING STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5271'}">Selected</c:if> value="5271"> MOBILE HOME DEALERS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5812'}">Selected</c:if> value="5812"> EATING PLACES, RESTAURANTS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5399'}">Selected</c:if> value="5399"> MISCELLANEOUS GENERAL MERCHANDISE STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5732'}">Selected</c:if> value="5732"> ELECTRONIC SALES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5045'}">Selected</c:if> value="5045"> COMPUTERS, COMPUTER PERIPHERAL EQUIPMENT</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5944'}">Selected</c:if> value="5944"> CLOCK STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5511'}">Selected</c:if> value="5511"> TRUCK,AUTO DEALERS.SALES,SERVICE,REPAIRS,PARTS,LEA</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '6300'}">Selected</c:if> value="6300"> INSURANCE SALES, UNDERWRITING, AND PREMIUMS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4722'}">Selected</c:if> value="4722"> TRAVEL AGENCIES AND TOUR OPERATORS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5411'}">Selected</c:if> value="5411"> GROCERY STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5921'}">Selected</c:if> value="5921"> PACKAGE, STORES, BEER, WINE, LIQUOR</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5912'}">Selected</c:if> value="5912"> DRUG STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7011'}">Selected</c:if> value="7011"> LODGING:HOTELS, MOTELS, RESORTS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7230'}">Selected</c:if> value="7230"> BARBER SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8062'}">Selected</c:if> value="8062"> HOSPITALS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8043'}">Selected</c:if> value="8043"> EYEGLASSES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7298'}">Selected</c:if> value="7298"> BEAUTY SPAS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5712'}">Selected</c:if> value="5712"> EQUIPMENT STORES (EXCEPT APPLIANCES)</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5661'}">Selected</c:if> value="5661"> SHOE STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5947'}">Selected</c:if> value="5947"> CARD SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4812'}">Selected</c:if> value="4812"> TELECOMMUNICATION EQUIPMENT INCLUDING TELEPHONE SA</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5722'}">Selected</c:if> value="5722"> HOUSEHOLD APPLIANCE STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5541'}">Selected</c:if> value="5541"> SERVICE STATIONS (WITH OR WITHOUT ANCILLARY SERVIC</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5311'}">Selected</c:if> value="5311"> DEPARTMENT STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5533'}">Selected</c:if> value="5533"> AUTOMOTIVE PARTS, ACCESSORIES STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5977'}">Selected</c:if> value="5977"> COSMETIC STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8011'}">Selected</c:if> value="8011"> DOCTORS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8021'}">Selected</c:if> value="8021"> DENTISTS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5451'}">Selected</c:if> value="5451"> DAIRY PRODUCTS STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5948'}">Selected</c:if> value="5948"> LEATHER GOODS STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7641'}">Selected</c:if> value="7641"> FURNITURE.REUPHOLSTERY AND REPAIR, REFINISHING</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8299'}">Selected</c:if> value="8299"> SCHOOLS AND EDUCATIONAL SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7221'}">Selected</c:if> value="7221"> PHOTOGRAPHIC STUDIOS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5441'}">Selected</c:if> value="5441"> CANDY STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5521'}">Selected</c:if> value="5521"> AUTOMOBILE AND TRUCK DEALERS.(USED ONLY).SALES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5971'}">Selected</c:if> value="5971"> ART DEALERS AND GALLERIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5251'}">Selected</c:if> value="5251"> HARDWARE STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5532'}">Selected</c:if> value="5532"> AUTOMOTIVE TIRE STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8398'}">Selected</c:if> value="8398"> CHARITABLE ORGANIZATIONS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5462'}">Selected</c:if> value="5462"> BAKERIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5651'}">Selected</c:if> value="5651"> FAMILY CLOTHING STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7216'}">Selected</c:if> value="7216"> DRY CLEANERS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5039'}">Selected</c:if> value="5039"> CONSTRUCTION MATERIALS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5940'}">Selected</c:if> value="5940"> BICYCLE SHOPS.SALES AND SERVICE</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5499'}">Selected</c:if> value="5499"> CONVENIENCE, SPECIALTY, MISCELLANEOUS FOOD STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5611'}">Selected</c:if> value="5611"> MENS AND BOYS. CLOTHING AND ACCESSORIES STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7392'}">Selected</c:if> value="7392"> CONSULTING SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5122'}">Selected</c:if> value="5122"> DRUGS, DRUG PROPRIETARIES, AND DRUGGISTS SUNDRIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5966'}">Selected</c:if> value="5966"> DIRECT MARKETING.OUTBOUND TELEMARKETING MERCHANTS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5942'}">Selected</c:if> value="5942"> BOOK STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4214'}">Selected</c:if> value="4214"> MOTOR FREIGHT,TRUCKING,MOVING & STORAGE COMPANIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5811'}">Selected</c:if> value="5811"> CATERERS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5231'}">Selected</c:if> value="5231"> GLASS STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7372'}">Selected</c:if> value="7372"> COMPUTER PROGRAMMING SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5065'}">Selected</c:if> value="5065"> ELECTRICAL PARTS AND EQUIPMENT</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '6513'}">Selected</c:if> value="6513"> REAL ESTATE AGENTS AND MANAGERS.RENTALS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5198'}">Selected</c:if> value="5198"> PAINTS AND SUPPLIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8099'}">Selected</c:if> value="8099"> HEALTH PRACTITIONERS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4215'}">Selected</c:if> value="4215"> COURIER SERVICES.AIR AND GROUND, FREIGHT FORWARDER</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5047'}">Selected</c:if> value="5047"> DENTAL EQUIPMENT AND SUPPLIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5949'}">Selected</c:if> value="5949"> FABRIC STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '1520'}">Selected</c:if> value="1520"> GENERAL CONTRACTORS.RESIDENTIAL AND COMMERCIAL</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4789'}">Selected</c:if> value="4789"> TRANSPORTATION SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '6011'}">Selected</c:if> value="6011"> MEMBER FINANCIAL INSTITUTION.AUTOMATED CASH DISPEN</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7512'}">Selected</c:if> value="7512"> AUTOMOBILE RENTAL AGENCY</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5995'}">Selected</c:if> value="5995"> PET SHOPS.PET FOOD AND SUPPLIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8661'}">Selected</c:if> value="8661"> RELIGIOUS ORGANIZATIONS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7993'}">Selected</c:if> value="7993"> VIDEO AMUSEMENT GAME SUPPLIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5970'}">Selected</c:if> value="5970"> ARTIST SUPPLY STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7998'}">Selected</c:if> value="7998"> AQUARIUMS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5943'}">Selected</c:if> value="5943"> OFFICE SUPPLY STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5571'}">Selected</c:if> value="5571"> MOTORCYCLE SHOPS AND DEALERS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5994'}">Selected</c:if> value="5994"> NEWS DEALERS AND NEWSSTANDS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5734'}">Selected</c:if> value="5734"> COMPUTER SOFTWARE STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5735'}">Selected</c:if> value="5735"> RECORD SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5331'}">Selected</c:if> value="5331"> VARIETY STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7333'}">Selected</c:if> value="7333"> ART, COMMERCIAL</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7538'}">Selected</c:if> value="7538"> AUTOMOTIVE SERVICE SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5072'}">Selected</c:if> value="5072"> HARDWARE EQUIPMENT AND SUPPLIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5137'}">Selected</c:if> value="5137"> CHILDRENS, MENS, WOMEN UNIFORMS AND COMMERCIAL CLO</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5997'}">Selected</c:if> value="5997"> ELECTRIC RAZOR STORES.SALES AND SERVICE</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4814'}">Selected</c:if> value="4814"> CALLS THROUGH USE OF MAGNETIC STRIPE.READING TELEP</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7379'}">Selected</c:if> value="7379"> COMPUTER MAINTENANCE, REPAIR, AND SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7631'}">Selected</c:if> value="7631"> CLOCK REPAIR SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5713'}">Selected</c:if> value="5713"> FLOOR COVERING STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5641'}">Selected</c:if> value="5641"> CHILDRENS AND INFANTS. WEAR STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5941'}">Selected</c:if> value="5941"> SPORTING GOODS STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7922'}">Selected</c:if> value="7922"> THEATRICAL PRODUCERS,TICKET AGENCIES (EXCL.MOTION</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '1761'}">Selected</c:if> value="1761"> ROOFING AND SIDING CONTRACTORS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8675'}">Selected</c:if> value="8675"> AUTOMOBILE ASSOCIATIONS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7299'}">Selected</c:if> value="7299"> OTHER SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7542'}">Selected</c:if> value="7542"> CAR WASHES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '2741'}">Selected</c:if> value="2741"> MISCELLANEOUS PUBLISHING AND PRINTING</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5946'}">Selected</c:if> value="5946"> CAMERA STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7623'}">Selected</c:if> value="7623"> AIR CONDITIONING REPAIR SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7211'}">Selected</c:if> value="7211"> LAUNDRY SERVICES.FAMILY AND COMMERCIAL</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '763 '}">Selected</c:if> value="763 ">AGRICULTURAL COOPERATIVES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7929'}">Selected</c:if> value="7929"> BANDS, ORCHESTRAS, AND MISCELLANEOUS ENTERTAINERS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '1731'}">Selected</c:if> value="1731"> ELECTRICAL CONTRACTORS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5051'}">Selected</c:if> value="5051"> METAL SERVICE CENTERS AND OFFICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5021'}">Selected</c:if> value="5021"> COMMERCIAL FURNITURE</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4900'}">Selected</c:if> value="4900"> ELECTRIC.UTILITIES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7996'}">Selected</c:if> value="7996"> AMUSEMENT PARKS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5933'}">Selected</c:if> value="5933"> PAWN SHOPS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5211'}">Selected</c:if> value="5211"> BUILDING MATERIALS STORES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5172'}">Selected</c:if> value="5172"> PETROLEUM AND PETROLEUM PRODUCTS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '8999'}">Selected</c:if> value="8999"> AUCTIONS</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7629'}">Selected</c:if> value="7629"> APPLIANCE REPAIR SHOPS, ELECTRICAL AND SMALL</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '7399'}">Selected</c:if> value="7399"> BUSINESS SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '4816'}">Selected</c:if> value="4816"> COMPUTER NETWORK/INFORMATION SERVICES</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '6012'}">Selected</c:if> value="6012"> MEMBER FINANCIAL INSTITUTION.MERCHANDISE AND SERVI</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5111'}">Selected</c:if> value="5111"> OFFICE SUPPLIES, PRINTING AND WRITING PAPER, STATI</option>
												<option <c:if test="${allMerchantDetails['businessCode'] == '5094'}">Selected</c:if> value="5094"> PRECIOUS STONES AND METALS</option>
									</select>
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Phone No</label>
                      <input type="number" class="form-control input-lg" value="${allMerchantDetails['phoneNo']}" data-clear-btn="true"
										name="PhoneNo" id="PhoneNo" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Marketing Name</label>
                      <input type="text" class="form-control input-lg" name="MarketingName"
										value="${allMerchantDetails['marketingName']}"
										id="MarketingName" >
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Website Url</label>
                      <input type="url" class="form-control input-lg" name="Websiteurl" value="${allMerchantDetails['webSiteUrl']}"
										id="Websiteurl" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="email">Email Id</label>
                      <input type="email" class="form-control input-lg" value="${allMerchantDetails['emailId']}" data-clear-btn="true"
										name="EmailId" id="EmailId" >
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Business Address1</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['businessAddress1']}"
										data-clear-btn="true" name="BusinessAddress1"
										id="BusinessAddress1" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Business Address2</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['businessAddress2']}"
										data-clear-btn="true" name="businessAddress2"
										id="BusinessAddress2">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Business State</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['businessState']}"
										id="businessstate" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Business City</label>
                      <input type="text" class="form-control input-lg" id="businesscity" name="businesscity"
										value="${allMerchantDetails['businessCity']}">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Business PinCode</label>
                      <input type="number" class="form-control input-lg" value="${allMerchantDetails['businessPincode']}"
										data-clear-btn="true" name="BusinessPinCode"
										id="BusinessPinCode" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Country</label>
                      <input type="text" class="form-control input-lg" id="country" value="INDIA">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                     <label for="exampleInputEmail1"><input type="checkbox" style="margin:0 !important;position:relative !important" id="sameStateCity" name="sameStateCity" onchange="onOffSameAddress();" /> Personal Address Same As Business Address</label>
                     				 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Personal Address 1</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['personalAddress1']}"
										data-clear-btn="true" name="UserAddress1" id="UserAddress1">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Personal Address 2</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['personalAddress2']}"
										data-clear-btn="true" name="UserAddress2" placeholder="Enter Address">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="userstatedropdowndiv">
                    <div class="form-group">
                      <label for="Password">Persnal State</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['personalState']}" id="userstate">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" id="usercitydropdowndiv">
                    <div class="form-group" >
                      <label for="phone">Personal City</label>
                      <input type="text" class="form-control input-lg" id="usercity" name="usercity"
										value="${allMerchantDetails['personalCity']}">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Personal Pincode</label>
                      <input type="number" class="form-control input-lg" value="${allMerchantDetails['personalPincode']}"
										data-clear-btn="true" name="UserPinCode" id="UserPinCode">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Country</label>
                      <input type="text" class="form-control input-lg" id="Country" value="INDIA" >
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Tin No</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['tinNo']}" data-clear-btn="true"
										name="TinNo" id="TinNo" >
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">GST No</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['serviceTaxNo']}"
										data-clear-btn="true" name="ServiceTaxNo" id="ServiceTaxNo" placeholder="Enter GST">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5"id="div_merchant" <c:if test="${allMerchantDetails['merchantType'] == 'wallet'}">style="display:none;"</c:if>>
                    <div class="form-group">
                      <label for="Password">Bank Mid</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['bankMId']}" data-clear-btn="true"
										name="bankMid" id="bankMid">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Mode Of Payment Collection</label>
                       <select name="modeofpayment" id="modeofpayment1" class="form-control input-lg" readonly="readonly">
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Free'}">Selected</c:if> value="Free">Free</option>
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Swipe'}">Selected</c:if> value="Swipe">Swipe</option>
					                                    <option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Cheque'}">Selected</c:if> value="Cheque">Cheque</option>
					                                    <option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Cash'}">Selected</c:if> value="Cash">Cash</option>
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'NEFT'}">Selected</c:if> value="NEFT">Internet Payment Gateway(Online Transfer/NEFT)</option> 
				                                    </select>
                    </div>
                  </div>

                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5"  id="div_swipeAmount" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="number" class="form-control input-lg" id="swipeAmount" placeholder="Enter Amount" step=".01">
                    </div>
                  </div>
                </div>
               <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_SwipeDate" >
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="SwipeDate" id="SwipeDate" readonly='true'/>
                                           
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_swipeTerminal" >
                      <label for="exampleInputEmail1">Swiped on the terminal of</label>
                        <input type="text" class="form-control input-lg" id="swipeTerminal" placeholder="Enter swipe Terminal">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_swipeCardType" >
                      <label for="exampleInputEmail1">Card Type</label>
                         <select data-clear-btn="true" name="cardType" id="cardType" required="true" class="form-control input-lg">
										         	<option value="Rupay">Rupay</option>
										          	<option value="Master">Master</option>
										          	<option value="Visa">Visa</option>
										          	<option value="Amex">Amex</option>										          	         
										          </select>
                    </div>
                  </div>
                  
                </div>
            <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_chequeNo" >
                      <label for="exampleInputEmail1">Cheque No</label>
                     <input type="number" class="form-control input-lg" id="chequeNo" placeholder="Enter cheque No"> </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_chequeAmount" >
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="number" class="form-control input-lg" id="chequeAmount" placeholder="Enter cheque Amount" step=".01">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_chequeDate" >
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="chequeDate" id="chequeDate" readonly='true'/>
                      </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_chequeDepositDate" >
                      <label for="exampleInputEmail1">Cheque Deposit Date</label>
                          <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="chequeDepositDate" id="chequeDepositDate" readonly='true'/>
                      </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_chequeBank" >
                      <label for="exampleInputEmail1">Bank Name</label>
                        <input type="text" class="form-control input-lg" id="chequeBank" placeholder="Enter Cheque Bank">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5"<c:if test="${allMerchantDetails['modeOfPayment'] != 'Cash'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_cashAmount" >
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="number" class="form-control input-lg" id="cashAmount" placeholder="Enter Amount" step=".01">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cash'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_cashDate" >
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="cashDate" id="cashDate" readonly='true'/>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_neft" >
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="text" class="form-control input-lg" id="neftAmount" placeholder="Enter Amount" step=".01">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_neftDate" >
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="neftDate" id="neftDate" readonly='true'/>
                                           
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFTt'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_neftchequeNo">
                      <label for="exampleInputEmail1">Cheque No.</label>
                        <input type="text" class="form-control input-lg" id="neftchequeNo0" placeholder="Enter Cheque No">
                    </div>
                  </div>
                </div>
            
            
            <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_neftRefNo" >
                      <label for="exampleInputEmail1">Ref/UTR. No.</label>
                            <input type="number" class="form-control input-lg" data-role="date" data-clear-btn="true" name="neftRefNo" id="neftRefNo" />
                                           
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                    <div class="form-group" id="div_neftchequeNo" >
                      <label for="exampleInputEmail1">Cheque No.</label>
                        <input type="text" class="form-control input-lg" id="neftchequeNo" placeholder="Enter Cheque No">
                    </div>
                  </div>
                </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">View Document</label>
                        <span><a href="<c:url value='view_docs' />?param=<c:out value="${allMerchantDetails['merchantId']}"/>" target="_blank">Download Pdf</a></span>
                                </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Upload Document</label>
                    	<input type="file" class="form-control input-lg" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" onPaste="return false"/>
                                </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="distributor">Distributor Name</label>
                    <select name="executiveName" id="executiveName" class="form-control input-lg">
								  	  <c:if test="${allMerchantDetails['executiveName']==''}">
								  	     <option value="NA">select</option> 	
									  </c:if>
									  <c:forEach var="RowData" items="${executiveList}">
									  <option <c:if test="${RowData['executiveEmail'] == allMerchantDetails['executiveName']}">selected</c:if> value="<c:out value="${RowData['executiveEmail']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								   </select></div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Remark</label>
                      <input type="number" class="form-control input-lg" value="${allMerchantDetails['note']}" data-clear-btn="true"
										name="Note" id="Note" placeholder="Enter Remark">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Verification Status</label>
                    <select data-clear-btn="true" name="VerificationStatus"
										id="VerificationStatus" required="true" class="form-control input-lg">
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'File Sent To Bank'}">
											<option value="File Sent To Bank">File Sent To Bank</option>
											<option value="MID-TID Received">MID-TID Received</option>
										    <option value="Mapping In-Process">Mapping In-Process</option>
										   	<option value="In Quality Check">In Quality Check</option>
										   	<option value="Deactivated">Deactivated</option>
										    <option value="Activated">Activated</option>
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'MID-TID Received'}">
											<option value="MID-TID Received">MID-TID Received</option>
											<option value="File Sent To Bank">File Sent To Bank</option>
										    <option value="Mapping In-Process">Mapping In-Process</option>
										   	<option value="In Quality Check">In Quality Check</option>
										    <option value="Activated">Activated</option>
										    <option value="Deactivated">Deactivated</option>
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'Mapping In-Process'}">
											<option value="Mapping In-Process">Mapping In-Process</option>
											<option value="File Sent To Bank">File Sent To Bank</option>
											<option value="MID-TID Received">MID-TID Received</option>										    
										   	<option value="In Quality Check">In Quality Check</option>
										    <option value="Activated">Activated</option>
										    <option value="Deactivated">Deactivated</option>
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'In Quality Check'}">
											<option value="In Quality Check">In Quality Check</option>
											<option value="File Sent To Bank">File Sent To Bank</option>
											<option value="MID-TID Received">MID-TID Received</option>
										    <option value="Mapping In-Process">Mapping In-Process</option>										   	
										    <option value="Activated">Activated</option>
										    <option value="Deactivated">Deactivated</option>
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'Activated'}">
											<option value="Activated">Activated</option>
											<option value="File Sent To Bank">File Sent To Bank</option>
											<option value="MID-TID Received">MID-TID Received</option>
										    <option value="Mapping In-Process">Mapping In-Process</option>
										   	<option value="In Quality Check">In Quality Check</option>		
										   	<option value="Deactivated">Deactivated</option>								    
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'Deactivated'}">
											<option value="Deactivated">Deactivated</option>
											<option value="Activated">Activated</option>
											<option value="File Sent To Bank">File Sent To Bank</option>
											<option value="MID-TID Received">MID-TID Received</option>
										    <option value="Mapping In-Process">Mapping In-Process</option>
										   	<option value="In Quality Check">In Quality Check</option>					    
										</c:if>
									</select>
									</div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">App Receipt Date</label>
                      <input type="number" class="form-control input-lg" name="appReceiptDate" id="appReceiptDate" value="${allMerchantDetails['appReceiptDate']}">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Boarding Date</label>
                      <input type="text" class="form-control input-lg" value="${allMerchantDetails['createdOn']}" data-clear-btn="true"
						          name="boardingDate" id="boardingDate">
                    </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">AM Name</label>
                    <select name="amName" id="amName" class="form-control input-lg">
								  	  <option value="NA">Select</option>
									  <c:forEach var="RowData" items="${executiveList}">
									  <option <c:if test="${RowData['executiveEmail'] == allMerchantDetails['amName']}">selected</c:if> value="<c:out value="${RowData['executiveEmail']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								   </select></div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">TSO Name</label>
                    <select name="tsoName" id="tsoName" class="form-control input-lg">
								  	  <option value="NA">Select</option>
									  <c:forEach var="RowData" items="${executiveList}">
									   <option <c:if test="${RowData['executiveEmail'] == allMerchantDetails['tsoName']}">selected</c:if> value="<c:out value="${RowData['executiveEmail']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								  	  		</select></div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Original App Status</label>
                    <select data-clear-btn="true" name="appCheckStatus" id="appCheckStatus" required="true" class="form-control input-lg">
										          <option <c:if test="${allMerchantDetails['checkStatus'] == 'No'}">Selected</c:if> value="No">No</option>
												
										         <option <c:if test="${allMerchantDetails['checkStatus'] == 'Yes'}">Selected</c:if> value="Yes">Yes</option>
												</select> </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">OnBoard Exe Name</label>
                      	<input type="text" class="form-control input-lg" data-clear-btn="true" name="onBoardEmpName" id="onBoardEmpName" value="${allMerchantDetails['onBoardEmpName']}" readonly="readonly" maxlength=60  />
                                           </div>
                  </div>
</div>
<div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">OnBoarding status</label>
                   <select data-clear-btn="true" name="onBoardingStatus" id="onBoardingStatus" required="true" class="form-control input-lg">
										         	<option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Entry done'}">Selected</c:if> value="Entry done">Entry done</option>
												 <option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Verified'}">Selected</c:if> value="Verified">Verified</option>
												 <option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Pending'}">Selected</c:if> value="Pending">Pending</option>
												 <option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Rejected'}">Selected</c:if> value="Rejected">Rejected</option>
												  </select> </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Type Of Sale</label>
                    <select data-clear-btn="true" name="typeOfSale" id="typeOfSale" required="true" class="form-control input-lg">
										         <option <c:if test="${allMerchantDetails['typeOfSale'] == 'Distributor'}">Selected</c:if> value="Distributor">Distributor</option>
												 <option <c:if test="${allMerchantDetails['typeOfSale'] == 'Direct'}">Selected</c:if> value="Direct">Direct</option>
												</select></div>
                  </div>
</div>


</div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" data-target=".bs-example-modal-sm" class="btn btn-info pull-right" onclick="return getaddEmp();">Submit</button>
              </div>
              	<c:forEach var="counter" begin="1"
						end="${allMerchantDetails['merchantOrgCount']}">
						<c:set var="orgVar" value="org${counter}" />
						<c:set var="orgDetails" value="${allMerchantDetails[orgVar]}" />
						<div class="x_panel">
							<div class="x_title">
								Terminals of Store - <b>${orgDetails.orgName}</b>
								<ul class="nav navbar-right panel_toolbox">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#" data-toggle="modal" data-target=".update_org_popup"
														onclick='setOrgDetails("${orgDetails.orgId}","${orgDetails.orgName}","${orgDetails.address1}","${orgDetails.address2}","${orgDetails.city}","${orgDetails.state}","${orgDetails.country}","${orgDetails.pincode}");'>Update Org</a></li>
										<li><a href="#" onclick='return deleteOrgConfirm("${orgDetails.orgId}")'<c:if test="${orgDetails.empRole != '1'}">style="display:none;"</c:if> >Delete Org</a></li>											
										</ul></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>Serial No.</th>
											<th>TID</th>
											<th>Terminal Id</th>
											<th>RMN</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="count" begin="1"
											end="${orgDetails.orgDeviceCount}">
											<c:set var="deviceVar" value="device${count}" />
											<c:set var="deviceDetails" value="${orgDetails[deviceVar]}" />
											<c:if test="${deviceDetails.userPhoneNo != null&&deviceDetails.userPhoneNo!=''&&fn:length(deviceDetails.userPhoneNo)>8}">
											<tr>
												<th>${deviceDetails.serialNo}</th>
												<th>${deviceDetails.bankTId}</th>
												<td>${deviceDetails.userPhoneNo}</td>
												<td>${deviceDetails.rmn}</td>
												<td><button type="button" class="btn btn-danger btn-xs"
														onclick='return deleteDeviceConfirm("${deviceDetails.userId}","${orgDetails.orgId}")' <c:if test="${orgDetails.empRole != '1'}">style="display:none;"</c:if>><i class="fa fa-fw fa-remove"></i>Delete</button>												
													<button type="button" class="btn btn-success btn-xs"
														data-toggle="modal" data-target=".update_device_popup"
														onclick='setDeviceDetails("${deviceDetails.userId}","${deviceDetails.bankTId}","${deviceDetails.serialNo}","${deviceDetails.validTil}","${deviceDetails.rent}","${deviceDetails.paymentMode}","${deviceDetails.pendingRent}","${deviceDetails.penaltyAmount}","${deviceDetails.discount}","${deviceDetails.avgTxnAmount}","${deviceDetails.userName}","${deviceDetails.userPhoneNo}","${deviceDetails.rmn}","${deviceDetails.userEmail}","${deviceDetails.mdrDebit1}","${deviceDetails.mdrDebit2}","${deviceDetails.mdrCreditPre}","${deviceDetails.mdrCreditNpre}","${deviceDetails.mdrAmex}","${deviceDetails.other}","${deviceDetails.mdrCashAtPos}","${deviceDetails.amexActivated}","${deviceDetails.amexTID}","${deviceDetails.amexMID}","${deviceDetails.bankAccName}","${deviceDetails.bankAccNo}","${deviceDetails.bankName}","${deviceDetails.bankIfsc}","${deviceDetails.bankMicr}","${deviceDetails.bankBranch}","${deviceDetails.mdrMobiKwik}","${deviceDetails.userType}","${deviceDetails.userStatus}","${deviceDetails.benefName}","${deviceDetails.penaltyReason}","${deviceDetails.discountReason}","${deviceDetails.loyaltyStatus}","${deviceDetails.closeWalletStatus}","${deviceDetails.txnSmsStatus}","${deviceDetails.integrationKey}","${deviceDetails.emprole2}","${deviceDetails.loanStatus}","${deviceDetails.loanType}","${deviceDetails.loanDedAmount}","${deviceDetails.loanBankName}","${deviceDetails.loanBankAcc}","${deviceDetails.loanBankIfsc}","${deviceDetails.mdrZero}","${deviceDetails.mdrDebit0}","${deviceDetails.activationDate}","${deviceDetails.planName}","${deviceDetails.feeMode}","${deviceDetails.feeAmount}","${deviceDetails.feeDate}","${deviceDetails.feeRemark}","${deviceDetails.switchType}","${deviceDetails.midTidEntryDate}","${deviceDetails.wlcmLtrSendDate}","${deviceDetails.settlementCharges}","${deviceDetails.rechargeService}","${deviceDetails.rechargeBal}","${deviceDetails.rechargeIncentive}","${deviceDetails.rechargeMonthlyRental}","${deviceDetails.ppcServiceEnable}","${deviceDetails.dmtServiceEnable}","${deviceDetails.dthMobileServiceEnable}");'<c:if test="${allMerchantDetails.emprole1 != '12'}">style="display:none;"</c:if>><i class="fa fa-fw fa-eye"></i>View Details</button>											
													<button type="button" class="btn btn-success btn-xs"
														data-toggle="modal" data-target=".update_device_popup"
														onclick='setDeviceDetails("${deviceDetails.userId}","${deviceDetails.bankTId}","${deviceDetails.serialNo}","${deviceDetails.validTil}","${deviceDetails.rent}","${deviceDetails.paymentMode}","${deviceDetails.pendingRent}","${deviceDetails.penaltyAmount}","${deviceDetails.discount}","${deviceDetails.avgTxnAmount}","${deviceDetails.userName}","${deviceDetails.userPhoneNo}","${deviceDetails.rmn}","${deviceDetails.userEmail}","${deviceDetails.mdrDebit1}","${deviceDetails.mdrDebit2}","${deviceDetails.mdrCreditPre}","${deviceDetails.mdrCreditNpre}","${deviceDetails.mdrAmex}","${deviceDetails.other}","${deviceDetails.mdrCashAtPos}","${deviceDetails.amexActivated}","${deviceDetails.amexTID}","${deviceDetails.amexMID}","${deviceDetails.bankAccName}","${deviceDetails.bankAccNo}","${deviceDetails.bankName}","${deviceDetails.bankIfsc}","${deviceDetails.bankMicr}","${deviceDetails.bankBranch}","${deviceDetails.mdrMobiKwik}","${deviceDetails.userType}","${deviceDetails.userStatus}","${deviceDetails.benefName}","${deviceDetails.penaltyReason}","${deviceDetails.discountReason}","${deviceDetails.loyaltyStatus}","${deviceDetails.closeWalletStatus}","${deviceDetails.txnSmsStatus}","${deviceDetails.integrationKey}","${deviceDetails.emprole2}","${deviceDetails.loanStatus}","${deviceDetails.loanType}","${deviceDetails.loanDedAmount}","${deviceDetails.loanBankName}","${deviceDetails.loanBankAcc}","${deviceDetails.loanBankIfsc}","${deviceDetails.mdrZero}","${deviceDetails.mdrDebit0}","${deviceDetails.activationDate}","${deviceDetails.planName}","${deviceDetails.feeMode}","${deviceDetails.feeAmount}","${deviceDetails.feeDate}","${deviceDetails.feeRemark}","${deviceDetails.switchType}","${deviceDetails.midTidEntryDate}","${deviceDetails.wlcmLtrSendDate}","${deviceDetails.settlementCharges}","${deviceDetails.rechargeService}","${deviceDetails.rechargeBal}","${deviceDetails.rechargeIncentive}","${deviceDetails.rechargeMonthlyRental}","${deviceDetails.ppcServiceEnable}","${deviceDetails.dmtServiceEnable}","${deviceDetails.dthMobileServiceEnable}");'<c:if test="${allMerchantDetails.emprole1 == '10'||allMerchantDetails.emprole1 == '12'}">style="display:none;"</c:if>><i class="fa fa-fw fa-eye"></i>Update</button>
												</td>
											</tr>
											</c:if>
											
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
            </form>
          </div>
        </div>
      </div>
      <!-- /.row -->
    </section>
<!------------------------------ Update ORG -------------------------------------------->
.
<div class="modal fade update_org_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Organization</h4>
					
				</div>
				<div class="modal-body1">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="id" name="id" value="">
						<div class="x_panel">
							<div class="x_title">
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								 		<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="modelName"> Name<span class="required">*</span></label>
                                               <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="updOrgName" id="updOrgName" required="true"  />
                                           </div>
                                        </div>                                                            
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Address Line 1<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="updOrgAddress1" id="updOrgAddress1" required="true"  />
                                           </div>
                                        </div>
                                        
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Address Line 2<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="updOrgAddress2" id="updOrgAddress2" required="true"  />                                                                                             
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">State<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="updOrgbusinessstate" id="updOrgbusinessstate" required="true"  />                                                                                            
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">City<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="name="updOrgbusinessstate" id="updOrgbusinesscity" name="updOrgbusinesscity" required="true"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Pincode<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="updOrgPinCode" id="updOrgPinCode" name="updOrgbusinesscity" required="true" minlength="8" maxlength="17" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" />
                                                                                              
                                            </div>
                                        </div>                   
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Country<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="name="updCountry" id="updCountry" name="updCountry" required="true" minlength="8" maxlength="17" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" />
                                                                                              
                                            </div>
                                        </div>                                               
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger btn-xs" data-dismiss="modal">Close</button>	
					<button type="button" class="btn btn-success btn-xs"
										data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return updOrgDetails();" id="UpdDeviceDetails"
										name="UpdDeviceDetails">Update Org</button>	
					
				</div>
			</div>
		</div>
	</div>

                
<!------------------------------ Update Device -------------------------------------------->

<div class="modal fade update_device_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Device</h4>
					
				</div>
				<div class="modal-body1">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="id" name="id" value="">
						<div class="x_panel">
							<div class="x_title">
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								 <div class="form-group">
                                        <div class="col-md-2 col-sm-2 col-xs-12">
                                           <div class="checkbox">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		           <input type="checkbox"
		            style="margin: 0 !important; position: relative !important"
		            id="userStatus" name="userStatus">User Enable
		           </div>
                                           </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                           <div class="checkbox">
	           <input type="checkbox"
	            style="margin: 0 !important; position: relative !important"
	            id="loyaltyStatus" name="loyaltyStatus" onclick="return setAcqLoyaltyStatus();">Loyalty Enable
	           </div>
                                            </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                           <div class="checkbox">
	           <input type="checkbox"
	            style="margin: 0 !important; position: relative !important"
	            id="closeWalletStatus" name="closeWalletStatus" onclick="return setAcqWalletStatus();">Closed Wallet Enable
	           </div>
	                                            </div>
	                                             <div class="col-md-2 col-sm-2 col-xs-12">
	                                           <div class="checkbox">
	           <input type="checkbox"
	            style="margin: 0 !important; position: relative !important"
	            id="txnSmsStatus" name="txnSmsStatus" onclick="return setTxnSmsStatus();">SMS Enable
	           </div>
                                            </div>
                    <div class="col-md-1 col-sm-1 col-xs-12">
			         <div class="checkbox">
			           <input type="checkbox"
			            style="margin: 0 !important; position: relative !important"
			            id="loanStatus" name="loanStatus"> Loan Enable
			           </div>
			        </div>
			        <div class="col-md-2 col-sm-2 col-xs-12">
	                                           <div class="checkbox">
	           <input type="checkbox" style="margin: 0 !important; position: relative !important" id="mdrZero" name="mdrZero">MDR Zero Enable
	           </div>
	           </div>
	           <div class="form-group percent-100">
		                
                   <div class="col-md-2 col-sm-2 col-xs-12">
                                           <div class="checkbox">
		           <input type="checkbox"
		            style="margin: 0 !important; position: relative !important"
		            id="rechargeServiceEnable" name="rechargeServiceEnable" onclick="return setRechargeServiceStatus();">Recharge Service Enable
		           </div>
                                           </div>   
                      <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                                        </div>                                                            
                                        <div class="form-group" id="div_SerialNo">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Device Serial No<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="SerialNo" id="SerialNo" required="true" minlength="8" maxlength="25" />
                                           </div>
                                        </div>
                                        
                                       <div class="form-group" id="div_bankTid">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank Tid<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="BankTid" id="BankTid" required="true"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Terminal Id<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="number" class="form-control" data-clear-btn="true" name="DLoginId" id="DLoginId" required="true" />
                                                                                              
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status"><input type="checkbox"
												style="margin: 0 !important; position: relative !important"
												id="sameUserId" name="sameUserId"
												onchange="onOffSamePhone();"> RMN Same As TerminalId RMN<span class="required"><span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="number" class="form-control" data-clear-btn="true" name="rmn" id="rmn"  required="true" />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Email Id<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="email" class="form-control" data-clear-btn="true" name="UserEmailId" id="UserEmailId" required="true"  />
                                                                                              
                                            </div>
                                        </div>                   
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Name Of User<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="DName" id="DName"  />
                                                                                              
                                            </div>
                                        </div>  
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Valid till Date<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="validTil" id="validTil"  readonly="readonly"/>
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Rent<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="Rent" id="Rent"  />
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Payment Mode<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <select name="PaymentMode" id="PaymentMode" required="true" class="form-control" readonly="readonly">
                                            <option value="">select</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="quaterly">Quaterly</option>
                                            <option value="halfyearly">HalfYearly</option>
                                            <option value="yearly">Yearly</option>
                                        </select>
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Pending Rent<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" ame="pendingRent" id="pendingRent"  />
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Penalty Amount<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="penaltyAmount" id="penaltyAmount"  />
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Penalty Reason<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="penaltyReason" id="penaltyReason"  />
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Discount<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="discount" id="discount"  />
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Discount Reason<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="discountReason" id="discountReason"  />
                                                                                              
                                            </div>
                                        </div> 
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Avg Txn Amt<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="avgTxnAmount" id="avgTxnAmount"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_MdrDebit0">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Mdr Debit <1000<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="MdrDebit0" id="MdrDebit0"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_MdrDebit1">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Mdr Debit (>1000 & <2000)<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="MdrDebit1" id="MdrDebit1"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_MdrDebit2">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Mdr Debit >2000<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="MdrDebit2" id="MdrDebit2"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_MdrCreditPre">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Mdr Credit Premium<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="MdrCreditPre" id="MdrCreditPre"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_MdrCreditNpre">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Mdr Credit Card Non-Premium<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="MdrCreditNpre" id="MdrCreditNpre"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_Other">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">International Card<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="Other" id="Other"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_mdrCashAtPos" style="display:none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">CASHATPOS MDR<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="mdrCashAtPos" id="mdrCashAtPos"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group" id="div_mobiKwikMdr">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Wallet MDR<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="mobiKwik" id="mobiKwik"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Fixed Settlement Charges<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="settlementCharges" id="settlementCharges"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank Account Type<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <select data-clear-btn="true" name="bankAccType"
											id="bankAccType1" required="bankAccType" class="form-control" readonly="readonly">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.bankAccName == 'current'}">Selected="Selected"</c:if> value="current">Current</option>
											<option <c:if test="${deviceDetails.bankAccName == 'saving'}">Selected="Selected"</c:if> value="saving">Saving</option>
											<option <c:if test="${deviceDetails.bankAccName == 'od'}">Selected="Selected"</c:if> value="od">OD</option>
										</select>                                          
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank Account Number<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" nname="bankAccNumber" id="bankAccNumber"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank Name<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="bankName" id="bankName"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Benefciary Name<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="benefName" id="benefName"  />
                                                                                              
                                            </div>
                                        </div> 
                                     <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank Branch<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="bankBranch" id="bankBranch"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank IFSC<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="bankIfsc" id="bankIfsc"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Bank MICR<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="bankMicr" id="bankMicr"  />
                                                                                              
                                            </div>
                                        </div> <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Plan Name<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <select name="upPlanName" id="upPlanName" class="form-control">
                                            	 	<option value="Life-Time(36Months)">Life-Time(36Months)</option>
                                            	  	<option value="Yearly">Yearly</option>
                                            	  	<option value="Half-Yearly">Half-Yearly</option>
                                            	   	<option value="Quarterly">Quarterly</option>
		                                            <option value="Monthly">Monthly</option>
	                                            </select>                                            
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Fee Mode<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <select name="upFeeMode" id="upFeeMode" class="form-control">
                                            		<option value="Free">Free</option>
		                                            <option value="Neft">Neft</option>
		                                            <option value="Cheque">Cheque</option>
		                                            <option value="Cash">Cash</option>		                                            
	                                            </select>                                            
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Fee Amount<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                      <input type="number" class="form-control" data-clear-btn="true" name="upFeeAmount" id="upFeeAmount"  />
                                                                                        
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Fee Date<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="date-picker form-control" id="upFeeDate" />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Activation Date<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" name="upActivationDate" class="date-picker form-control" id="upActivationDate"  />
                                                                                              
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Fee Remarks<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="upFeeRemarks" id="upFeeRemarks"  />
                                                                                              
                                            </div>
                                        </div>    
                                                                                     
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	
					<button type="button" class="btn btn-info pull-right"
										data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return updOrgDetails();" id="UpdDeviceDetails"
										name="UpdDeviceDetails">Update Org</button>	
					
				</div>
			</div>
		</div>
	</div>

    





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








































	<!-- footer content -->
	<jsp:include page="/jsp/footer.jsp" />
	<!-- /footer content -->
					                           