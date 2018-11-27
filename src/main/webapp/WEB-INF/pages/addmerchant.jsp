<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script src="<c:url value="resources/js/acqcitystate.js" />"></script>

<div class="content-wrapper">
<script type="text/javascript">
var expanded = false;

function showCheckboxes() {
  var checkboxes = document.getElementById("checkboxes");
  if (!expanded) {
    checkboxes.style.display = "block";
    expanded = true;
  } else {
    checkboxes.style.display = "none";
    expanded = false;
  }
}

var selectedFileAdd;

function onFileSelected(event) {
	selectedFileAdd = event.target.files[0];
	var iFileSize = selectedFileAdd.size;
    if (selectedFileAdd.name.split(".")[1].toUpperCase() == "PDF"||selectedFileAdd.name.split(".")[1] == "pdf"|| iFileSize < 70971520){
        var reader = new FileReader();
        var imgtag = document.getElementById("pdfFile");
        imgtag.title = selectedFileAdd.name;
        reader.onload = function(event) {
            imgtag.src = event.target.result;
        };
        reader.readAsDataURL(selectedFileAdd);      
    } else {
    	$("#pdfFile").val('');
        alert("Please select valid pdf.");
    }           
}

function submitMerchant(){
	$("#AddMerchantDetails").hide();
	$("#modal-body").html("<h2>In Process</h2>");
	var merchantName=$("#Name").val();
	var businessType=$("#BusinessType").val();
	var merchantType="wallet/credit";
	var directorsName=$("#DirectorsName").val();
	var authorizedSignatory=$("#AuthorizedSignatory").val();
	var businessNature=$("#BusinessNature").val();
	var businessCode=$("#BusinessCode").val();
	var marketingName=$("#MarketingName").val();
	var executiveName=$("#executiveName").val();
	var neftAmount =$("#neftAmount").val();
	var neftDate =$("#neftDate").val();
	var neftchequeNo =$("#neftchequeNo").val();
	var neftRefNo =$("#neftRefNo").val();
	var businessAddress1=$("#BusinessAddress1").val();
	var businessAddress2=$("#BusinessAddress2").val();
	var businessState=$("#businessstate").val();
	var businessCity=$("#businesscity").val();
	var businessPinCode=$("#BusinessPinCode").val();
	var personalAddress1=$("#UserAddress1").val();
	var personalAddress2=$("#UserAddress2").val();
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
	var cubMerchant ="NO";
	var personalState=null;
	var personalCity=null;
	if($("#sameStateCity").is(':checked')){
		personalState=$("#userstate1").val();
		personalCity=$("#usercity1").val();
	}else{
		personalState=$("#userstate").val();
		personalCity=$("#usercity").val();
	}
	var personalPinCode=$("#UserPinCode").val();
	var country=$("#Country").val();
	var phoneNo=$("#PhoneNo").val();
	var webSiteUrl=$("#Websiteurl").val();
	var emailId=$("#EmailId").val();
	var tinNo=$("#TinNo").val();
	var serviceTaxNo=$("#ServiceTaxNo").val();
	//var deviceSerialNo=$("#DeviceSerialNo").val();
	var pdfFile = document.getElementById("pdfFile");
	var note=$("#Note").val();
	var verificationStatus=$("#VerificationStatus").val();

	var appReceiptDate = $("#appReceiptDate").val();
	var typeOfSale = $("#typeOfSale").val();
	var amName = $("#amName").val();
	var tsoName = $("#tsoName").val();
	var onBoardEmpName = $("#onBoardEmpName").val();
	var onBoardingStatus = $("#onBoardingStatus").val();
	var verificationEntryDate = $("#verificationEntryDate").val();
	var agreementRcvdDate = $("#agreementRcvdDate").val();
	
	var appCheckStatus = $("#appCheckStatus").val();
	
	var regex="^[0-9]{1,8}[\\.]{1}[0-9]{0,2}?$";	
	 if(merchantName==null||merchantName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Name</p></n>Length should be min 2 and max 60 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(merchantName.length<2||merchantName.length>60){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Correct Format</p></n>Length should be min 2 and max 60 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessType=='Business Type'){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Business Type</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessType=='Others'){
	var other=$("#other").val();
	if(other==null||other==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Type Other</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(other.length<2||other.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Type</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		   return false;
	}
	if(executiveName!=null||executiveName!='' ){
		if(executiveName.length<2||executiveName.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Executive Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}
	}
	}else if(merchantType==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Merchant Type</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(directorsName==null||directorsName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Proprietor/Director/Partner Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(directorsName.length<2||directorsName.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Proprietor/Director/Partner Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(authorizedSignatory==null||authorizedSignatory==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Authorized Signatory</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(authorizedSignatory.length<2||authorizedSignatory.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Authorized Signatory</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessNature==null||businessNature==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Nature</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessNature.length<2||businessNature.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Nature</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(BusinessCode==null||BusinessCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Code</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(MarketingName==null||MarketingName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Marketing Name</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(MarketingName.length<2||MarketingName.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Marketing Name</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessAddress1==null||businessAddress1==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Address1</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessAddress1.length<2||businessAddress1.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Address1</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessAddress2==null||businessAddress2==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business Address2</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessAddress2.length<2||businessAddress2.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business Address2</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessState==null||businessState==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Business State</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessState.length<2||businessState.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business State</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessCity==null||businessCity==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Business City</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessCity.length<2||businessCity.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business City</p>');
		return false;
	}else if(businessPinCode==null||businessPinCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Business PinCode</p></n>Length should be 6 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(businessPinCode.length!=6){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Business PinCode</p></n>Length should be 6 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalAddress1==null||personalAddress1==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal Address1</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalAddress1.length<2||personalAddress1.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal Address1</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalAddress2==null||personalAddress2==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal Address2</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalAddress2.length<2||personalAddress2.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal Address2</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalState==null||personalState==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal State</p>');
		return false;
	}else if(personalState.length<2||personalState.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal State</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalCity==null||personalCity==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal City</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalCity.length<2||personalCity.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal City</p>');
		return false;
	}else if(personalPinCode==null||personalPinCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Personal PinCode</p></n>Length should be 6 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(personalPinCode.length!=6){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Personal PinCode</p></n>Length should be 6 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(country==null||country==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Country</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(country!='INDIA'){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Country</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(phoneNo==null||phoneNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Phone No</p></n>Phone No Length should be 10 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(phoneNo.length<10||phoneNo.length>54){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Phone No</p></n>Phone No Length should be 10 digits</n>Add Many Phone No with comma(,) Separeted');
		$("#AddMerchantDetails").show();
		return false;
	}else if(webSiteUrl!=null&&webSiteUrl!=''){
		var re = /(http(s)?:\\)?([\w-]+\.)+[\w-]+[.com|.in|.org]+(\[\?%&=]*)?/
		if(webSiteUrl.length>=100){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct WebSite Url</p></n>Length should be less than 100 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(re.test(webSiteUrl)==false){
			$("#modal-body").html('<h2>Validation Error</h2><p>website url Should be in proper format</p>');
			$("#AddMerchantDetails").show();
			return false;
		}
	}else if(emailId!=null&&emailId!=''){
		var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		console.log('re.test(emailId): '+re.test(emailId));
		if(emailId.length>100){
			console.log("email length is > 100");
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p>');
			$("#AddMerchantDetails").show();
			return false;
		}else if(re.test(emailId)==false){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct EmailId</p></n>Length should be less than 100 char');
			$("#AddMerchantDetails").show();
			return false;
	    }
	}else if(tinNo!=null&&tinNo!=''&&tinNo.length!=11){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Tin No</p></n>Length should be 11 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(serviceTaxNo!=null&&serviceTaxNo!=''&&serviceTaxNo.length!=15){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Service Tax No</p></n>Length should be 15 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(note!=null&&note!=''&&note>200){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Note</p></n>Length should be less than 200 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(verificationStatus==null||verificationStatus==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Verification Status</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(verificationStatus.length<3||verificationStatus.length>25){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Verification Status</p>');
		$("#AddMerchantDetails").show();
		return false;
	}
	if(modeofpayment=="Swipe"){
		if(swipeAmount==null||swipeAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter swipeAmount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(swipeAmount.length<1||swipeAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Swipe Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(swipeAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Swipe Amount Should be in proper format (xxxxxxxx.xx)</p>');
			$("#AddMerchantDetails").show();
				return false;
		}else if(SwipeDate==null||SwipeDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter SwipeDate</p>');
			$("#AddMerchantDetails").show();
			return false;
		}else if(swipeTerminal==null||swipeTerminal==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter swipeTerminal</p></n>Length should be min 2 and max 50 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(swipeTerminal.length<2||swipeTerminal.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Swipe Terminal</p>');
			$("#AddMerchantDetails").show();
			return false;
		}
	}
	else if(modeofpayment=="Cheque"){
		if(chequeNo==null||chequeNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeNo</p></n>Length should be min 1 and max 10 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeNo.length<1||chequeNo.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque No</p></n>Length should be min 1 and max 10 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeAmount==null||chequeAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cheque Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeAmount.length<1||chequeAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Cheque Amount Should be in proper format (xxxxxxxx.xx)</p>');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeDate==null||chequeDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeDate</p>');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeDepositDate==null||chequeDepositDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeDepositDate</p>');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeBank==null||chequeBank==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cheque Bank Name</p></n>Length should be min 1 and max 50 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeBank.length<1||chequeBank.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque Bank Name</p></n>Length should be min 1 and max 50 char');
			$("#AddMerchantDetails").show();
			return false;
		}
	}else if(modeofpayment=="Cash"){
		if(cashDate==null||cashDate==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cash Date</p>');
			$("#AddMerchantDetails").show();
			return false;
		}else if(cashAmount==null||cashAmount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cash Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(cashAmount.length<1||cashAmount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cash Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(cashAmount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Cash Amount Should be in proper format (xxxxxxxx.xx)</p>');
			$("#AddMerchantDetails").show();
			return false;
		}
	}else if(modeofpayment=="NEFT"){
		
	if(neftAmount==null||neftAmount==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter neft Amount</p></n>Length should be min 1 and max 11 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(neftAmount.length<1||neftAmount.length>11){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct neft Amount</p></n>Length should be min 1 and max 11 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(neftAmount.match(regex) == null){
		$("#modal-body").html('<h2>Validation Error</h2><p>neft Amount Should be in proper format (xxxxxxxx.xx)</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(neftDate==null||neftDate==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter neft Date</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(neftchequeNo==null&&neftRefNo==null){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Neft chequeNo OR Ref chequeNo</p></n>Length should be min 1 and max 10 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(neftchequeNo==""&&neftRefNo==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Neft chequeNo OR Ref chequeNo</p></n>Length should be min 1 and max 10 char');
		$("#AddMerchantDetails").show();
		return false;
	}
}


	
	var frmData = new FormData();
	frmData.append("Name", merchantName);
	frmData.append("BusinessType", businessType);	
	frmData.append("DirectorsName",directorsName);
	//console.log("1111"+directorsName);
	frmData.append("AuthorizedSignatory",authorizedSignatory);
	//console.log("1111"+authorizedSignatory);
	frmData.append("BusinessNature",businessNature);
	//console.log("1111"+businessNature);
	frmData.append("BusinessCode",businessCode);
	//console.log("1111"+businessCode);
	frmData.append("MarketingName",marketingName);
	//console.log("1111"+marketingName);
	frmData.append("BusinessAddress1",businessAddress1);
	//console.log("1111"+businessAddress1);
	frmData.append("businessAddress2",businessAddress2);
	//console.log("1111"+businessAddress2);
	frmData.append("BusinessState",businessState);
    //console.log("1111"+businessState);
	frmData.append("BusinessCity",businessCity);
	//console.log("1111"+businessCity);
	frmData.append("BusinessPincode",businessPinCode);
	//console.log("1111"+businessPinCode);
	frmData.append("PersonalUserAddress1",personalAddress1);
	//console.log("1111"+personalAddress1);
	frmData.append("PersonalUserAddress2",personalAddress2);
	//console.log("1111"+personalAddress2);
	frmData.append("PersonalUserState",personalState);
	//console.log("1111"+personalState);
	frmData.append("PersonalUserCity",personalCity);
	//console.log("1111"+personalCity);
	frmData.append("PersonalUserPincode",personalPinCode);
	//console.log("1111"+personalPinCode);
	frmData.append("Country",country);
	frmData.append("PhoneNo",phoneNo);
	frmData.append("WebsiteUrl",webSiteUrl);
	frmData.append("EmailId",emailId);
	frmData.append("TinNo",tinNo);
	frmData.append("ServiceTaxNo",serviceTaxNo);
	frmData.append("executiveEmail",executiveName);
	frmData.append("Note",note);
	frmData.append("VerificatonStatus",verificationStatus);	
	frmData.append("cubMerchant",cubMerchant);	
	frmData.append("swipeAmount",swipeAmount);
	//alert('swipeAmount  '+swipeAmount);
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
	var opts = {
            type: "POST",
            success: function (data) {
                var obj = JSON.parse(data);
                $(".loading").css("visibility","hidden");
                if (obj.status==0&&obj.message=='OK') {
                    $("#modal-body").html("<h2>Merchant Added Successfully</h2><p>Application No Is <Strong>"+obj.result+"</strong></p>");  
                    $("#AddMerchantDetails").show();
                    $("#Name").val('');$("#BusinessType").val('');$("#merchantType").val('');
                    $("#DirectorsName").val('');$("#AuthorizedSignatory").val('');
                    $("#BusinessNature").val('');$("#BusinessCode").val('');
                    $("#MarketingName").val('');$("#BusinessAddress1").val('');$("#BusinessAddress2").val('');
                    //$("#businessstate").val('');$("#businesscity").val('');
                    $("#BusinessPinCode").val('');$("#UserAddress1").val('');$("#UserAddress2").val('');
                    $("#UserPinCode").val('');;$("#PhoneNo").val('');
                    $("#Websiteurl").val('');$("#EmailId").val('');$("#TinNo").val('');
                    $("#ServiceTaxNo").val('');$("#Note").val('');
                    $("#modeofpayment").val(''); $("#cashDate").val(''); $("#cashAmount").val('');
                    $("#chequeBank").val(''); $("#chequeDepositDate").val(''); $("#chequeDate").val('');
                    $("#chequeAmount").val(''); $("#chequeDepositDate").val(''); $("#chequeNo").val('');
                    $("#swipeTerminal").val(''); $("#SwipeDate").val(''); $("#swipeAmount").val('');
                    $("#sameStateCity").val('');$("#SwipeDate").val(''); $("#swipeAmount").val('');
                    $("#neftAmount").val('');$("#neftDate").val(''); $("#neftchequeNo").val(''); $("#neftRefNo").val('');
                    location.reload();
                } else if (data.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (obj.message.startsWith('Invalid')) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>");
                    $("#AddMerchantDetails").show();                    
                }else if (obj.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+obj.message+"</p>"); 
                    $("#AddMerchantDetails").show();                   
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
                    $("#AddMerchantDetails").show();
                }
            },
            error: function (data, textStatus, errorThrown) {
                $(".loading").css("visibility","hidden");
                if(textStatus=="timeout"){
                	$("#modal-body").html("<h2>Connection Error</h2><p>Your Request Has Timed-Out. Please Try Again Later</p>");
                	$("#AddMerchantDetails").show();
                }else{
                	$("#modal-body").html("<h2>Connection Error</h2><p>"+ textStatus+"</p>");  
                	$("#AddMerchantDetails").show();
                }
            },            
            mimeType:"multipart/form-data",
		    contentType: false,
	      	cache: false,
	       	processData:false,
	       	url: "addmerchant",
            data: frmData
        }; 
        $.ajax(opts);
        return false;
}
function onOffSameAddress() {
	if($("#sameStateCity").is(":checked") == true) {
	  	$("#userstatedropdowndiv").hide();
	  	$("#usercitydropdowndiv").hide();
	  	$("#userstatediv").show();
	  	$("#usercitydiv").show();
	  	var address1=$("#BusinessAddress1").val();
		var address2=$("#BusinessAddress2").val();
		$("#UserAddress1").val(address1);
		$("#UserAddress2").val(address2);
  		var businessstate = $('#businessstate').val();
  		$('#userstate1').val(businessstate); 
  		var businesscity = $('#businesscity').val();
  		$('#usercity1').val(businesscity);
  		$('#UserPinCode').val($('#BusinessPinCode').val());
	}else{
	 	$("#UserAddress1").val('');
	  	$("#UserAddress2").val('');
	  	$("#userstatedropdowndiv").show();
	  	$("#usercitydropdowndiv").show();
	  	$("#userstatediv").hide();
	  	$("#usercitydiv").hide();
	  	$("#UserPinCode").val('');
	}
}
function addOrgSub(){
	console.log('add org sub is called');
	var table = document.getElementById("orgListTable");
	var row = table.insertRow(0);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	cell1.innerHTML = $("#AddOrgName").val();
	cell2.innerHTML = "<a href='#'>Add Device/User</a>";
	cell3.innerHTML = "Delete";
}</script>
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
    });
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
    });

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
</script>
<script type="text/javascript">
function fillBilling(f) {
	  if(f.billingtoo.checked == true) {
	    f.UserPhoneNo.value = f.PhoneNo.value;
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
            if (modeofpayment == "Swipe") 
            {
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
           	}
           	else if (modeofpayment == "Cheque") 
            {
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
          	}
          	else if (modeofpayment == "Cash") 
            {
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
          	}else if (modeofpayment == "NEFT") 
            {
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
           }
      });
    });
</script> 
    <!-- Content Header (Page header) -->

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add Merchant</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Merchant Name</label>
                      <input type="text" class="form-control input-lg" id="Name" placeholder="Enter Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business Type</label>
                      <div class="selectBox" onclick="showCheckboxes()">
						        <select data-clear-btn="true" name="BusinessType"
										id="BusinessType" required="true" class="form-control input-lg">
											<option value="">Choose	option</option>	
											<option value="1"> Proprietor</option>
											<option value="2"> Joint Proprietor</option>
											<option value="3"> LLP</option>
											<option value="4"> Public Ltd</option>
											<option value="5"> Trust</option>
											<option value="6"> HUF</option>
											<option value="7"> Others</option>
											<option value="8"> Partnership</option>
											<option value="9"> Private Ltd</option>
											</select>  
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Proprietor /Partner Name /Director /Trustee Name</label>
                      <input type="text" class="form-control input-lg" id="DirectorsName" placeholder="Enter Director Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Authorized Signatory</label>
                      <input type="text" class="form-control input-lg" id="AuthorizedSignatory" placeholder="Enter AuthorizedSignatory">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business Nature</label>
                      <input type="text" class="form-control input-lg" id="BusinessNature" placeholder="Enter Business Nature">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">MCC Code</label>
                     <select data-clear-btn="true" name="BusinessCode" id="BusinessCode" required="true" class="form-control input-lg">
                                                    <option  value="">Choose option</option>
                                                   	<option  value="5691"> MENS AND WOMENS CLOTHING STORES</option>
													<option  value="5271"> MOBILE HOME DEALERS</option>
													<option  value="5812"> EATING PLACES, RESTAURANTS</option>
													<option  value="5399"> MISCELLANEOUS GENERAL MERCHANDISE STORES</option>
													<option  value="5732"> ELECTRONIC SALES</option>
													<option  value="5045"> COMPUTERS, COMPUTER PERIPHERAL EQUIPMENT</option>
													<option  value="5944"> CLOCK STORES</option>
													<option  value="5511"> TRUCK,AUTO DEALERS.SALES,SERVICE,REPAIRS,PARTS,LEA</option>
													<option  value="6300"> INSURANCE SALES, UNDERWRITING, AND PREMIUMS</option>
													<option  value="4722"> TRAVEL AGENCIES AND TOUR OPERATORS</option>
													<option  value="5411"> GROCERY STORES</option>
													<option  value="5921"> PACKAGE, STORES, BEER, WINE, LIQUOR</option>
													<option  value="5912"> DRUG STORES</option>
													<option  value="7011"> LODGING:HOTELS, MOTELS, RESORTS</option>
													<option  value="7230"> BARBER SHOPS</option>
													<option  value="8062"> HOSPITALS</option>
													<option  value="8043"> EYEGLASSES</option>
													<option  value="7298"> BEAUTY SPAS</option>
													<option  value="5712"> EQUIPMENT STORES (EXCEPT APPLIANCES)</option>
													<option  value="5661"> SHOE STORES</option>
													<option  value="5947"> CARD SHOPS</option>
													<option  value="4812"> TELECOMMUNICATION EQUIPMENT INCLUDING TELEPHONE SA</option>
													<option  value="5722"> HOUSEHOLD APPLIANCE STORES</option>
													<option  value="5541"> SERVICE STATIONS (WITH OR WITHOUT ANCILLARY SERVIC</option>
													<option  value="5311"> DEPARTMENT STORES</option>
													<option  value="5533"> AUTOMOTIVE PARTS, ACCESSORIES STORES</option>
													<option  value="5977"> COSMETIC STORES</option>
													<option  value="8011"> DOCTORS</option>
													<option  value="8021"> DENTISTS</option>
													<option  value="5451"> DAIRY PRODUCTS STORES</option>
													<option  value="5948"> LEATHER GOODS STORES</option>
													<option  value="7641"> FURNITURE.REUPHOLSTERY AND REPAIR, REFINISHING</option>
													<option  value="8299"> SCHOOLS AND EDUCATIONAL SERVICES</option>
													<option  value="7221"> PHOTOGRAPHIC STUDIOS</option>
													<option  value="5441"> CANDY STORES</option>
													<option  value="5521"> AUTOMOBILE AND TRUCK DEALERS.(USED ONLY).SALES</option>
													<option  value="5971"> ART DEALERS AND GALLERIES</option>
													<option  value="5251"> HARDWARE STORES</option>
													<option  value="5532"> AUTOMOTIVE TIRE STORES</option>
													<option  value="8398"> CHARITABLE ORGANIZATIONS</option>
													<option  value="5462"> BAKERIES</option>
													<option  value="5651"> FAMILY CLOTHING STORES</option>
													<option  value="7216"> DRY CLEANERS</option>
													<option  value="5039"> CONSTRUCTION MATERIALS</option>
													<option  value="5940"> BICYCLE SHOPS.SALES AND SERVICE</option>
													<option  value="5499"> CONVENIENCE, SPECIALTY, MISCELLANEOUS FOOD STORES</option>
													<option  value="5611"> MENS AND BOYS. CLOTHING AND ACCESSORIES STORES</option>
													<option  value="7392"> CONSULTING SERVICES</option>
													<option  value="5122"> DRUGS, DRUG PROPRIETARIES, AND DRUGGISTS SUNDRIES</option>
													<option  value="5966"> DIRECT MARKETING.OUTBOUND TELEMARKETING MERCHANTS</option>
													<option  value="5942"> BOOK STORES</option>
													<option  value="4214"> MOTOR FREIGHT,TRUCKING,MOVING & STORAGE COMPANIES</option>
													<option  value="5811"> CATERERS</option>
													<option  value="5231"> GLASS STORES</option>
													<option  value="7372"> COMPUTER PROGRAMMING SERVICES</option>
													<option  value="5065"> ELECTRICAL PARTS AND EQUIPMENT</option>
													<option  value="6513"> REAL ESTATE AGENTS AND MANAGERS.RENTALS</option>
													<option  value="5198"> PAINTS AND SUPPLIES</option>
													<option  value="8099"> HEALTH PRACTITIONERS</option>
													<option  value="4215"> COURIER SERVICES.AIR AND GROUND, FREIGHT FORWARDER</option>
													<option  value="5047"> DENTAL EQUIPMENT AND SUPPLIES</option>
													<option  value="5949"> FABRIC STORES</option>
													<option  value="1520"> GENERAL CONTRACTORS.RESIDENTIAL AND COMMERCIAL</option>
													<option  value="4789"> TRANSPORTATION SERVICES</option>
													<option  value="6011"> MEMBER FINANCIAL INSTITUTION.AUTOMATED CASH DISPEN</option>
													<option  value="7512"> AUTOMOBILE RENTAL AGENCY</option>
													<option  value="5995"> PET SHOPS.PET FOOD AND SUPPLIES</option>
													<option  value="8661"> RELIGIOUS ORGANIZATIONS</option>
													<option  value="7993"> VIDEO AMUSEMENT GAME SUPPLIES</option>
													<option  value="5970"> ARTIST SUPPLY STORES</option>
													<option  value="7998"> AQUARIUMS</option>
													<option  value="5943"> OFFICE SUPPLY STORES</option>
													<option  value="5571"> MOTORCYCLE SHOPS AND DEALERS</option>
													<option  value="5994"> NEWS DEALERS AND NEWSSTANDS</option>
													<option  value="5734"> COMPUTER SOFTWARE STORES</option>
													<option  value="5735"> RECORD SHOPS</option>
													<option  value="5331"> VARIETY STORES</option>
													<option  value="7333"> ART, COMMERCIAL</option>
													<option  value="7538"> AUTOMOTIVE SERVICE SHOPS</option>
													<option  value="5072"> HARDWARE EQUIPMENT AND SUPPLIES</option>
													<option  value="5137"> CHILDRENS, MENS, WOMEN UNIFORMS AND COMMERCIAL CLO</option>
													<option  value="5997"> ELECTRIC RAZOR STORES.SALES AND SERVICE</option>
													<option  value="4814"> CALLS THROUGH USE OF MAGNETIC STRIPE.READING TELEP</option>
													<option  value="7379"> COMPUTER MAINTENANCE, REPAIR, AND SERVICES</option>
													<option  value="7631"> CLOCK REPAIR SHOPS</option>
													<option  value="5713"> FLOOR COVERING STORES</option>
													<option  value="5641"> CHILDRENS AND INFANTS. WEAR STORES</option>
													<option  value="5941"> SPORTING GOODS STORES</option>
													<option  value="7922"> THEATRICAL PRODUCERS,TICKET AGENCIES (EXCL.MOTION</option>
													<option  value="1761"> ROOFING AND SIDING CONTRACTORS</option>
													<option  value="8675"> AUTOMOBILE ASSOCIATIONS</option>
													<option  value="7299"> OTHER SERVICES</option>
													<option  value="7542"> CAR WASHES</option>
													<option  value="2741"> MISCELLANEOUS PUBLISHING AND PRINTING</option>
													<option  value="5946"> CAMERA STORES</option>
													<option  value="7623"> AIR CONDITIONING REPAIR SHOPS</option>
													<option  value="7211"> LAUNDRY SERVICES.FAMILY AND COMMERCIAL</option>
													<option  value="763 ">AGRICULTURAL COOPERATIVES</option>
													<option  value="7929"> BANDS, ORCHESTRAS, AND MISCELLANEOUS ENTERTAINERS</option>
													<option  value="1731"> ELECTRICAL CONTRACTORS</option>
													<option  value="5051"> METAL SERVICE CENTERS AND OFFICES</option>
													<option  value="5021"> COMMERCIAL FURNITURE</option>
													<option  value="4900"> ELECTRIC.UTILITIES</option>
													<option  value="7996"> AMUSEMENT PARKS</option>
													<option  value="5933"> PAWN SHOPS</option>
													<option  value="5211"> BUILDING MATERIALS STORES</option>
													<option  value="5172"> PETROLEUM AND PETROLEUM PRODUCTS</option>
													<option  value="8999"> AUCTIONS</option>
													<option  value="7629"> APPLIANCE REPAIR SHOPS, ELECTRICAL AND SMALL</option>
													<option  value="7399"> BUSINESS SERVICES</option>
													<option  value="4816"> COMPUTER NETWORK/INFORMATION SERVICES</option>
													<option  value="6012"> MEMBER FINANCIAL INSTITUTION.MERCHANDISE AND SERVI</option>
													<option  value="5111"> OFFICE SUPPLIES, PRINTING AND WRITING PAPER, STATI</option>
													<option  value="5094"> PRECIOUS STONES AND METALS</option>
                                                </select>
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Phone No</label>
                      <input type="number" class="form-control input-lg" id="PhoneNo" placeholder="Enter Phone No">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Marketing Name</label>
                      <input type="text" class="form-control input-lg" id="MarketingName" placeholder="Enter Marketing Name">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Website Url</label>
                      <input type="url" class="form-control input-lg" id="Websiteurl" placeholder="Enter Website url">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Email Id</label>
                      <input type="email" class="form-control input-lg" id="EmailId" placeholder="Enter Email Id">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business Address 1</label>
                      <input type="text" class="form-control input-lg" id="BusinessAddress1" placeholder="Enter Business Address 1">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business Address 2</label>
                      <input type="text" class="form-control input-lg" id="BusinessAddress2" placeholder="Enter Business Address 1">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business State</label>
                     <select onchange="print_businesscity('businesscity', selectedIndex);" id="businessstate" name ="businessstate" class="form-control input-lg">
					    <option value="">STATE</option>
					 </select> </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business City</label>
                     <script language="javascript">print_businessstate("businessstate");</script>
                      <select id="businesscity" name ="businesscity" class="form-control input-lg">
					    <option value="">CITY</option>
					  </select>
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Business Pincode</label>
                      <input type="text" class="form-control input-lg" id="BusinessPinCode" placeholder="Enter Pincode">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Country</label>
                      <input type="text" class="form-control input-lg" id="Country1" value="INDIA" readonly="readonly">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1"></label>
                       <input type="checkbox" style="margin:0 !important;position:relative !important" id="sameStateCity" name="sameStateCity" onchange="onOffSameAddress();"> Personal Address Same As Business Address                                                   
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Address 1</label>
                      <input type="text" class="form-control input-lg" id="UserAddress1" placeholder="Enter User Address1">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Address 2</label>
                      <input type="text" class="form-control input-lg" id="UserAddress2" placeholder="Enter User Address2">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">State</label>
                       <select onchange="print_usercity('usercity',this.selectedIndex);" id="userstate" name ="userstate" class="form-control input-lg">
					       <option value="">STATE</option>
					   </select>
                    </div>
                  </div>
                </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">State</label>
                      <input type="text" class="form-control input-lg" id="userstate1" placeholder="Enter State">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">City</label>
                      <script language="javascript">print_userstate("userstate");</script>
                         <select id="usercity" name ="usercity" class="form-control input-lg">
					         <option value="">CITY</option>
					     </select>
                    </div>
                  </div>
                </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">City</label>
                      <input type="text" class="form-control input-lg" id="usercity1" placeholder="Enter User City">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Country</label>
                        <input type="text" class="form-control input-lg" id="Country" value="INDIA">
                    </div>
                  </div>
                </div>
                
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Tin No</label>
                      <input type="text" class="form-control input-lg" id="TinNo" placeholder="Enter Tin No">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">GST No</label>
                        <input type="text" class="form-control input-lg" id="ServiceTaxNo" placeholder="Enter ServiceTaxNo">
                    </div>
                  </div>
                </div>
                  <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Mode of Payment Collection</label>
                      <select name="modeofpayment" id="modeofpayment" class="form-control input-lg">
                                                	<option value="">Select Option</option>
                                                	<option value="Free">Free</option>
	                                                <option value="Swipe">Swipe</option>
	                                                <option value="Cheque">Cheque</option>
	                                                <option value="Cash">Cash/DD</option>
	                                               <option value="NEFT">Internet Payment Gateway(E-Wallet/NEFT/RTGS/IMPS/PAYTM)</option>
                                                </select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_swipeAmount" style="display:none;">
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="number" class="form-control input-lg" id="swipeAmount" placeholder="Enter Amount" step=".01">
                    </div>
                  </div>
                </div>
               <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" id="div_SwipeDate" style="display:none;">
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="SwipeDate" id="SwipeDate" readonly='true'/>
                                           
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_swipeTerminal" style="display:none;">
                      <label for="exampleInputEmail1">Swiped on the terminal of</label>
                        <input type="text" class="form-control input-lg" id="swipeTerminal" placeholder="Enter swipe Terminal">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_swipeCardType" style="display:none;">
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
                  <div class="col-md-5">
                    <div class="form-group" id="div_chequeNo" style="display:none;">
                      <label for="exampleInputEmail1">Cheque No</label>
                     <input type="number" class="form-control input-lg" id="chequeNo" placeholder="Enter cheque No"> </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_chequeAmount" style="display:none;">
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="number" class="form-control input-lg" id="chequeAmount" placeholder="Enter cheque Amount" step=".01">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" id="div_chequeDate" style="display:none;">
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="chequeDate" id="chequeDate" readonly='true'/>
                      </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_chequeDepositDate" style="display:none;">
                      <label for="exampleInputEmail1">Cheque Deposit Date</label>
                          <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="chequeDepositDate" id="chequeDepositDate" readonly='true'/>
                      </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" id="div_chequeBank" style="display:none;">
                      <label for="exampleInputEmail1">Bank Name</label>
                        <input type="text" class="form-control input-lg" id="chequeBank" placeholder="Enter Cheque Bank">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_cashAmount" style="display:none;">
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="number" class="form-control input-lg" id="cashAmount" placeholder="Enter Amount" step=".01">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" id="div_cashDate" style="display:none;">
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="cashDate" id="cashDate" readonly='true'/>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_neft" style="display:none;">
                      <label for="exampleInputEmail1">Amount</label>
                        <input type="text" class="form-control input-lg" id="neftAmount" placeholder="Enter Amount" step=".01">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" id="div_neftDate" style="display:none;">
                      <label for="exampleInputEmail1">Date</label>
                            <input type="text" class="date-picker form-control input-lg" data-role="date" data-clear-btn="true" name="neftDate" id="neftDate" readonly='true'/>
                                           
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_neftchequeNo" style="display:none;">
                      <label for="exampleInputEmail1">Cheque No.</label>
                        <input type="text" class="form-control input-lg" id="neftchequeNo" placeholder="Enter Cheque No">
                    </div>
                  </div>
                </div>
            
            
            <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" id="div_neftRefNo" style="display:none;">
                      <label for="exampleInputEmail1">Ref/UTR. No.</label>
                            <input type="number" class="form-control input-lg" data-role="date" data-clear-btn="true" name="neftRefNo" id="neftRefNo" />
                                           
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" id="div_neftchequeNo" style="display:none;">
                      <label for="exampleInputEmail1">Cheque No.</label>
                        <input type="text" class="form-control input-lg" id="neftchequeNo" placeholder="Enter Cheque No">
                    </div>
                  </div>
                </div>
               
               
               
               <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" >
                      <label for="exampleInputEmail1">Upload Document</label>
                         	<input type="file" class="form-control input-lg" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" />
                                                             
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">Distributor Name</label>
                        <select name="executiveName" id="executiveName" class="form-control input-lg">
										    	<option value="">select</option>
										 			<c:forEach var="RowData" items="${executiveList}">
										 				<option value="<c:out value="${RowData['executiveEmail']}"/>" <c:if test="${RowData['executiveEmail'] == param.executiveEmail}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
						</select>
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" >
                      <label for="exampleInputEmail1">Remark</label>
                           <input type="number" class="form-control input-lg" data-role="date" data-clear-btn="true" name="Note" id="Note" />
                                                              
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">Verification Status</label>
                        <select data-clear-btn="true" name="VerificationStatus" id="VerificationStatus" required="true" class="form-control input-lg">
										         	<option value="File Sent To Bank">File Sent To Bank</option>
										          	<option value="MID-TID Received">MID-TID Received</option>
										          	<option value="Mapping In-Process">Mapping In-Process</option>
										          	<option value="In Quality Check">In Quality Check</option>
										          	<option value="Activated">Activated</option>
										            <!--<option value="Pending">Pending</option>
										            <option value="In Process">In Process</option>
										             <option value="Verified">Verified</option>  -->          
										          </select> 
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" >
                      <label for="exampleInputEmail1">>Original App Status</label>
                         	<select data-clear-btn="true" name="appCheckStatus" id="appCheckStatus"  class="form-control input-lg">
										         	<option value="">Select</option>
										         	<option value="Yes">Yes</option>
										          	<option value="No">No</option>										                    
										          </select>                                 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">App Receipt Date</label>
                           	<input type="text" class="form-control input-lg" data-clear-btn="true" name="appReceiptDate" id="appReceiptDate"   maxlength=20  />
                                           
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" >
                      <label for="exampleInputEmail1">Type Of Sale</label>
                         	<select data-clear-btn="true" name="typeOfSale" id="typeOfSale" required="true" class="form-control input-lg">
										         	<option value="Distributor">Distributor</option>
										          	<option value="Direct">Direct</option>										                    
										          </select>                                
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">AM Name</label>
                         <select name="amName" id="amName" class="form-control input-lg">
										    	<option value="">select</option>
										 			<c:forEach var="RowData" items="${executiveList}">
										 				<option value="<c:out value="${RowData['executiveEmail']}"/>" <c:if test="${RowData['executiveEmail'] == param.executiveEmail}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
											</select>                  
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" >
                      <label for="exampleInputEmail1">TSO Name</label>
                         	<select name="tsoName" id="tsoName" class="form-control input-lg">
										    	<option value="">select</option>
										 			<c:forEach var="RowData" items="${executiveList}">
										 				<option value="<c:out value="${RowData['executiveEmail']}"/>" <c:if test="${RowData['executiveEmail'] == param.executiveEmail}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
											</select>                                
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">OnBoard Emp Name</label>
                           	<input type="text" class="form-control input-lg" data-clear-btn="true" name="onBoardEmpName" id="onBoardEmpName" value='<c:out value="${employeeName}"/>' readonly="readonly"   maxlength=20  />
                                           
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group" >
                      <label for="exampleInputEmail1">OnBoarding Status</label>
                         	<select data-clear-btn="true" name="onBoardingStatus" id="onBoardingStatus" required="true" class="form-control input-lg">
										         	<option value="Pending"> Pending</option>
										          	<option value="Verified"> Verified</option>
										          	<option value="Entry done"> Entry done</option>
										          	<option value="Rejected"> Rejected</option>           
										          </select>                             
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">Verification Entry Date</label>
                           	<input type="text" class="form-control input-lg" data-clear-btn="true" name="verificationEntryDate" id="verificationEntryDate"  />
                                           
                    </div>
                  </div>
                </div>
                <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group" ">
                      <label for="exampleInputEmail1">Agreement Recevied Date</label>
                           	<input type="text" class="form-control input-lg" data-clear-btn="true" name="agreementRcvdDate" id="agreementRcvdDate"  />
                                           
                    </div>
                  </div>
                
                
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" onclick="return submitMerchant();">Submit</button>
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