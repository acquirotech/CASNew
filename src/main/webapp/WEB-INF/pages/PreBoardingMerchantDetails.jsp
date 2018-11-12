<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("5")||session.getAttribute("empRole").equals("5")||session.getAttribute("empRole").equals("4")||session.getAttribute("empRole").equals("6")||session.getAttribute("empRole").equals("7")||session.getAttribute("empRole").equals("9")||session.getAttribute("empRole").equals("10"))){	
	response.sendRedirect("welcome");
}%>

<script src="<c:url value="/resources/js/Acqcitystate.js" />"></script>

<!----------------------------------------------jsFunction---------------------------------------------------------  -->
<script type="text/javascript">
$(document).ready(function (){
	<c:if var="msg" test="${kycCheck!=null}">
	var msg = '<c:out value="${kycCheck}" />';
	console.log("22222:::"+msg);
	if(msg=="0"){
		console.log("111111111:::"+'<c:out value="${kycCheck}" />');
		  $("#kycCheck").prop( "checked", false );	
		  $("#financeCheck").prop( "checked", false );			  
	}else if(msg=="1"){
		  $("#kycCheck").prop( "checked", true );	
		  $("#financeCheck").prop( "checked", false );	
	}else if(msg=="2"){
		$("#kycCheck").prop( "checked", true );	
		  $("#financeCheck").prop( "checked", true );
		}
</c:if>	
});

function addressValidation(evt) {
	try {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==33||charCode==35||charCode==38||charCode==40||charCode==41||charCode==44||charCode==45||charCode==46||charCode==47||charCode==58||charCode==95) {
		   	return true;
		}else{
			return false;
		}
	}catch (err) {
		alert('error');
		alert(err.Description);
	}
}

function setFinanceCheck(){
	console.log("1111");
	if($("#kycCheck").is(":checked") == true) {
		return true;
	}else{
		alert("KYc check is not completed");
		return false;
	}	
	}

function tinNoValidate(evt){
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if ((charCode >= 48 && event.charCode <= 57)||charCode==8||charCode==37||charCode==39){
 	   return true;
 	}else{
 	   return false;
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
	 $("#modal-body").html("<h2>In Process</h2>");
	var merchantId=$("#merchantId").val();
	var merchantName=$("#Name").val();
	var executiveName=$("#executiveName").val();
	var marketingName=$("#MarketingName").val();
	var businessState=$("#businessstate").val();
	var businessCity=$("#businesscity").val();
	var phoneNo=$("#PhoneNo").val();
	var note=$("#note").val();
	var cubBranch="NA";
	var location=$("#location").val();
	var verificationStatus=$("#VerificationStatus").val();
	var chequeNo =$("#chequeNo").val();
	var amount =$("#amount").val();
	var kycCheck =$("#kycCheck").val();
	var financeCheck =$("#financeCheck").val();
	if($("#kycCheck").is(":checked") == true) {
		var kycCheck = "1";
	}if($("#financeCheck").is(":checked") == true) {
		var kycCheck = "2";
	}
	var fileName;
	if (selectedFileAdd != undefined) {
		fileName=selectedFileAdd;
	}
	var regex="^[0-9]{1,8}[\\.]{1}[0-9]{0,2}?$";
	if(merchantName==null||merchantName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Name</p></n>Length should be min 2 and max 60 char');
		return false;
	}else if(merchantName.length<2||merchantName.length>60){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Correct Format</p></n>Length should be min 2 and max 60 char');
		return false;
	}
	if(executiveName!=null&&executiveName!='' ){
		if(executiveName.length<2||executiveName.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Executive Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}}else if(MarketingName==null||MarketingName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Marketing Name</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(MarketingName.length<2||MarketingName.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Marketing Name</p></n>Length should be min 2 and max 50 char');
		return false;
	}else if(location==null||location==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Location</p>');
		return false;
	}else if(location.length<2||location.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Location</p>');
		return false;
	}else if(phoneNo==null||phoneNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Phone No</p></n>Phone No Length should be 10 digits');
		return false;
	}else if(phoneNo.length<10||phoneNo.length>10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Phone No</p></n>Phone No Length should be 10 digits');
		return false;
	}else if(note!=null&&note!=''&&note>200){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Note</p></n>Length should be less than 200 char');
		return false;
	}else if(verificationStatus==null||verificationStatus==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Verification Status</p>');
		return false;
	}else if(verificationStatus.length<3||verificationStatus.length>12){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Verification Status</p>');
		return false;
	}if(chequeNo==null||chequeNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeNo</p></n>Length should be min 1 and max 45 char');
			return false;
		}else if(chequeNo.length<1||chequeNo.length>50){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque No</p></n>Length should be min 1 and max 45 char');
			return false;
		}else if(amount==null||amount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter cheque Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(amount.length<1||amount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque Amount</p></n>Length should be min 1 and max 11 char');
			return false;
		}else if(amount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p>Cheque Amount Should be in proper format (xxxxxxxx.xx)</p>');
			return false;
	}if(kycCheck!="2" && verificationStatus == "oktoboard"){
		$("#modal-body").html('<h2>Validation Error</h2><p>Finance check is not completed</p>');
		return false;
	 }
 	var frmData = new FormData();
 	frmData.append("id", merchantId);
	frmData.append("name", merchantName);
 	frmData.append("executiveName",executiveName);
 	frmData.append("marketingName",marketingName);
	frmData.append("phoneNo",phoneNo);
	frmData.append("note",note);
	frmData.append("location",location);
	frmData.append("status",verificationStatus);	
	frmData.append("chequeNo",chequeNo);
	frmData.append("amount",amount);	
	frmData.append("kycCheck",kycCheck);	
	frmData.append("cubBranch",cubBranch);
	if (selectedFileAdd != undefined) {
		frmData.append("file", selectedFileAdd);
	}		
	console.log("hello "+frmData);
	var opts = {
			type: "POST",
            success: function (data) {
               var obj = JSON.parse(data);
               if (obj.status == 0&&obj.message=='OK') {
                    $("#modal-body").html("<h2>Pre Merchant Boarded Updated Successfully</h2>");  
                    window.location.reload();
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
	       	url: "updatePreBoardMerchant",
            data: frmData           
        }; 
        $.ajax(opts);
        return false;
}
function isDecimal(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( charCode == 46 || (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
	  return false;
	 }
	}
	function isNumberKey(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
	  return false;
	 }
	}

function isAlphaNumericBankType(evt) {	
	try {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
    	if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==37|| charCode==39|| charCode==46|| charCode==40|| charCode==41|| charCode==47){
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
    	evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==32|| charCode==37|| charCode==39|| charCode==46|| charCode==40|| charCode==41||charCode==45||charCode==46||charCode==47||charCode==58||charCode==44||charCode==95||charCode==38)
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
    	evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58||charCode==8||charCode==37||charCode==39)
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
    if ((charCode > 47 && charCode < 58 )|| charCode == 44||charCode==8||charCode==37||charCode==39){
        return true;
    }
    return false;
}
function isAlphaNumericLocation(evt) {
	try {
			//console.log('aaaaaaaaa');
			evt = (evt) ? evt : window.event;
			var charCode = (evt.which) ? evt.which : evt.keyCode;
			if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 ||charCode==8||charCode==32||charCode==46||charCode==38||charCode==45||charCode==40||charCode==41||charCode==44) {
			   	return true;
			}else{
				return false;
			}
	    }catch (err) {
	        console.log('errerrerr: '+err);
	    	alert(err.Description);
	   	}
}
function isAlphaNumericNote(evt) {
try {
		//console.log('aaaaaaaaa');
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 ||charCode==8||charCode==32||charCode==46||charCode==38||charCode==45||charCode==40||charCode==41||charCode==44||charCode==47||charCode==35||charCode==58||charCode==33||charCode==95) {
		   	return true;
		}else{
			return false;
		}
    }catch (err) {
        console.log('errerrerr: '+err);
    	alert(err.Description);
   	}
}

function isChequeNo(evt) {
try {
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode>47&&charCode<58 ) {
	   	return true;
	}else{
		return false;
	}
	}catch (err) {
		alert(err.Description);
	}
}
function isMarketingName(evt){
	try {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==32||charCode==38) {
		   	return true;
		}else{
			return false;
		}
    }catch (err) {
    	alert(err.Description);
   	}
}
function isAmountNumeric(evt){
try {
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	var str = $("#amount").val();		
	
	if ((charCode>47&&charCode<58)||charCode==46) {
		if(charCode==46&&str.indexOf(".")>=0){
			return false;	
		}else{
	   		return true;
		}
	}else{
		return false;
	}
}catch (err) {
	alert(err.Description);
	}
}
function isNumeric(evt){
	try {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if (charCode>47&&charCode<58 ) {
		   	return true;
		}else{
			return false;
		}
    }catch (err) {
    	alert(err.Description);
   	}
}

function isAlphaNumericName(evt) {
	try {
		//console.log('aaaaaaaaa');
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 ||charCode==8||charCode==32||charCode==46||charCode==38||charCode==45||charCode==40||charCode==41) {
		   	return true;
		}else{
			return false;
		}
    }catch (err) {
        console.log('errerrerr: '+err);
    	alert(err.Description);
   	}
}

	</script>
	
<script type="text/javascript">
<c:out value="${allMerchantDetails['merchantId']}"/>
var merchantState = '<c:out value="${allMerchantDetails['businessState']}" />'
$('select option[value="1"]').attr("selected",true);
</script>

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
<div class="right_col" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>PreBorded Merchant Details</h3>
			</div>
		</div>
		<div class="row">			
			<form class="form-horizontal form-label-left">
				<input type="hidden" name="merchantId" id="merchantId"
					value="${allMerchantDetails['merchantId']}" />
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
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="executiveName">Sales Executive Name/DSA/Channel Partner</label>
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
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Merchant name/Client Name/Director Name<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true" name="Name" id="Name" required="true" minlength="2" onpaste="return false"
										maxlength="60" loginRegex="true" value="${allMerchantDetails['merchantName']}" onkeypress="return isAlphaNumericName(event);" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="PhoneNo">Phone No<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" value="${allMerchantDetails['phoneNo']}" data-clear-btn="true"
										name="PhoneNo" id="PhoneNo" digits="true" onkeypress='return isNumeric(event);' minlength="0" maxlength="10" onpaste="return false" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="MarketingName">Marketing/Firm's Name<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true" name="MarketingName" value="${allMerchantDetails['marketingName']}"
										id="MarketingName" required="true" minlength="2" onkeypress="return isMarketingName(event);" maxlength="50" onpaste="return false"/>
								</div>
							</div>	
							
							<%-- <div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="MarketingName">CUB Branch<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true" name="cubBranch" value="${allMerchantDetails['cubBranch']}"
										id="cubBranch"  onkeypress="return isMarketingName(event);" maxlength="50" onpaste="return false"/>
								</div>
							</div>	 --%>					
						</div>
					</div>

<!-------------------------- panel business ---------------------------------------------------------->

					<div class="x_panel">
						<div class="x_title">
							<h2>Location</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>								
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<br />
							 <div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="Businessstate">Merchant Location<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text"
										value="${allMerchantDetails['location']}"
										id="location" name="location" minlength="2" maxlength=45 onkeypress="return isAlphaNumericLocation(event);" onpaste="return false" class="form-control">
								</div>
							</div>
						</div>
					</div>
   <!-- -------------------------------------Payment Details------------------------- -->                                           
               <div class="x_panel">
                                <div class="x_title">
                                    <h2>Rental Amount Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                       
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Rental Amount</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="amount" id="amount" value="${allMerchantDetails['amount']}" digits="true" onkeypress='return isAmountNumeric(event)' minlength="0" maxlength="8" onpaste="return false" />
                                            </div>
                                        </div>
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeNo">Cheque No/NEFT No/Swipe No.
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" name="chequeNo" id="chequeNo" value="${allMerchantDetails['chequeNo']}" minlength="0" maxlength=10 onkeypress="return isChequeNo(event);" onpaste="return false" />
                                            </div>
                                    </div>                                
                                </div>
                            </div>    
     <!-- -------------------------------------Nash Details------------------------- -->                                           
               <div class="x_panel">
                                <div class="x_title">
                                    <h2>NACH Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                       
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Nash Number</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="nashNumber" id="nashNumber" digits="true" onkeypress='return isAmountNumeric(event)' minlength="0" maxlength="20" onpaste="return false"/>
                                            </div>
                                        </div>
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="nashBankNAme">Nash Bank Name
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                   <input type="text" class="form-control" data-clear-btn="true" name="nashBankNAme" id="nashBankNAme" minlength="0" maxlength=50 onkeypress="return isAlphaNumeric(event);" alphanumeric="true"/>
                                            </div>
                                    </div> 
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeNo">Nash Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" name="neftDate" id="neftDate" onkeypress='return false;' readonly='true'/>
                                            </div>
                                    </div>                                
                                </div>
                            </div>                                   
<!-- ---------------------------------------------- DEVICE DETAIL --------------------------------------->
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
							<div class="form-group">
                            	<label class="control-label col-md-3 col-sm-3 col-xs-12" for=""></label>
                                 <div class="col-md-2 col-sm-2 col-xs-12">
                                           <div class="checkbox">
							           <input type="checkbox" style="margin: 0 !important; position: relative !important"
							            id="kycCheck" name="kycCheck">Kyc Check
							           </div>
                                  </div>
                                   <div class="col-md-2 col-sm-2 col-xs-12">
                                           <div class="checkbox">
							           <input type="checkbox" style="margin: 0 !important; position: relative !important"
							            id="financeCheck" name="financeCheck" onclick="return setFinanceCheck();">Finance Check
							           </div>
                                   </div>
                            </div>
                              
							<div class="form-group">
                            	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">View Document<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12" >
                                    <span><a href="<c:url value='view_docs_preboard' />?param=<c:out value="${allMerchantDetails['phoneNo']}"/>" target="_blank">Download Pdf</a></span>
                                </div>
                            </div> 
							<div class="form-group">
                            	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="DeviceSerialNo">Update Document<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12" >
                                	<input type="file" class="form-control" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" />
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
							 <div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Comments/Remarks<span class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<textarea class="form-control" data-clear-btn="true" name="note" id="note" required="true" maxlength="100" onkeypress="return isAlphaNumericNote(event);" onpaste="return false"><c:out value="${allMerchantDetails['note']}" /></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="VerificationStatus">VerificationStatus<span
									class="required">*</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select data-clear-btn="true" name="VerificationStatus"
										id="VerificationStatus" required="true" class="form-control">
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'Pending'}">
											<option value="Pending">Pending</option>
											<option value="oktoboard">Ok To Board</option>
											<option value="rejected">Rejected</option>
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'oktoboard'}">
											<option value="oktoboard">Ok To Board</option>
										    <option value="rejected">Rejected</option>
											<option value="Pending">Pending</option>
										</c:if>
										<c:if
											test="${allMerchantDetails['verificationStatus'] == 'rejected'}">
											<option value="rejected">Rejected</option>
											<option value="oktoboard">Ok To Board</option>
										    <option value="Pending">Pending</option>
										</c:if>
									</select>
								</div>
							</div>
							<div class="form-group">
						        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="boardingDate">Boarding Date</label>
						        <div class="col-md-6 col-sm-6 col-xs-12">
						         <input type="text" class="form-control" value="${allMerchantDetails['createdOn']}" data-clear-btn="true"
						          name="boardingDate" id="boardingDate"  readonly="readonly" />
						        </div>
						    </div>
							<div class="form-group">
								<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
									<a href="<c:url value='PreBoardedMerchantlist' />" class="btn-cancel">Cancel</a>									
										<button type="button" class="btn-submit" data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return updMerchant();" id="UpdMerchantDetails" name="UpdMerchantDetails" <c:if test="${allMerchantDetails['empRole'] != '6'}">style="display:none;"</c:if>>Update Merchant</button>
								</div>
							</div>

						</div>
					</div>

<!-- ----------------------------------------------------------------panels end------------------------------>
<!-- ----------------------------------------------------------------delete Org------------------------------>
				
				</div>
				                           
			</form>
		</div>
	</div>

<!--------------------------------------------------- Small modal ------------------------------------------->
	<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
	 
		aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" >
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
				</div>
				<div id="modal-body" class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
				</div>
			</div>
		</div>
	</div>
	<!---------------------------------- / send sms modals ------------------------------------------------------>
<div class="modal fade send_sms_popup" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel">Send SMS</h4>
                                            </div>
                                            <div class="modal-body12">
                                               <form class="form-horizontal form-label-left"> 
                                                <input type="hidden" id="MerchantId" name="MerchantId" value="">
                                                 <input type="hidden" id="sendOrgId" name="sendOrgId" value="">
                                                  <input type="hidden" id="sendUserId" name="sendUserId" value="">
                                                   <input type="hidden" id="sendRmn" name="sendRmn" value="">
                                               <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">SMS Text<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" name="smstext" id="smstext" minlength="0" maxlength="100"  />
											 </div>
                                        </div>
                                                                         
                                    </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target=".bs-example-modal-sm"
													onclick="return sendsms();" id="sendsms" name="updateMdr">Send</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


	<!-- /page content -->

	<!-- footer content -->
	<jsp:include page="/jsp/footer.jsp" />
	<!-- /footer content -->
					                           