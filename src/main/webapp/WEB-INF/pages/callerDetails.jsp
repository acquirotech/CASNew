<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
<script type="text/javascript">
$(document).ready(function (){
	<c:if var="pg" test="${merchantName!='0'}">
		 $('#div_merchant').show();  
		 $('#existingMerchant').val('1');
	</c:if>
	<c:if var="pg1" test="${merchantName=='0'}">
	$('#existingMerchant').val('2');	
	$('#div_merchant').hide();
	</c:if> 
});

function deleteEmp(empId){
	if (confirm("Do you want to delete Employee ?") == true) {
		var sendvalue={dummyUser:empId}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Employee Deleted Successfully</h2>"); 
	                     window.location.href="empList";
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
	                    $("body").attr("onunload","");
	                    window.location.href="logout.jsp";
	                }else if (data.status==100) {
	                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");                    
	                }else if (data.status==101) {
	                    $("#modal-body").html("<h2>"+data.message+"</h2>");                    
	                }
	                 else {
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
	            url: "deleteEmployee",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;

	}else{
		return false;
	}
}
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

	function getaddEmp(){
		$("#modal-body").html("<h2>In Process</h2>");
		  var callType=$("#callType").val();
	      var callPurpose=$("#callPurpose").val();
	      var callerName=$("#callerName").val();
	      var merchantName=$("#merchantName").val();
	      var callType=$("#callType").val();	
	      var comment=$("#comments").val();
	      var empid=$("#empid").val();
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
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter callback No</p>');
			return false;
		}else if(callbackNo.length<10||callbackNo.length>10){
			$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct callback No</p>');
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
		var sendvalue={id:empid,callType:callType,callPurpose:callPurpose,callerName:callerName,merchantName:merchantName,comment:comment,callbackNo:callbackNo}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Caller Updated Successfully</h2>"); 
	                    $("#comments").val(''); 
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
	            url: "updateTeleCustomer",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
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


    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title"> Caller Details</h3>
            </div>
            <form role="form">
             <input type="hidden" value="${id}" name="empid" id="empid" /> 
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="name">Call Type</label>
                        <select data-clear-btn="true" name="callType" id="callType" required="true" class="form-control input-lg">
                                            	<option value="" <c:if test="${callType == ''}">Selected</c:if>>Choose option</option>
												<option <c:if test="${callType == 'InBound'}">Selected</c:if> value="InBound"> InBound</option>
												<option <c:if test="${callType == 'OutBound'}">Selected</c:if> value="OutBound"> OutBound</option>
											
											</select> 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="email">Type Of Query</label>
                      <select data-clear-btn="true" name="callType" id="queryType" required="true" class="form-control input-lg">
											<option <c:if test="${callType == 'Major'}">Selected</c:if> value="Major"> Major</option>
											<option <c:if test="${callType == 'Minor'}">Selected</c:if> value="Minor"> Minor</option>
											<option <c:if test="${callType == 'Critical'}">Selected</c:if> value="Critical"> Critical</option>
											</select>  
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Call Purpose</label>
                     <select data-clear-btn="true" name="callPurpose" id="callPurpose" required="true" class="form-control input-lg">
                                            <option value="" <c:if test="${callPurpose == ''}">Selected</c:if>>Choose option</option>
												<option <c:if test="${callPurpose == '1'}">Selected</c:if> value="1"> Software grievances</option>
												<option <c:if test="${callPurpose == '2'}">Selected</c:if> value="2"> Hardware repairs</option>
												<option <c:if test="${callPurpose == '3'}">Selected</c:if> value="3"> Transaction related queries</option>
												<option <c:if test="${callPurpose == '4'}">Selected</c:if> value="4"> Charge pack/Cash@pos</option>
												<option <c:if test="${callPurpose == '5'}">Selected</c:if> value="5"> Technical support</option>
												<option <c:if test="${callPurpose == '6'}">Selected</c:if> value="6"> Rental call</option>
												<option <c:if test="${callPurpose == '7'}">Selected</c:if> value="7"> Change of bank account</option>
												<option <c:if test="${callPurpose == '8'}">Selected</c:if> value="8"> New Pos inquiry/Sign up</option>
												<option <c:if test="${callPurpose == '9'}">Selected</c:if> value="9"> Others</option>
												
											</select> </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Employee Name</label>
                         <input type="text" class="form-control input-lg" data-clear-btn="true" onpaste="return false" name="callerName" id="callerName" value="${callerName}" required="true" minlength="2" maxlength=100 />
                                           
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                   <div class="col-md-5">
                  <div class="form-group">
                                            <label for="createdOn">Existing Merchant</label>
                                          <select data-clear-btn="true" name="existingMerchant" id="existingMerchant" required="true" class="form-control input-lg">
                                            	<option <c:if test="${existingMerchant == '1'}">Selected</c:if> value="1"> Yes</option>
												<option <c:if test="${existingMerchant == '2'}">Selected</c:if> value="2"> No</option>
											</select></div>
                                        </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_merchant" <c:if test="${existingMerchant != '1'}">style="display:none;"</c:if> >
                    <div class="form-group">
                      <label for="emprole">Merchant Name</label>
                    <select name="merchantName" id="merchantName" class="form-control input-lg">
								  	  <c:if test="${merchantList==''}">
								  	     <option value="NA">select</option> 	
									  </c:if>
									  <c:forEach var="RowData" items="${merchantList}">
									  <option <c:if test="${RowData['merchantId'] == merchantName}">selected</c:if> value="<c:out value="${RowData['merchantId']}"/>"><c:out value="${RowData['merchantName']}"/></option> 									  
								  	  </c:forEach>
								   </select>               </div>
                  </div>
                
                <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="emprole">New Call </label>
                         <input type="text" class="form-control input-lg" data-clear-btn="true" onpaste="return false" name="callbackNo" id="callbackNo" value="${callbackNo}"  required="true" maxlength=10 digits="true" />
                     </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                   <div class="col-md-5">
                  <div class="form-group">
                                            <label for="createdOn">Purpose of the call</label>
                                          <textarea rows="4" cols="30" class="form-control input-lg" data-clear-btn="true" onpaste="return false" name="comments" id="comments" required="true" minlength="2" maxlength=250 ></textarea>
                                           </div>
                                        </div>
                                        <div class="col-md-1">&nbsp;</div>
                   <div class="col-md-5">
                  <div class="form-group">
                                            <label for="createdOn">Previous Comment</label>
                                          ${commentsList}
                                            </div>
                                        </div>
                  
                  
                  
                  
                  </div>
                </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" data-target=".bs-example-modal-sm" class="btn btn-info pull-right" data-toggle="modal"onclick="return getaddEmp();">Submit</button>
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
        <form id="id2DelFrm" method="GET">
          <input type="hidden" class="form-control" id="id2Delete" name="id2Delete">
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove"></i>Close</button>
        </form>
      </div>
    </div>
  </div>
</div>
  
	<!-- Small modal -->
                                
                    
<jsp:include page="/jsp/footer.jsp" />