<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script src="<c:url value="resources/js/acqcitystate.js" />"></script>
<script type="text/javascript">
function changeSalesType(){
         var salesType = $("#salesType").val();
        if (salesType == "1") 
        {
        	$("#employee_List").show();
        	$("#distributor_List").hide();
        	  
       	}else  if (salesType == "2") 
        {
        	$("#employee_List").hide();
        	$("#distributor_List").show();
        	  
       	}
} 


function submitMerchant(){
	$("#AddMerchantDetails").hide();
	$("#modal-body").html("<h2>In Process</h2>");
	var employeeName=$("#employeeName").val();
	var salesType=$("#salesType").val();
	var merchantName=$("#Name").val();
	var marketingName=$("#MarketingName").val();
	var location = $("#businessstate").val();
	var executiveName=$("#executiveName").val();
	var chequeNo =$("#chequeNo").val();
	var amount =$("#amount").val();
	var phoneNo=$("#PhoneNo").val();
	var note=$("#note").val();
	var cubBranch="NA";
	var nashBankNAme=$("#nashBankNAme").val();
	var nashNumber=$("#nashNumber").val();
	var nachDate=$("#nachDate").val();
	
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
	frmData.append("kycCheck",kycCheck);
	frmData.append("name", merchantName);
 	frmData.append("executiveName",executiveName);
 	frmData.append("salesType",salesType);
 	frmData.append("employeeName",employeeName);
 	frmData.append("marketingName",marketingName);
	frmData.append("phoneNo",phoneNo);
	frmData.append("note",note);
	frmData.append("location",location);
	frmData.append("status",verificationStatus);	
	frmData.append("chequeNo",chequeNo);
	frmData.append("amount",amount);
	frmData.append("cubBranch",cubBranch);
	frmData.append("nashBankNAme",nashBankNAme);
	frmData.append("nashNumber",nashNumber);
	frmData.append("nachDate",nachDate);
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
	    	url: "preBoardNewMerchantPost",
            data: frmData           
        }; 
        $.ajax(opts);
        return false;
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
</script>

  <div class="content-wrapper">
<!-- Content Header (Page header) -->

<!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">PreBoard Merchant</h3>
            </div>
            <form role="form">
              <div class="box-body">
               <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Sales Type</label>
                      <select name="salesType" id="salesType" class="form-control input-lg" onchange="return changeSalesType();">
										    	<option value="">select</option>
										       <option value="1">Direct sale </option>
										       <option value="2">Distributor</option>
											</select>
                    </div>
                  </div>
                  <div class="col-md-5" id="employee_List" style="display: none;">
                  <div class="col-md-1">&nbsp;</div>
                  
                    <div class="form-group">
                      <label for="exampleInputEmail1">Employee Name</label>
                       <select name="employeeName" id="employeeName" class="form-control input-lg">
                      	<option value="">select</option>
										        <c:forEach var="RowData" items="${empList}">
										 			<option value="<c:out value="${RowData['executiveId']}"/>" <c:if test="${RowData['executiveId'] == param.executiveId}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 		</c:forEach>
											</select>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-5" id="distributor_List" style="display: none;">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Distributor List</label>
                      <select name="executiveName" id="executiveName" class="form-control input-lg">
										    	<option value="">select</option>
										        <c:forEach var="RowData" items="${executiveListDsa}">
										 				<option value="<c:out value="${RowData['executiveId']}"/>" <c:if test="${RowData['executiveId'] == param.executiveId}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
											</select>
                    </div>
                  </div>
                  <div class="col-md-5">
                  <div class="col-md-1">&nbsp;</div>
                  
                    <div class="form-group">
                      <label for="exampleInputEmail1">Merchant name/Client Name/Director Name</label>
                      <input type="text" class="form-control input-lg" id="Name" placeholder="Enter Name">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="PhoneNo">Phone No</label>
                      <input type="number" class="form-control input-lg" id="PhoneNo" placeholder="Enter Phone">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Marketing/Firm's Name</label>
                      <input type="text" class="form-control input-lg" id="MarketingName" placeholder="Enter Marketing Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Merchant Location</label>
                      <select onchange="print_businesscity('businesscity', selectedIndex);" id="businessstate" name ="businessstate" class="form-control input-lg">
					                             <option value="">STATE</option>
					                            </select>
                                                  </div>
                                        
                                        <div class="form-group percent-50" style="display: none;">
                                            <label for="BusinessCity">Business City</span></label>
                                            <script language="javascript">print_businessstate("businessstate");</script>
                                            <select id="businesscity" name ="businesscity" class="form-control">
					                             <option value="">CITY</option>
					                            </select>
                                                  
                                  </div> </div>
                  
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Rental Amount</label>
                      <input type="number" class="form-control input-lg" id="amount" placeholder="Enter Rental Amount">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Cheque No/NEFT No/Swipe No.</label>
                      <input type="text" class="form-control input-lg" id="chequeNo" placeholder="Enter Cheque No">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">NACH Number</label>
                      <input type="number" class="form-control input-lg" id="nashNumber" placeholder="Enter Nach Number">
                    </div>
                  </div>
                  
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">NACH Bank Name</label>
                      <input type="text" class="form-control input-lg" id="nashBankNAme" placeholder="Enter Bank Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">NACH Date</label>
                      <input type="datetime" class=" date-picker form-control input-lg" id="nachDate" placeholder="Enter Date">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName"></label>
                     <input type="checkbox" style="margin: 0 !important; position: relative !important"
							            id="kycCheck" name="kycCheck">Kyc Check
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName"></label>
                          <div class="checkbox">
							           <input type="checkbox" style="margin: 0 !important; position: relative !important"
							            id="financeCheck" name="financeCheck" onclick="return setFinanceCheck();">Finance Check
                    </div>
                  </div>
                  
                 </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Upload Document</label>
                      	<input type="file" class="form-control" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" />
                              
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Comments/Remarks</label>
                      	<input type="text" class="form-control input-lg" data-clear-btn="true" name="note" id="note" required="true" maxlength="100"  onpaste="return false" />
								        
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Verification Status</label>
                      	<select data-clear-btn="true" name="VerificationStatus" id="VerificationStatus" required="true" class="form-control input-lg">
										            <option value="Pending">Pending</option>
										            <option value="oktoboard">Ok To Board</option>
										            <option value="rejected">Rejected</option>
										         </select>       
                    </div>
                  </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" onclick="return submitMerchant();" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn btn-info pull-right">Submit</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      
<!--------------------------------------------- Small modal ----------------------------------------->
                                <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">X</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
                                            </div>
                                            <div id="modal-body" class="modal-body">
                                                
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<jsp:include page="/jsp/footer.jsp" />
