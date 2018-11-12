<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/head.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("6")||session.getAttribute("empRole").equals("10"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
 <script type="text/javascript">

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
function submitMerchant(){
	$("#AddMerchantDetails").hide();
	$("#modal-body").html("<h2>In Process</h2>");
	var merchantName=$("#Name").val();
	var marketingName=$("#MarketingName").val();
	var location = $("#businessstate").val();
	var executiveName=$("#executiveName").val();
	var chequeNo =$("#chequeNo").val();
	var amount =$("#amount").val();
	var phoneNo=$("#PhoneNo").val();
	var note=$("#note").val();
	var cubBranch="NA";
	var verificationStatus=$("#VerificationStatus").val();
	
	if($("#kycCheck").is(":checked") == true) {
		var kycCheck = "1";
	}else{
		var kycCheck = "0";
	}var kycCheck =$("#kycCheck").val();
	var financeCheck =$("#financeCheck").val();
	if($("#kycCheck").is(":checked") == true) {
		var kycCheck = "1";
	}if($("#financeCheck").is(":checked") == true) {
		var kycCheck = "2";
	}else{
		var kycCheck = "0";
	}
	var fileName;
	if (selectedFileAdd != undefined) {
		fileName=selectedFileAdd;
	}
	var regex="^[0-9]{1,8}[\\.]{1}[0-9]{0,2}?$";
	
	if(merchantName==null||merchantName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Name</p></n>Length should be min 2 and max 60 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(merchantName.length<2||merchantName.length>60){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Correct Format</p></n>Length should be min 2 and max 60 char');
		$("#AddMerchantDetails").show();
		return false;
	}
	if(executiveName!=null||executiveName!='' ){
		if(executiveName.length<2||executiveName.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Executive Name</p></n>Length should be min 2 and max 100 char');
		$("#AddMerchantDetails").show();
		return false;
	}
	}else if(MarketingName==null||MarketingName==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Marketing Name</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(MarketingName.length<2||MarketingName.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Marketing Name</p></n>Length should be min 2 and max 50 char');
		$("#AddMerchantDetails").show();
		return false;
	}else if(location==null||location==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Location</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(location.length<2||location.length>45){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Location</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(phoneNo==null||phoneNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Phone No</p></n>Phone No Length should be 10 digits');
		$("#AddMerchantDetails").show();
		return false;
	}else if(phoneNo.length<10||phoneNo.length>10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Phone No</p></n>Phone No Length should be 10 digits</n>Add Many Phone No with comma(,) Separeted');
		$("#AddMerchantDetails").show();
		return false;
	}else if(verificationStatus==null||verificationStatus==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Verification Status</p>');
		$("#AddMerchantDetails").show();
		return false;
	}else if(verificationStatus.length<3||verificationStatus.length>12){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Verification Status</p>');
		$("#AddMerchantDetails").show();
		return false;
	}
		if(chequeNo==null||chequeNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter chequeNo</p></n>Length should be min 1 and max 45 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(chequeNo.length<1||chequeNo.length>45){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Cheque No</p></n>Length should be min 1 and max 45 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(amount==null||amount==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter  Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(amount.length<1||amount.length>11){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Amount</p></n>Length should be min 1 and max 11 char');
			$("#AddMerchantDetails").show();
			return false;
		}else if(amount.match(regex) == null){
			$("#modal-body").html('<h2>Validation Error</h2><p> Amount Should be in proper format (xxxxxxxx.xx)</p>');
			$("#AddMerchantDetails").show();
			return false;
		}
		if(kycCheck!="2" && verificationStatus == "oktoboard"){
			$("#modal-body").html('<h2>Validation Error</h2><p>Finance check is not completed</p>');
			$("#AddMerchantDetails").show();
			return false;
	 	}
	var frmData = new FormData();
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
	var opts = {
            type: "POST",
            success: function (data) {
            	 var obj = JSON.parse(data);
                $(".loading").css("visibility","hidden");
                if (obj.status == 0&&obj.message=='OK') {
                    $("#modal-body").html("<h2>Merchant Boarded Successfully</h2>");
                    window.location.reload();
                } else if (obj.status==111) {
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
	    	url: "preBoardNewMerchant",
            data: frmData           
        }; 
        $.ajax(opts);
        return false;
}

function isNumberKeyWithComa(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if ((charCode > 47 && charCode < 58 )|| charCode == 44|| charCode==8){
        return true;
    }
    return false;
}

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 47 && charCode < 58 || charCode==8){
        return true;
    }
    return false;
}
</script>
<script type="text/javascript">

function passwordValidations(event){
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58||charCode==33||charCode==35||charCode==36||charCode==40||charCode==41||charCode==46||charCode==63||charCode==64||charCode==95)
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
		if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode>45|| charCode==8) {
		   	return true;
		}else{
			return false;
		}
    }
    catch (err) {
    	alert(err.Description);
   	}
}

function onlyAlphabets(e, t) {
    try {
        if (window.event) {
            var charCode = window.event.keyCode;
        }
        else if (e) {
            var charCode = e.which;
        }
        else { return true; }
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123 || charCode == 32))
            return true;
        else
            return false;
    }
    catch (err) {
        alert(err.Description);
    }
}

function isDecimal(evt){
	evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if(charCode == 46){
		return true;
    }
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

</script>

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>Pre Board New Merchant</h3>
                        </div>
                      </div>
                    <div class="row">
                    <form class="form-horizontal form-label-left">
                        <div class="col-md-12 col-sm-12 col-xs-12">
<!-- ----------------------------------------------------------------panels start----------------->
<!-- ----------------------------------------------------------------Basic details----------------->
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
                                    <br />  
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="executiveName">Sales Executive Name/DSA/Channel Partner</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select name="executiveName" id="executiveName" class="form-control">
										    	<option value="">select</option>
										 			<c:forEach var="RowData" items="${executiveList}">
										 				<option value="<c:out value="${RowData['executiveEmail']}"/>" <c:if test="${RowData['executiveEmail'] == param.executiveEmail}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
											</select>
                                             </div>
                                        </div>                     
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Merchant name/Client Name/Director Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="Name" id="Name" required="true" minlength="2" maxlength=60 onkeypress="return isAlphaNumericName(event);" onpaste="return false" />
                                            </div>
                                        </div>
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="PhoneNo">Phone No<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <input type="text" class="form-control" data-clear-btn="true" name="PhoneNo" id="PhoneNo" digits="true" minlength="0" maxlength="10" onkeypress="return isNumeric(event);" onpaste="return false" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="MarketingName">Marketing/Firm's Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="MarketingName" id="MarketingName" required="true" minlength="2" onkeypress="return isMarketingName(event);" maxlength=50 onpaste="return false"  />
                                            </div>
                                        </div>
                                  <!--  <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="cubBranch">CUB Branch<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="cubBranch" id="cubBranch"  maxlength=50 onpaste="return false"  />
                                            </div>
                                        </div>   -->                                       
                                </div>
                            </div>                                              
<!----------------------------------------- panel business ---------------------------------------------------------->                          
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Location</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />            
                                       <div class="form-group">
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Merchant Location<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select onchange="print_businesscity('businesscity', selectedIndex);" id="businessstate" name ="businessstate" class="form-control">
					                             <option value="">STATE</option>
					                            </select>
                                                  </div>
                                        </div>
                                        <div class="form-group percent-50" style="display: none;">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="BusinessCity">Business City<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            <script language="javascript">print_businessstate("businessstate");</script>
                                            <select id="businesscity" name ="businesscity" class="form-control">
					                             <option value="">CITY</option>
					                            </select>
                                                  </div>
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
                                                <input type="text" class="form-control" data-clear-btn="true" name="amount" id="amount" digits="true" onkeypress='return isAmountNumeric(event)' minlength="0" maxlength="8" onpaste="return false"/>
                                            </div>
                                        </div>
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeNo">Cheque No/NEFT No/Swipe No.
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="form-control" data-clear-btn="true" name="chequeNo" id="chequeNo" minlength="0" maxlength=10 onkeypress="return isChequeNo(event);" onpaste="return false"/>
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
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">NACH Number</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="nashNumber" id="nashNumber" digits="true" onkeypress='return isAmountNumeric(event)' minlength="0" maxlength="20" onpaste="return false"/>
                                            </div>
                                        </div>
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="nashBankNAme">NACH Bank Name
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                   <input type="text" class="form-control" data-clear-btn="true" name="nashBankNAme" id="nashBankNAme" minlength="0" maxlength=50 onkeypress="return isAlphaNumeric(event);" alphanumeric="true"/>
                                            </div>
                                    </div> 
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="chequeNo">NACH Date
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <input type="text" class="date-picker form-control" data-role="date" data-clear-btn="true" name="neftDate" id="neftDate" onkeypress='return false;' readonly='true'/>
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
                            	<label class="control-label col-md-3 col-sm-3 col-xs-12" for="DeviceSerialNo">Upload Document<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12" >
                                	<input type="file" class="form-control" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" />
                                </div>
                            </div>
                           
						</div>
					</div>                                                                                                         
 <!-- ----------------------------------------------Additional Detail --------------------------------------->
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
                                       <div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"> Comments/Remarks</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input type="text" class="form-control" data-clear-btn="true" name="note" id="note" required="true" maxlength="100" onkeypress="return isAlphaNumericNote(event);" onpaste="return false" />
								</div>
							</div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="VerificationStatus">VerificationStatus<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="VerificationStatus" id="VerificationStatus" required="true" class="form-control">
										            <option value="Pending">Pending</option>
										            <option value="oktoboard">Ok To Board</option>
										            <option value="rejected">Rejected</option>
										         </select> 
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                               <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return submitMerchant();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddMerchantDetails" name="AddMerchantDetails">Submit</button>
                                            </div>
                                       </div>                                        
                                 </div>
                            </div>                                                            
<!-- ----------------------------------------------------------------panels end----------------->
                        </div>
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
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /modals -->                 
                <!-- /page content -->
<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->