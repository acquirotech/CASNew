<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">
function submitDevice(){
	$("#modal-body").html("<h2>In Process</h2>");

	var kitNo=$("#kitNo").val();
	var cardNo=$("#cardNo").val();
	var cardType=$("#cardType").val();
	var status=$("#status").val();
	

	if(kitNo==null||kitNo==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter kit No</p>');
		return false;
	}else if(kitNo.length<2||kitNo.length>40){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Kit No</p></n>Length should be min 2 and max 40 char');
		return false;
	}else if(cardNo==null||cardNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Card No</p></n>Length should be min 8 and max 17 char');
		return false;
	}else if(cardNo.length<8||cardNo.length>20){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Card No</p></n>Length should be min 8 and max 17 char');
		return false;
	}
	else if(cardType==null||cardType==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Status</p>');
		return false;
	}
	var sendvalue={
			kitNo:kitNo,
			cardNo:cardNo,
			cardType:cardType,
			status:status
			
			 }
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>Prepaid Inventory Added Successfully</h2>");  
                    $("#kitNo").val('');$("#cardNo").val('');
                    $("#tid").val('');$("#cardType").val("Available");
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
            url: "addPrepaidInventory",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}



function getorg(){
    	 var merchantId = $("#merchantId").val();
    	 document.location.href = "?merchantId="+merchantId+"";
    	}



</script> 

<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>Add Prepaid Inventory</h3>
                         </div>
                     </div>
                   <div class="row">
                    <form class="form-horizontal form-label-left">
                        <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->

<!-- ----------------------------------------------------------------Basic details----------------->
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Add Prepaid Inventory</h2>
                                 	 <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                       </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br /> 
                                     <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="kitNo">Kit No.<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control input-lg" data-clear-btn="true" name="kitNo" id="kitNo" required="true" minlength="8" maxlength="20" digits="true" />
                                           </div>
                                        </div>
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cardNo">Card No.<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control input-lg" data-clear-btn="true" name="cardNo" id="cardNo" required="true" minlength="8" maxlength="20"  digits="true" />
                                           </div>
                                        </div>	
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cardType">Card Type<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<select data-clear-btn="true" name="cardType" id="cardType" required="true" class="form-control input-lg">
            										<option value="0"> Select</option>
            										<option value="1"> NFC/CHIP&MAG CARD</option>
            										<option value="2"> CHIP CARD</option>
            										<option value="3"> MAG CARD</option>
            										<option value="4"> OTHERS</option>
            									</select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Status<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="status"
											id="status" required="true" class="form-control input-lg">
											<option value="Active"> Active</option>
											<option value="Unavailable"> Unavailable</option>
											<option value="Damaged">Damaged</option>
											<option value="Internaluse">Internal Use</option>
											<option value="Activated">Activated</option>
											</select>                                                    
                                            </div>
                                        </div> 								 
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                              <a href="<c:url value='welcome' />" class="btn btn-default">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn btn-info pull-right" onclick="return submitDevice();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddMerchantDetails" name="AddMerchantDetails">Submit</button>
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