<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script src="<c:url value="resources/js/acqcitystate.js" />"></script>
<<script type="text/javascript">
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
                      <label for="exampleInputEmail1">Sales Executive Name/DSA/Channel Partner</label>
                      <select name="executiveName" id="executiveName" class="form-control input-lg">
										    	<option value="">select</option>
										        <c:forEach var="RowData" items="${executiveList}">
										 				<option value="<c:out value="${RowData['executiveEmail']}"/>" <c:if test="${RowData['executiveEmail'] == param.executiveEmail}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
											</select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
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
                      <input type="datetime" class=" date-picker form-control input-lg" id="neftDate" placeholder="Enter Date">
                    </div>
                  </div>
                 </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" onclick="return submitMerchant();" class="btn btn-info pull-right">Submit</button>
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
