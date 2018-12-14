<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
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

function setFinanceCheck(){
	console.log("1111");
	if($("#kycCheck").is(":checked") == true) {
		return true;
	}else{
		alert("KYc check is not completed");
		return false;
	}	
	}
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
	$("#AddMerchantDetails").hide();
	$("#modal-body").html("<h2>In Process</h2>");
	var merchantId=$("#merchantId").val();
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
	}
	var kycCheck =$("#kycCheck").val();
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
	
	
	var frmData = new FormData();
	frmData.append("id",merchantId);
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
	    	url: "updatePreBoardMerchant",
            data: frmData           
        }; 
        $.ajax(opts);
        return false;
}

	</script>
	
<script type="text/javascript">
<c:out value="${allMerchantDetails['merchantId']}"/>
var merchantState = '<c:out value="${allMerchantDetails['businessState']}" />'
$('select option[value="1"]').attr("selected",true);
</script>

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>

 <div class="content-wrapper">
    <!-- Content Header (Page header) -->

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Pre-Board Merchant Details</h3>
            </div>
            <form role="form">
              <div class="box-body">
               <input type="hidden" name="merchantId" id="merchantId"
					value="${allMerchantDetails['merchantId']}" />
              <div class="row">&nbsp;</div>
              <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Sales Type</label>
                      <select name="salesType" id="salesType" class="form-control input-lg" onchange="return changeSalesType();">
										    	<option value="">select</option>
										    	<option <c:if test="${allMerchantDetails['salesType'] == '1'}">Selected="Selected"</c:if> value="1">Direct sale</option>
                                            	<option <c:if test="${allMerchantDetails['salesType'] == '2'}">Selected="Selected"</c:if> value="2">Distributor</option>
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
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Sales Executive Name/DSA/Channel Partner</label>
                         <select name="executiveName" id="executiveName" class="form-control input-lg">
								  	  <c:if test="${allMerchantDetails['executiveName']==''}">
								  	     <option value="NA">select</option> 	
									  </c:if>
									  <c:forEach var="RowData" items="${executiveListDsa}">
									  <option <c:if test="${RowData['executiveId'] == allMerchantDetails['executiveName']}">selected</c:if> value="<c:out value="${RowData['executiveId']}"/>"><c:out value="${RowData['executiveName']}"/></option> 									  
								  	  </c:forEach>
								   </select>	
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                 <div class="col-md-5">
                    <div class="form-group">
                      <label for="text">Merchant name/Client Name/Director Name</label>
                        <input type="text" class="form-control input-lg" value="${allMerchantDetails['merchantName']}" data-clear-btn="true" name="Name" id="Name"  required="true" minlength="0" maxlength="8"  onPaste="return false"/> 
                    
                    </div>
                  </div>
                 <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="number">Phone No</label>
                    <input type="text" class="form-control input-lg" value="${allMerchantDetails['phoneNo']}" data-clear-btn="true"
										name="PhoneNo" id="PhoneNo" digits="true" minlength="0" maxlength="10" onpaste="return false" />
								
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Merchant Location</label>
                   <input type="text"
										value="${allMerchantDetails['location']}"
										id="location" name="location" minlength="2" maxlength=45  onpaste="return false" class="form-control input-lg">
								 </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Rental Amount</label>
                         <input type="text" class="form-control input-lg" data-clear-btn="true" name="amount" id="amount" value="${allMerchantDetails['amount']}" digits="true" onkeypress='return isAmountNumeric(event)' minlength="0" maxlength="8" onpaste="return false" />
                                           </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Cheque No/NEFT No/Swipe No.</label>
                       <input type="text" class="form-control input-lg" data-clear-btn="true" name="chequeNo" id="chequeNo" value="${allMerchantDetails['chequeNo']}" minlength="0" maxlength=10 onkeypress="return isChequeNo(event);" onpaste="return false" />
                                                       
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Nach Number</label>
                      <input type="text" class="form-control input-lg" data-clear-btn="true"  placeholder="Nach Number" value="${allMerchantDetails['nachNo']}" id="nashNumber" required="true" minlength="10" maxlength="10" digits="true" onPaste="return false"  />
                        
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Nach Bank Name</label>
                             <input type="text" class="form-control input-lg" data-clear-btn="true" name="nashBankNAme" value="${allMerchantDetails['nachBank']}" id="nashBankNAme" minlength="0" maxlength=50 onkeypress="return isAlphaNumeric(event);" alphanumeric="true"/>
                                           
                    </div>
                  </div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Nach Date</label>
                           <input type="text" class="date-picker form-control input-lg" placeholder="Enter Valid Till Date" data-role="date" value="${allMerchantDetails['nashDate']}" data-clear-btn="true" name="nachDate" id="nachDate" onkeypress='return false;' readonly='true'/>
                                            
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                    <input type="checkbox" style="margin: 0 !important; position: relative !important"
							            id="kycCheck" name="kycCheck">Kyc Check</div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                    <label for="Password"></label>
                      <input type="checkbox" style="margin: 0 !important; position: relative !important"
							            id="financeCheck" name="financeCheck" onclick="return setFinanceCheck();">Finance Check</div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                     <label for="Password"></label>
                      <span><a href="<c:url value='view_docs_preboard' />?param=<c:out value="${allMerchantDetails['phoneNo']}"/>" target="_blank">Download Pdf</a></span>
                               
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="text">Update Document</label>
                       	<input type="file" class="form-control input-lg" data-clear-btn="true" name="pdfFile" id="pdfFile" onchange="onFileSelected(event)" accept="application/pdf" />
                               
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="text">Comments/Remarks</label>
                      <input type="text" class="form-control input-lg" id="note" value="${allMerchantDetails['note']}">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">VerificationStatus</label>
                     <select data-clear-btn="true" name="VerificationStatus"
										id="VerificationStatus" required="true" class="form-control input-lg">
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
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Boarding Date</label>
                      <input type="text" class="form-control input-lg" id="boardingDate" value="${allMerchantDetails['createdOn']}"  readonly="readonly">
                    </div>
                  </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" data-toggle="modal" onclick="return updMerchant();" data-target=".bs-example-modal-sm">Submit</button>
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
      
      
      
      
 <!---------------------------------------------- /row --------------------------------------------------------->
    </section>
    </div>
				
					<!-- ----------------------------------------------------------------panels start----------------->
					<!-- ----------------------------------------------------------------Basic details----------------->
					

<!--------------------------------------------------- Small modal ------------------------------------------->
	
	<!-- footer content -->
<jsp:include page="/jsp/footer.jsp" />
	<!-- /footer content -->
					                           