<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/acqcitystate.js" />"></script>
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

 
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->

    <!-- Main content -->
	    <section class="content">
	      <div class="row">
	        <div class="col-md-12">
	          <div class="box box-primary">
	            <div class="box-header with-border">
	              <h3 class="box-title">Add Store</h3>
	            </div>
	            <form role="form">
	            <input type="hidden" value="${allMerchantDetails['merchantId']}" name="AddOrgMid" id="AddOrgMid" />
	              <div class="box-body">
	                <div class="row">
	                  <div class="col-md-5">
	                    <div class="form-group">
	                      <label for="exampleInputEmail1">Merchant Name</label>
	                     <select name="merchantId" id="merchantId" class="form-control input-lg">
	                         <option value="">Merchant Name</option>
	                          <c:forEach var="RowData" items="${merchantList}">
								<option value="<c:out value="${RowData['merchantId']}"/>">
									<c:out value="${RowData['merchantName']}"/></option> 
								</c:forEach>        
                     </select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Name</label>
                      <input type="text" class="form-control input-lg" id="AddOrgName" placeholder="Enter name">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Address Line 1</label>
                      <input type="text" class="form-control input-lg" id="AddOrgAddress1" placeholder="Enter Address1">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Address Line 2</label>
                      <input type="text" class="form-control input-lg" id="AddOrgAddress2" placeholder="Enter Address2">
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">State</label>
                       <select onchange="print_businesscity('businesscity', selectedIndex);" id="businessstate" name ="businessstate" class="form-control input-lg">
					       <option value="">STATE</option>
					   </select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">City</label>
                      <script language="javascript">print_businessstate("businessstate");</script>
                        <select id="businesscity" name ="businesscity" class="form-control input-lg">
					      <option value="">CITY</option>
					    </select>
                    </div>
                  </div>
                </div>
                 <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">PinCode</label>
                      <input type="number" class="form-control input-lg" id="AddOrgPinCode" placeholder="Enter Pincode">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Country</label>
                      <input type="text" class="form-control input-lg" id="Country" value="INDIA">
                    </div>
                  </div>
                </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" data-toggle="modal" data-target=".bs-example-modal-sm" onclick="return getorg();">Submit</button>
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
