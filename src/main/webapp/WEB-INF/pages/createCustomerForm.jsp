<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script type="text/javascript">
$(function () {
	$("#existingMerchant").change(function () {
		 var existingMerchant1 = $("#existingMerchant").val();
//		console.log("111111111::"+existingMerchant1);
	   if (existingMerchant1 == "1") {
	     $("#div_merchant").show();
	  } else {
		 $("#div_merchant").hide();
	 }
	});
	});

	$(function () {
		$("#callType").change(function () {
			 var callType1 = $("#callType").val();
		   if (callType1 == "InBound") {
		     $("#div_Inbound").show();
		     $("#div_Outbound").hide();
		  } else if(callType1 == "OutBound"){
			 $("#div_Inbound").hide();
			 $("#div_Outbound").show();
		 }else{
			 $("#div_Inbound").hide();
			 $("#div_Outbound").hide();
			 }
		});
		});
	function getaddEmp(){
		$("#modal-body").html("<h2>In Process</h2>");
		  var callType=$("#callType").val();
	      var callPurpose=$("#callPurpose").val();
	      var callerName=$("#callerName").val();
	      var merchantName=$("#merchantName").val();
	      var callType=$("#callType").val();	
	      var comment=$("#comment").val();
	      var existingMerchant=$("#existingMerchant").val();
	      var callbackNo=$("#callbackNo").val();
		 if(callType==null||callType==""){
			$("#modal-body").html('<h2>Validation Error</h2><p>Select call Type</p>');
			return false;
		}else if(callPurpose==null||callPurpose==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Select call Purpose</p>');
			return false;
		}else if(callerName==null||callerName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter caller Name</p>');
			return false;
		}else if(callerName.length<2||callerName.length>60){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct caller Name</p>');
			return false;
		}else if(callbackNo==null||callbackNo==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter callBack No</p>');
			return false;
		}else if(callbackNo.length<10||callbackNo.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct callBack No</p>');
			return false;
		}
		else if(comment==null||comment==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Comment</p>');
			return false;
		}else if(comment.length<2||comment.length>250){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Comment. Length Should be min 2 char and 250 char</p>');
			return false;
		}
	if(existingMerchant == 1){
	 if(merchantName==null||merchantName==''){
			$("#modal-body").html('<h2>Validation Error</h2><p>Select Merchant Name</p>');
			return false;
		}	
	}else{

		merchantName = "0";
		
	}
		var sendvalue={callType:callType,callPurpose:callPurpose,callerName:callerName,merchantName:merchantName,comment:comment,callbackNo:callbackNo}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Caller Added Successfully</h2>");  
	                    window.location.reload();
	                }else if (data.status==100&&data.message=='EmailId already in use') {                	
	                	$("#modal-body").html("<h2>"+data.message+"</h2>"); 
	                	//$("#email").val('');
	                }else if (data.status==111) {
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
	            url: "createTeleCustomer",
	            data: sendvalue
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
              <h3 class="box-title">Add New Caller Details</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Model Name</label>
                      <select data-clear-btn="true" name="callType" id="callType" required="true" class="form-control input-lg">
            										<option value="">Choose	option</option>
											<option value="InBound">InBound</option>
											<option value="OutBound">OutBound</option>
            		  </select>
            		</div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_Inbound" style="display: none;">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Call Type For Inbound</label>
                     <select data-clear-btn="true" name="callType" id="callTypeInbound" required="true" class="form-control input-lg">
											<option value="">Choose	option</option>
											<option value="sales">Sales</option>
											<option value="operations">Operations</option>
											<option value="accounting">Accounting</option>
											<option value="development">Development</option>
											<option value="team">Team</option>
											<option value="others">Others(Sim card related)</option>
											</select>  
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                 <div class="col-md-5" id="div_Outbound" style="display: none;">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Adapter Serial No</label>
                      <select data-clear-btn="true" name="callType" id="callTypeOutbound" required="true" class="form-control input-lg">
											<option value="">Choose	option</option>
											<option value="1">Call purpose</option>
											<option value="2">Rental/MDR/Invoice</option>
											<option value="3">DMT/Other services</option>
											<option value="4">Non-Transacting merchant</option>
											<option value="5">Pre-verification cheque/New cheque follow up</option>
											<option value="6">De-installation</option>
											<option value="7">Others</option>
											</select>  
                    </div>
                  </div> 
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Type Of Query</label>
                      <select data-clear-btn="true" name="callType" id="queryType" required="true" class="form-control input-lg">
											<option value="">Choose	option</option>
											<option value="Major">Major</option>
											<option value="Minor">Minor</option>
											<option value="Critical">Critical</option>
											</select>  
                    </div>
                  </div>
                  
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                 <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Call Purpose</label>
                        <select data-clear-btn="true" name="callPurpose"
											id="callPurpose" required="true" class="form-control input-lg">
											<option value="">Choose	option</option>
											<option value="1">Software grievances</option>
											<option value="2">Hardware repairs</option>
											<option value="3">Transaction related queries</option>
											<option value="4">Charge pack/Cash@pos</option>
											<option value="5">Technical support</option>
											<option value="6">Rental call</option>
											<option value="7">Change of bank account</option>
											<option value="8">New Pos inquiry/Sign up</option>
											<option value="9">Others</option>
											</select>
                    </div>
                  </div> 
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Employee Name</label>
                          <input type="email" class="form-control input-lg" data-clear-btn="true" name="callerName" id="callerName" required="true" minlength="2" maxlength=100 />                                       
                    </div>
                  </div>                 
                </div>
                
                
                <div class="row">&nbsp;</div>
                <div class="row">
                 <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Existing Merchant</label>
                        <select data-clear-btn="true" name="existingMerchant"
											id="existingMerchant" required="true" class="form-control input-lg">
											<option value="">Choose	option</option>
											<option value="2">No</option>
											<option value="1">Yes</option>
											</select>
                    </div>
                  </div> 
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_merchant" style="display:none;">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Employee Name</label>
                         <select name="merchantName" id="merchantName" class="form-control input-lg">
                          <option value="">Merchant Name</option>
	                          <c:forEach var="RowData" items="${merchantList}">
								<option value="<c:out value="${RowData['merchantId']}"/>">
									<c:out value="${RowData['merchantName']}"/></option> 
								</c:forEach>									    	
											</select>                   
                    </div>
                  </div>
                  
                </div> 
                
                
                 <div class="row">&nbsp;</div>
                <div class="row">
                 <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">New Call</label>
                           <input type="text" class="form-control input-lg" data-clear-btn="true" name="callbackNo" onkeypress='return isNumberKey(event);' id="callbackNo" required="true" maxlength=10 digits="true" />
                                            
                    </div>
                  </div> 
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Purpose of the call</label>
                   <textarea rows="4" cols="30" class="form-control input-lg" data-clear-btn="true"  name="comment" id="comment" required="true" minlength="2" maxlength=250 ></textarea>
                                            </div>
                  </div>                 
                </div>
                
                
                
                
                
                
                
                
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" data-toggle="modal" data-target=".bs-example-modal-sm" onclick="return getaddEmp();">Submit</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
   <!-- Small modal -->
  <div class="modal fade bs-example-modal-sm" id="deleteConfirm">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Your Request Status</h4>
      </div>
       <div id="modal-body" class="modal-body">
                                                
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
  
<jsp:include page="/jsp/footer.jsp" />
