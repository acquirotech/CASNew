<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("11"))){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">	
$(function () {
$("#existingMerchant").change(function () {
	 var existingMerchant1 = $("#existingMerchant").val();
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
<script type="text/javascript">



function isAlphaNumeric(event) {	
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32|| charCode==46|| charCode==40|| charCode==41||charCode==45||charCode==46||charCode==47||charCode==58||charCode==44||charCode==95)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}

function passwordValidations(event){
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {3
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58||charCode==33||charCode==35||charCode==36||charCode==64||charCode==95)
    	            return true;
    	        else
    	            return false;
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
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 47 && charCode < 58 || charCode==8){
        return true;
    }
    return false;
}
</script>
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                    <form class="form-horizontal form-label-left"> 
                   <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->


  <!------------------------ panel Store-------------------------->
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Add New Caller Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                   
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                   <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="callType">Call Type<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="callType" id="callType" required="true" class="form-control"">
											<option value="">Choose	option</option>
											<option value="InBound">InBound</option>
											<option value="OutBound">OutBound</option>
											</select>  
                                         </div>
                                          </div>
                                       <div class="form-group" id="div_Inbound" style="display: none;">                               
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="callType">Call Type For Inbound<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="callType" id="callTypeInbound" required="true" class="form-control"">
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
                                        
                                        <div class="form-group" id="div_Outbound" style="display: none;">                               
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="callType">Call Type For Outbound<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="callType" id="callTypeOutbound" required="true" class="form-control"">
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
                                       
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="callType">Type Of Query<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="callType" id="queryType" required="true" class="form-control"">
											<option value="">Choose	option</option>
											<option value="Major">Major</option>
											<option value="Minor">Minor</option>
											<option value="Critical">Critical</option>
											</select>  
                                         </div>
                                       
                                        </div>
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="callPurpose">Call Purpose<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="callPurpose" id="callPurpose" required="true" class="form-control"">
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
                                     <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Employee Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="email" class="form-control" data-clear-btn="true" name="callerName" id="callerName" required="true" minlength="2" maxlength=100 />
                                            </div>
                                        </div>
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="existingMerchant">Existing Merchant<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="existingMerchant" id="existingMerchant" required="true" class="form-control"">
											<option value="">Select</option>
											<option value="2">No</option>
											<option value="1">Yes</option>
											</select>  
                                         </div>
                                        </div>
                                         <div class="form-group" id="div_merchant" style="display:none;">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="merchantName"> Merchant Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <select name="merchantName" id="merchantName" class="form-control">
										    	<option value="">select</option>
										 			<c:forEach var="RowData" items="${merchantList}">
										 				<option value="<c:out value="${RowData['merchantId']}"/>" <c:if test="${RowData['merchantId'] == param.merchantId}">selected="selected"</c:if> ><c:out value="${RowData['merchantName']}"/></option> 
										 			</c:forEach>
											</select>
                                         </div>
                                        </div>
                                    	 <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">New Call<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="callbackNo" onkeypress='return isNumberKey(event);' id="callbackNo" required="true" maxlength=10 digits="true" />
                                            </div>
                                        </div>
                                    	 <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Purpose of the call <span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <textarea rows="4" cols="30" class="form-control" data-clear-btn="true"  name="comment" id="comment" required="true" minlength="2" maxlength=250 ></textarea>
                                           
                                           <!--      <input type="text" class="form-control" data-clear-btn="true" name="comment" id="comment" required="true" minlength="2" maxlength=250 />
                                            --> </div>
                                        </div>
                                         <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                               <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return getaddEmp();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="addEmp" name="addEmp">Submit</button>
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
                                                <button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /modals -->
                    
                <!-- /page content -->

<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->