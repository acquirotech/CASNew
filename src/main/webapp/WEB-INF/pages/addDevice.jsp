<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">
function submitDevice(){
	$("#modal-body").html("<h2>In Process</h2>");

	var modelName=$("#modelName").val();
	var serialNo=$("#serialNo").val();
	var status=$("#status").val();
	

	if(modelName==null||modelName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Model Name</p>');
		return false;
	}else if(modelName.length<2||modelName.length>40){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 2 and max 40 char');
		return false;
	}else if(serialNo==null||serialNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 and max 17 char');
		return false;
	}else if(serialNo.length<8||serialNo.length>17){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 and max 17 char');
		return false;
	}
	else if(status==null||status==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Status</p>');
		return false;
	}
	var sendvalue={
			modelName:modelName,
			inventorySerialNo:serialNo,
			status:status
			
			 }
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>Inventory Terminal Added Successfully</h2>");  
                    $("#modelName").val('');$("#serialNo").val('');
                    $("#tid").val('');$("#status").val("Available");
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
            url: "inventoryAddDevice",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}



function isAlphaNumericWithoutSpace(evt) {
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==37|| charCode==39|| charCode==46|| charCode==45|| charCode==46|| charCode==47|| charCode==44|| charCode==38|| charCode==40|| charCode==41|| charCode==58|| charCode==95) {
	      return true;
	  }else{
	   return false;
	  }
	}catch (err) {
	 alert(err. Description);
	 }
	}

function isAlphaNumeric(evt) { 
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==32|| charCode==37|| charCode==39|| charCode==46|| charCode==45|| charCode==46|| charCode==47|| charCode==44|| charCode==38|| charCode==40|| charCode==41|| charCode==58|| charCode==95) {
	      return true;
	  }else{
	   return false;
	  }
	}catch (err) {
	 alert(err. Description);
	 }
	}
	function isNumberKey(evt){
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
	   return false;
	  }
	 }
function isDecimal(evt){
	if (!(evt.keyCode == 46 || (evt.keyCode >= 48 && evt.keyCode <= 57)))
		return false;
}

function getorg(){
    	 var merchantId = $("#merchantId").val();
    	 document.location.href = "?merchantId="+merchantId+"";
    	}
function isAlphaNumeric(event) {	
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}
function isAlphaNumericBankType(event) {	
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32|| charCode==46|| charCode==40|| charCode==41|| charCode==47)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}


</script> 

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>Add Inventory Terminal</h3>
                         </div>
                     </div>
                   <div class="row">
                    <form class="form-horizontal form-label-left">
                        <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->

<!-- ----------------------------------------------------------------Basic details----------------->
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Add Inventory Terminal</h2>
                                 	 <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br /> 
									  <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="modelName">Model Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<select data-clear-btn="true" name="modelName" id="modelName" required="true" class="form-control">
            										<option value="A920"> A920</option>
            										<option value="WizarPosQ1"> WizarPos Q1</option>
            										<option value="NewlandN910"> Newland N910</option>
            										<option value="PaxA920"> Pax A920</option>
            										<option value="PaxD200"> Pax D200</option>
            										<option value="NewlandME51"> Newland ME51</option>
            										</select>
                                            </div>
                                        </div>                               
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Serial No<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="serialNo" id="serialNo" required="true" minlength="8" maxlength="17" onkeypress='return isNumberKey(event)' digits="true" />
                                           </div>
                                        </div>
                                  
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Status<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="status"
											id="status" required="true" class="form-control">
											<option value="Available"> Available</option>
											<option value="Unavailable"> Unavailable</option>
											<option value="Damaged">Damaged</option>
											<option value="Internaluse">Internal Use</option>
											<option value="Inuse">InUse</option>
											</select>                                                    
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                              <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return submitDevice();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddMerchantDetails" name="AddMerchantDetails">Submit</button>
                                            </div>
                                        </div>  
                                      </div>
                                    </div>                                     
                                </div>
                            </div>    
                            
<!------------------------------------------------------------------panels end----------------->
                        </div>
                    </form>
                    </div>
				</div>
				
								<!-- Small modal -->
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
                                <!-- /modals - ->
                    
                <!-- /page content -->

<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->