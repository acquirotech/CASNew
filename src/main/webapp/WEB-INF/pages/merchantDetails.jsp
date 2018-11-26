<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3")||session.getAttribute("empRole").equals("4")||session.getAttribute("empRole").equals("7")||session.getAttribute("empRole").equals("9")||session.getAttribute("empRole").equals("10"))){	
	response.sendRedirect("welcome");
}%>
<script src="<c:url value="/resources/js/Acqcitystate.js" />"></script>
<!----------------------------------------------jsFunction----------------------------------------------------------->
<script type="text/javascript">

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


function welcomeLetter(wlcmBankTid,wlcmRmn, wlcmUserId, wlcmMID, wlcmMdrCreditNpre, wlcmMdrCreditPre, wlcmMdrDebit1, wlcmMdrDebit2) {
	
	//console.log("Welcome Call");
	if (confirm("Do you want send welcome letter?") == true) {
	var sendvalue= {wlcmBankTid:wlcmBankTid,wlcmRmn:wlcmRmn, wlcmUserId:wlcmUserId, wlcmMID:wlcmMID, wlcmMdrCreditNpre:wlcmMdrCreditNpre, wlcmMdrCreditPre:wlcmMdrCreditPre, wlcmMdrDebit1:wlcmMdrDebit1, wlcmMdrDebit2:wlcmMdrDebit2 }
	var opts = {
		 	type: "POST",
		     	success: function (data) {
			     	//alert(data.status+':data:'+data.message);
		                $(".loading").css("visibility","hidden");
		                if (data.status == 0 || data.message=='OK') {
		                	alert("Welcome Letter Generated Successfully"); 
		                	location.reload();               
		                } else if (data.status == 102)  {
		                	alert(data.message); 
		                	//location.reload();               
		                }else if (data.status == 101 || data.message=='User Not Found') {
		                	alert("User not found for generate wlecome letter"); 
		                	//location.reload();               
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
		            url: "welcomeLetter",
		            data: sendvalue
		        }; 
		        $.ajax(opts);
		        return false;
		}else{
			return false;
		}
	}

function sendsms(){
	 var sendMerchantId = $("#MerchantId").val();
	 var sendOrgId = $("#sendOrgId").val();
	 var sendUserId = $("#sendUserId").val();
	 var smstext = $("#smstext").val();
	 var sendRmn = $("#sendRmn").val();
	 var sendvalue={smstext:smstext,sendMerchantId:sendMerchantId,sendOrgId:sendOrgId,sendUserId:sendUserId,sendRmn:sendRmn}
	 var opts = {
	     type: "POST",
	     	success: function (data) {
	       		$(".loading").css("visibility","hidden");
	            if (data.status == 0&&data.message=='OK') {
	                alert("Sms Send Successfully"); 
	                location.reload();
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
	            url: "sendSms",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	 
	 }
function setsendsms(sendMerchantId,sendOrgId,sendUserId,sendRmn){
	$("#MerchantId").val(sendMerchantId);
	$("#sendOrgId").val(sendOrgId);
	$("#sendUserId").val(sendUserId);
	$("#sendRmn").val(sendRmn);
}

function onchangepassword(){
	if($("#checkpassword").is(":checked") == true) {
	  	$("#div_changePassword").show();
	}else{
		$("#changePassword").val('');
	 	$("#div_changePassword").hide();
	}
}

function tinNoValidate(evt){
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if ((charCode >= 48 && event.charCode <= 57)||charCode==8||charCode==37){
 	   return true;
 	}else{
 	   return false;
 	}
}
function onChangeCloneDeviceIds(){
	 var SerialNo = $("#cloneSerialNo").val();
	 var sendvalue={serialNo:SerialNo}
	 var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                 var list =  data.result;                
	                // $("#cloneBankTid").val(list.bankTid);
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


function isAlphaNumericName(evt) {	
	try {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==37|| charCode==46||charCode==45||charCode==46||charCode==47||charCode==44||charCode==38||charCode==40||charCode==41){
    	   return true;
    	}else{
    	   return false;
    	}
    }catch (err) {
    	alert(err.Description);
   	}
}
function ChangePassword(){	
	var userId = $("#DeviceID").val();
	var changePassword = $("#changePassword").val();
	if(userId==null||userId==''||userId.length<1){
		$("#modal-body").html("<h2>Invalid User Details</h2>");  
		return false;
	}
	if(changePassword==null||changePassword==''||changePassword.length<6){
		$("#modal-body").html("<h2>Invalid Password</h2>");  
		return false;
	}
	var sendvalue={userId:userId,changePassword:changePassword}
	var opts = {
		type: "POST",
	    success: function (data) {
	    	$(".loading").css("visibility","hidden");
	        if (data.status == 0&&data.message=='OK') {
	        	alert("Password Change Successfully");
	            $("#changePassword").val('');
	            $("#checkpassword").val('');
	        }else if(data.status==111) {
	        	$("body").attr("onload","noBack();");
	            $("body").attr("onpageshow","if (event.persisted) noBack();");
	            $("body").attr("onunload","");
	            window.location.href="logout.jsp";
	        }else if (data.status==100) {
	            $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	        } else {
	        	$(".loading").css("visibility", "hidden");
	        	alert(data.message);
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
	   url: "changePassword",
	   data: sendvalue
	   };
	   $.ajax(opts);
	   return false;
	}

function onchangeLoanType(){
var loanType = $("#loanType").val();
if(loanType == "fixed"){
	$("#div_loanAmount").show();
	$("#div_loanAmount1").show();
	$("#div_loanPercentage").hide();
}else if(loanType == "percentage"){
	$("#div_loanAmount").show();
	$("#div_loanAmount1").hide();
	$("#div_loanPercentage").show();
}else{
	$("#div_loanPercentage").hide();
	$("#div_loanAmount").hide();	
}	
}

function onchangeUserType() {
	// var userType = $("#userType").val();
	var userType;
    if ($('#userType').is(":checked")){
    	$("#userType").val('credit');
    }else{
    	$("#userType").val('notCredit');
        }
  	var userType = $("#userType").val();
    if (userType == "credit"){
    	$("#div_bankTid").show();
    	$("#div_mobiKwikMdr").hide();
    	$("#div_Other").show();
    	$("#div_MdrCreditNpre").show();
    	$("#div_MdrCreditPre").show();
    	$("#div_MdrDebit2").show();
    	$("#div_MdrDebit0").show();
    	$("#div_MdrDebit1").show(); 
    	$("#div_americanExpress").show();  
    	$("#div_SerialNo").show(); 
    	$("#div_mdrCashAtPos").show(); 	   	
    }
   	else if (userType == "wallet/credit") 
    {
   		$("#div_bankTid").show();
   		$("#div_mobiKwikMdr").show();
   		$("#div_Other").show();
   		$("#div_MdrDebit0").show();
   		$("#div_MdrCreditNpre").show();
   		$("#div_MdrCreditPre").show();
   		$("#div_MdrDebit2").show();
   		$("#div_MdrDebit1").show();
   		$("#div_americanExpress").show();
   		$("#div_SerialNo").show(); 
   		$("#div_mdrCashAtPos").show();  		
   	}
  	else if (userType == "wallet") 
    {
  		$("#div_bankTid").hide();
  		$("#div_mobiKwikMdr").show();
  		$("#div_Other").hide();
  		$("#div_MdrCreditNpre").hide();
  		$("#div_MdrCreditPre").hide();
  		$("#div_MdrDebit2").hide();
  		$("#div_MdrDebit1").hide();
  		$("#div_MdrDebit0").hide();
  		$("#div_americanExpress").hide();
  		$("#div_SerialNo").hide(); 
  		$("#div_mdrCashAtPos").hide();  		
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

function onChangeAmexActivated() {
	 var AmexActivated = $("#AmexActivated").val();
    if (AmexActivated == "NO") 
    {
    	$("#div_mdrAmex").hide();
    	$("#div_amexTID").hide();
    	$("#div_amexMID").hide();    	      
   	}
   	else 
    {
   		$("#div_mdrAmex").show();
   		$("#div_amexTID").show();
   		$("#div_amexMID").show();
  	}
}
function onChangeDeviceIds(){
	var SerialNo = $("#SerialNo").val();
	var sendvalue={serialNo:SerialNo}
	var acquirerCode = $("#acquirerCode").val();
	console.log("11:::"+acquirerCode);
	if(acquirerCode!="acquiro"){  
		alert("Acquirer is not acquiro, Serial No cant be changed"); 
		$("#SerialNo").val(srNo);
		 return false;
		  }
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                	var list =  data.result;               	
	             //   $("#BankTid").val(list.bankTid);
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

function setNodalAccountDetails(tid,merchantID,orgId,userId,bankIfsc,bankAccNo,benefName,bankName,emailId,rmn,personalAddress1, personalAddress2,benCity,benState,personalPincode,benDob,benBankCd,benBranchCd,benTranParticular,benTrnsRmks,benPan,benType,benId,limitDaily,limitWeekly,limitMonthly,issueBranchCd,bt,btype){

	var sendvalue={accessKey:'nodalaccben',merchantId:merchantID,bankAccNo:bankAccNo}
 	var opts = {
    	type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                	//alert("Successfully called");     	
                	$("#nodalTid").val(tid);
                	$("#nodalMerchantId").val(merchantID);
                	$("#nodalOrgId").val(orgId);     	
                	$("#nodalUserId").val(userId);
                	$("#benIfsc").val(data.result.benIfsc);
                	$("#benAccNo").val(data.result.benAccNo);
                	$("#nodalBenName").val(data.result.benName);
                	$('#nodalModeOfPay option[value="' + data.result.nodalModeOfPay + '"]').prop('selected', true);
                	//$('#nodalModeOfPay').empty();
                	//$("#nodalModeOfPay").append('<option value="'+data.result.nodalModeOfPay+'"> '+data.result.nodalModeOfPay+'</option>');
                	//$("#nodalModeOfPay").val(data.result.nodalModeOfPay);
                	$("#benBankName").val(data.result.benBankName);
                	$("#benEmail").val(data.result.benEmail);	
                	$("#benMobile").val(data.result.benMobile);	
                    $("#benAddress").val(data.result.benAddress); 
                    $("#benState").append('<option value="'+data.result.benState+'"> '+data.result.benState+'</option>');                    
                    $("#benState").val(data.result.benState);
                    console.log('data.result.benState:'+data.result.benState);                                       
                    $("#benCity").append('<option value="'+data.result.benCity+'"> '+data.result.benCity+'</option>');                    
                     $("#benCity").val(data.result.benCity);
                     console.log('data.result.benCity:'+data.result.benCity);
                     
                    $("#benPinCd").val(data.result.benPinCd);
                    $("#benDob").val(data.result.benDob);
                    //$("#benBankCd").val(data.result.benBankCd);
                    // $("#benBranchCd").val(data.result.benBranchCd);
                    $("#benTrnParticulars").val(data.result.benTrnParticulars);
                    $("#benTrnsRmks").val(data.result.benTrnsRmks);
                    //$("#issueBranchCd").val(data.result.issueBranchCd);                    
                    $("#benPan").val(data.result.benPan);
                    $("#benType").append('<option value="'+data.result.benType+'"> '+data.result.benType+'</option>'); 
                    $("#benType").val(data.result.benType);
                    $("#benId").val(data.result.benIdRes);
                    if(data.result.limitDaily==null||data.result.limitDaily==''){
                    	$("#limitDaily").val('500000');
                    }else{
                    	$("#limitDaily").val(data.result.limitDaily);
                	}if(data.result.limitWeekly==null||data.result.limitWeekly==''){
                    	$("#limitWeekly").val('3500000');
                    }else{
                    	$("#limitWeekly").val(data.result.limitWeekly);
                	} if(data.result.limitMonthly==null||data.result.limitMonthly==''){
                    	$("#limitMonthly").val('15000000');
                    }else{
                    	$("#limitMonthly").val(data.result.limitMonthly);
                	}                     
                    $("#resStatus").val(data.result.status);
                    $("#resDesc").val(data.result.resDesc);                   
                }else if (data.status==101&&data.message=='Not Found') {
                	$("#nodalTid").val(tid);
                	$("#nodalMerchantId").val(merchantID);
                	$("#nodalOrgId").val(orgId);                	
                	$("#nodalUserId").val(userId);
                	$("#benIfsc").val(bankIfsc);
                	$("#benAccNo").val(bankAccNo);
                	$("#nodalBenName").val(benefName);
                	$("#benBankName").val(bankName);
                	$("#benEmail").val(emailId);
                	$("#benMobile").val(rmn);
                	var addrs = (personalAddress1+' '+personalAddress2);
                	var caddress = addrs.replace(/, /g, ',');
                	$("#benAddress").val(caddress);
                	console.log('addrsaddrsaddrsaddrsaddrs:::'+addrs);
                	//$("#benAddress").val(personalAddress1+" "+personalAddress2);        
                    //$("#benState").val('');
                    //$("#benCity").val('');
                    $("#benState").append('<option value="'+benState+'"> '+benState+'</option>');
                    $("#benState").val(benState);
                    console.log('benState:'+benState);
                    $("#benCity").append('<option value="'+benCity+'"> '+benCity+'</option>');
                    $("#benCity").val(benCity);
                    console.log('benCity:'+benCity);
                    if(btype.startsWith("4")){
                    	$("#benType").append('<option value="Private/Public Ltd Co/One Person Company"> Private/Public Ltd Co/One Person Company</option>'); 
                        $("#benType").val("Private/Public Ltd Co/One Person Company");
                    }else{
                    	$("#benType").append('<option value="Sole Proprietor"> Sole Proprietor</option>'); 
                        $("#benType").val("Sole Proprietor");
                    }
                    $("#benPinCd").val(personalPincode);
                    $("#benDob").val('');              
                    $("#benTrnParticulars").val('');
                    $("#benTrnsRmks").val('');
                    $("#benPan").val('');
                    $("#benId").val('');
                    $("#resStatus").val('');
                    $("#resDesc").val('');
                    $("#limitDaily").val('500000');
                    $("#limitWeekly").val('3500000');
                    $("#limitMonthly").val('15000000');
                   
                    
                }else if (data.status==111) {
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
            url: "getRgstrdBenDetails",
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

function updOrgDetails(){
	$("#modal-body").html("<h2>In Process</h2>");  
	var updOrgId = $("#UpdOrgId").val();
	var updOrgName = $("#updOrgName").val();
	var updOrgAddress1 = $("#updOrgAddress1").val();
	var updOrgAddress2 = $("#updOrgAddress2").val();
	var orgstate = $("#updOrgbusinessstate").val();
	var orgcity = $("#updOrgbusinesscity").val();
	var updCountry = $("#updCountry").val();
	var updOrgPinCode = $("#updOrgPinCode").val();
	
	if(updOrgName==null||updOrgName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store Name</p></n>Length should be min 3 and max 50 char');
			return false;
		}else if(updOrgName.length<=2||updOrgName.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store Name</p></n>Length should be min 3 and max 50 char');
			return false;
		}else if(updOrgAddress1==null||updOrgAddress1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Address Line1</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(updOrgAddress1.length<4||updOrgAddress1.length>100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Address Line1</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(updOrgAddress2==null||updOrgAddress2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Address Line2</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(updOrgAddress2.length<4||updOrgAddress2.length>100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Address Line2</p></n>Length should be min 4 and max 100 char');
			return false;
		}else if(orgstate==null||orgstate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store State</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(orgstate.length<2||orgstate.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store State</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(orgcity==null||orgcity==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store City</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(orgcity.length<=2||orgcity.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store City</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(updOrgPinCode==null||updOrgPinCode==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store PinCode</p></n>Length should be 6 digits');
			return false;
		}else if(updOrgPinCode.length!=6){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store PinCode</p></n>Length should be 6 digits');
			return false;
		}else if(updCountry==null||updCountry==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Country</p>');
			return false;
		}else if(updCountry!='INDIA'){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Country</p>');
			return false;
		}
	var sendvalue={UpdOrgId:updOrgId,UpdOrgName:updOrgName,UpdOrgAddress1:updOrgAddress1,UpdOrgAddress2:updOrgAddress2,UpdOrgCity:orgcity,UpdOrgState:orgstate,UpdOrgCountry:updCountry,UpdOrgPinCode:updOrgPinCode}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Store Details Updated Successfully</h2>"); 
	                    location.reload(); 
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
	            url: "updateOrg",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
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
	 $("#modal-body").html("<h2>In Process</h2>");
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
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Type Of Sale</p>');
		$("#AddMerchantDetails").show();
		return false;
	}if(onBoardingStatus==null||onBoardingStatus==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select OnBoarding Status</p>');
		$("#AddMerchantDetails").show();
		return false;
	}if(verificationEntryDate==null||verificationEntryDate==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Verification Entry Date</p>');
		$("#AddMerchantDetails").show();
		return false;
	}

	
	if(merchantName==null||merchantName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Name</p></n>Length should be min 2 and max 60 char');
		return false;
	}else if(merchantName.length<2||merchantName.length>60){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Correct Format</p></n>Length should be min 2 and max 60 char');
		return false;
	}else if(businessType=='Business Type'){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Business Type</p>');
		return false;
	}else if(businessType=='Others'){
	var other=$("#other").val();
	if(other==null||other==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Type Other</p>');
		return false;
	}else if(other.length<2||other.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Type</p></n>Length should be min 2 and max 50 char');
		   return false;
	}
	}else if(merchantType==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Merchant Type</p>');
		return false;
	}
	if(executiveName!=null&&executiveName!='' ){
		if(executiveName.length<2||executiveName.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Executive Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}
	}
	
	else if(directorsName==null||directorsName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Proprietor/Director/Partner Name</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(directorsName.length<2||directorsName.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Proprietor/Director/Partner Name</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(authorizedSignatory==null||authorizedSignatory==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Authorized Signatory</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(authorizedSignatory.length<2||directorsName.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Authorized Signatory</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(businessNature==null||businessNature==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Nature</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(businessNature.length<2||businessNature.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Nature</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(BusinessCode==null||BusinessCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Code</p>');
		return false;
	}else if(MarketingName==null||MarketingName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Marketing Name</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(MarketingName.length<2||MarketingName.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Marketing Name</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(businessAddress1==null||businessAddress1==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessAddress1.length<2||businessAddress1.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessAddress2==null||businessAddress2==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessAddress2.length<2||businessAddress2.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(businessState==null||businessState==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Business State</p>');
		return false;
	}else if(businessState.length<2||businessState.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business State</p>');
		return false;
	}else if(businessCity==null||businessCity==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Business City</p>');
		return false;
	}else if(businessCity.length<2||businessCity.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business City</p>');
		return false;
	}else if(businessPinCode==null||businessPinCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(businessPinCode.length!=6){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(personalAddress1==null||personalAddress1==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalAddress1.length<2||personalAddress1.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal Address1</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalAddress2==null||personalAddress2==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalAddress2.length<2||personalAddress2.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal Address2</p></n>Length should be min 2 and max 100 char');
		return false;
	}else if(personalState==null||personalState==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal State</p>');
		return false;
	}else if(personalState.length<2||personalState.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal State</p>');
		return false;
	}else if(personalCity==null||personalCity==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal City</p>');
		return false;
	}else if(personalCity.length<2||personalCity.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal City</p>');
		return false;
	}else if(personalPinCode==null||personalPinCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(personalPinCode.length!=6){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal PinCode</p></n>Length should be 6 digits');
		return false;
	}else if(country==null||country==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Country</p>');
		return false;
	}else if(country!='INDIA'){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Country</p>');
		return false;
	}else if(phoneNo==null||phoneNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Phone No</p></n>Phone No Length should be 10 digits');
		return false;
	}else if(phoneNo.length<10||phoneNo.length>54){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Phone No</p></n>Phone No Length should be 10 digits</n>Add Many Phone No with comma(,) Separeted');
		return false;
	}else if(webSiteUrl!=null&&webSiteUrl!=''){
		var re = /(http(s)?:\\)?([\w-]+\.)+[\w-]+[.com|.in|.org]+(\[\?%&=]*)?/
		if(webSiteUrl.length>=100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct WebSite Url</p></n>Length should be less than 100 char');
			return false;
		}else if(re.test(webSiteUrl)==false){
			 $("#modal-body").html('<h2>Validation Error</h2><p>website url Should be in proper format</p>');
			  return false;
		}
	}else if(emailId!=null&&emailId!=''){
		var re =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(emailId.length>100){
			console.log("email length is > 100");
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p>');
			return false;
		}else if(re.test(emailId)==false){			
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length should be less than 100 char');
			return false;
	    }
	}else if(tinNo!=null&&tinNo!=''&&tinNo.length!=11){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Tin No</p></n>Length should be 11 digits');
		return false;
	}else if(serviceTaxNo!=null&&serviceTaxNo!=''&&serviceTaxNo.length!=15){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Service Tax No</p></n>Length should be 15 digits');
		return false;
	}else if(note!=null&&note!=''&&note>200){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Note</p></n>Length should be less than 200 char');
		return false;
	}else if(verificationStatus==null||verificationStatus==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Verification Status</p>');
		return false;
	}else if(verificationStatus.length<3||verificationStatus.length>25){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Verification Status</p>');
		return false;
	}
	if(modeofpayment=="Swipe")
	{
		if(swipeAmount==null||swipeAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter swipeAmount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(swipeAmount.length<1||swipeAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Swipe Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(swipeAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Swipe Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}else if(SwipeDate==null||SwipeDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter SwipeDate</p>');
			return false;
		}else if(swipeTerminal==null||swipeTerminal==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter swipeTerminal</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(swipeTerminal.length<2||swipeTerminal.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Swipe Terminal</p>');
			return false;
		}
	}
	else if(modeofpayment=="Cheque")
	{
		if(chequeNo==null||chequeNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeNo</p></n>Length should be min 1 and max 10 char');
			return false;
		}else if(chequeNo.length<1||chequeNo.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque No</p></n>Length should be min 1 and max 10 char');
			return false;
		}else if(chequeAmount==null||chequeAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cheque Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(chequeAmount.length<1||chequeAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(chequeAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Cheque Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}else if(chequeDate==null||chequeDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeDate</p>');
			return false;
		}else if(chequeDepositDate==null||chequeDepositDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeDepositDate</p>');
			return false;
		}else if(chequeBank==null||chequeBank==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cheque Bank Name</p></n>Length should be min 1 and max 50 char');
			return false;
		}else if(chequeBank.length<1||chequeBank.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque Bank Name</p></n>Length should be min 1 and max 50 char');
			return false;
		}
	}
else if(modeofpayment=="Cash")
	{
		if(cashDate==null||cashDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cash Date</p>');
			return false;
		}else if(cashAmount==null||cashAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cash Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(cashAmount.length<1||cashAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cash Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(cashAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Cash Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}
	}else if(modeofpayment=="NEFT"){
		if(neftAmount==null||neftAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter neft Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(neftAmount.length<1||neftAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct neft Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(neftAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>neft Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
		}else if(neftDate==null||neftDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter neft Date</p>');
			return false;
		}else if(neftchequeNo==null&&neftRefNo==null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Neft chequeNo OR Ref chequeNo</p></n>Length should be min 1 and max 10 char');
			return false;
		}else if(neftchequeNo==""&&neftRefNo==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Neft chequeNo OR Ref chequeNo</p></n>Length should be min 1 and max 10 char');
			return false;
		}
	}
// if(merchantType=="credit")

if((merchantType=="credit"|| merchantType=="wallet/credit")&&verificationStatus=="Activated"){
	if(bankMid==null&&bankMid==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank MId</p></n>Length should be min 15 and max 45 char');
		return false;
	}else if(bankMid.length<15||bankMid.length>45){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Mid</p></n>Length should be min 15 and max 45 char');
		return false;
	}
}
/*	else if(merchantType=="wallet/credit")
 {
	 if(deviceSerialNo==null||deviceSerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Device Serial No</p></n>Length should be min 8 and max 17 char');
			return false;
		}else if(deviceSerialNo.length<8||deviceSerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Device Serial No</p></n>Length should be min 8 and max 17 char');
			return false;
		}else if(bankMid==null&&bankMid==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank MId</p></n>Length should be min 15 and max 45 char');
			return false;
		}else if(bankMid.length<15||bankMid.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Mid</p></n>Length should be min 15 and max 45 char');
				return false;
		}
	 }*/
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
                    $("#modal-body").html("<h2>Merchant Updated Successfully</h2>");  
                    location.reload(); 
                } else if (data.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (obj.message.startsWith('Invalid')) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");                    
                }else if (obj.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");                    
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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

 var document11;
 function onFileSelectedDocument1(event) {
	 document11 = event.target.files[0];
         var reader = new FileReader();
         var imgtag = document.getElementById("document1");
         imgtag.title = document11.name;
         reader.onload = function(event) {
             imgtag.src = event.target.result;
         };
         reader.readAsDataURL(document11);               
 }
 
 var document22;
 function onFileSelectedDocument2(event) {
	 document22 = event.target.files[0];
         var reader = new FileReader();
         var imgtag = document.getElementById("document2");
         imgtag.title = document22.name;
         reader.onload = function(event) {
             imgtag.src = event.target.result;
         };
         reader.readAsDataURL(document22);      
 }
 var document33;
 function onFileSelectedDocument3(event) {
	 document33 = event.target.files[0];
         var reader = new FileReader();
         var imgtag = document.getElementById("document3");
         imgtag.title = document33.name;
         reader.onload = function(event) {
             imgtag.src = event.target.result;
         };
         reader.readAsDataURL(document33);      
 }
 var document44;
 function onFileSelectedDocument4(event) {
	 document44 = event.target.files[0];
         var reader = new FileReader();
         var imgtag = document.getElementById("document4");
         imgtag.title = document44.name;
         reader.onload = function(event) {
             imgtag.src = event.target.result;
         };
         reader.readAsDataURL(document44);             
 }


 function isNodalAlphaNumericName(evt) {	
		try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32|| charCode==95 || charCode==44 ){
	    	   return true;
	    	}else{
	    	   return false;
	    	}
	    }catch (err) {
	    	alert(err.Description);
	   	}
	}

 function isNodalAlphaNumericName1(evt) {	
		try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32){
	    	   return true;
	    	}else{
	    	   return false;
	    	}
	    }catch (err) {
	    	alert(err.Description);
	   	}
	}

 function isNodalAlphaNumericName2(evt) {	
		try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32 || charCode==95){
	    	   return true;
	    	}else{
	    	   return false;
	    	}
	    }catch (err) {
	    	alert(err.Description);
	   	}
	}
 function isNodalBenBankName(evt) {	
		try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	    	if ((charCode > 64 && charCode < 91)||(charCode > 96 && charCode < 123)||charCode>47&&charCode<58||charCode ==45 ||charCode ==32){
	    	   return true;
	    	}else{
	    	   return false;
	    	}
	    }catch (err) {
	    	alert(err.Description);
	   	}
	}
 
 function isNodalAlphaRemarks(evt) {	
		try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	    	if ((charCode > 64 && charCode < 91)||(charCode > 96 && charCode < 123)||charCode>47&&charCode<58||charCode ==44 || charCode ==45||charCode ==95){
	    	   return true;
	    	}else{
	    	   return false;
	    	}
	    }catch (err) {
	    	alert(err.Description);
	   	}
	}
	
 function isNodalAlphaNumericName3(evt) {	
		try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58){
	    	   return true;
	    	}else{
	    	   return false;
	    	}
	    }catch (err) {
	    	alert(err.Description);
	   	}
	}


 function nodalUpdDetails(){
		$("#modal-body").html("<h2>In Process</h2>");
		var nodalTid=$("#nodalTid").val();
	    var nodalMerchantId=$("#nodalMerchantId").val();
		var nodalOrgId=$("#nodalOrgId").val();
		var nodalUserId=$("#nodalUserId").val();
		var banCorpId =$("#banCorpId").val();
		var benIfsc =$("#benIfsc").val();
		var benAccNo =$("#benAccNo").val();
		var nodalBenName =$("#nodalBenName").val();
		var benAddress =$("#benAddress").val();		
		var benState =$("#benState").val();
		var benCity =$("#benCity").val();
		var benPinCd =$("#benPinCd").val();
		var benDob =$("#benDob").val();
		var benBankName =$("#benBankName").val();
		var modeOfPay = $("#nodalModeOfPay").val();
		//var benBankCd =$("#benBankCd").val();
		//var benBranchCd =$("#benBranchCd").val();
		var benEmail =$("#benEmail").val();
		var benMobile =$("#benMobile").val();
		var benTrnParticulars =$("#benTrnParticulars").val();
		var benTrnsRmks =$("#benTrnsRmks").val();
		//var issueBranchCd =$("#issueBranchCd").val();
		var benPan =$("#benPan").val();
		//var benUid =$("#benUid").val();
		var benType =$("#benType").val();
		var benId =$("#benId").val();
		var limitDaily =$("#limitDaily").val();
		var limitWeekly =$("#limitWeekly").val();
		var limitMonthly =$("#limitMonthly").val();
		var document1 = document.getElementById("document1");
		var document2 = document.getElementById("document2");
		var document3 = document.getElementById("document3");
		var document4 = document.getElementById("document4");
		if (document11 != undefined) {
			document1=document11;
		}
		if (document22 != undefined) {
			document2=document22;
		}
		if (document33 != undefined) {
			document3=document33;
		}
		if (document44 != undefined) {
			document4=document44;
		}  

		if(benIfsc==null||benIfsc==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary IFSC</p></n>Length should be min 2 and max 15 char');
			return false;
		}else if(benIfsc.length<2||benIfsc.length>15){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary IFSC Correct Format</p></n>Length should be min 2 and max 15 char');
			return false;
		}
		if(benAccNo==null||benAccNo==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Account No</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(benAccNo.length<2||benAccNo.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Account No Correct Format</p></n>Length should be min 2 and max 50 char');
			return false;
		}
		else if(nodalBenName==null||nodalBenName==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(nodalBenName.length<2||nodalBenName.length>60){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name Correct Format</p></n>Length should be min 2 and max 50 char');
			return false;
		}
		else if(benAddress==null||benAddress==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Address</p></n>Length should be min 2 and max 200 char');
			return false;
		}else if(benAddress.length<2||benAddress.length>200){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Address Correct Format</p></n>Length should be min 2 and max 200 char');
			return false;
		}
		else if(benDob==null||benDob==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary DOB</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benDob.length<2||benDob.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary DOB Correct Format</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benDob!=null&&benDob!=''){
			var regEx = /^\d{4}-\d{2}-\d{2}$/;
			if(regEx.test(benDob)==false){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary DOB Correct Format</p></n>Date should be in YYYY-MM-DD format');
				return false;
			}	
		}else if(benType==null||benType ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Type</p></n>Length should be less than 10 char');
			return false;
		}else if(benType.length<2||benType.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Type Correct Format</p></n>Length should be less than 10 char');
			return false;
		}else if(benBankName==null||benBankName==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Bank Name</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benBankName.length<2||benBankName.length>20){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Bank Name Correct Format</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benBankCd==null||benBankCd==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary BankCD</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benBranchCd==null||benBranchCd==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary BranchCD</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benEmail!=null&&benEmail!=''){
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			console.log('re.test(benEmail): '+re.test(benEmail));
			if(benEmail.length>100){
				console.log("email length is > 100");
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p>');
				return false;
			}else if(re.test(benEmail)==false){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length should be less than 100 char');
				return false;
		    }
		}else if(benMobile==null||benMobile ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Mobile</p></n>Length should be 10 char');
			return false;
		}else if(benMobile.length<10||benMobile.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Mobile Correct Format</p></n>Length should be 10 char');
			return false;
		}else if(benTrnParticulars==null||benTrnParticulars ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary TrnParticulars</p></n>Length should be less than 50 char');
			return false;
		}else if(benTrnParticulars.length<2||benTrnParticulars.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary TrnParticulars Correct Format</p></n>Length should be less than 50 char');
			return false;
		}else if(benTrnsRmks==null||benTrnsRmks ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Txn Remark</p></n>Length should be less than 50 char');
			return false;
		}else if(benTrnsRmks.length<4||benTrnsRmks.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Txn Remark Correct Format</p></n>Length should be less than 50 char');
			return false;
		}else if(issueBranchCd.length<3||issueBranchCd.length>20){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Issue Branch Code Correct Format</p></n>Length should be less than 20 char');
			return false;
		}else if(benType==null||benType ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Type</p></n>Length should be less than 10 char');
			return false;
		}else if(benType.length<2||benType.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Type Correct Format</p></n>Length should be less than 10 char');
			return false;
		}
		else if(benPan==null||benPan ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct PAN</p></n>First 5 char should be Capital letter Alphabet, Next four should be digit and last should be Aplphabet');
			return false;
		}else if(benPan!=null&&benPan!=''){
			var re = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
			console.log('re.test(benPan): '+re.test(benPan));
			if(benPan.length>10&&benPan.length<10){
				console.log("PAN length is > 10");
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct PAN</p></n>First 5 char should be Capital letter Alphabet, Next four should be digit and last should be Aplphabet');
				return false;
			}else if(re.test(benPan)==false){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct PAN</p></n>First 5 char should be Capital letter Alphabet, Next four should be digit and last should be Aplphabet');
				return false;
		    }
		}else if(limitDaily==null||limitDaily ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Daily</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitWeekly==null||limitWeekly ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Weekly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitMonthly==null||limitMonthly ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Monthly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitDaily.length<1||limitDaily.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Daily</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitWeekly.length<1||limitWeekly.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Weekly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitMonthly.length<1||limitMonthly.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Monthly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}
	var frmData = new FormData();
	frmData.append("nodalTid", nodalTid);
	frmData.append("nodalMerchantId", nodalMerchantId);
	frmData.append("nodalOrgId", nodalOrgId);
	frmData.append("nodalUserId",nodalUserId);
	frmData.append("benIfsc", benIfsc);
	frmData.append("benAccNo",benAccNo);
	frmData.append("nodalBenName",nodalBenName);
	frmData.append("benAddress",benAddress);
	frmData.append("modeOfPay",modeOfPay);
	frmData.append("benCity",benCity);
	frmData.append("benState",benState);
	frmData.append("benPinCd",benPinCd);
	
	frmData.append("benDob",benDob);
	frmData.append("benBankName",benBankName);
	//frmData.append("benBankCd",benBankCd);
	//frmData.append("benBranchCd",benBranchCd);
	frmData.append("benEmail",benEmail);
	frmData.append("benMobile",benMobile);
	frmData.append("benTrnParticulars",benTrnParticulars);
	frmData.append("benTrnsRmks",benTrnsRmks);
	//frmData.append("issueBranchCd",issueBranchCd);
	frmData.append("benPan",benPan);
	//frmData.append("benUid",benUid);
	frmData.append("benType",benType);
	frmData.append("benId",benId);
	frmData.append("limitDaily",limitDaily);
	frmData.append("limitWeekly",limitWeekly);
	frmData.append("limitMonthly",limitMonthly);	
	console.log("qqqq::+"+document11);
	if (document11 != undefined) {
		frmData.append("document1", document11);
	}
	if (document22 != undefined) {
		frmData.append("document2", document22);
	}
	if (document33 != undefined) {
		frmData.append("document3", document33);
	}
	if (document44 != undefined) {
		frmData.append("document4", document44);
	}
	//console.log("hello "+frmData);
	var opts = {
		type: "POST",
       	success: function (data) {
           	alert('111111111');
           	var obj = JSON.parse(data);
            if (obj.status == 0&&obj.message=='OK') {
            	$("#modal-body").html("<h2>Nodal Ben Updated Successfully</h2>");  
                //location.reload(); 
            }else if (obj.message=='Schema Validation Failure') {
            	$("#modal-body").html("<h2>Schema Validation Failure from rbl </h2>");  
               	//  location.reload(); 
            } else if (obj.status==111) {
                 $("body").attr("onload","noBack();");
                 $("body").attr("onpageshow","if (event.persisted) noBack();");
                 $("body").attr("onunload","");
                 window.location.href="logout.jsp";
             }else if (obj.message=='Ben Account already exists') {
                 $("#modal-body").html("<h2>"+obj.message+"</h2>");                    
             }else if (obj.message=='RBL Serve Not Responding') {
                 $("#modal-body").html("<h2>"+obj.message+"</h2>");                    
             }else if (obj.message.startsWith('Invalid')) {
                 $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");                    
             }else if (obj.status==100) {
                 $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");                    
             } else {
                 $(".loading").css("visibility", "hidden");
                 $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
         mimeType:"multipart/form-data",
		    contentType: false,
	      	cache: false,
	       	processData:false,
	       	url: "addBenDetail",
         data: frmData           
     }; 
     $.ajax(opts);
     return false;
}

 
 function nodalAddDetails(){
		$("#modal-body").html("<h2>In Process</h2>");		
		var nodalTid=$("#nodalTid").val();
	    var nodalMerchantId=$("#nodalMerchantId").val();
		var nodalOrgId=$("#nodalOrgId").val();
		var nodalUserId=$("#nodalUserId").val();
		var banCorpId =$("#banCorpId").val();
		var benIfsc =$("#benIfsc").val();
		var benAccNo =$("#benAccNo").val();
		var nodalBenName =$("#nodalBenName").val();
		var benAddress =$("#benAddress").val();
		var benCity =$("#benCity").val();
		var benState =$("#benState").val();
		var benPinCd =$("#benPinCd").val();
		var benDob =$("#benDob").val();
		var benBankName =$("#benBankName").val();
		var modeOfPay = $("#nodalModeOfPay").val();
		//var benBankCd =$("#benBankCd").val();
		//var benBranchCd =$("#benBranchCd").val();
		var benEmail =$("#benEmail").val();
		var benMobile =$("#benMobile").val();
		var benTrnParticulars =$("#benTrnParticulars").val();
		var benTrnsRmks =$("#benTrnsRmks").val();
		//var issueBranchCd =$("#issueBranchCd").val();
		var benPan =$("#benPan").val();
		//var benUid =$("#benUid").val();
		var benType =$("#benType").val();
		var benId =$("#benId").val();
		var limitDaily =$("#limitDaily").val();
		var limitWeekly =$("#limitWeekly").val();
		var limitMonthly =$("#limitMonthly").val();
		
		
		var document1 = document.getElementById("document1");
		var document2 = document.getElementById("document2");
		var document3 = document.getElementById("document3");
		var document4 = document.getElementById("document4");
		if (document11 != undefined) {
			document1=document11;
		}
		if (document22 != undefined) {
			document2=document22;
		}
		if (document33 != undefined) {
			document3=document33;
		}
		if (document44 != undefined) {
			document4=document44;
		}  
		if(benIfsc==null||benIfsc==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary IFSC</p></n>Length should be min 2 and max 15 char');
			return false;
		}else if(benIfsc.length<2||benIfsc.length>15){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary IFSC Correct Format</p></n>Length should be min 2 and max 15 char');
			return false;
		}
		if(benAccNo==null||benAccNo==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Account No</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(benAccNo.length<2||benAccNo.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Account No Correct Format</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(nodalBenName==null||nodalBenName==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(nodalBenName.length<2||nodalBenName.length>60){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name Correct Format</p></n>Length should be min 2 and max 50 char');
			return false;
		}else if(benAddress==null||benAddress==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Address</p></n>Length should be min 2 and max 200 char');
			return false;
		}else if(benAddress.length<2||benAddress.length>200){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Address Correct Format</p></n>Length should be min 2 and max 200 char');
			return false;
		}else if(benDob==null||benDob==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary DOB</p></n>Date should be in YYYY-MM-DD format');
			return false;
		}else if(benDob.length<2||benDob.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary DOB Correct Format</p></n>Date should be in YYYY-MM-DD format');
			return false;
		}else if(benDob!=null&&benDob!=''){
			var regEx = /^\d{4}-\d{2}-\d{2}$/;
			if(regEx.test(benDob)==false){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary DOB Correct Format</p></n>Date should be in YYYY-MM-DD format');
				return false;
			}	
		}else if(benBankName==null||benBankName==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Bank Name</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benBankName.length<2||benBankName.length>20){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Bank Name Correct Format</p></n>Length should be min 2 and max 20 char');
			return false;
		}else if(benEmail!=null&&benEmail!=''){
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			console.log('re.test(benEmail): '+re.test(benEmail));
			if(benEmail.length>100){
				console.log("email length is > 100");
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p>');
				return false;
			}else if(re.test(benEmail)==false){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length should be less than 100 char');
				return false;
		    }
		}else if(benMobile==null||benMobile ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Mobile</p></n>Length should be 10 char');
			return false;
		}else if(benMobile.length<10||benMobile.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Mobile Correct Format</p></n>Length should be 10 char');
			return false;
		}else if(benTrnParticulars==null||benTrnParticulars ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary TrnParticulars</p></n>Length should be less than 50 char');
			return false;
		}else if(benTrnParticulars.length<2||benTrnParticulars.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary TrnParticulars Correct Format</p></n>Length should be less than 50 char');
			return false;
		}
		else if(benTrnsRmks==null||benTrnsRmks ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Txn Remark</p></n>Length should be less than 50 char');
			return false;
		}else if(benTrnsRmks.length<4||benTrnsRmks.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Txn Remark Correct Format</p></n>Length should be less than 50 char');
			return false;
		}else if(benType==null||benType ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Type</p></n>Length should be less than 10 char');
			return false;
		}else if(benType.length<2||benType.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Type Correct Format</p></n>Length should be less than 10 char');
			return false;
		}else if(benPan==null||benPan ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct PAN</p></n>First 5 char should be Capital letter Alphabet, Next four should be digit and last should be Aplphabet');
			return false;
		}else if(benPan!=null&&benPan!=''){
			var re = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
			console.log('re.test(benPan): '+re.test(benPan));
			if(benPan.length>10&&benPan.length<10){
				console.log("PAN length is > 10");
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct PAN</p></n>First 5 char should be Capital letter Alphabet, Next four should be digit and last should be Aplphabet');
				return false;
			}else if(re.test(benPan)==false){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct PAN</p></n>First 5 char should be Capital letter Alphabet, Next four should be digit and last should be Aplphabet');
				return false;
		    }
		}else if(limitDaily==null||limitDaily ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Daily</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitWeekly==null||limitWeekly ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Weekly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitMonthly==null||limitMonthly ==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Monthly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitDaily.length<1||limitDaily.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Daily</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitWeekly.length<1||limitWeekly.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Weekly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}else if(limitMonthly.length<1||limitMonthly.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct limit Monthly</p></n>Length should be min 1 and max 8 digits');
			return false;
		}
 	var frmData = new FormData();
 	
 	frmData.append("nodalTid", nodalTid);
 	frmData.append("nodalMerchantId", nodalMerchantId);
 	frmData.append("nodalOrgId", nodalOrgId);
 	frmData.append("nodalUserId",nodalUserId);
 	frmData.append("benIfsc", benIfsc);
 	frmData.append("benAccNo",benAccNo);
 	frmData.append("nodalBenName",nodalBenName);
 	frmData.append("benAddress",benAddress);
 	frmData.append("benCity",benCity);
	frmData.append("benState",benState);
	frmData.append("benPinCd",benPinCd);
 	frmData.append("benDob",benDob);
 	frmData.append("benBankName",benBankName);
 	frmData.append("modeOfPay",modeOfPay);
 	
 	//frmData.append("benBankCd",benBankCd);
 	//frmData.append("benBranchCd",benBranchCd);
 	frmData.append("benEmail",benEmail);
 	frmData.append("benMobile",benMobile);
 	frmData.append("benTrnParticulars",benTrnParticulars);
 	frmData.append("benTrnsRmks",benTrnsRmks);
	//frmData.append("issueBranchCd",issueBranchCd);
	frmData.append("benPan",benPan);
	//frmData.append("benUid",benUid);
	frmData.append("benType",benType);
	frmData.append("benId",benId);
	frmData.append("limitDaily",limitDaily);
	frmData.append("limitWeekly",limitWeekly);
	frmData.append("limitMonthly",limitMonthly);
	
	//console.log("qqqq::+"+document11);
	if (document11 != undefined) {
		frmData.append("document1", document11);
	}
	if (document22 != undefined) {
		frmData.append("document2", document22);
	}
	if (document33 != undefined) {
		frmData.append("document3", document33);
	}
	if (document44 != undefined) {
		frmData.append("document4", document44);
	}
	//console.log("hello "+frmData);
	var opts = {
			type: "POST",
            success: function (data) {
            var obj = JSON.parse(data);
             //  alert(obj.message);
               if (obj.status == 0&&obj.message=='OK') {
                    $("#modal-body").html("<h2>Nodal Beneficiary Updated Successfully</h2>");  
                    //location.reload();
               }else if (obj.message=='Success') {
               		$("#modal-body").html("<h2>Nodal Beneficiary Updated Successfully </h2>");  
           	  		//location.reload();
         	   }else if (obj.message=='Incorrect Mapping') {
               		$("#modal-body").html("<h2>Rbl has an issue, Incorrect Mapping</h2>");  
           	  		//location.reload();
         	   }else if (obj.message=='Beneficary cannot be modified as pervious request is in progress') {
               		$("#modal-body").html("<h2>Beneficary cannot be modified as pervious request is in progress</h2>");  
           	  		//location.reload();
         	   }else if (obj.message=='NEFT Weekly limit cannot be greater than Monthly limit') {
                	$("#modal-body").html("<h2>NEFT Weekly limit cannot be greater than Monthly limit</h2>");  
                 	 // location.reload();
               }else if (obj.message=='NEFT Daily limit cannot be greater then weekly limit') {
               		$("#modal-body").html("<h2>NEFT Daily limit cannot be greater then weekly limit</h2>");  
           	  		//location.reload();
         	   }else if (obj.message=='Schema Validation Failure') {
                	$("#modal-body").html("<h2>Schema Validation Failure from rbl </h2>");  
                   	//  location.reload();
               } else if (obj.message=='Ben Account already exists for the given Seller ID, modify API to update details') {
                	$("#modal-body").html("<h2>Ben Account already exists for the given Seller ID, modify API to update details</h2>");  
                 	//  location.reload();
               }else if (obj.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (obj.message=='Ben Account already exists') {
                    $("#modal-body").html("<h2>"+obj.message+"</h2>");                    
                }else if (obj.message=='RBL Serve Not Responding') {
                    $("#modal-body").html("<h2>"+obj.message+"</h2>");                    
                }
                else if (obj.message=='Invalid') {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");                    
                }else if (obj.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");                    
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
            mimeType:"multipart/form-data",
		    contentType: false,
	      	cache: false,
	       	processData:false,
	       	url: "addBenDetail",
            data: frmData           
        }; 
        $.ajax(opts);
        return false;
}
 
 
function updDeviceDetails(){
	$("#modal-body").html("<h2>In Process</h2>");
	if($("#mdrZero").is(":checked") == true) {
		var mdrZero = "1";
	}else{
		var mdrZero = "0";
	}
	if($("#loanStatus").is(":checked") == true) {
		var loanStatus = "1";
	}else{
		var loanStatus = "0";
	}	
	if($("#userStatus").is(":checked") == true) {
		var userStatus = "0";
	}else{
		var userStatus = "1";
	}
	if($("#loyaltyStatus").is(":checked") == true) {
		var loyaltyStatus = "1";
	}else{
		var loyaltyStatus = "0";
	}
	if($("#closeWalletStatus").is(":checked") == true) {
		var closeWalletStatus = "1";
	}else{
		var closeWalletStatus = "0";
	}
	if($("#txnSmsStatus").is(":checked") == true) {
		var txnSmsStatus = "0";
	}else{
		var txnSmsStatus = "1";
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
	var bankAccountNo = $("#bankAccNumber").val();
	var bankName = $("#bankName").val();
	var benefName=$("#benefName").val();
	var bankAccountType = $("#bankAccType").val();
	var bankIfsc = $("#bankIfsc").val();
	var bankMicr = $("#bankMicr").val();
	var DeviceID = $("#DeviceID").val();
	var BankTid = $("#BankTid").val();
	var SerialNo = $("#SerialNo").val();
	var validTil = $("#validTil").val();
	var Rent = $("#Rent").val();
	var PaymentMode = $("#PaymentMode").val();
	var pendingRent = $("#pendingRent").val();
	var Name = $("#DName").val();
	var rmn = $("#rmn").val();
	var loginId = $("#DLoginId").val();
	var EmailId = $("#UserEmailId").val();
	var MdrDebit0 = $("#MdrDebit0").val();
	var MdrDebit1 = $("#MdrDebit1").val();
	var MdrDebit2 = $("#MdrDebit2").val();
	var MdrCreditPre = $("#MdrCreditPre").val();
	var MdrCreditNpre = $("#MdrCreditNpre").val();
	var MdrAmex = $("#mdrAmex").val();
	var Other = $("#Other").val();
	var mdrCashAtPos = $("#mdrCashAtPos").val();
	var updateAmexActivated = $("#AmexActivated").val();
	var updateAmexTID = $("#amexTID").val();
	var updateAmexMID = $("#amexMID").val();
	var bankBranch = $("#bankBranch").val();
	//var userType=$("#userType").val();	
	var mobiKwik=$("#mobiKwik").val();
	var penaltyAmount=$("#penaltyAmount").val();
	var discount=$("#discount").val();
	var avgTxnAmount = $("#avgTxnAmount").val();
	var integrationKey = $("#integrationKey").val();
	var penaltyReason = $("#penaltyReason").val();
	var discountReason = $("#discountReason").val();
	var loanType = $("#loanType").val();
	var loandedAmount = $("#loanDedAmount").val();
//	var loanamountPayout = $("#loanAmountPayout").val();
	var loanIfsc = $("#loanIfsc").val();
	var loanBankName = $("#loanBankName").val();
	var loanAccount = $("#loanAccount").val();
	var activationDate = $("#upActivationDate").val();
	var planName = $("#upPlanName").val();
	var feeModel = $("#upFeeMode").val();
	var feeDate = $("#upFeeDate").val();
	var feeAmount = $("#upFeeAmount").val();
	var feeRemarks = $("#upFeeRemarks").val();
	var switchType = $("#upswitchType").val();
	var midTidEntryDate = $("#midTidEntryDate").val();
	var wlcmLtrSendDate = $("#wlcmLtrSendDate").val();
	var settlementCharges=$("#settlementCharges").val();
	
	var maxValue = 100;
	if($("#rechargeServiceEnable").is(":checked") == true) {
		var rechargeServiceEnable = "1";
	}else{
		var rechargeServiceEnable = "0";
	}
	var rechargeBal=$("#rechargeBal").val();
	var rechargeIncentive=$("#rechargeIncentive").val();
	var rechargeMonthlyRental=$("#rechargeMonthlyRental").val();
	
	var regex="^[0-9]{1,8}[\\.]{1}[0-9]{0,2}?$";
	
	if(rechargeServiceEnable == "1"){
	 if(rechargeBal==null||rechargeBal==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Balance</p>');
			$("#AddDeviceDetails").show();
			return false;
		}
	 if(rechargeIncentive==null||rechargeIncentive==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Incentive</p>');
			$("#AddDeviceDetails").show();
			return false;
		}
	 if(rechargeMonthlyRental==null||rechargeMonthlyRental==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Monthly Rental</p>');
			$("#AddDeviceDetails").show();
			return false;
		}
	}
	if(loanStatus == "1"){
		console.log("bbbbbbbbb::"+loanStatus);
		if(loanType==null||loanType==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Select Loan Type</p>');
			return false;
		}else if(loandedAmount==null||loandedAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Loan Deduction Amount/Percentage</p>');
			return false;
		}else if(loanType=="fixed"){
		if(loandedAmount.length<1||loandedAmount.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Loan Deduction Amount </p></n>Length should be 8 digits');
				return false;
		}}else if(loanType=="percentage"){
		if(loandedAmount>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Loan Deduction Percentage </p></n>Length should be not Greater Than 100');
				return false;
		}}
		else if(loanAccount==null||loanAccount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Loan Bank Account Number</p></n>Length should be min 6 max 30 char');
			return false;
		}else if(loanAccount.length<6||loanAccount.length>30){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Loan Bank Account Number</p></n>Length should be min 6 max 30 char');
			return false;
		}else if(loanBankName==null||loanBankName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Loan Bank Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(loanBankName.length<1||loanBankName.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Loan  Bank Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(loanIfsc==null||loanIfsc==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Loan Bank IFSC</p></n>Length should be 11 char');
			return false;
		}else if(loanIfsc.length<11||loanIfsc.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Loan Correct Bank IFSC</p</n>Length should be 11 char>');
			return false;
		}
		}
		else if(loginId==null||loginId==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Login Id</p></n>Length should be 10 digits');
			return false;
		}else if(loginId.length<10||loginId.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Login Id</p></n>Length should be 10 digits');
			return false;
		}else if(rmn==null||rmn==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter RMN</p></n>Length should be 10 digits');
			return false;
		}else if(rmn.length<10||rmn.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct RMN</p></n>Length should be 10 digits');
			return false;
		}else if(UserEmailId!=null&&UserEmailId!=''&&UserEmailId.length>100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length less than 100 digits');
			return false;
		}else if(Name==null||Name==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(Name.length<1||Name.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(validTil==null||validTil==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Enter Valid till Date');
			return false;
		}else if(Rent==null||Rent==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(Rent.length<1||Rent.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(PaymentMode==null||PaymentMode==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Payment Mode</p>');
			return false;
		}else if(PaymentMode.length<=2||PaymentMode.length>100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Payment Mode</p>');
			return false;
		}else if(pendingRent==null||pendingRent==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(pendingRent.length<1||pendingRent.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(avgTxnAmount==null|| avgTxnAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter avgTxnAmount</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(avgTxnAmount.length<1|| avgTxnAmount.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct avgTxnAmount</p></n>Length should be min 1 max 8 char');
			return false;
		}
	if(userType=="wallet")
	{
	 if(mobiKwik==null||mobiKwik==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Wallet MDR</p></n>value must be less than 100');
		return false;
	}else if(mobiKwik>=maxValue){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Wallet MDR</p></n>value must be less than 100');
		return false;
	}
	}
	if(userType=="credit")
	{
		if(SerialNo==null||SerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(SerialNo.length<8||SerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(BankTid==null||BankTid==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank TID</p></n>Length should be 8 char');
			return false;
		}else if(BankTid.length<8||BankTid.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Tid</p></n>Length should be 8 char');
			return false;
		}
		else if(MdrDebit0==null||MdrDebit0==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit0</p></n>value must be less than 100');
			return false;
		}
		else if(MdrDebit0>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit0</p></n>value must be less than 100');
			return false;
		}
		else if(MdrDebit1==null||MdrDebit1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit1</p></n>value must be less than 100');
			return false;
		}
		else if(MdrDebit1>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit1</p></n>value must be less than 100');
			return false;
		}

		else if(MdrDebit2==null||MdrDebit2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(MdrDebit2>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditPre==null||MdrCreditPre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditPre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditNpre==null||MdrCreditNpre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditNpre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(Other==null||Other==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter International Card</p></n>value must be less than 100');
			return false;
		}else if(Other>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct International Card</p></n>value must be less than 100');
			return false;
		}else if(mdrCashAtPos==null||mdrCashAtPos==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter CashAtPos</p></n>value must be less than 100');
			return false;
		} if(mobiKwik==null||mobiKwik==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Wallet MDR</p></n>value must be less than 100');
			return false;
		}else if(mobiKwik>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Wallet MDR</p></n>value must be less than 100');
			return false;
		}else if(updateAmexActivated==null||updateAmexActivated==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Choose Amex Activated</p>');
			return false;
		}
		if(updateAmexActivated=="YES"){
			if(MdrAmex==null||MdrAmex==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Amex</p>');
				return false;
			}else if(MdrAmex>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Amex</p>');
				return false;
			}else if(updateAmexTID==null&&updateAmexTID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(updateAmexTID.length<8||updateAmexTID.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(updateAmexMID==null&&updateAmexMID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex MID</p></n>Length should be min 15 max 45 char');
				return false;
			}else if(updateAmexMID.length<10||updateAmexMID.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex MID</p></n>Length should be min 10 max 45 char');
				return false;
			}
		}
	}else if(userType=="wallet/credit"){
	  if(MdrDebit0==null||MdrDebit0==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit0</p></n>value must be less than 100');
			return false;
		}
		else if(MdrDebit0>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit0</p></n>value must be less than 100');
			return false;
		}
		if(SerialNo==null||SerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(SerialNo.length<8||SerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(BankTid==null||BankTid==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank TID</p></n>Length should be 8 char');
			return false;
		}else if(BankTid.length<8||BankTid.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Tid</p></n>Length should be 8 char');
			return false;
		}else if(MdrDebit1==null||MdrDebit1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit1</p></n>value must be less than 100');
			return false;
		}else if(MdrDebit1>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit1</p></n>value must be less than 100');
			return false;
		}else if(MdrDebit2==null||MdrDebit2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(MdrDebit2>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditPre==null||MdrCreditPre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditPre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditNpre==null||MdrCreditNpre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(MdrCreditNpre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(Other==null||Other==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter International Card</p></n>value must be less than 100');
			return false;
		}else if(Other>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct International Card</p></n>value must be less than 100');
			return false;
		}else if(mdrCashAtPos==null||mdrCashAtPos==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter CashAtPos</p></n>value must be less than 100');
			return false;
		}else if(updateAmexActivated==null||updateAmexActivated==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Choose Amex Activated</p>');
			return false;
		}
		if(updateAmexActivated=="YES")
		{
			if(MdrAmex==null||MdrAmex==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Amex</p>');
				return false;
			}else if(MdrAmex>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Amex</p>');
				return false;
			}else if(updateAmexTID==null&&updateAmexTID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(updateAmexTID.length<8||updateAmexTID.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(updateAmexMID==null&&updateAmexMID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex MID</p></n>Length should be min 15 max 45 char');
				return false;
			}else if(updateAmexMID.length<10||updateAmexMID.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex MID</p></n>Length should be min 10 max 45 char');
				return false;
			}
		}
	}else if(bankAccType==null||bankAccType==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Account Type</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(bankAccType.length<1||bankAccType.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Account Type</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(bankAccNumber==null||bankAccNumber==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Account Number</p></n>Length should be min 6 max 30 char');
			return false;
		}else if(bankAccNumber.length<6||bankAccNumber.length>30){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Account Number</p></n>Length should be min 6 max 30 char');
			return false;
		}else if(bankName==null||bankName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(bankName.length<1||bankName.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct  Bank Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(benefName==null||benefName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name</p></n>Length should be min 1 and max 45 char');
			return false;
		}else if(benefName.length<1||benefName.length>45){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Beneficiary Name</p></n>Length should be min 1 and max 45 char');
			return false;
		}else if(bankBranch==null||bankBranch==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Branch</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(bankBranch.length<1||bankBranch.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct  Bank Branch</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(bankIfsc==null||bankIfsc==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank IFSC</p></n>Length should be 11 char');
			return false;
		}else if(bankIfsc.length<11||bankIfsc.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank IFSC</p</n>Length should be 11 char>');
			return false;
		}else if(bankMicr==null||bankMicr==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank MICR</p></n>Length should be min 9 max 15 char');
			return false;
		}else if(bankMicr.length<9||bankMicr.length>15){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank MICR</p></n>Length should be min 9 max 15 char');
			return false;
		}
	if(penaltyAmount!=null&&penaltyAmount!=''){
		 if(penaltyAmount.length<1||penaltyAmount.length>8){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct penalty Amount</p></n>Length should be min 1 and max 8 digits');
		return false;
	 }
	}if(discount!=null&&discount!=''){
		 if(discount.length<1||discount.length>8){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Discount</p></n>Length should be min 1 and max 8 digits');
		return false;
	}}
	else if(integrationKey!=null&&integrationKey!=''&&integrationKey.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Integration Key</p></n>Length should be less than 100 char');
		return false;
	}
	
	var sendvalue={bankAccountNo:bankAccountNo,bankName:bankName,bankAccountType:bankAccountType,bankIfsc:bankIfsc,bankMicr:bankMicr,DeviceID:DeviceID,BankTid:BankTid,SerialNo:SerialNo,validTil:validTil,Rent:Rent,PaymentMode:PaymentMode,pendingRent:pendingRent,Name:Name,rmn:rmn,loginId:loginId,EmailId:EmailId,MdrDebit1:MdrDebit1,MdrDebit2:MdrDebit2,MdrCreditPre:MdrCreditPre,MdrCreditNpre:MdrCreditNpre,MdrAmex:MdrAmex,Other:Other,mdrCashAtPos:mdrCashAtPos,updateAmexActivated:updateAmexActivated,updateAmexTID:updateAmexTID,updateAmexMID:updateAmexMID,branchName:bankBranch,userType:userType,mdrMobiKwik:mobiKwik,penaltyAmount:penaltyAmount,discount:discount,avgTxnAmount:avgTxnAmount,userStatus:userStatus, benefName:benefName,penaltyReason:penaltyReason,discountReason:discountReason,loyaltyStatus:loyaltyStatus,closeWalletStatus:closeWalletStatus,txnSmsStatus:txnSmsStatus,integrationKey:integrationKey,
	loanStatus:loanStatus,loanType:loanType,loanDedAmount:loandedAmount,loanBankName:loanBankName,loanBankAccNo:loanAccount,loanBankIfsc:loanIfsc,mdrZero:mdrZero,MdrDebit0:MdrDebit0,activationDate:activationDate,planName:planName,feeModel:feeModel,feeDate:feeDate,feeAmount:feeAmount,feeRemarks:feeRemarks, switchType:switchType,midTidEntryDate:midTidEntryDate,wlcmLtrSendDate:wlcmLtrSendDate,settlementCharges:settlementCharges,rechargeServiceEnable:rechargeServiceEnable,
	rechargeBal:rechargeBal,rechargeIncentive:rechargeIncentive,rechargeMonthlyRental:rechargeMonthlyRental,ppcServiceEnable:ppcServiceEnable,dmtServiceEnable:dmtServiceEnable,dthMobileServiceEnable:dthMobileServiceEnable
	}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK'){
	                    $("#modal-body").html("<h2>Terminal Details Updated Successfully</h2>"); 
	                    location.reload();
	                } else if (data.status==111){
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if(data.status==100){
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
	            url: "updatedevicedetails",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}

function deleteDeviceConfirm(userId,orgId){
	if (confirm("Do you want to delete device details ?") == true) {
		var sendvalue={userId:userId,orgId:orgId}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Terminal Details Deleted Successfully</h2>"); 
	                    location.reload(); 
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
	            url: "devicedelete",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}else{
		return false;
	}
}

function isDecimal(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( charCode == 46 || (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37)){
	  return false;
	 }
	}
	function isNumberKey(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37)){
	  return false;
	 }
	}
function deleteOrgConfirm(orgId){
	if (confirm("Do you want to delete Store details ?") == true) {
		var sendvalue={orgId:orgId}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Store Details Deleted Successfully</h2>"); 
	                    location.reload(); 
	                } else if (data.status==111) {
	                    //onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload=""
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
	            url: "deleteorg",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;

	}else{
		return false;
	}
}
function onOffSamePhone() {
	if($("#sameUserId").is(":checked") == true) {
	  var devicephone=$("#DLoginId").val();
		$("#rmn").val(devicephone);
		
	}else{
	 	$("#rmn").val('');
	}
}
function addressValidation(evt) {
	 try {
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
	
	        /*if (window.event) {
	            var charCode = window.event.keyCode;
	        }
	        else if (e) {
	            var charCode = e.which;
	        }
	        else { return true; }*/
	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32||charCode==33||charCode==35||charCode==40||charCode==41||charCode==45||charCode==46||charCode==47||charCode==58||charCode==44||charCode==95){
	            return true;
	 		}else{
	            return false;
	 		}
	    }
	    catch (err) {
	        alert(err.Description);
	    }
}
function isAlphaNumericBankType(evt) {	
	try {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
   		/*if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }*/
    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==37|| charCode==46|| charCode==40|| charCode==41|| charCode==47){
    	     return true;
		}else{
	    	 return false;
		}
    }catch (err) {
    	alert(err.Description);
   	}
}
function isAlphaNumeric(evt) {	
	try {
   		/*if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }*/
    	evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==37|| charCode==46|| charCode==40|| charCode==41||charCode==45||charCode==46||charCode==47||charCode==58||charCode==44||charCode==95||charCode==38)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}
function isAlphaNumericWithoutSpace(evt) {
	try {
   		/*if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }*/
    	evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58||charCode==8||charCode==37)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}
function isNumberKeyWithComa(evt){
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
    if ((charCode > 47 && charCode < 58 )|| charCode == 44||charCode==8||charCode==37){
        return true;
    }
    return false;
}

function onOffCloneSamePhone() {
	if($("#clonesameUserId").is(":checked") == true) {
	  var devicephone=$("#cloneDLoginId").val();
		$("#clonermn").val(devicephone);
		
	}else{
	 	$("#clonermn").val('');
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

function createCloneDevice(){
	$("#modal-body").html("<h2>In Process</h2>");
	
	if($("#cloneRechargeServiceEnable").is(":checked") == true) {
		var cloneRechargeServiceEnable = "1";
	}else{
		var cloneRechargeServiceEnable = "0";
	}
	var clonemerchantId=$("#cloneMerchantId").val();
	var cloneorgId=$("#cloneOrgId").val();
	var clonebankAccountNo = $("#clonebankAccNumber").val();
	var clonebankName = $("#clonebankName").val();
	var clonebenefName=$("#clonebenefName").val();
	var clonebankAccountType = $("#clonebankAccType").val();
	var clonebankIfsc = $("#clonebankIfsc").val();
	var clonebankMicr = $("#clonebankMicr").val();
	//var cloneDeviceID = $("#cloneDeviceID").val();
	var cloneBankTid = $("#cloneBankTid").val();
	var cloneSerialNo = $("#cloneSerialNo").val();
	var clonevalidTil = $("#clonevalidTil").val();
	var cloneRent = $("#cloneRent").val();
	var clonePaymentMode = $("#clonePaymentMode").val();
	var clonependingRent = $("#clonependingRent").val();
	var clonePenaltyAmount = $("#clonePenaltyAmount").val();
	var cloneDiscount = $("#cloneDiscount").val();
	var cloneAvgTxnAmount = $ ("#cloneAvgTxnAmount"). val ();
	var cloneName = $("#cloneDName").val();
	var clonermn = $("#clonermn").val();
	var cloneloginId = $("#cloneDLoginId").val();
	var cloneEmailId = $("#cloneUserEmailId").val();
	var cloneMdrDebit0 = $("#cloneMdrDebit0").val();
	var cloneMdrDebit1 = $("#cloneMdrDebit1").val();
	var cloneMdrDebit2 = $("#cloneMdrDebit2").val();
	var cloneMdrCreditPre = $("#cloneMdrCreditPre").val();
	var cloneMdrCreditNpre = $("#cloneMdrCreditNpre").val();
	var cloneMdrAmex = $("#clonemdrAmex").val();
	var cloneOther = $("#cloneOther").val();
	var clonemdrCashAtPos = $("#clonemdrCashAtPos").val();
	var cloneupdateAmexActivated = $("#cloneAmexActivated").val();
	var cloneupdateAmexTID = $("#cloneamexTID").val();
	var cloneupdateAmexMID = $("#cloneamexMID").val();
	var clonebankBranch = $("#clonebankBranch").val();
	var cloneuserType=$("#cloneuserType").val();	
	var clonemobiKwik=$("#clonemobiKwik").val();
	var cloneSettlementCharges=$("#cloneSettlementCharges").val();
	var cloneIntegrationKey=$("#cloneIntegrationKey").val();
	var clonePenaltyReason=$("#clonePenaltyReason").val();
	var cloneDiscountReason=$("#cloneDiscountReason").val();
	var planName=$("#planName").val();
	var feeMode=$("#feeMode").val();
	var feeAmount=$("#feeAmount").val();
	var feeDate=$("#feeDate").val();
	var feeRemarks=$("#feeRemarks").val();
	var switchType="ACQ";
	var cloneWlcmLtrSendDate=$("#cloneWlcmLtrSendDate").val();
	var cloneMidTidEntryDate=$("#cloneMidTidEntryDate").val();
	var cloneRechargeBal=$("#cloneRechargeBal").val();
	var cloneRechargeIncentive=$("#cloneRechargeIncentive").val();
	var clonerechargeMonthlyRental=$("#clonerechargeMonthlyRental").val();
	
	var maxValue = 100;
	
	if(cloneRechargeServiceEnable!="0"){
		 if(cloneRechargeBal==null||cloneRechargeBal==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Balance</p>');
				$("#AddDeviceDetails").show();
				return false;
		 }
		 if(cloneRechargeIncentive==null||cloneRechargeIncentive==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Incentive</p>');
				$("#AddDeviceDetails").show();
				return false;
			}
		 if(clonerechargeMonthlyRental==null||clonerechargeMonthlyRental==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Recharge Monthly Rental</p>');
				$("#AddDeviceDetails").show();
				return false;
			}
		}
	if(cloneloginId==null||cloneloginId==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Login Id</p></n>Length should be 10 digits');
			return false;
		}else if(cloneloginId.length<10||cloneloginId.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Login Id</p></n>Length should be 10 digits');
			return false;
		}else if(clonermn==null||clonermn==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter RMN</p></n>Length should be 10 digits');
			return false;
		}else if(clonermn.length<10||clonermn.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct RMN</p></n>Length should be 10 digits');
			return false;
		}else if(cloneUserEmailId!=null&&UserEmailId!=''&&UserEmailId.length>100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length less than 100 digits');
			return false;
		}else if(cloneName==null||cloneName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(cloneName.length<1||cloneName.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonevalidTil==null||clonevalidTil==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Enter Valid till Date');
			return false;
		}else if(cloneRent==null||cloneRent==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(cloneRent.length<1||cloneRent.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(clonePaymentMode==null||clonePaymentMode==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Payment Mode</p>');
			return false;
		}else if(clonePaymentMode.length<=2||clonePaymentMode.length>100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Payment Mode</p>');
			return false;
		}else if(clonependingRent==null||clonependingRent==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}else if(clonependingRent.length<1||clonependingRent.length>8){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Rent</p></n>Length should be min 1 max 8 char');
			return false;
		}
	if(cloneuserType=="wallet")
	{
	 if(clonemobiKwik==null||clonemobiKwik==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Wallet MDR </p></n>value must be less than 100');
		return false;
	}else if(clonemobiKwik>=maxValue){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Wallet MDR</p></n>value must be less than 100');
		return false;
	}
	}
	if(cloneuserType=="credit"){
		if(cloneSerialNo==null||cloneSerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(cloneSerialNo.length<8||cloneSerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(cloneMdrDebit0==null||cloneMdrDebit0==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit0</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit0>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit0</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit1==null||cloneMdrDebit1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit1</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit1>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit1</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit2==null||cloneMdrDebit2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit2>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditPre==null||cloneMdrCreditPre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditPre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditNpre==null||cloneMdrCreditNpre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditNpre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneOther==null||cloneOther==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter International Card</p></n>value must be less than 100');
			return false;
		}else if(cloneOther>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct International Card</p></n>value must be less than 100');
			return false;
		}if(clonemdrCashAtPos ==null||clonemdrCashAtPos ==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter clonemdrCashAtPos </p>');
			return false;
		} if(clonemobiKwik==null||clonemobiKwik==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Wallet MDR</p></n>value must be less than 100');
			return false;
		}else if(clonemobiKwik>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Wallet MDR</p></n>value must be less than 100');
			return false;
		}else if(cloneupdateAmexActivated==null||cloneupdateAmexActivated==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Choose Amex Activated</p>');
			return false;
		}
		if(cloneupdateAmexActivated=="YES"){
			if(cloneMdrAmex==null||cloneMdrAmex==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Amex</p>');
				return false;
			}else if(cloneMdrAmex>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Amex</p>');
				return false;
			}else if(cloneupdateAmexTID==null&&updateAmexTID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(cloneupdateAmexTID.length<8||cloneupdateAmexTID.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(cloneupdateAmexMID==null&&updateAmexMID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex MID</p></n>Length should be min 15 max 45 char');
				return false;
			}else if(cloneupdateAmexMID.length<10||cloneupdateAmexMID.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex MID</p></n>Length should be min 10 max 45 char');
				return false;
			}
		}
	}
	else if(cloneuserType=="wallet/credit")
	{
		if(cloneSerialNo==null||cloneSerialNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(cloneSerialNo.length<8||cloneSerialNo.length>17){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 max 17 digits');
			return false;
		}else if(cloneMdrDebit0==null||cloneMdrDebit0==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit0</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit0>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit0</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit1==null||cloneMdrDebit1==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit1</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit1>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit1</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit2==null||cloneMdrDebit2==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrDebit2>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Debit2</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditPre==null||cloneMdrCreditPre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditPre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditNpre==null||cloneMdrCreditNpre==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneMdrCreditNpre>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Credit Non Premium</p></n>value must be less than 100');
			return false;
		}else if(cloneOther==null||cloneOther==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter International Card</p></n>value must be less than 100');
			return false;
		}else if(cloneOther>=maxValue){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct International Card</p></n>value must be less than 100');
			return false;
		}if(clonemdrCashAtPos ==null||clonemdrCashAtPos ==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Clone MDR CashAtPos </p>');
			return false;
		}else if(cloneupdateAmexActivated==null||cloneupdateAmexActivated==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Choose Amex Activated</p>');
			return false;
		}
		if(cloneupdateAmexActivated=="YES"){
			if(cloneMdrAmex==null||cloneMdrAmex==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Mdr Amex</p>');
				return false;
			}else if(cloneMdrAmex>=maxValue){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Mdr Amex</p>');
				return false;
			}else if(cloneupdateAmexTID==null&&updateAmexTID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(cloneupdateAmexTID.length<8||cloneupdateAmexTID.length>8){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex TID</p></n>Length should be 8 char');
				return false;
			}else if(cloneupdateAmexMID==null&&updateAmexMID==''){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Amex MID</p></n>Length should be min 15 max 45 char');
				return false;
			}else if(cloneupdateAmexMID.length<10||cloneupdateAmexMID.length>45){
				$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amex MID</p></n>Length should be min 10 max 45 char');
				return false;
			}
		}
	}
		else if(clonebankAccType==null||clonebankAccType==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Account Type</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonebankAccType.length<1||clonebankAccType.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Account Type</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonebankAccNumber==null||clonebankAccNumber==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Account Number</p></n>Length should be min 6 max 30 char');
			return false;
		}else if(clonebankAccNumber.length<6||clonebankAccNumber.length>30){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank Account Number</p></n>Length should be min 6 max 30 char');
			return false;
		}else if(clonebankName==null||clonebankName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonebankName.length<1||clonebankName.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct  Bank Name</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonebenefName==null||clonebenefName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Beneficiary Name</p></n>Length should be min 1 and max 45 char');
			return false;
		}else if(clonebenefName.length<1||clonebenefName.length>45){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Beneficiary Name</p></n>Length should be min 1 and max 45 char');
			return false;
		}else if(clonebankBranch==null||clonebankBranch==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank Branch</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonebankBranch.length<1||clonebankBranch.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct  Bank Branch</p></n>Length should be min 1 max 50 char');
			return false;
		}else if(clonebankIfsc==null||clonebankIfsc==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank IFSC</p></n>Length should be 11 char');
			return false;
		}else if(clonebankIfsc.length<11||clonebankIfsc.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank IFSC</p</n>Length should be 11 char>');
			return false;
		}else if(clonebankMicr==null||clonebankMicr==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Bank MICR</p></n>Length should be min 9 max 15 char');
			return false;
		}else if(clonebankMicr.length<9||clonebankMicr.length>15){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Bank MICR</p></n>Length should be min 9 max 15 char');
			return false;
		}
	if(clonePenaltyAmount!=null&&clonePenaltyAmount!=''){
		 if(clonePenaltyAmount.length<1||clonePenaltyAmount.length>8){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct penalty Amount</p></n>Length should be min 1 and max 8 digits');
		return false;
	 }
	}if(cloneDiscount!=null&&cloneDiscount!=''){
		 if(cloneDiscount.length<1||cloneDiscount.length>8){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Discount</p></n>Length should be min 1 and max 8 digits');
		return false;
	}}
	else if(cloneIntegrationKey!=null&&cloneIntegrationKey!=''&&cloneIntegrationKey.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Integration Key</p></n>Length should be less than 100 char');
		return false;
	}
	var sendvalue={MerchantId:clonemerchantId,
			OrgId:cloneorgId,
			BankTid:cloneBankTid,
			userType:cloneuserType,
			SerialNo:cloneSerialNo,
			accountNo:clonebankAccountNo,
			bankName:clonebankName,
			branchName:clonebankBranch,
			accountType:clonebankAccountType,
			bankIfsc:clonebankIfsc,
			bankMicr:clonebankMicr,
			rent:cloneRent,
			PaymentMode:clonePaymentMode,
			Name:cloneName,
			loginId:cloneloginId,
			rmn:clonermn,
			EmailId:cloneEmailId,
			mdrMobiKwik:clonemobiKwik,
			MdrDebit1:cloneMdrDebit1,
			MdrDebit2:cloneMdrDebit2,
			MdrCreditPre:cloneMdrCreditPre,
			MdrCreditNpre:cloneMdrCreditNpre,
			MdrAmex:cloneMdrAmex,
			Other:cloneOther,
			mdrCashAtPos:clonemdrCashAtPos,
			amexActivated:cloneupdateAmexActivated,
			amexTID:cloneupdateAmexTID,
			amexMID:cloneupdateAmexMID,
			validTil:clonevalidTil,
			pendingRent:clonependingRent,
			penaltyAmount:clonePenaltyAmount,
			discount:cloneDiscount,
			avgTxnAmount: cloneAvgTxnAmount,
			benefName:clonebenefName,
			discountReason:cloneDiscountReason,
			penaltyReason:clonePenaltyReason,
			integrationKey:cloneIntegrationKey,	
			MdrDebit0:cloneMdrDebit0,
			planName:planName,
			feeAmount:feeAmount,
			feeModel:feeMode,
			feeDate:feeDate,
			feeRemarks:feeRemarks,
			switchType:switchType,
			wlcmLtrSendDate:cloneWlcmLtrSendDate,
			midTidEntryDate:cloneMidTidEntryDate,
			settlementCharges:cloneSettlementCharges,
			rechargeServiceEnable:cloneRechargeServiceEnable,
			rechargeBal:cloneRechargeBal,rechargeIncentive:cloneRechargeIncentive,rechargeMonthlyRental:clonerechargeMonthlyRental
		}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Terminal Created Successfully</h2>"); 
	                    $("#cloneSerialNo").val('');
	                    $("#cloneDLoginId").val('');
	                    location.reload(); 
	                } else if (data.status==111) {
	                    //onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload=""
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                } else {
	                    $(".loading").css("visibility", "hidden");
	                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
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
	            url: "addDeviceDetail",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}	
function setCloneDeviceDetails(cloneOrgId,clonedeviceId,clonebankTId,clonevalidTil,clonerent,clonepaymentMode,clonependingRent,clonePenaltyAmount,cloneDiscount,cloneAvgTxnAmount,cloneuserName,clonermn,cloneuserEmail,clonemdrDebit1,clonemdrDebit2,clonemdrCreditPre,clonemdrCreditNpre,clonemdrAmex,cloneother,clonemdrCashAtPos,cloneamexCreated,cloneamexTID,cloneamexMID,clonebankAccName,clonebankAccNo,clonebankName,clonebankIfsc,clonebankMicr,clonebankBranch,clonemdrMobiKwik,cloneuserType,cashatpos,clonebenefName,clonePenaltyReason,cloneDiscountReason,cloneIntegrationKey,cloneMdrDebit0,activationDate,planName,feeMode,feeAmount,feeDate,feeRemark,cloneMidTidEntryDate,cloneWlcmLtrSendDate){
	$("#cloneOrgId").val(cloneOrgId);
	$("#cloneDeviceID").val(clonedeviceId);
	//$("#cloneBankTid").val(clonebankTId);
	//$("#cloneSerialNo").val(cloneserialNo);
	$("#clonevalidTil").val(clonevalidTil);
	$("#cloneRent").val(clonerent);

	$("#cloneWlcmLtrSendDate").val(cloneWlcmLtrSendDate);
		$("#cloneMidTidEntryDate").val(cloneMidTidEntryDate);

	$("#clonePenaltyReason").val(clonePenaltyReason);
	$("#cloneDiscountReason").val(cloneDiscountReason);
	
	$('#clonePaymentMode option[value="' + clonepaymentMode + '"]').prop('selected', true);
	$("#clonependingRent").val(clonependingRent);
	$("#clonePenaltyAmount").val(clonePenaltyAmount);
	$("#cloneDiscount").val(cloneDiscount);
	$("#cloneAvgTxnAmount").val(cloneAvgTxnAmount);
	$("#cloneDName").val(cloneuserName);
//	$("#cloneDLoginId").val(cloneuserPhoneNo);
	$("#clonermn").val(clonermn);
	$("#cloneUserEmailId").val(cloneuserEmail);
	$("#clonePassword").val("password");
	$("#cloneMdrDebit0").val(cloneMdrDebit0);
	$("#cloneMdrDebit1").val(clonemdrDebit1);
	$("#cloneMdrDebit2").val(clonemdrDebit2);
	$("#cloneMdrCreditPre").val(clonemdrCreditPre);
	$("#cloneMdrCreditNpre").val(clonemdrCreditNpre);
	$("#clonemdrAmex").val(clonemdrAmex);
	$("#cloneOther").val(cloneother);	
	$("#clonemdrCashAtPos").val(clonemdrCashAtPos);
	$('#cloneAmexActivated option[value="' + cloneamexCreated + '"]').prop('selected', true);
	$("#cloneamexTID").val(cloneamexTID);
	$("#cloneamexMID").val(cloneamexMID);
	$("#clonebankAccType").val(clonebankAccName);
	$("#clonebankAccNumber").val(clonebankAccNo);
	$("#clonebankName").val(clonebankName);
	$("#clonebenefName").val(clonebenefName);
	$("#clonebankIfsc").val(clonebankIfsc);
	$("#clonebankMicr").val(clonebankMicr);
	$("#clonebankBranch").val(clonebankBranch);
	$("#clonemobiKwik").val(clonemdrMobiKwik);
	$("#cloneIntegrationKey").val(cloneIntegrationKey);
	$('#cloneuserType option[value="' + cloneuserType + '"]').prop('selected', true);	
	$('#planName option[value="' + planName + '"]').prop('selected', true);
	$('#feeMode option[value="' + feeMode + '"]').prop('selected', true);
	$("#feeAmount").val(feeAmount);
	$("#feeDate").val(feeDate);
	$("#feeRemarks").val(feeRemark);
	//$("#switchType").val(switchType);
	
	if(cloneuserType=="wallet")
	{
		$("#div_clonebankTid").hide();
		$("#div_cloneMdrDebit0").hide();
		$("#div_cloneMdrDebit1").hide();
		$("#div_cloneMdrDebit2").hide();
		$("#div_cloneMdrCreditPre").hide();
		$("#div_cloneMdrCreditNpre").hide();
		$("#div_cloneOther").hide();	
		$("#div_clonemdrCashAtPos").hide();
		$("#div_clonemobiKwikMdr").show();	
		$("#div_cloneamericanExpress").hide();	
		$("#div_cloneSerialNo").hide();	
	}
	else if(cloneuserType=="credit")
	{
		$("#div_clonebankTid").show();
		$("#div_cloneMdrDebit1").show();
		$("#div_cloneMdrDebit2").show();
		$("#div_cloneMdrCreditPre").show();
		$("#div_cloneMdrCreditNpre").show();
		$("#div_cloneOther").show();
		$("#div_cloneMdrDebit0").show();	
		$("#div_clonemdrCashAtPos").show();
		$("#div_clonemobiKwikMdr").hide();	
		$("#div_cloneamericanExpress").show();	
		$("#div_cloneSerialNo").show();	
	}
	else if(cloneuserType=="wallet/credit")
	{
		$("#div_clonebankTid").show();
		$("#div_cloneMdrDebit1").show();
		$("#div_cloneMdrDebit2").show();
		$("#div_cloneMdrCreditPre").show();
		$("#div_cloneMdrCreditNpre").show();
		$("#div_cloneOther").show();
		$("#div_cloneMdrDebit0").show();
		$("#div_clonemdrCashAtPos").show();
		$("#div_clonemobiKwikMdr").show();	
		$("#div_cloneamericanExpress").show();	
		$("#div_cloneSerialNo").show();	
	}
	if(cloneamexCreated=="NO")	
		{
		$("#div_clonemdrAmex").hide();
		$("#div_cloneamexTID").hide();
		$("#div_cloneamexMID").hide();
		}
	else if(cloneamexCreated=="YES")	
	{
	$("#div_clonemdrAmex").show();
	$("#div_cloneamexTID").show();
	$("#div_cloneamexMID").show();
	}	
	$('#cloneuserType option[value="' + cloneuserType + '"]').prop('selected', true);

	var sendvalue={accessKey:'dummy'}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                	var list =  data.result;
	                	$("#cloneSerialNo option:not([value=''])").remove();
		                for(var i=0;i<list.length;i++){
			                var x = document.getElementById("cloneSerialNo");
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

function onChangeCloneAmexActivated() {
	 var cloneAmexActivated = $("#cloneAmexActivated").val();
   if (cloneAmexActivated == "NO") 
   {
   	$("#div_clonemdrAmex").hide();
   	$("#div_cloneamexTID").hide();
   	$("#div_cloneamexMID").hide();    	      
  	}
  	else 
   {
  		$("#div_clonemdrAmex").show();
  		$("#div_cloneamexTID").show();
  		$("#div_cloneamexMID").show();
 	}
}

function onchangeCloneUserType() {
//var cloneuserType = $("#cloneuserType").val();
var cloneuserType;
if ($('#cloneuserType').is(":checked")){
	$("#cloneuserType").val('credit');
}else{
	$("#cloneuserType").val('notCredit');
    }
var cloneuserType = $("#cloneuserType").val();
   if (cloneuserType == "credit"){
   	$("#div_clonebankTid").show();
 //   $("#cloneBankTid").val(''); 
   	$("#div_clonemobiKwikMdr").hide();
   	$("#div_cloneOther").show();
   	$("#div_mdrCashAtPos").show();
   	$("#div_cloneMdrCreditNpre").show();
   	$("#div_cloneMdrCreditPre").show();
   	$("#div_cloneMdrDebit2").show();
   	$("#div_cloneMdrDebit0").show();
   	$("#div_cloneMdrDebit1").show(); 
   	$("#div_cloneamericanExpress").show();  
   	$("#div_cloneSerialNo").show();  	
   	$("#cloneSerialNo").val('');  
	var sendvalue={accessKey:'dummy'}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                	var list =  data.result;
                	$("#cloneSerialNo option:not([value=''])").remove();
	                for(var i=0;i<list.length;i++){
		                //console.log('mappppp: '+list[i]);
		                var x = document.getElementById("cloneSerialNo");
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
  	else if (cloneuserType == "wallet/credit") 
   {
  		$("#div_clonebankTid").show();
  //	    $("#cloneBankTid").val('');
  		$("#div_clonemobiKwikMdr").show();
  		$("#div_cloneOther").show();
  		$("#div_mdrCashAtPos").show();
  		$("#div_cloneMdrCreditNpre").show();
  		$("#div_cloneMdrCreditPre").show();
  		$("#div_cloneMdrDebit2").show();
  		$("#div_cloneMdrDebit1").show();
  		$("#div_cloneamericanExpress").show();
  		$("#div_cloneSerialNo").show(); 
  		$("#cloneSerialNo").val('');
  		$("#div_cloneMdrDebit0").show();
  		var sendvalue={accessKey:'dummy'}
  		var opts = {
  	            type: "POST",
  	            success: function (data) {
  	                $(".loading").css("visibility","hidden");
  	                if (data.status == 0&&data.message=='OK') {
  	                	var list =  data.result;
  	                	$("#cloneSerialNo option:not([value=''])").remove();
  		                for(var i=0;i<list.length;i++){
  			                var x = document.getElementById("cloneSerialNo");
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
 	else if (cloneuserType == "wallet") 
   {
 		$("#div_clonebankTid").hide();
 //	    $("#cloneBankTid").val('');
 		$("#div_clonemobiKwikMdr").show();
 		$("#div_cloneOther").hide();
 		$("#div_mdrCashAtPos").hide();
 		$("#div_cloneMdrCreditNpre").hide();
 		$("#div_cloneMdrCreditPre").hide();
 		$("#div_cloneMdrDebit2").hide();
 		$("#div_cloneMdrDebit1").hide();
 		$("#div_cloneamericanExpress").hide();
 		$("#div_cloneSerialNo").hide(); 
 		$("#div_cloneMdrDebit0").hide();
 	}
}
	</script>
	<script type="text/javascript">
    $(function () {
    	
        $("#BusinessType").change(function () {
              var bsnsstype = $("#BusinessType").val();
              if ($("#BusinessType").val() == "Others") {
                $("#dvOther").show();
             } else {
                $("#dvOther").hide();
            }
        });

        $("#modeofpayment").change(function () {
            var modeofpayment = $("#modeofpayment").val();
            if (modeofpayment == "Swipe") {
            	$("#div_swipeAmount").show();
            	$("#div_SwipeDate").show();
            	$("#div_swipeTerminal").show();
            	$("#div_chequeNo").hide();
            	$("#div_chequeAmount").hide();
            	$("#div_chequeDate").hide();
            	$("#div_chequeDepositDate").hide();
            	$("#div_chequeBank").hide();  
            	$("#div_cashAmount").hide();
            	$("#div_cashDate").hide();  
            	$("#div_neft").hide();
            	$("#div_neftDate").hide();  
            	$("#div_neftchequeNo").hide();
            	$("#div_neftRefNo").hide();       
            	$("#neftRefNo").val('');
            	$("#neftchequeNo").val('');
            	$("#neftDate").val('');
            	$("#neftAmount").val('');  
                $("#cashDate").val('');
                $("#cashAmount").val('');
                $("#chequeBank").val('');   
                $("#chequeDepositDate").val('');
                $("#chequeDate").val('');
                $("#chequeAmount").val('');
                $("#chequeNo").val('');
			}else if (modeofpayment == "Cheque") {
           		$("#div_swipeAmount").hide();
            	$("#div_SwipeDate").hide();
            	$("#div_swipeTerminal").hide();
            	$("#div_chequeNo").show();
           		$("#div_chequeAmount").show();
           		$("#div_chequeDate").show();
           		$("#div_chequeDepositDate").show();
           		$("#div_chequeBank").show();
           		$("#div_cashAmount").hide();
           		$("#div_cashDate").hide();

           		$("#div_neft").hide();
            	$("#div_neftDate").hide();  
            	$("#div_neftchequeNo").hide();
            	$("#div_neftRefNo").hide();
            	$("#neftRefNo").val('');$("#neftchequeNo").val('');$("#neftDate").val('');$("#neftAmount").val('');  
                $("#cashDate").val('');$("#cashAmount").val('');$("#swipeTerminal").val('');$("#SwipeDate").val('');  
                $("#swipeAmount").val('');
          	}else if (modeofpayment == "Cash"){
          		$("#div_swipeAmount").hide();
            	$("#div_SwipeDate").hide();
            	$("#div_swipeTerminal").hide();
            	$("#div_chequeNo").hide();
          		$("#div_chequeAmount").hide();
          		$("#div_chequeDate").hide();
          		$("#div_chequeDepositDate").hide();
          		$("#div_chequeBank").hide();
          		$("#div_cashAmount").show();
          		$("#div_cashDate").show();
          		$("#div_neft").hide();
            	$("#div_neftDate").hide();  
            	$("#div_neftchequeNo").hide();
            	$("#div_neftRefNo").hide();
            	$("#chequeBank").val('');$("#chequeDepositDate").val('');$("#chequeDate").val('');   
                $("#chequeAmount").val('');$("#chequeNo").val('');$("#neftRefNo").val('');$("#neftchequeNo").val('');  
                $("#neftDate").val('');$("#neftAmount").val('');$("#swipeTerminal").val('');$("#SwipeDate").val('');  
                $("#swipeAmount").val(''); 
          	}else if (modeofpayment == "NEFT"){
          		$("#div_swipeAmount").hide();
            	$("#div_SwipeDate").hide();
            	$("#div_swipeTerminal").hide();
            	$("#div_chequeNo").hide();
          		$("#div_chequeAmount").hide();
          		$("#div_chequeDate").hide();
          		$("#div_chequeDepositDate").hide();
          		$("#div_chequeBank").hide();
          		$("#div_cashAmount").hide();
          		$("#div_cashDate").hide();
          		$("#div_neft").show();
            	$("#div_neftDate").show();  
            	$("#div_neftchequeNo").show();
            	$("#div_neftRefNo").show();
            	$("#cashDate").val('');$("#cashAmount").val('');$("#chequeBank").val('');   
                $("#chequeDepositDate").val('');$("#chequeDate").val('');$("#chequeAmount").val('');$("#chequeNo").val('');
                $("#swipeTerminal").val('');$("#SwipeDate").val('');$("#swipeAmount").val('');             
          	}else if (modeofpayment == "Free"){
        		$("#div_swipeAmount").hide();
            	$("#div_SwipeDate").hide();
            	$("#div_swipeTerminal").hide();
            	$("#div_chequeNo").hide();
          		$("#div_chequeAmount").hide();
          		$("#div_chequeDate").hide();
          		$("#div_chequeDepositDate").hide();
          		$("#div_chequeBank").hide();
          		$("#div_cashAmount").hide();
          		$("#div_cashDate").hide();
          		$("#div_neft").hide();
            	$("#div_neftDate").hide();  
            	$("#div_neftchequeNo").hide();
            	$("#div_neftRefNo").hide();
            	$("#neftRefNo").val('');$("#neftchequeNo").val('');$("#neftDate").val('');   
                $("#neftAmount").val('');$("#cashDate").val('');$("#cashAmount").val('');$("#chequeBank").val('');   
                $("#chequeDepositDate").val('');$("#chequeDate").val('');$("#chequeAmount").val('');
                $("#chequeNo").val('');$("#swipeTerminal").val('');$("#SwipeDate").val('');$("#swipeAmount").val('');
           }
      	});
    });
   
    
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

function setAcqLoyaltyStatus(){
	//loyaltyStatus
	if ($('#loyaltyStatus').is(":checked")){
		$("#closeWalletStatus").prop( "checked", true );
	}		
}
function setAcqWalletStatus(){
	//closeWalletStatus
	if ($('#loyaltyStatus').is(":checked")){
		$("#closeWalletStatus").prop( "checked", true );
	}
	
}
function setRechargeServiceStatus(){
	if ($('#rechargeServiceEnable').is(":checked")){
		$("#div_rechargeServiceDetails").show();
	}else{
		$("#div_rechargeServiceDetails").hide();
		}
}

function setCloneRechargeServiceStatus(){
	if ($('#cloneRechargeServiceEnable').is(":checked")){
		$("#div_cloneRechargeServiceDetails").show();
	}else{
		$("#div_cloneRechargeServiceDetails").hide();
		}
}
</script>

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
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
					<input type="hidden" name="acquirerCode" id="acquirerCode" class="form-control"  value="${allMerchantDetails['acquirerCode']}" />
					
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
                       <select data-clear-btn="true" name="BusinessType" id="BusinessType" required="true" class="form-control">
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
                      <label for="phone">Phone</label>
                      <input type="number" class="form-control input-lg" id="phone" value="${empPhone}" placeholder="Enter Phone">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Password</label>
                      <input type="password" class="form-control input-lg" id="password" placeholder="Enter Password">
                    </div>
                  </div>


<div class="right_col" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>Merchant Details</h3>
			</div>
		</div>
		<div class="row">			
		<form class="form-horizontal form-label-left" >
				<input type="hidden" name="merchantId" id="merchantId"
					value="${allMerchantDetails['merchantId']}" />
<input type="hidden" name="acquirerCode" id="acquirerCode" class="form-control"  value="${allMerchantDetails['acquirerCode']}" />
				<div class="col-md-12 col-sm-12 col-xs-12">

					<!-- ----------------------------------------------------------------panels start----------------->

					<!-- ----------------------------------------------------------------Basic details----------------->
					<div class="x_panel">
						<div class="x_title">
							<h2>Basic Details</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<br />
							
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Merchant Name<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true"
										name="Name" id="Name" required="true" minlength="2"
										maxlength="50" loginRegex="true"
										value="${allMerchantDetails['merchantName']}"
										onkeypress="return isAlphaNumericName(event);" onPaste="return false"/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessType">Business Type<span class="required">*</span>
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									   <select data-clear-btn="true" name="BusinessType" id="BusinessType" required="true" class="form-control">
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
												<input type="text" class="form-control" id="other" />
											</div>
										</div>
								 </div>
							 </div>
							
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="DirectorsName">Proprietor /Partner Name /Director /Trustee Name<span
									class="required">*</span>
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true"
										name="DirectorsName" id="DirectorsName" required="true"
										value="${allMerchantDetails['directorsName']}" minlength="2"
										maxlength=100 onkeypress="return isAlphaNumericName(event);" onPaste="return false"
										 />
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="AuthorizedSignatory">Authorized Signatory<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true"
										name="AuthorizedSignatory" id="AuthorizedSignatory"
										value="${allMerchantDetails['authorizedSignatory']}"
										required="true" minlength="2"
										onkeypress="return isAlphaNumeric(event);" onPaste="return false"
										 />
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessNature">Business Nature<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true"
										value="${allMerchantDetails['businessNature']}"
										name="BusinessNature" id="BusinessNature" required="true"
										minlength="2" onkeypress="return isAlphaNumeric(event);" onPaste="return false"
										maxlength=50 />
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessCode">MCC Code<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select data-clear-btn="true" name="BusinessCode"
										id="BusinessCode" required="true" class="form-control">
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
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="PhoneNo">Phone No<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['phoneNo']}" data-clear-btn="true"
										name="PhoneNo" id="PhoneNo" digits="true"
										onkeypress='return isNumberKeyWithComa(event);' minlength="0"
										maxlength="54" onPaste="return false" />
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="MarketingName">Marketing Name<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true"
										name="MarketingName"
										value="${allMerchantDetails['marketingName']}"
										id="MarketingName" required="true" minlength="2"
										onkeypress="return isAlphaNumeric(event);" maxlength=50 onPaste="return false"
										/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="Websiteurl">Website Url</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input data-clear-btn="true" class="form-control"
										name="Websiteurl" value="${allMerchantDetails['webSiteUrl']}"
										id="Websiteurl" minlength="0" maxlength=100 onPaste="return false"/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="EmailId">Email Id</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="email" class="form-control"
										value="${allMerchantDetails['emailId']}" data-clear-btn="true"
										name="EmailId" id="EmailId" 
										maxlength="100" onPaste="return false"/>
								</div>
							</div>
						</div>
					</div>

<!-------------------------- panel business ---------------------------------------------------------->

					<div class="x_panel">
						<div class="x_title">
							<h2>Business Address Details</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>								
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<br />
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessAddress1">Business Address 1<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['businessAddress1']}"
										data-clear-btn="true" name="BusinessAddress1"
										id="BusinessAddress1" required="true" minlength="2"
										onkeypress="return addressValidation(event);" maxlength=100 onPaste="return false"
										 />
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessAddress2">Business Address 2<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['businessAddress2']}"
										data-clear-btn="true" name="businessAddress2"
										id="BusinessAddress2" required="true" minlength="2"
										onkeypress="return addressValidation(event);" maxlength=100 onPaste="return false"
										 />
								</div>
							</div>
							 <div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="Businessstate">Business State<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text"
										value="${allMerchantDetails['businessState']}"
										id="businessstate" name="businessstate" class="form-control" onPaste="return false">
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessCity">Business City<span class="required">*</span></label>
								
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" id="businesscity" name="businesscity"
										class="form-control"
										value="${allMerchantDetails['businessCity']}" onPaste="return false">
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="BusinessPinCode">Business Pincode<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['businessPincode']}"
										data-clear-btn="true" name="BusinessPinCode"
										id="BusinessPinCode" digits="true"
										onkeypress='return event.charCode >= 48 && event.charCode <= 57'
										minlength="0" maxlength="6" onPaste="return false"/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="Country">Country</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="INDIA" data-clear-btn="true"
										name="Country" id="Country" required="true" minlength="5"
										onkeypress="return onlyAlphabets(event);" maxlength=50
										 value="INDIA" onlyalpha="true"
										readonly="readonly" onPaste="return false"/>
								</div>
							</div>
						</div>
					</div>

<!--------------------------- panel personanal Address ----------------------------------------->
					<div class="x_panel">
						<div class="x_title">
							<h2>Personal Address Details</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">&nbsp;</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<div class="checkbox">
										<input type="checkbox"
											style="margin: 0 !important; position: relative !important"
											id="sameStateCity" name="sameStateCity"
											onchange="onOffSameAddress();"> Personal Address Same As Business Address
									</div>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="UserAddress1">Address 1<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['personalAddress1']}"
										data-clear-btn="true" name="UserAddress1" id="UserAddress1"
										required="true" minlength="2"
										onkeypress="return addressValidation(event);" maxlength=100
										/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="UserAddress2">Address 2<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['personalAddress2']}"
										data-clear-btn="true" name="UserAddress2" id="UserAddress2"
										required="true" minlength="2"
										onkeypress="return addressValidation(event);" maxlength=100 onPaste="return false"
										/>
								</div>
							</div>
							<div class="form-group percent-50" id="userstatedropdowndiv">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="userstate">State<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text"
										value="${allMerchantDetails['personalState']}" id="userstate" onPaste="return false"
										name="userstate" class="form-control">
								</div>
							</div>
							<div class="form-group percent-50" id="usercitydropdowndiv">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="UserCity">City<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" id="usercity" name="usercity" class="form-control"
										value="${allMerchantDetails['personalCity']}" onPaste="return false">
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="UserPinCode">Pincode<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['personalPincode']}"
										data-clear-btn="true" name="UserPinCode" id="UserPinCode"
										digits="true"
										onkeypress='return event.charCode >= 48 && event.charCode <= 57'
										minlength="0" maxlength="6" onPaste="return false"/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="Country">Country</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['country']}" data-clear-btn="true"
										name="Country" id="Country" required="true" minlength="5"
										onkeypress="return onlyAlphabets(event);" maxlength=50
										 value="INDIA" onlyalpha="true"
										readonly="readonly" onPaste="return false"/>
								</div>
							</div>
						</div>
					</div>
<!-------------------------------------------------- Taxation Details ---------------------------------->
					<div class="x_panel">
						<div class="x_title">
							<h2>Taxation Details</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<br />
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Tin No</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['tinNo']}" data-clear-btn="true"
										name="TinNo" id="TinNo" digits="true"
										onkeypress='return tinNoValidate(event);'
										minlength="0" maxlength="11" onPaste="return false"/>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="for="ServiceTaxNo">GST No </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['serviceTaxNo']}"
										data-clear-btn="true" name="ServiceTaxNo" id="ServiceTaxNo"
										minlength="0" maxlength=15
										onkeypress="return isAlphaNumericWithoutSpace(event);"
										alphanumeric="true" onPaste="return false"/>
								</div>
							</div>
						<%--  <div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="merchantType">Merchant Application Type<span class="required">*</span>
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									   <select data-clear-btn="true" name="merchantType" id="merchantType" required="true" class="form-control" onchange="callMeForHide();">
												<option value="" <c:if test="${allMerchantDetails['merchantType'] == ''}">Selected</c:if>>Choose option</option>
												<option <c:if test="${allMerchantDetails['merchantType'] == 'DMT'}">Selected</c:if> value="DMT"> DMT</option>
												<option <c:if test="${allMerchantDetails['merchantType'] == 'AEPS'}">Selected</c:if> value="AEPS"> AEPS</option>
												<option <c:if test="${allMerchantDetails['merchantType'] == 'PPC'}">Selected</c:if> value="PPC"> PPC</option>
												<option <c:if test="${allMerchantDetails['merchantType'] == 'DTH Recharge'}">Selected</c:if> value="DTH Recharge"> DTH Recharge</option>
												<option <c:if test="${allMerchantDetails['merchantType'] == 'Mobile Recharge'}">Selected</c:if> value="Mobile Recharge"> Mobile Recharge</option>
												 </select>
								 </div>
							 </div> --%>
						<div class="form-group percent-50" id="div_merchant" <c:if test="${allMerchantDetails['merchantType'] == 'wallet'}">style="display:none;"</c:if>>
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="for="ServiceTaxNo">Bank MID </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['bankMId']}" data-clear-btn="true"
										name="bankMid" id="bankMid" minlength="0" maxlength=45
										onkeypress="return isAlphaNumericWithoutSpace(event);"
										alphanumeric="true" onPaste="return false"/>
								</div>
						</div>
						</div>
					</div>


<!--------------------------------------- Payment Details ----------------------------------------->                                           
               <div class="x_panel" <c:if test="${allMerchantDetails['emprole1'] != '3'}">style="display:none;"</c:if> >
                                <div class="x_title">
                                    <h2> Payment Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                	   <div class="form-group percent-50" >
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Mode of Payment Collection<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
				                                    <select name="modeofpayment" id="modeofpayment1" class="form-control" readonly="readonly">
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Free'}">Selected</c:if> value="Free">Free</option>
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Swipe'}">Selected</c:if> value="Swipe">Swipe</option>
					                                    <option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Cheque'}">Selected</c:if> value="Cheque">Cheque</option>
					                                    <option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Cash'}">Selected</c:if> value="Cash">Cash</option>
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'NEFT'}">Selected</c:if> value="NEFT">Internet Payment Gateway(Online Transfer/NEFT)</option> 
				                                    </select>
				                            </div>
                                        </div>
                                                             
                                        <div class="form-group percent-50" id="div_swipeAmount1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if> >
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Amount</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" value="${allMerchantDetails['swipeAmount']}" data-clear-btn="true" name="swipeAmount" id="swipeAmount1" digits="true" onkeypress='return isDecimal(event)' minlength="0" maxlength="11" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_SwipeDate1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="SwipeDate1" >Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" value="${allMerchantDetails['swipeDate']}" readonly='true' data-role="date" data-clear-btn="true" name="SwipeDate" id="SwipeDate1" onkeypress="return false;" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_swipeTerminal1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="swipeTerminal">Swiped on the terminal of</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['swipeTerminal']}" name="swipeTerminal1" id="swipeTerminal1" minlength="0" maxlength=50 onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>   
                                        <div class="form-group percent-50" id="div_chequeNo1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeNo">Cheque No
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['chequeNo']}" name="chequeNo1" id="chequeNo1" minlength="0" maxlength=10 onkeypress="return isNumberKeyWithComa(event);" alphanumeric="true" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                       <div class="form-group percent-50" id="div_chequeAmount1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeAmount">Amount
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['chequeAmount']}" name="chequeAmount1" id="chequeAmount1" minlength="0" maxlength=11 onkeypress='return isDecimal(event)' alphanumeric="true" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_chequeDate1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeDate1">Cheque Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" readonly='true' onkeypress='return false;' value="${allMerchantDetails['chequeDate']}" name="chequeDate1" id="chequeDate1" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_chequeDepositDate1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeDepositDate1">Cheque Deposit Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" readonly='true' onkeypress='return false;' value="${allMerchantDetails['chequeDepositDate']}" name="chequeDepositDate1" id="chequeDepositDate1" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_chequeBank1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeBank">Bank Name
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['chequeBank']}" name="chequeBank1" id="chequeBank1" minlength="0" maxlength=50 onkeypress="return isAlphaNumeric(event);" alphanumeric="true" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>                                   
                                        <div class="form-group percent-50" id="div_cashAmount1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cash'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cashAmount">Amount
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['cashAmount']}" name="cashAmount1" id="cashAmount1" minlength="0" maxlength=11 onkeypress="return isDecimal(event)" alphanumeric="true" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_cashDate1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cash'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cashDate1">Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" readonly='true' value="${allMerchantDetails['cashDate']}" onkeypress='return false;' data-clear-btn="true" name="cashDate1" id="cashDate1" data-role="date" readonly="readonly" onPaste="return false"/>
                                            </div>
                                        </div>  
                                        <div class="form-group percent-50" id="div_neft1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Amount</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" data-clear-btn="true" name="neftAmount1" value="${allMerchantDetails['neftAmount']}" id="neftAmount1" digits="true" onkeypress='return isDecimal(event)' minlength="0" maxlength="11" readonly="readonly"/>
                                                </div>
                                            </div>
                                            <div class="form-group percent-50" id="div_neftDate1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"for="neftDate1">Date</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" value="${allMerchantDetails['neftDate']}" name="neftDate1" id="neftDate1" onkeypress='return false;' readonly='true' readonly="readonly"/>
                                                </div>
                                            </div>
                                             <div class="form-group percent-50" id="div_neftchequeNo1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"for="neftchequeNo">Cheque No
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="neftchequeNo1" value="${allMerchantDetails['neftchequeNo']}" id="neftchequeNo1" minlength="0" maxlength=10 onkeypress="return isNumberKeyWithComa(event);" digits="true" readonly="readonly"/>
                                                </div>
                                            </div>
                                            <div class="form-group percent-50" id="div_neftRefNo1" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"for="neftRefNo"> Ref/UTR. No.
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="neftRefNo1" value="${allMerchantDetails['neftRefNo']}" id="neftRefNo1" minlength="0" maxlength=15 onkeypress="return isNumberKeyWithComa(event);" digits="true" readonly="readonly"/>
                                                </div>
                                            </div>        
                                </div>                                               
                            </div>                                  

 <!--------------------------------------- Payment Details ----------------------------------------->                                           
               <div class="x_panel" <c:if test="${allMerchantDetails['emprole1'] == '3'}">style="display:none;"</c:if> >
                                <div class="x_title">
                                    <h2>Payment Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                	   <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Mode of Payment Collection<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
				                                    <select name="modeofpayment" id="modeofpayment" class="form-control">
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Free'}">Selected</c:if> value="Free">Free</option>
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Swipe'}">Selected</c:if> value="Swipe">Swipe</option>
					                                    <option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Cheque'}">Selected</c:if> value="Cheque">Cheque</option>
					                                    <option <c:if test="${allMerchantDetails['modeOfPayment'] == 'Cash'}">Selected</c:if> value="Cash">Cash</option>
														<option <c:if test="${allMerchantDetails['modeOfPayment'] == 'NEFT'}">Selected</c:if> value="NEFT">Internet Payment Gateway(Online Transfer/NEFT)</option> 
				                                    </select>
				                            </div>
                                        </div>                 
                                        <div class="form-group percent-50" id="div_swipeAmount" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if> >
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Amount</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" value="${allMerchantDetails['swipeAmount']}" data-clear-btn="true" name="swipeAmount" id="swipeAmount" digits="true" onkeypress='return isDecimal(event)' minlength="0" maxlength="11"  onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_SwipeDate" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="SwipeDate1" >Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" value="${allMerchantDetails['swipeDate']}" readonly='true' data-role="date" data-clear-btn="true" name="SwipeDate" id="SwipeDate" onkeypress="return false;" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_swipeTerminal" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Swipe'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="swipeTerminal">Swiped on the terminal of</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['swipeTerminal']}" name="swipeTerminal" id="swipeTerminal" minlength="0" maxlength=50 onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>   
                                        <div class="form-group percent-50" id="div_chequeNo" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeNo">Cheque No
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['chequeNo']}" name="chequeNo" id="chequeNo" minlength="0" maxlength=10 onkeypress="return isNumberKeyWithComa(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                       <div class="form-group percent-50" id="div_chequeAmount" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeAmount">Amount
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['chequeAmount']}" name="chequeAmount" id="chequeAmount" minlength="0" maxlength=11 onkeypress='return isDecimal(event)' alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_chequeDate" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeDate1">Cheque Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" readonly='true' onkeypress='return false;' value="${allMerchantDetails['chequeDate']}" name="chequeDate" id="chequeDate" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_chequeDepositDate" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeDepositDate1">Cheque Deposit Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" readonly='true' onkeypress='return false;' value="${allMerchantDetails['chequeDepositDate']}" name="chequeDepositDate" id="chequeDepositDate" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_chequeBank" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cheque'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeBank">Bank Name
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['chequeBank']}" name="chequeBank" id="chequeBank" minlength="0" maxlength=50 onkeypress="return isAlphaNumeric(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                   
                                        <div class="form-group percent-50" id="div_cashAmount" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cash'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cashAmount">Amount
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" value="${allMerchantDetails['cashAmount']}" name="cashAmount" id="cashAmount" minlength="0" maxlength=11 onkeypress="return isDecimal(event)" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50" id="div_cashDate" <c:if test="${allMerchantDetails['modeOfPayment'] != 'Cash'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cashDate1">Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" readonly='true' value="${allMerchantDetails['cashDate']}" onkeypress='return false;' data-clear-btn="true" name="cashDate" id="cashDate" data-role="date" onPaste="return false"/>
                                            </div>
                                        </div>  
                                        <div class="form-group percent-50" id="div_neft" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Amount</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" data-clear-btn="true" name="neftAmount" value="${allMerchantDetails['neftAmount']}" id="neftAmount" digits="true" onkeypress='return isDecimal(event)' minlength="0" maxlength="11" onPaste="return false"/>
                                                </div>
                                            </div>
                                            <div class="form-group percent-50" id="div_neftDate" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"for="neftDate1">Date</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" value="${allMerchantDetails['neftDate']}" name="neftDate" id="neftDate" onkeypress='return false;' readonly='true' onPaste="return false"/>
                                                </div>
                                            </div>
                                             <div class="form-group percent-50" id="div_neftchequeNo" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"for="neftchequeNo">Cheque No
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="neftchequeNo" value="${allMerchantDetails['neftchequeNo']}" id="neftchequeNo" minlength="0" maxlength=10 onkeypress="return isNumberKeyWithComa(event);" digits="true" onPaste="return false"/>
                                                </div>
                                            </div>
                                            <div class="form-group percent-50" id="div_neftRefNo" <c:if test="${allMerchantDetails['modeOfPayment'] != 'NEFT'}">style="display:none;"</c:if>>
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"for="neftRefNo"> Ref/UTR. No.
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                     <input type="text" class="form-control" data-clear-btn="true" name="neftRefNo" value="${allMerchantDetails['neftRefNo']}" id="neftRefNo" minlength="0" maxlength=15 onkeypress="return isNumberKeyWithComa(event);" digits="true" onPaste="return false"/>
                                                </div>
                                            </div>        
                                </div>
                            </div>                                  

<!-- ----------------------------------------------DEVICE DETAIL --------------------------------------->
					<div class="x_panel">
						<div class="x_title">
							<h2>KYC Details</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<br />
							<div class="form-group percent-50">
                            	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="DeviceSerialNo">View Document<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12" >
                                    <span><a href="<c:url value='view_docs' />?param=<c:out value="${allMerchantDetails['merchantId']}"/>" target="_blank">Download Pdf</a></span>
                                </div>
                            </div>
							<div class="form-group percent-50">
                            	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="DeviceSerialNo">Update Document<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12" >
                                	<input type="file" class="form-control" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" onPaste="return false"/>
                                </div>
                            </div>
						</div>
					</div>
<!------------------------------------------------Additional Detail ------------------------------------------->
					<div class="x_panel">
						<div class="x_title">
							<h2>Additional Details</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<br />
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="executiveName">Distributor Name</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select name="executiveName" id="executiveName" class="form-control">
								  	  <c:if test="${allMerchantDetails['executiveName']==''}">
								  	     <option value="NA">select</option> 	
									  </c:if>
									  <c:forEach var="RowData" items="${executiveList}">
									  <option <c:if test="${RowData['executiveEmail'] == allMerchantDetails['executiveName']}">selected</c:if> value="<c:out value="${RowData['executiveEmail']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								   </select>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="Note">Remark</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control"
										value="${allMerchantDetails['note']}" data-clear-btn="true"
										name="Note" id="Note" minlength="2" maxlength=200 onPaste="return false"
										 />
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="VerificationStatus">Verification Status<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select data-clear-btn="true" name="VerificationStatus"
										id="VerificationStatus" required="true" class="form-control">
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
							
							
							<div class="form-group percent-50">
						        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="boardingDate">OnBoarding Date</label>
						        <div class="col-md-6 col-sm-6 col-xs-12">
						         <input type="text" class="form-control" value="${allMerchantDetails['createdOn']}" data-clear-btn="true"
						          name="boardingDate" id="boardingDate"  readonly="readonly" onPaste="return false"/>
						        </div>
						    </div>
						                  
							<!-- ---------------------------------------------------------------- Other Started ----------------->
  							<div class="x_panel">
                                <div class="x_title">
                                    <h2>Other</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                        
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br /> 
                                    <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="VerificationStatus">Original App Status<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="appCheckStatus" id="appCheckStatus" required="true" class="form-control">
										          <option <c:if test="${allMerchantDetails['checkStatus'] == 'No'}">Selected</c:if> value="No">No</option>
												
										         <option <c:if test="${allMerchantDetails['checkStatus'] == 'Yes'}">Selected</c:if> value="Yes">Yes</option>
												</select>
                                            </div>
                                        </div>                      
                                      <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="appReceiptDate">App Receipt Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">                                             
                                             	<input type="text" class="form-control" data-clear-btn="true" name="appReceiptDate" id="appReceiptDate" value="${allMerchantDetails['appReceiptDate']}"   maxlength=20  />
                                            </div>
                                        </div>                                        
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="VerificationStatus">Type Of Sale<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="typeOfSale" id="typeOfSale" required="true" class="form-control">
										         <option <c:if test="${allMerchantDetails['typeOfSale'] == 'Distributor'}">Selected</c:if> value="Distributor">Distributor</option>
												 <option <c:if test="${allMerchantDetails['typeOfSale'] == 'Direct'}">Selected</c:if> value="Direct">Direct</option>
												</select>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="amName">AM Name</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select name="amName" id="amName" class="form-control">
								  	  <option value="NA">Select</option>
									  <c:forEach var="RowData" items="${executiveList}">
									  <option <c:if test="${RowData['executiveEmail'] == allMerchantDetails['amName']}">selected</c:if> value="<c:out value="${RowData['executiveEmail']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								   </select>
								</div>
							</div>
							<div class="form-group percent-50">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="executiveName">TSO Name</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select name="tsoName" id="tsoName" class="form-control">
								  	  <option value="NA">Select</option>
									  <c:forEach var="RowData" items="${executiveList}">
									   <option <c:if test="${RowData['executiveEmail'] == allMerchantDetails['tsoName']}">selected</c:if> value="<c:out value="${RowData['executiveEmail']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								   </select>
								</div>
							</div>
                                        
                           
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="onBoardEmpName">OnBoard Exe Name</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">                                  
                                             	<input type="text" class="form-control" data-clear-btn="true" name="onBoardEmpName" id="onBoardEmpName" value="${allMerchantDetails['onBoardEmpName']}" readonly="readonly" maxlength=60  />
                                            </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="onBoardingStatus">Boarding Status<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="onBoardingStatus" id="onBoardingStatus" required="true" class="form-control">
										         	<option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Entry done'}">Selected</c:if> value="Entry done">Entry done</option>
												 <option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Verified'}">Selected</c:if> value="Verified">Verified</option>
												 <option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Pending'}">Selected</c:if> value="Pending">Pending</option>
												 <option <c:if test="${allMerchantDetails['onBoardStatus'] == 'Rejected'}">Selected</c:if> value="Rejected">Rejected</option>
												  </select>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="verificationEntryDate">Verification Entry Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">                                  
                                             	<input type="text" class="form-control" data-clear-btn="true" name="verificationEntryDate" id="verificationEntryDate" value="${allMerchantDetails['verificationEntryDate']}"  maxlength=20  />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="agreementRcvdDate">Agreement Received Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             	<input type="text" class="form-control" data-clear-btn="true" name="agreementRcvdDate" id="agreementRcvdDate" value="${allMerchantDetails['agreementRcvdDate']}"  maxlength=20  />
                                            </div>
                                        </div>
                                        <div class="form-group percent-100">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                              <!--   <button class="btn btn-primary">Cancel</button> -->
                                                <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" <c:if test="${allMerchantDetails.emprole1 == '12'}">style="display:none;"</c:if> data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return updMerchant();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddMerchantDetails" name="AddMerchantDetails">Update</button>
                                            </div>
                                       </div>                                        
                                 </div>
                            </div>                     
                                        
<!-- ----------------------------------------------------------------panels end----------------->
 

						</div>
					</div>

<!-- ----------------------------------------------------------------panels end------------------------------>
<!-- ----------------------------------------------------------------delete Org------------------------------>
					<c:forEach var="counter" begin="1"
						end="${allMerchantDetails['merchantOrgCount']}">
						<c:set var="orgVar" value="org${counter}" />
						<c:set var="orgDetails" value="${allMerchantDetails[orgVar]}" />
						<div class="x_panel">
							<div class="x_title">
								<h2>Terminals of Store - <b>${orgDetails.orgName}</b></h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
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
												<td><button type="button" class="btn-delete"
														onclick='return deleteDeviceConfirm("${deviceDetails.userId}","${orgDetails.orgId}")' <c:if test="${orgDetails.empRole != '1'}">style="display:none;"</c:if>>Delete</button>												
													<button type="button" class="btn-submit"
														data-toggle="modal" data-target=".update_device_popup"
														onclick='setDeviceDetails("${deviceDetails.userId}","${deviceDetails.bankTId}","${deviceDetails.serialNo}","${deviceDetails.validTil}","${deviceDetails.rent}","${deviceDetails.paymentMode}","${deviceDetails.pendingRent}","${deviceDetails.penaltyAmount}","${deviceDetails.discount}","${deviceDetails.avgTxnAmount}","${deviceDetails.userName}","${deviceDetails.userPhoneNo}","${deviceDetails.rmn}","${deviceDetails.userEmail}","${deviceDetails.mdrDebit1}","${deviceDetails.mdrDebit2}","${deviceDetails.mdrCreditPre}","${deviceDetails.mdrCreditNpre}","${deviceDetails.mdrAmex}","${deviceDetails.other}","${deviceDetails.mdrCashAtPos}","${deviceDetails.amexActivated}","${deviceDetails.amexTID}","${deviceDetails.amexMID}","${deviceDetails.bankAccName}","${deviceDetails.bankAccNo}","${deviceDetails.bankName}","${deviceDetails.bankIfsc}","${deviceDetails.bankMicr}","${deviceDetails.bankBranch}","${deviceDetails.mdrMobiKwik}","${deviceDetails.userType}","${deviceDetails.userStatus}","${deviceDetails.benefName}","${deviceDetails.penaltyReason}","${deviceDetails.discountReason}","${deviceDetails.loyaltyStatus}","${deviceDetails.closeWalletStatus}","${deviceDetails.txnSmsStatus}","${deviceDetails.integrationKey}","${deviceDetails.emprole2}","${deviceDetails.loanStatus}","${deviceDetails.loanType}","${deviceDetails.loanDedAmount}","${deviceDetails.loanBankName}","${deviceDetails.loanBankAcc}","${deviceDetails.loanBankIfsc}","${deviceDetails.mdrZero}","${deviceDetails.mdrDebit0}","${deviceDetails.activationDate}","${deviceDetails.planName}","${deviceDetails.feeMode}","${deviceDetails.feeAmount}","${deviceDetails.feeDate}","${deviceDetails.feeRemark}","${deviceDetails.switchType}","${deviceDetails.midTidEntryDate}","${deviceDetails.wlcmLtrSendDate}","${deviceDetails.settlementCharges}","${deviceDetails.rechargeService}","${deviceDetails.rechargeBal}","${deviceDetails.rechargeIncentive}","${deviceDetails.rechargeMonthlyRental}","${deviceDetails.ppcServiceEnable}","${deviceDetails.dmtServiceEnable}","${deviceDetails.dthMobileServiceEnable}");'<c:if test="${allMerchantDetails.emprole1 != '12'}">style="display:none;"</c:if>>View Details</button>
											
													<button type="button" class="btn-submit"
														data-toggle="modal" data-target=".update_device_popup"
														onclick='setDeviceDetails("${deviceDetails.userId}","${deviceDetails.bankTId}","${deviceDetails.serialNo}","${deviceDetails.validTil}","${deviceDetails.rent}","${deviceDetails.paymentMode}","${deviceDetails.pendingRent}","${deviceDetails.penaltyAmount}","${deviceDetails.discount}","${deviceDetails.avgTxnAmount}","${deviceDetails.userName}","${deviceDetails.userPhoneNo}","${deviceDetails.rmn}","${deviceDetails.userEmail}","${deviceDetails.mdrDebit1}","${deviceDetails.mdrDebit2}","${deviceDetails.mdrCreditPre}","${deviceDetails.mdrCreditNpre}","${deviceDetails.mdrAmex}","${deviceDetails.other}","${deviceDetails.mdrCashAtPos}","${deviceDetails.amexActivated}","${deviceDetails.amexTID}","${deviceDetails.amexMID}","${deviceDetails.bankAccName}","${deviceDetails.bankAccNo}","${deviceDetails.bankName}","${deviceDetails.bankIfsc}","${deviceDetails.bankMicr}","${deviceDetails.bankBranch}","${deviceDetails.mdrMobiKwik}","${deviceDetails.userType}","${deviceDetails.userStatus}","${deviceDetails.benefName}","${deviceDetails.penaltyReason}","${deviceDetails.discountReason}","${deviceDetails.loyaltyStatus}","${deviceDetails.closeWalletStatus}","${deviceDetails.txnSmsStatus}","${deviceDetails.integrationKey}","${deviceDetails.emprole2}","${deviceDetails.loanStatus}","${deviceDetails.loanType}","${deviceDetails.loanDedAmount}","${deviceDetails.loanBankName}","${deviceDetails.loanBankAcc}","${deviceDetails.loanBankIfsc}","${deviceDetails.mdrZero}","${deviceDetails.mdrDebit0}","${deviceDetails.activationDate}","${deviceDetails.planName}","${deviceDetails.feeMode}","${deviceDetails.feeAmount}","${deviceDetails.feeDate}","${deviceDetails.feeRemark}","${deviceDetails.switchType}","${deviceDetails.midTidEntryDate}","${deviceDetails.wlcmLtrSendDate}","${deviceDetails.settlementCharges}","${deviceDetails.rechargeService}","${deviceDetails.rechargeBal}","${deviceDetails.rechargeIncentive}","${deviceDetails.rechargeMonthlyRental}","${deviceDetails.ppcServiceEnable}","${deviceDetails.dmtServiceEnable}","${deviceDetails.dthMobileServiceEnable}");'<c:if test="${allMerchantDetails.emprole1 == '10'||allMerchantDetails.emprole1 == '12'}">style="display:none;"</c:if>>Update</button>
													<button type="button" class="btn-submit" data-toggle="modal" data-target=".create_clone_device_popup"
														onclick='setCloneDeviceDetails("${orgDetails.orgId}","${deviceDetails.userId}","${deviceDetails.bankTId}","${deviceDetails.validTil}","${deviceDetails.rent}","${deviceDetails.paymentMode}","${deviceDetails.pendingRent}","${deviceDetails.penaltyAmount}","${deviceDetails.discount}","${deviceDetails.avgTxnAmount}","${deviceDetails.userName}","${deviceDetails.rmn}","${deviceDetails.userEmail}","${deviceDetails.mdrDebit1}","${deviceDetails.mdrDebit2}","${deviceDetails.mdrCreditPre}","${deviceDetails.mdrCreditNpre}","${deviceDetails.mdrAmex}","${deviceDetails.other}","${deviceDetails.mdrCashAtPos}","${deviceDetails.amexActivated}","${deviceDetails.amexTID}","${deviceDetails.amexMID}","${deviceDetails.bankAccName}","${deviceDetails.bankAccNo}","${deviceDetails.bankName}","${deviceDetails.bankIfsc}","${deviceDetails.bankMicr}","${deviceDetails.bankBranch}","${deviceDetails.mdrMobiKwik}","${deviceDetails.userType}","${deviceDetails.mdrCashAtPos}","${deviceDetails.benefName}","${deviceDetails.penaltyReason}","${deviceDetails.discountReason}","${deviceDetails.integrationKey}","${deviceDetails.mdrDebit0}","${deviceDetails.activationDate}","${deviceDetails.planName}","${deviceDetails.feeMode}","${deviceDetails.feeAmount}","${deviceDetails.feeDate}","${deviceDetails.feeRemark}","${deviceDetails.midTidEntryDate}","${deviceDetails.wlcmLtrSendDate}","${deviceDetails.settlementCharges}","${deviceDetails.rechargeService}");'<c:if test="${allMerchantDetails.acquirerCode != 'Acquiro'||allMerchantDetails.emprole1 == '10'||allMerchantDetails.emprole1 == '12'}">style="display:none;"</c:if>>Clone</button>
													<%-- <button type="button" class="btn-submit" data-toggle="modal" data-target=".nodal_details_popup"
														onclick='setNodalAccountDetails("${deviceDetails.bankTId}","${allMerchantDetails.merchantId}","${orgDetails.orgId}","${deviceDetails.userId}","${deviceDetails.bankIfsc}","${deviceDetails.bankAccNo}","${deviceDetails.benefName}","${deviceDetails.bankName}","${allMerchantDetails.emailId}","${deviceDetails.rmn}","${allMerchantDetails.businessAddress1}","${allMerchantDetails.businessAddress2}","${allMerchantDetails.businessCity}","${allMerchantDetails.businessState}","${allMerchantDetails.businessPincode}","${deviceDetails.benDob}","${deviceDetails.benBankCd}","${deviceDetails.benBranchCd}","${deviceDetails.benTranParticular}","${deviceDetails.benTrnsRmks}","${deviceDetails.benPan}","${deviceDetails.benType}","${deviceDetails.benId}","${deviceDetails.limitDaily}","${deviceDetails.limitWeekly}","${deviceDetails.limitMonthly}","${deviceDetails.issueBranchCd}","${deviceDetails.benHide}","${allMerchantDetails.businessType}");' <c:if test="${allMerchantDetails.emprole1 == '9' ||allMerchantDetails.emprole1 == '4'|| allMerchantDetails.emprole1 == '10'}">style="display:none;"</c:if>>Update Nodal</button>
													 --%><button type="button" class="btn-submit" data-toggle="modal" data-target=".send_sms_popup"
														onclick='setsendsms("${allMerchantDetails.merchantId}","${orgDetails.orgId}","${deviceDetails.userId}","${deviceDetails.rmn}");' <c:if test="${allMerchantDetails.emprole1 == '9'||allMerchantDetails.emprole1 == '10'||allMerchantDetails.emprole1 == '4'}">style="display:none;"</c:if>>Send Sms</button>
													<button type="button" class="btn-submit" data-toggle="modal"
														onclick='welcomeLetter("${deviceDetails.bankTId}","${deviceDetails.userPhoneNo}","${deviceDetails.userId}","${deviceDetails.amexMID}","${deviceDetails.mdrCreditNpre}","${deviceDetails.mdrCreditPre}","${deviceDetails.mdrDebit1}","${deviceDetails.mdrDebit2}");' <c:if test="${allMerchantDetails.emprole1 == '9'||allMerchantDetails.emprole1 == '10'||allMerchantDetails.emprole1 == '4'}">style="display:none;"</c:if>>Send WelcomeLetter</button>
										
													
												</td>
											</tr>
											</c:if>
											
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
	</div>
	<!-- -----------------------------------------  clone create Device ------------------------------------------------------->

	<div class="modal fade create_clone_device_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">x</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Create Copy Terminal</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="cloneMerchantId" name="cloneMerchantId" value="${allMerchantDetails['merchantId']}">
					<input type="hidden" id="cloneOrgId" name="cloneOrgId" value="${orgDetails.orgId}">
						<div class="x_panel">
							<div class="x_title">
								<h2>Terminal Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
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
		            id="cloneRechargeServiceEnable" name="cloneRechargeServiceEnable"  onclick="return setCloneRechargeServiceStatus();">Recharge Service Enable
		           </div>
                                           </div>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="cloneDmtServiceEnable" name="cloneDmtServiceEnable">DMT Service Enable
									          </div>
                                           </div>
                                              <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="clonePpcServiceEnable" name="clonePpcServiceEnable">PPC Service Enable
									          </div>
                                           </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="cloneDthMobileServiceEnable" name="cloneDthMobileServiceEnable">DTH/Mobile Service Enable
									          </div>
                                           </div>
                                             <div class="col-md-2 col-sm-2 col-xs-12">
                                             <div class="checkbox">
									           <input type="checkbox"
									            style="margin: 0 !important; position: relative !important"
									            id="cloneuserType" name="cloneuserType" onchange="return onchangeCloneUserType();">Credit/Debit Service Enable
									          </div>
                                           </div>
                                 </div>	
								<%-- <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneuserType">User Type<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="cloneuserType"
											id="cloneuserType" required="true" class="form-control" onchange="return onchangeCloneUserType();">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.userType == 'wallet'}">Selected="Selected"</c:if> value="wallet">Wallet</option>
											<option <c:if test="${deviceDetails.userType == 'credit'}">Selected="Selected"</c:if> value="credit">Credit</option>
											<option <c:if test="${deviceDetails.userType == 'wallet/credit'}">Selected="Selected"</c:if> value="wallet/credit">Wallet/Credit</option>
											</select>                                                    
                                            </div>
                                        </div>   --%>
                                        	<%-- <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="switchType">Switch Type<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="switchType"
											id="switchType" required="true" class="form-control" >
											<option value="">select</option>
											<option <c:if test="${deviceDetails.switchType == 'AGS'}">Selected="Selected"</c:if> value="AGS">AGS</option>
											<option <c:if test="${deviceDetails.switchType == 'OGS'}">Selected="Selected"</c:if> value="OGS">OGS</option>
											</select>                                                    
                                            </div>
                                        </div>  --%>
                                <div class="form-group percent-50" id="div_cloneSerialNo">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">Terminal Serial No<span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
                                       <select data-clear-btn="true" name="cloneSerialNo" id="cloneSerialNo"  required="true" class="form-control">
                                       <option value="">Select</option>
                                    </select>
							<!--	<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneSerialNo" id="cloneSerialNo" required="true" minlength="8"
											maxlength="17"
											onkeypress='return event.charCode >= 48 && event.charCode <= 57'
											digits="true" />  -->
									</div>
								</div>
								
                               <div class="form-group percent-50" id="div_clonebankTid">
									<label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneBankTid">Bank Tid<span class="required">*</span> </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneBankTid" id="cloneBankTid" required="true" minlength="0"
											maxlength="8" onkeypress="return isAlphaNumericWithoutSpace(event);" alphanumeric="true" onPaste="return false"/>
									</div>
								</div> 
							</div>
						</div>

<!--------------------------------------------------------- User Details ------------------------------------------------------->

						<div class="x_panel">
							<div class="x_title">
								<h2>User Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="cloneLoginId">Terminal Id<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneDLoginId" id="cloneDLoginId" required="true" minlength="10"
											maxlength="10"
											onkeypress='return isNumberKey(event)'
											digits="true" onPaste="return false"/>
									</div>
								</div>
								
								<div class="form-group percent-50">
								
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="rmn"><input type="checkbox"
												style="margin: 0 !important; position: relative !important"
												id="clonesameUserId" name="clonesameUserId"
												onchange="onOffCloneSamePhone();" onPaste="return false"> User Id same as Phone	No RMN<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonermn" id="clonermn" required="true"
											minlength="10" maxlength="10"
											onkeypress='return isNumberKey(event)'
											digits="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="UserEmailId">Email Id</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneUserEmailId" id="cloneUserEmailId" required="true"
											minlength="0" maxlength="100" email="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Name">Name Of User<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneDName" id="cloneDName" required="true" minlength="1"
											maxlength="50" onkeypress="return isAlphaNumeric(event);" onPaste="return false"/>
									</div>
								</div>
								
							</div>
						</div>


						<!------------------------------------------------------ Rent Details ----------------------------------------->
						<div class="x_panel" id="div_other1">
							<div class="x_title">
								<h2>Rent Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="validTil1">Valid till Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" name="clonevalidTil" id="clonevalidTil" onkeypress='return false;' readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="cloneRent">Rent<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneRent" id="cloneRent" required="true" minlength="1"
											onkeypress='return isDecimal(event)' maxlength="8"
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="penaltyAmount">Penalty Amount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="clonePenaltyAmount" id="clonePenaltyAmount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="clonePenaltyReason">Penalty Reason<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="clonePenaltyReason" placeholder="NA" id="clonePenaltyReason"  minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" onPaste="return false" />
                                            </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="discount">Discount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="cloneDiscount" id="cloneDiscount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cloneDiscountReason">Discount Reason<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="cloneDiscountReason" placeholder="NA" id="cloneDiscountReason"  required="true" minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);"  onPaste="return false"/>
                                            </div>
                                </div>
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneAvgTxnAmount">Avg Txn Amt<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="cloneAvgTxnAmount" id="cloneAvgTxnAmount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="PaymentMode">Payment Mode<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select name="clonePaymentMode" id="clonePaymentMode" required="true" class="form-control">
                                            <option value="">select</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="quaterly">Quaterly</option>
                                            <option value="halfyearly">HalfYearly</option>
                                            <option value="yearly">Yearly</option>
                                        </select>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="pendingRent">Pending Rent<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonependingRent" id="clonependingRent" required="true" minlength="1"
											onkeypress='return isDecimal(event)' maxlength="8"
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneMdrDebit0">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit0">Mdr Debit <1000<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneMdrDebit0" id="cloneMdrDebit0" required="true" minlength="1"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneMdrDebit1">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit1">Mdr Debit (>1000 & <2000)<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneMdrDebit1" id="cloneMdrDebit1" required="true" minlength="1"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneMdrDebit2">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit2">Mdr Debit >2000<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneMdrDebit2" id="cloneMdrDebit2" required="true" minlength="0"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneMdrCreditPre">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrCreditPre">Mdr Credit Premium<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneMdrCreditPre" id="cloneMdrCreditPre"
											onkeypress='return isDecimal(event)'
											minlength="0" maxlength="6" number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneMdrCreditNpre">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrCreditNpre">Mdr Credit Card Non-Premium</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneMdrCreditNpre" id="cloneMdrCreditNpre" required="true"
											minlength="0" maxlength="6"
											onkeypress='return isDecimal(event)' number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneOther">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Other">International Card</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneOther" id="cloneOther" required="true" minlength="0"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_clonemdrCashAtPos" style="display:none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="clonemdrCashAtPos">mdrCashAtPosAmount</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="clonemdrCashAtPos" id="clonemdrCashAtPos" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                             </div>
                                </div>
								<div class="form-group percent-50" id="div_clonemobiKwikMdr">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mobiKwik">Wallet MDR</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="clonemobiKwik" id="clonemobiKwik" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneSettlementCharges">Fixed Settlement Charges<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="cloneSettlementCharges" id="cloneSettlementCharges" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" />
                                          </div>
                                </div>
							</div>
						</div>
<!------------------------------------------------ Bank Details ------------------------------------------------------------------->
						<div class="x_panel" id="div_other2">
							<div class="x_title">
								<h2>Bank Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankAccType">Bank Account Type<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select data-clear-btn="true" name="bankAccType"
											id="clonebankAccType" required="clonebankAccType" class="form-control">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.bankAccName == 'current'}">Selected="Selected"</c:if> value="current">Current</option>
											<option <c:if test="${deviceDetails.bankAccName == 'saving'}">Selected="Selected"</c:if> value="saving">Saving</option>
											<option <c:if test="${deviceDetails.bankAccName == 'od'}">Selected="Selected"</c:if> value="od">OD</option>
										</select>
										<!-- <input type="text" class="form-control" data-clear-btn="true"
											name="clonebankAccType" id="clonebankAccType" minlength="1"
											maxlength="50"
											onkeypress="return isAlphaNumericBankType(event);"
											alphanumeric="true" />-->
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankAccNumber">Bank Account Number<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonebankAccNumber" id="clonebankAccNumber" minlength="6"
											maxlength="30"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankName">Bank Name<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonebankName" id="clonebankName" minlength="1" maxlength="50"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="benefName">Benefciary Name<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonebenefName" id="clonebenefName" minlength="1" maxlength="45"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>								
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankBranch">Bank Branch<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonebankBranch" id="clonebankBranch" minlength="1" maxlength="45"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankIfsc">Bank IFSC<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonebankIfsc" id="clonebankIfsc" minlength="11" maxlength="11"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankMicr">Bank MICR<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonebankMicr" id="clonebankMicr" minlength="9" maxlength="15"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
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
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="planName">Plan Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	 <select name="planName" id="planName" class="form-control">
                                            	 	<option value="Life-Time(36Months)">Life-Time(36Months)</option>
                                            	 	 <option value="Yearly">Yearly</option>
                                            	 	  <option value="Half-Yearly">Half-Yearly</option>
                                            	 	  <option value="Quarterly">Quarterly</option>
		                                            <option value="Monthly">Monthly</option>
	                                            </select>
                                                <!-- <input type="text" class="form-control" data-clear-btn="true" name="bankAccType" id="bankAccType"  minlength="1" maxlength="50" onkeypress="return isAlphaNumericBankType(event);" alphanumeric="true" /> -->
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="feeModel">Fee Mode<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select name="feeMode" id="feeMode" class="form-control">
                                            		<option value="Free">Free</option>
		                                            <option value="Neft">Neft</option>
		                                            <option value="Cheque">Cheque</option>
		                                            <option value="Cash">Cash</option>		                                            
	                                            </select>                                         
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="feeAmount">Fee Amount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="feeAmount" id="feeAmount"  minlength="1" maxlength="8" onkeypress="return isDecimal(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="feeDate">Fee Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="feeDate" data-role="date" placeholder="Fee Date" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="feeRemarks">Fee Remarks<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="feeRemarks" id="feeRemarks"  minlength="2" maxlength="150" onkeypress="return isFeeRemarks(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                          
                                </div>
                            </div>                     						
		
<!------------------------------------------------American Express Detail -------------------------------------------------->
						<div class="x_panel" id="div_cloneamericanExpress">
							<div class="x_title">
								<h2>American Express Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
							<div>
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="AmexActivated">Amex Activated<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select data-clear-btn="true" name="cloneAmexActivated" id="cloneAmexActivated" onchange="return onChangeCloneAmexActivated();" class="form-control">
											<option value="">Select</option>
											<option value="NO">NO</option>
											<option value="YES">YES</option>
										</select>
									</div>
								</div>
								<div class="form-group percent-50" id="div_clonemdrAmex">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="mdrAmex">Mdr Amex</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="clonemdrAmex" id="clonemdrAmex" onkeypress='return isDecimal(event)'
											minlength="0" maxlength="6" number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneamexTID">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="AmexTID">Amex Tid</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneamexTID" id="cloneamexTID" minlength="8" maxlength="8"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_cloneamexMID">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="AmexMID">Amex Mid</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="cloneamexMID" id="cloneamexMID" minlength="10" maxlength="45"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
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
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneMidTidEntryDate">MID/TID Entry Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="cloneMidTidEntryDate" data-role="date" placeholder="MID/TID Entry Date" value="01/01/2016" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="wlcmLtrSendDate">Welcome Letter Send Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="cloneWlcmLtrSendDate" data-role="date" placeholder="Welcome Letter Send Date" value="01/01/2016" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                                                                                                                                               
                                </div>
                            </div>                
<!-------------------------------------- Recharge Service Details ---------------------------------->
            				<div class="x_panel" id="div_cloneRechargeServiceDetails" style="display: none">
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
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneRechargeBal">Recharge Balance</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="cloneRechargeBal" id="cloneRechargeBal"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div> 
                                         <div class="form-group percent-50" >
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12"  for="cloneRechargeIncentive">Recharge incentive</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="cloneRechargeIncentive" id="cloneRechargeIncentive"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                         <div class="form-group percent-50" >
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12"  for="clonerechargeMonthlyRental">Recharge Monthly Rental</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="clonerechargeMonthlyRental" id="clonerechargeMonthlyRental"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div>
              
                                                                                                                                                                                  
                                </div>
                            </div>                     		
						                                   
                                                  
<!-------------------------------------- Integration Details ---------------------------------->
            				<div class="x_panel">
                                <div class="x_title">
                                    <h2>Integration field</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                                                        
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cloneIntegrationKey">Integration Key<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="cloneIntegrationKey" id="cloneIntegrationKey"  minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" alphanumeric="true" onPaste="return false" />
                                            </div>
                                        </div>                                                                                                                                                
                                </div>
                                
                            </div>                     
                                                                 
                            
<!----------------------------------- x-Panel End  ------------------------------------------------------------------>  						
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-close" data-dismiss="modal" >Close</button>		
					<button type="button" class="btn-submit"
										data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return createCloneDevice();" id="UpdMerchantDetails"
										name="UpdMerchantDetails">Create Terminal</button>
				</div>
			</div>
		</div>
	</div>

	
<!-----------------------------------------------------Update Device Popup ----------------------------------------------->
	<div class="modal fade update_device_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" onclick="window.location.reload();">
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Terminal</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="DeviceID" name="DeviceID" value="">
						<div class="x_panel">
							<div class="x_title">
								<h2>Terminal Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
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
                                           
                                                                  </div>
			        
                                 </div>
				
				
				
								
								
								<%-- <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="userType">User Type<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="userType"
											id="userType" required="true" class="form-control" onchange="return onchangeUserType();">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.userType == 'wallet'}">Selected="Selected"</c:if> value="wallet">Wallet</option>
											<option <c:if test="${deviceDetails.userType == 'credit'}">Selected="Selected"</c:if> value="credit">Credit</option>
											<option <c:if test="${deviceDetails.userType == 'wallet/credit'}">Selected="Selected"</c:if> value="wallet/credit">Wallet/Credit</option>
											</select>                                                    
                                            </div>
                                        </div>  --%> 
                                       <%--  <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upswitchType">Switch Type<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="upswitchType" id="upswitchType" required="true" class="form-control" >
											<option value="">select</option>
											<option <c:if test="${deviceDetails.switchType == 'AGS'}">Selected="Selected"</c:if> value="AGS">AGS</option>
											<option <c:if test="${deviceDetails.switchType == 'OGS'}">Selected="Selected"</c:if> value="OGS">OGS</option>
											</select>                                                    
                                            </div>
                                        </div>   --%>
                                        <div class="form-group percent-50" id="div_SerialNo">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">Device Serial No<span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
									<select data-clear-btn="true" name="SerialNo" id="SerialNo" required="true" class="form-control">
                                    </select>
										<!-- <input type="text" class="form-control" data-clear-btn="true"
											name="SerialNo" id="SerialNo" required="true" minlength="8"
											maxlength="17"
											onkeypress='return event.charCode >= 48 && event.charCode <= 57'
											digits="true" /> -->
									</div>
								</div>
                                <div class="form-group percent-50" id="div_bankTid">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="BankTid">Bank Tid<span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="BankTid" id="BankTid" required="true" minlength="0"
											maxlength="8"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
											
									</div>
									
									
									
								</div>
							</div>
						</div>

<!---------------------------------------------------------User Details----------------------------------------------------- -->
						<div class="x_panel">
							<div class="x_title">
								<h2>User Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="LoginId">Terminal Id<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="DLoginId" id="DLoginId" required="true" minlength="10"
											maxlength="10"
											onkeypress='return isNumberKey(event)'
											digits="true" onPaste="return false"/>
									</div>
								</div>
								
								<div class="form-group percent-50">
								
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="rmn"><input type="checkbox"
												style="margin: 0 !important; position: relative !important"
												id="sameUserId" name="sameUserId"
												onchange="onOffSamePhone();"> RMN Same As TerminalId RMN<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="rmn" id="rmn" required="true"
											minlength="10" maxlength="10"
											onkeypress='return isNumberKey(event)'
											digits="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="UserEmailId">Email Id</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="UserEmailId" id="UserEmailId" required="true"
											minlength="0" maxlength="100" email="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Name">Name Of User<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="DName" id="DName" required="true" minlength="1"
											maxlength="50" onkeypress="return isAlphaNumericName(event);" onPaste="return false"/>
									</div>
								</div>
								
							</div>
						</div>
<!------------------------------------------------------ Rent Details ----------------------------------------->
						<div class="x_panel" <c:if test="${deviceDetails.emprole2 != '2'}">style="display:none;"</c:if>>
							<div class="x_title">
								<h2>Rent Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="validTil2">Valid till Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" name="validTil" 

id="validTil1" onkeypress='return false;' readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Rent">Rent<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="Rent" id="Rent1" required="true" minlength="1"
											onkeypress='return isDecimal(event)' maxlength="8"
											number="true" readonly="readonly" onPaste="return false"/>
									</div>
								</div>
								
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="PaymentMode">Payment Mode<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select name="PaymentMode" id="PaymentMode1" required="true" class="form-control" readonly="readonly">
                                            <option value="">select</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="quaterly">Quaterly</option>
                                            <option value="halfyearly">HalfYearly</option>
                                            <option value="yearly">Yearly</option>
                                        </select>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="pendingRent">Pending Rent<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="pendingRent" id="pendingRent1" required="true" minlength="1"
											onkeypress='return isDecimal(event)' maxlength="8"
											number="true" readonly="readonly" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="penaltyAmount">Penalty Amount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="penaltyAmount" id="penaltyAmount1" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" readonly="readonly"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="penaltyReason">Penalty Reason<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="penaltyReason" id="penaltyReason1" placeholder="NA"  minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);"  readonly="readonly"/>
                                            </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="discount">Discount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="discount" id="discount1" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" readonly="readonly"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="discountReason">Discount Reason<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="discountReason" id="discountReason1" placeholder="NA" required="true" minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" readonly="readonly" />
                                            </div>
                                </div>
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="avgTxnAmount">Avg Txn Amt<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="avgTxnAmount" id="avgTxnAmount1" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" readonly="readonly"/>
                                          </div>
                                </div>
								<div class="form-group percent-50" id="div_MdrDebit00">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit00">Mdr Debit <1000<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrDebit00" id="MdrDebit00" required="true" minlength="1"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrDebit11">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit1">Mdr Debit (>1000 & <2000)<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrDebit1" id="MdrDebit11" required="true" minlength="1"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrDebit21">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit2">Mdr Debit >2000<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrDebit2" id="MdrDebit21" required="true" minlength="0"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrCreditPre1">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrCreditPre">Mdr Credit Premium<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrCreditPre" id="MdrCreditPre1"
											onkeypress='return isDecimal(event)'
											minlength="0" maxlength="6" number="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrCreditNpre1">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrCreditNpre">Mdr Credit Card Non-Premium</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrCreditNpre" id="MdrCreditNpre1" required="true"
											minlength="0" maxlength="6"
											onkeypress='return isDecimal(event)' number="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_Other1">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Other">International Card</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="Other" id="Other1" required="true" minlength="0"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_mdrCashAtPos1" style="display:none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mdrCashAtPos">CASHATPOS MDR</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mdrCashAtPos" id="mdrCashAtPos1" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" readonly="readonly"/> 
                                                </div>
                                        </div>
								<div class="form-group percent-50" id="div_mobiKwikMdr1">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mobiKwik">Wallet MDR</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mobiKwik" id="mobiKwik1" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" readonly="readonly"/> 
                                                </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="settlementCharges">Fixed Settlement Charges<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="settlementCharges" id="settlementCharges1" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" readonly="readonly"/>
                                          </div>
                                </div>
							</div>
						</div>
<!------------------------------------------------ Bank Details ------------------------------------------------------------------->
						<div class="x_panel" <c:if test="${deviceDetails.emprole2 != '2'}">style="display:none;"</c:if>>
							<div class="x_title">
								<h2>Bank Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankAccType">Bank Account Type<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select data-clear-btn="true" name="bankAccType"
											id="bankAccType1" required="bankAccType" class="form-control" readonly="readonly">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.bankAccName == 'current'}">Selected="Selected"</c:if> value="current">Current</option>
											<option <c:if test="${deviceDetails.bankAccName == 'saving'}">Selected="Selected"</c:if> value="saving">Saving</option>
											<option <c:if test="${deviceDetails.bankAccName == 'od'}">Selected="Selected"</c:if> value="od">OD</option>
										</select>
										<!-- <input type="text" class="form-control" data-clear-btn="true"
											name="clonebankAccType" id="clonebankAccType" minlength="1"
											maxlength="50"
											onkeypress="return isAlphaNumericBankType(event);"
											alphanumeric="true" />-->
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankAccNumber">Bank Account Number<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankAccNumber" id="bankAccNumber1" minlength="6"
											maxlength="30"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankName">Bank Name<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankName" id="bankName1" minlength="1" maxlength="50"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="benefName">Benefciary Name<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="benefName" id="benefName1" minlength="1" maxlength="45"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" readonly="readonly"/>
									</div>
								</div>								
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankBranch">Bank Branch<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankBranch" id="bankBranch1" minlength="1" maxlength="45"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankIfsc">Bank IFSC<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankIfsc" id="bankIfsc1" minlength="11" maxlength="11"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" readonly="readonly"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankMicr">Bank MICR<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankMicr" id="bankMicr1" minlength="9" maxlength="15"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" readonly="readonly"/>
									</div>
								</div>
							</div>
						</div>
<!------------------------------------------------------ Rent Details ----------------------------------------->
						<div class="x_panel" <c:if test="${deviceDetails.emprole2 == '2'}">style="display:none;"</c:if>>
							<div class="x_title">
								<h2>Rent Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="validTil2">Valid till Date</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" name="validTil" 

id="validTil" onkeypress='return false;' readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Rent">Rent<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="Rent" id="Rent" required="true" minlength="1"
											onkeypress='return isDecimal(event)' maxlength="8"
											number="true" onPaste="return false"/>
									</div>
								</div>
								
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="PaymentMode">Payment Mode<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
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
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="pendingRent">Pending Rent<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="pendingRent" id="pendingRent" required="true" minlength="1"
											onkeypress='return isDecimal(event)' maxlength="8"
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="penaltyAmount">Penalty Amount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="penaltyAmount" id="penaltyAmount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="penaltyReason">Penalty Reason<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="penaltyReason" id="penaltyReason" placeholder="NA"  minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);"  onPaste="return false"/>
                                            </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="discount">Discount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="discount" id="discount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
                                <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="discountReason">Discount Reason<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="discountReason" id="discountReason" placeholder="NA" required="true" minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" onPaste="return false" />
                                            </div>
                                </div>
								<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="avgTxnAmount">Avg Txn Amt<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="avgTxnAmount" id="avgTxnAmount" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                          </div>
                                </div>
								<div class="form-group percent-50" id="div_MdrDebit0">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit1">Mdr Debit <1000<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrDebit0" id="MdrDebit0" required="true" minlength="1"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrDebit1">
									<label class="control-labesl col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit1">Mdr Debit(>1000 & <2000)<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrDebit1" id="MdrDebit1" required="true" minlength="1"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrDebit2">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrDebit2">Mdr Debit >2000<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrDebit2" id="MdrDebit2" required="true" minlength="0"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrCreditPre">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrCreditPre">Mdr Credit Premium<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrCreditPre" id="MdrCreditPre"
											onkeypress='return isDecimal(event)'
											minlength="0" maxlength="6" number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_MdrCreditNpre">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="MdrCreditNpre">Mdr Credit Card Non-Premium</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="MdrCreditNpre" id="MdrCreditNpre" required="true"
											minlength="0" maxlength="6"
											onkeypress='return isDecimal(event)' number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_Other">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="Other">International Card</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="Other" id="Other" required="true" minlength="0"
											maxlength="6" onkeypress='return isDecimal(event)'
											number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_mdrCashAtPos" style="display:none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mdrCashAtPos">CASHATPOS MDR</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mdrCashAtPos" id="mdrCashAtPos" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                        </div>
								<div class="form-group percent-50" id="div_mobiKwikMdr">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="mobiKwik">Wallet MDR</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="mobiKwik" id="mobiKwik" minlength="0" maxlength="6" onkeypress='return isDecimal(event)' number="true" onPaste="return false"/> 
                                                </div>
                                </div>
                                 <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="settlementCharges">Fixed Settlement Charges<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="settlementCharges" id="settlementCharges" required="true" onkeypress='return isDecimal(event)' maxlength="8" number="true" />
                                          </div>
                                </div>
							</div>
						</div>
<!------------------------------------- Bank Details ---------------------------------->
						<div class="x_panel" <c:if test="${deviceDetails.emprole2 == '2'}">style="display:none;"</c:if>>
							<div class="x_title">
								<h2>Bank Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankAccType">Bank Account Type<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select data-clear-btn="true" name="bankAccType"
											id="bankAccType" required="true" class="form-control">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.bankAccName == 'current'}">Selected="Selected"</c:if> value="current">Current</option>
											<option <c:if test="${deviceDetails.bankAccName == 'saving'}">Selected="Selected"</c:if> value="saving">Saving</option>
											<option <c:if test="${deviceDetails.bankAccName == 'od'}">Selected="Selected"</c:if> value="od">OD</option>
										</select>
									
										<!-- <input type="text" class="form-control" data-clear-btn="true"
											name="bankAccType" id="bankAccType" minlength="1"
											maxlength="50"
											onkeypress="return isAlphaNumericBankType(event);"
											alphanumeric="true" />-->
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankAccNumber">Bank Account Number<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankAccNumber" id="bankAccNumber" minlength="6"
											maxlength="30"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankName">Bank Name<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankName" id="bankName" minlength="1" maxlength="50"
											onkeypress="return isAlphaNumericName(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="benefName">Beneficiary Name<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="benefName" id="benefName" minlength="1" maxlength="45"
											onkeypress="return isAlphaNumericName(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankBranch">Bank Branch<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankBranch" id="bankBranch" minlength="1" maxlength="45"
											onkeypress="return isAlphaNumeric(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankIfsc">Bank IFSC<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankIfsc" id="bankIfsc" minlength="11" maxlength="11"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="bankMicr">Bank MICR<span class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="bankMicr" id="bankMicr" minlength="9" maxlength="15"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
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
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upPlanName">Plan Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	 <select name="upPlanName" id="upPlanName" class="form-control">
                                            	 	<option value="Life-Time(36Months)">Life-Time(36Months)</option>
                                            	  	<option value="Yearly">Yearly</option>
                                            	  	<option value="Half-Yearly">Half-Yearly</option>
                                            	   	<option value="Quarterly">Quarterly</option>
		                                            <option value="Monthly">Monthly</option>
	                                            </select>
                                                <!-- <input type="text" class="form-control" data-clear-btn="true" name="bankAccType" id="bankAccType"  minlength="1" maxlength="50" onkeypress="return isAlphaNumericBankType(event);" alphanumeric="true" /> -->
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upFeeModel">Fee Mode<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select name="upFeeMode" id="upFeeMode" class="form-control">
                                            		<option value="Free">Free</option>
		                                            <option value="Neft">Neft</option>
		                                            <option value="Cheque">Cheque</option>
		                                            <option value="Cash">Cash</option>		                                            
	                                            </select>                                         
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upFeeAmount">Fee Amount<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="upFeeAmount" id="upFeeAmount"  minlength="1" maxlength="8" onkeypress="return isDecimal(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upFeeDate">Fee Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" name="upFeeDate" class="date-picker form-control" id="upFeeDate" data-role="date" placeholder="Fee Date" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upActivationDate">Activation Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" name="upActivationDate" class="date-picker form-control" id="upActivationDate" data-role="date" placeholder="Activation Date" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="upFeeRemarks">Fee Remarks<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="upFeeRemarks" id="upFeeRemarks"  minlength="2" maxlength="150" onkeypress="return isFeeRemarks(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                          
                                </div>
                            </div>       
<!-- ----------------------------------------------American Express Detail -------------------------------------------------->
						<div class="x_panel" id="div_americanExpress">
							<div class="x_title">
								<h2>American Express Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
							<div>
								<br />
								<div class="form-group percent-50">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="AmexActivated">Amex Activated<span
										class="required">*</span></label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<select data-clear-btn="true" name="AmexActivated" id="AmexActivated" onchange="return onChangeAmexActivated();" class="form-control">
											<option value="">Select</option>
											<option value="NO">NO</option>
											<option value="YES">YES</option>
										</select>
									</div>
								</div>
								<div class="form-group percent-50" id="div_mdrAmex">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="mdrAmex">Mdr Amex</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="mdrAmex" id="mdrAmex" onkeypress='return isDecimal(event)'
											minlength="0" maxlength="6" number="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_amexTID">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="AmexTID">Amex Tid</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="amexTID" id="amexTID" minlength="8" maxlength="8"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
									</div>
								</div>
								<div class="form-group percent-50" id="div_amexMID">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="AmexMID">Amex Mid</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<input type="text" class="form-control" data-clear-btn="true"
											name="amexMID" id="amexMID" minlength="10" maxlength="45"
											onkeypress="return isAlphaNumericWithoutSpace(event);"
											alphanumeric="true" onPaste="return false"/>
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
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="midTidEntryDate">MID/TID Entry Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" name="feeDate" class="date-picker form-control" id="midTidEntryDate" data-role="date" placeholder="MID/TID Entry Date" value="01/01/2016" readonly='true' onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="wlcmLtrSendDate">Welcome Letter Send Date<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
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
                                    <h2>Integration field</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                                                        
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="integrationKey">Integration Key<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="integrationKey" id="integrationKey"  minlength="0" maxlength="100" onkeypress="return isAlphaNumericName(event);" alphanumeric="true" onPaste="return false" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                                                
                                </div>
                            </div>                     
                                                
   	<!-------------------------------------- Loan Details ---------------------------------->
            				<div class="x_panel" id="div_loanDetails" style="display: none">
                                <div class="x_title">
                                    <h2>Loan Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />                                                        
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="loanType">Loan Type</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="loanType"
											id="loanType" required="true" class="form-control" onchange="return onchangeLoanType();">
											<option value="">select</option>
											<option <c:if test="${deviceDetails.loanType == 'fixed'}">Selected="Selected"</c:if> value="fixed">Fixed</option>
											<option <c:if test="${deviceDetails.loanType == 'percentage'}">Selected="Selected"</c:if> value="percentage">Percentage</option>
											</select>                                                    
                                            </div>
                                        </div>  
                                    
                                        <div class="form-group percent-50" id="div_loanAmount" style="display: none">
                                        	<label class="control-label col-md-3 col-sm-3 col-xs-12" id="div_loanPercentage" style="display: none" for="loanPercentage">Loan Percentage</label>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="loanAmount" id="div_loanAmount1" style="display: none">Deduction Amount</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="loanDedAmount" id="loanDedAmount"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" onPaste="return false"/>
                                            </div>
                                        </div> 
                                    <!--      <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="totLoanAmt">Total Loan Deduction For Payout</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="loanAmountPayout" id="loanAmountPayout"  minlength="0" onkeypress='return isDecimal(event)' maxlength="8" number="true" readonly="readonly"/>
                                            </div>
                                        </div> -->
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="loanBankName">Loan Bank Name</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="loanBankName" id="loanBankName"  minlength="0" maxlength="45" onkeypress="return isAlphaNumeric(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="loanAccount">Loan Bank Account</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="loanAccount" id="loanAccount"  minlength="0" maxlength="45" onkeypress="return isAlphaNumeric(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="loanIfsc">Loan Bank IFSC</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="loanIfsc" id="loanIfsc"  minlength="0" maxlength="11" onkeypress="return isAlphaNumeric(event);" alphanumeric="true" onPaste="return false"/>
                                            </div>
                                        </div>                                                                                                                                             
                                </div>
                            </div>                     		
						               
<!----------------------------------- x-Panel End  ------------------------------------------------------------------>  						
					</form>
				</div>
				  <div class="modal-footer">
					<button type="button" class="btn-cancel" data-dismiss="modal">Close</button>		
					<button type="button" class="btn-submit"
										data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return updDeviceDetails();" id="UpdMerchantDetails"
										name="UpdMerchantDetails" <c:if test="${deviceDetails.emprole2 == '9'||deviceDetails.emprole2 == '10'||deviceDetails.emprole2 == '12'}">style="display:none;"</c:if>>Update Device</button>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------------------- Update Org Popup -------------------------------------------------------->


                                <div class="modal fade update_org_popup" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" onclick="window.location.reload();"><span aria-hidden="true">X</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel">Update Store Detail</h4>
                                            </div>
                                            <div class="modal-body">
                                               <form class="form-horizontal form-label-left"> 
                                                <input type="hidden" id="UpdOrgId" name="UpdOrgId" value="">
                                               <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="updOrgName" id="updOrgName" required="true" minlength="2" maxlength=50 onkeypress="return isAlphaNumeric(event);" onPaste="return false" />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="updOrgAddress1">Address Line 1<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="updOrgAddress1" id="updOrgAddress1" required="true" minlength="2" onkeypress="return addressValidation(event);" maxlength=100  onPaste="return false" />
                                          </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="updOrgAddress2">Address Line 2<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="updOrgAddress2" id="updOrgAddress2" required="true" minlength="2" onkeypress="return addressValidation(event);" maxlength=100  onPaste="return false" />
                                            </div>
                                        </div>                                                                            
                                        <div class="form-group percent-50">
											<label class="control-label col-md-3 col-sm-3 col-xs-12"
												for="Businessstate">State<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6 col-xs-12">
											 <input type="text" class="form-control" data-clear-btn="true" name="updOrgbusinessstate" id="updOrgbusinessstate" required="true" minlength="2" onkeypress="return addressValidation(event);" maxlength=50  onPaste="return false" />
                                          
											</div>
										</div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="AddOrgCity">City<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <input type="text" class="form-control" data-clear-btn="true" name="updOrgbusinesscity" id="updOrgbusinesscity" required="true" minlength="2" onkeypress="return addressValidation(event);" maxlength=50 onPaste="return false"  />
                                            </div>
                                  		</div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="updOrgPinCode">Pincode<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="updOrgPinCode" id="updOrgPinCode" digits="true" onkeypress='return event.charCode >= 48 && event.charCode <= 57' minlength="0" maxlength="6" onPaste="return false" />
                                               </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="updCountry">Country</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="updCountry" id="updCountry" required="true" minlength="5" onkeypress="return onlyAlphabets(event);" maxlength=50 value="INDIA" onlyalpha="true" readonly="readonly"  onPaste="return false"/> 
                                                </div>
                                        </div>
                                         
                                    </form>
                                            </div>
                                           
                                            <div class="modal-footer">
                                                <button type="button" class="btn-cancel" data-dismiss="modal" >Close</button>
                                                <button type="button" class="btn-submit"
													data-toggle="modal" data-target=".bs-example-modal-sm"
													onclick="return updOrgDetails();" id="UpdMerchantDetails"
													name="UpdMerchantDetails" <c:if test="${allMerchantDetails['emprole1'] == '10'||allMerchantDetails.emprole1 == '12'}">style="display:none;"</c:if>>Update</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
		<!---------------------------------- / nodal update modals ------------------------------------------------------>
		<div class="modal fade nodal_details_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" onclick="window.location.reload();">
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Nodal Beneficiary Details</h4>
				</div>
				<div class="modal-body">
		   <form class="form-horizontal form-label-left"> 
                                         
                           <div class="x_panel">
                                <div class="x_title">
                                    <h2>Basic Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                 <div class="x_content">
                                        <input type="hidden" id="nodalMerchantId" name="nodalMerchantId" value="">
                                        <input type="hidden" id="nodalOrgId" name="nodalOrgId" value="">
                                        <input type="hidden" id="nodalUserId" name="nodalUserId" value="">  
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BANK TID<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="nodalTid" id="nodalTid" readonly="readonly"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">CORP ID<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="banCorpId" id="banCorpId" value="acquiroP"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN IFSC<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benIfsc" id="benIfsc" required="true" minlength="2" maxlength=15 onkeypress="return isNodalAlphaNumericName3(event);" />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN AACCOUNT NO<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benAccNo" id="benAccNo" required="true" minlength="6" maxlength=50  onkeypress='return isNumberKey(event)' digits="true" />
                                            </div>
                                        </div>
                                       <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN NAME<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="nodalBenName" id="nodalBenName" required="true" minlength="2" maxlength=50 onkeypress="return isNodalAlphaNumericName1(event);" />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">MODE OFPAY<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	    <select data-clear-btn="true" name="nodalModeOfPay" id="nodalModeOfPay" class="form-control">
                                                    <option  value="NEFT"> NEFT</option>
                                                    <option  value="FT"> FT</option>
                                                    </select>
                                            </div>
                                        </div>
                      
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN ADDRESS<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benAddress" id="benAddress" required="true" minlength="2" maxlength=250  onkeypress="return addressValidation(event);"/>
                                            </div>
                                        </div>
                                        
                                        
                                       
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN STATE<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<select onchange="print_nodalCity('benCity', selectedIndex);" id="benState" name ="benState" class="form-control">
					                             	<option value="">STATE</option>
					                            </select>    
                                               <!--  <input type="text" class="form-control" data-clear-btn="true" name="benState" id="benState" required="true" minlength="2" maxlength=50  onkeypress="return addressValidation(event);"/>-->
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN CITY<span class="required">*</span></label>
                                             <div class="col-md-6 col-sm-6 col-xs-12">
                                           <!--  <script language="javascript">print_nodalState("benState");</script> -->
                                            	<select id="benCity" name ="benCity" class="form-control">
					                             	<option value="">CITY</option>
					                            </select>
                                              </div>                                            
                                           <!--  <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benCity" id="benCity" required="true" minlength="2" maxlength=50  onkeypress="return addressValidation(event);"/>
                                            </div>-->
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN PINCD<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benPinCd" id="benPinCd" required="true" minlength="6" maxlength=6  onkeypress="return isNumberKey(event);"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN DOB<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benDob" id="benDob" required="true" minlength="2" maxlength=200  />
                                            </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN BANK NAME<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benBankName" id="benBankName" required="true" minlength="6" maxlength=20 onkeypress="return isNodalBenBankName(event);" />
                                            </div>
                                        </div>
                                       <!--  <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN BANK CD<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benBankCd" id="benBankCd" required="true" minlength="2" maxlength=20  onkeypress="return isNodalAlphaNumericName3(event);"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN BRANCH CD<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benBranchCd" id="benBranchCd" required="true" minlength="2" maxlength=20  onkeypress="return isNodalAlphaNumericName3(event);"/>
                                            </div>
                                        </div>-->
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN EMAIL<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benEmail" id="benEmail" required="true" minlength="2" maxlength=100 email="true" />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN MOBILE<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benMobile" id="benMobile" required="true" minlength="10" maxlength=10 onkeypress='return isNumberKey(event)' digits="true" />
                                            </div>
                                        </div>
                                         <div class="form-group percent-50" style="display: none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN TRNPARTICULARS<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" value="CHANGING" name="benTrnParticulars" id="benTrnParticulars"  minlength="2" maxlength=50  onkeypress="return isNodalAlphaRemarks(event);"/>
                                            </div>                                                 
                                        </div>
                                        <div class="form-group percent-50" style="display: none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN TRNSRMKS<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" value="CHANGING" name="benTrnsRmks" id="benTrnsRmks" minlength="2" maxlength=50  onkeypress="return isNodalAlphaRemarks(event);"/>
                                            </div>
                                        </div>
                                        <!--  <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">ISSUE BRANCH CD<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="issueBranchCd" id="issueBranchCd" required="true" minlength="4" maxlength=20 onkeypress="return isNodalAlphaNumericName3(event);" />
                                            </div>
                                        </div>-->
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">BEN PAN<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="benPan" id="benPan" required="true" minlength="10" maxlength=10 onkeypress="return isNodalAlphaNumericName3(event);" />
                                            </div>
                                        </div>
     
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="UserAddress1">BEN TYPE<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="benType" id="benType" class="form-control">
                                                    <option  value="Sole Proprietor"> Sole Proprietor</option>
                                                    <option  value="Partnership Firm"> Partnership Firm</option>
                                                    <option  value="Private/Public Ltd Co/One Person Company"> Private/Public Ltd Co/One Person Company</option>
                                                    <option  value="Limited Liability Partnership Firms"> Limited Liability Partnership Firms</option>
                                                    <option  value="Societies/Clubs/Association of Persons/Condominum"> Societies/Clubs/Association of Persons/Condominum</option>
												</select>
											</div>
                                		</div>
                                		<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="benId">BEN ID<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="benId" id="benId" required="true" minlength="2" onkeypress="return addressValidation(event);"  maxlength=100 readonly="readonly"  />
                                          </div>
                                		</div>  
                                		<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="resStatus">STATUS<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="resStatus" id="resStatus" required="true" minlength="2"  readonly="readonly" maxlength=100   />
                                          </div>
                                		</div>  
                                		<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="resDesc">DESCRIPTION<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="resDesc" id="resDesc" required="true" minlength="2"  readonly="readonly" maxlength=100   />
                                          </div>
                                		</div>
                                	</div>
                                </div>
  <!----------------------------------------- panel business ---------------------------------------------------------->
               
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>NEFT Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                   <!--  <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">MODE OF PAY<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select data-clear-btn="true" name="modeOfPay" id="modeOfPay" required="true" class="form-control">
                                                    <option  value="">Choose option</option>
                                                   	<option  value="NEFT"> NEFT</option>
													<option  value="RTGS"> RTGS</option>
													<option  value="DD"> DD</option>
													<option  value="IMPS"> IMPS</option>
												</select>
                                            </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">MODE OF PAY(Y/N)<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select data-clear-btn="true" name="modeOfPayYn" id="modeOfPayYn" required="true" class="form-control">
                                                    <option  value="">Choose option</option>
                                                   	<option  value="YES"> YES</option>
													<option  value="NO"> NO</option>
												</select>
                                            </div>
                                        </div>-->
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">LIMIT DAILY<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" value="500000" name="limitDaily" id="limitDaily" required="true" onkeypress='return isNumberKey(event)' minlength="2" maxlength="8" number="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">LIMIT WEEKLY<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="limitWeekly" id="limitWeekly" required="true" value="3500000" onkeypress='return isNumberKey(event)' minlength="2" maxlength="10" number="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">LIMIT MONTHLY<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="limitMonthly" id="limitMonthly" required="true" value="15000000" onkeypress='return isNumberKey(event)' minlength="2" maxlength="12" number="true"/>  
                                            </div>
                                        </div>
                                </div>
                            </div>                            
                
  <!------------------------------------- panel personanal Address ----------------------------------------->
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Document Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                               			<div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="document1"> PAN Card <span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12" >
                                            	<input type="file" class="form-control" data-clear-btn="true" name="document1" id="document1" onchange="onFileSelectedDocument1(event)"  />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="document2"> ID Proof</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12" >
                                            	<input type="file" class="form-control" data-clear-btn="true" name="document2" id="document2" onchange="onFileSelectedDocument2(event)" />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="document3"> Document 3</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12" >
                                            	<input type="file" class="form-control" data-clear-btn="true" name="document3" id="document3" onchange="onFileSelectedDocument3(event)" />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="document4"> Document 4</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12" >
                                            	<input type="file" class="form-control" data-clear-btn="true" name="document4" id="document4" onchange="onFileSelectedDocument4(event)" />
                                            </div>
                                        </div>
                               			</div>   
                                       </div>   
                                         </form>
                                    </div>
                                                        
                                      <div class="modal-footer">
										<button type="button" class="btn-cancel" data-dismiss="modal" >Close</button>	
											<!-- <button type="button" class="btn-submit"
											data-toggle="modal" data-target=".bs-example-modal-sm"
											onclick="return nodalUpdDetails();" id="updNodalBene"
											name="updNodalBene">Update</button>-->
                                         
                                        <button type="button" class="btn-submit"
										data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return nodalAddDetails();" id="addNodalBene"
										name="addNodalBene">Update</button> 
                                          
                                       </div>
                                    
                                            </div>
                                            
                                        </div>
                                    </div>
                             
	
	

	<!---------------------------------- / send sms modals ------------------------------------------------------>
<div class="modal fade send_sms_popup" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">X</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel">Send SMS</h4>
                                            </div>
                                            <div class="modal-body12">
                                               <form class="form-horizontal form-label-left"> 
                                                <input type="hidden" id="MerchantId" name="MerchantId" value="">
                                                 <input type="hidden" id="sendOrgId" name="sendOrgId" value="">
                                                  <input type="hidden" id="sendUserId" name="sendUserId" value="">
                                                   <input type="hidden" id="sendRmn" name="sendRmn" value="">
                                               <div class="form-group percent-50">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">SMS Text<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" name="smstext" id="smstext" minlength="0" maxlength="100"  />
											 </div>
                                        </div>
                                                                         
                                    </form>
                                            </div>
                                           <div class="modal-footer">
											<button type="button" class="btn-cancel" data-dismiss="modal" onclick="window.location.reload();">Close</button>
                                            <button type="button" class="btn-submit" data-toggle="modal" data-target=".bs-example-modal-sm"
												onclick="return sendsms();" id="sendsms" name="updateMdr">Send</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

	
	<!--------------------------------------------------- Small modal ------------------------------------------->
	<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
	 	aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" onclick="window.location.reload();"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
				</div>
				<div id="modal-body" class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn-cancel" data-dismiss="modal" >Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- /page content -->

	<!-- footer content -->
	<jsp:include page="/jsp/footer.jsp" />
	<!-- /footer content -->
					                           