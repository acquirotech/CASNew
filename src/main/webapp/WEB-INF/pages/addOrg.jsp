<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">


function getorg(){
	$("#AddOrgSub").hide();
	$("#modal-body").html("<h2>In Process</h2>");
	var merchantId=$("#merchantId").val();
	var AddOrgName=$("#AddOrgName").val();
	var AddOrgAddress1=$("#AddOrgAddress1").val();
	var AddOrgAddress2=$("#AddOrgAddress2").val();
	var businessState=$("#businessstate").val();
	var businessCity=$("#businesscity").val();
	var AddOrgPinCode=$("#AddOrgPinCode").val();
	var Country=$("#Country").val();

	if(merchantId==null||merchantId==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Merchant Name</p>');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgName==null||AddOrgName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store Name</p></n>Length should be min 3 and max 60 char');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgName.length<=2||AddOrgName.length>60){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Merchant Correct Format</p></n>Length should be min 3 and max 60 char');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgAddress1==null||AddOrgAddress1==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store Address Line 1</p></n>Length should be min 4 and max 100 char');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgAddress1.length<4||AddOrgAddress1.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store Address Line 1</p></n>Length should be min 4 and max 100 char');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgAddress2==null||AddOrgAddress2==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store Address Line 2</p></n>Length should be min 4 and max 100 char');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgAddress2.length<4||AddOrgAddress2.length>100){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store Address Line 2</p></n>Length should be min 4 and max 100 char');
		$("#AddOrgSub").show();
		return false;
	}else if(businessState==null||businessState==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Store State</p>');
		$("#AddOrgSub").show();
		return false;
	}else if(businessState.length<=2||businessState.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store State</p>');
		$("#AddOrgSub").show();
		return false;
	}else if(businessCity==null||businessCity==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Store City</p>');
		$("#AddOrgSub").show();
		return false;
	}else if(businessCity.length<=2||businessCity.length>50){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store City</p>');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgPinCode==null||AddOrgPinCode==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Store PinCode</p></n>Length should be 6 digits');
		$("#AddOrgSub").show();
		return false;
	}else if(AddOrgPinCode.length!=6){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Store PinCode</p></n>Length should be 6 digits');
		$("#AddOrgSub").show();
		return false;
	}
	
	var sendvalue={
			AddOrgMid:merchantId,AddOrgName:AddOrgName,AddOrgAddress1:AddOrgAddress1,AddOrgAddress2:AddOrgAddress2,
			AddOrgState:businessState,AddOrgCity:businessCity,AddOrgPinCode:AddOrgPinCode,AddOrgCountry:Country}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>Store Added Successfully</h2>");  
                    $("#AddOrgSub").show();
                    $('#merchantId').prop('selectedIndex',0);
                    $("#AddOrgName").val('');
                    $("#AddOrgAddress1").val('');
                    $("#AddOrgAddress2").val('');
                    $('#businessState').prop('selectedIndex',0);
                    $('#businessCity').prop('selectedIndex',0);
                    $("#AddOrgPinCode").val('');
                } else if (data.status==111) {
                    $("body").attr("onload","noBack();");
                    $("body").attr("onpageshow","if (event.persisted) noBack();");
                    $("body").attr("onunload","");
                    window.location.href="logout.jsp";
                }else if (data.status==100) {
                    $("#modal-body").html("<h2>Server Side Validation Failed</h2><p>"+data.message+"</p>");  
                    $("#AddOrgSub").show();                  
                } else {
                    $(".loading").css("visibility", "hidden");
                    $("#modal-body").html("<h2>Connection Error</h2><p>Your Request Could Not Be Processed. Please Try Again Later</p>");
                    $("#AddOrgSub").show();
                     }
            },
            error: function (data, textStatus, errorThrown) {
                $(".loading").css("visibility","hidden");
                if(textStatus=="timeout"){
                	$("#modal-body").html("<h2>Connection Error</h2><p>Your Request Has Timed-Out. Please Try Again Later</p>");
                	$("#AddOrgSub").show();
                    }else{
                	$("#modal-body").html("<h2>Connection Error</h2><p>"+ textStatus+"</p>");  
                	$("#AddOrgSub").show();
                }
            },
            url: "addOrg",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}

</script>


<script type="text/javascript">

function isNumberKey(evt){
	 evt = (evt) ? evt : window.event;
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
	  return false;
	 }
	}

	function isAlphaNumericName(evt) { 
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8||charCode==37|| charCode==39|| charCode==32|| charCode==46|| charCode==45|| charCode==46|| charCode==47|| charCode==44|| charCode==38|| charCode==40|| charCode==41) {
	      return true;
	  }else{
	   return false;
	  }
	     }catch (err) {
	        console.log('errerrerr: '+err);
	     alert(err. Description);
	    }
	}

	function addressValidation(evt) {
	 try {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==8|| charCode==37|| charCode==39|| charCode==32|| charCode==33|| charCode==35|| charCode==38|| charCode==40|| charCode==41|| charCode==44|| charCode==45|| charCode==46|| charCode==47|| charCode==58|| charCode==95) {
	      return true;
	  }else{
	   return false;
	  }
	 }catch (err) {
	 // console.log(charCode+' :6666666666666');
	  alert('error');
	  alert(err. Description);
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

</script>
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                    <form class="form-horizontal form-label-left"> 
                    <input type="hidden" value="${allMerchantDetails['merchantId']}" name="AddOrgMid" id="AddOrgMid" />
	     			 <div class="col-md-12 col-sm-12 col-xs-12">-

<!-- ----------------------------------------------------------------panels start----------------->


  <!--- panel Store ---------------------------------------------------------->
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Add New Store Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                   
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                   <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="merchantId">Merchant Name</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                 <select name="merchantId" id="merchantId" class="form-control">
                                                    <option value="">Merchant Name</option>
                                                     <c:forEach var="RowData" items="${merchantList}">
														<option value="<c:out value="${RowData['merchantId']}"/>">
														<c:out value="${RowData['merchantName']}"/></option> 
										 			 </c:forEach>        
                                                  </select>
                                             </div>
                                        </div>
                                        
                                     	<div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12">Name<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="AddOrgName" id="AddOrgName" required="true" minlength="2" maxlength=60 onkeypress="return isAlphaNumeric(event);"  />
                                            </div>
                                        </div>
                                    	<div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12" for="BusinessAddress1">Address Line 1<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="AddOrgAddress1" id="AddOrgAddress1" required="true" minlength="4" onkeypress="return addressValidation(event);" maxlength=100   />
                                          </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="BusinessAddress2">Address Line 2<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="AddOrgAddress2" id="AddOrgAddress2" required="true" minlength="4" onkeypress="return addressValidation(event);" maxlength=100   />
                                            </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="AddOrgState">State<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            <select onchange="print_businesscity('businesscity', selectedIndex);" id="businessstate" name ="businessstate" class="form-control">
					                             <option value="">STATE</option>
					                            </select>
                                                  </div>
                                        </div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="AddOrgCity">City<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                            <script language="javascript">print_businessstate("businessstate");</script>
                                            <select id="businesscity" name ="businesscity" class="form-control">
					                             <option value="">CITY</option>
					                            </select>
                                                  </div>
                                  		</div>
                                        <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="AddOrgPinCode">Pincode<span class="required">*</span></label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="AddOrgPinCode" id="AddOrgPinCode" digits="true" onkeypress='return isNumberKey(event)' minlength="0" maxlength="6"  />
                                               </div>
                                        </div>
                                         <div class="form-group percent-50">
                                            <label class="control-label col-md-12 col-sm-12 col-xs-12"for="Country">Country</label>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="Country" id="Country" required="true" minlength="5" onkeypress="return onlyAlphabets(event);" maxlength=50 value="INDIA" onlyalpha="true" readonly="readonly" /> 
                                                </div>
                                        </div>
                                          <div class="form-group percent-100">
                                            <div class="col-md-12 col-sm-12 col-xs-12 submit-box">
                                               <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return getorg();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddOrgSub" name="AddOrgSub">Submit</button>
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
                                <!-- /modals -->
                    
                <!-- /page content -->

<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->