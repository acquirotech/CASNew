<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <script type="text/javascript"> 
    function downloadFile(){
    	var fromDate1 = $("#fromDate1").val();
    	var toDate1 = $("#toDate1").val();
    	document.body.innerHTML += '<form id="downloadForm" action="<c:url value='downloadDeviceDetails' />"><input type="hidden" name="fromDate" value='+fromDate1+' /><input type="hidden" name="toDate" value='+toDate1+' /></form>';
    	document.getElementById("downloadForm").submit();
    	setTimeout(function(){ location.reload(); }, 3000);	
    }
    function closeModel(){
    	location.reload();
    }

    function searchClickedTns(){
    	var Name = $("#Name").val();
    	var Status = $("#Status").val();
    	var SrNo = $("#SrNo").val();
    	
    	var appendMe="";
    	
    	if(Name!=null&&Name!=""){
    		appendMe=appendMe.concat("&modelName="+Name+"")
    	}
    	if(Status!=null&&Status!=""){
    		appendMe=appendMe.concat("&status="+Status+"");
    	}
    	if(SrNo!=null&&SrNo!=""){
    		appendMe=appendMe.concat("&serialNo="+SrNo+"");
    	}
    	
    	document.location.href = "?page=1&txn=123654321"+appendMe;
    }

    function clearAllFillter(){
    	var Name = $("#Name").val('');
    	var Status = $("#Status").val('');
    	var SrNo = $("#SrNo").val('');
    	 document.location.href = "?page=1"
    }

    function updDeviceDetails(){
    	$("#modal-body").html("In Process");
    	var modelName=$("#modelName").val();
    	var serialNo=$("#serialNo").val();
    	var status=$("#status").val();
    	var id=$("#id").val();	
    	var adapterSerialNo=$("#adapterSerialNo").val();
    	var batterySerialNo=$("#batterySerialNo").val();
    	var dsaList=$("#dsaList").val();
    	//console.log('deviceSerialNo update: '+deviceSerialNo+' ::::::::new :::::: '+serialNo);
    	if(status=='Inuse'||status=='Allotted'&&deviceSerialNo!=serialNo){
    		alert("Device Serial Alerady In Use, Can't Update");
    		location.reload();
    		return false;
    	}
    	if(modelName==null||modelName==""){
    		$("#modal-body").html('Validation Error<p>Enter Model Name</p>');
    		return false;
    	}else if(modelName.length<2||modelName.length>40){
    		$("#modal-body").html('Validation Error<p>Enter Correct Name</p></n>Length should be min 2 and max 40 char');
    		return false;
    	}else if(serialNo==null||serialNo==''){
    		$("#modal-body").html('Validation Error<p>Enter Device Serial No</p></n>Length should be min 8 and max 17 char');
    		return false;
    	}else if(serialNo.length<8||serialNo.length>17){
    		$("#modal-body").html('Validation Error<p>Enter Correct Device Serial No</p></n>Length should be min 8 and max 17 char');
    		return false;
    	}else if(status==null||status==""){
    		$("#modal-body").html('Validation Error<p>Select Status</p>');
    		return false;
    	}
    	var sendvalue={inventoryDeviceId:id,modelName:modelName,inventorySerialNo:serialNo,status:status,adapterSerialNo:adapterSerialNo,
    			batterySerialNo:batterySerialNo,
    			dsaList:dsaList}
    	var opts = {
                type: "POST",
                success: function (data) {
                    $(".loading").css("visibility","hidden");
                   	if (data.status==0&&data.message=='OK'){                   	                   	
                        $("#modal-body").html("Inventory Terminal Updated Successfully");  
                        location.reload(); 
                    } else if (data.status==111) {
                        $("body").attr("onload","noBack();");
                        $("body").attr("onpageshow","if (event.persisted) noBack();");
                        $("body").attr("onunload","");
                        window.location.href="logout.jsp";
                    }else if (data.status==100) {
                        $("#modal-body").html("Server Side Validation Failed<p>"+data.message+"</p>");                    
                    } else {
                        $(".loading").css("visibility", "hidden");
                        $("#modal-body").html("Connection Error<p>Your Request Could Not Be Processed. Please Try Again Later</p>");
                    }
                },
                error: function (data, textStatus, errorThrown) {
                    $(".loading").css("visibility","hidden");
                    if(textStatus=="timeout"){
                    	$("#modal-body").html("Connection Error<p>Your Request Has Timed-Out. Please Try Again Later</p>");
                    }else{
                    	$("#modal-body").html("Connection Error<p>"+ textStatus+"</p>");  
                    }
                },
                url: "inventoryUpdateDevice",
                data: sendvalue
            }; 
            $.ajax(opts);
            return false;
    }

    var deviceSerialNo;
    function setDeviceDetails(id,modelName,serialNo,status, batterySerialNo,adaptorSerialNo,dsaList){
    	deviceSerialNo = serialNo;	
    	$("#id").val(id);
    	$("#modelName").val(modelName);
    	$("#serialNo").val(serialNo);
    	$("#status").val(status);
    	$("#batterySerialNo").val(batterySerialNo);
    	$("#adaptorSerialNo").val(adaptorSerialNo);
    	$("#dsaList").val(dsaList);	
    	var status2 = $("#status").val();
    	$('#status').on('change', function() {
    		var status1= $('#status').val();
    	  	if(status2=="Inuse"||status2=="Allotted"){
    	  		if ( $('#status').val() == "Available" || $('#status').val() == "Defected" ) {
    	          	alert ( 'Device Already in Use');
    	          	$("#status").val(status2);
    	          	return false;
    	     	}else{
    	   			return true;
    	      	}
    	  	}
    	 });
    }

    function deleteDeviceConfirm(status,id){
    	if(status=="Inuse"||status=="Allotted"){
    		 alert("Device is in use, Can't delete");
    		 return false;
    	}else{

    		
    	if (confirm("Do you want to delete device details ?") == true) {
    		var sendvalue={id2Delete:id}
    		var opts = {
    	            type: "POST",
    	            success: function (data) {
    	                $(".loading").css("visibility","hidden");
    	                if (data.status == 0&&data.message=='OK') {
    	                    $("#modal-body").html("Inventory Terminal Deleted Successfully"); 
    	                    location.reload(); 
    	                } else if (data.status==111) {
    	                    $("body").attr("onload","noBack();");
    	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
    	                    $("body").attr("onunload","");
    	                    window.location.href="logout.jsp";
    	                }else if (data.status==100) {
    	                    $("#modal-body").html("Server Side Validation Failed<p>"+data.message+"</p>");                    
    	                } else {
    	                    $(".loading").css("visibility", "hidden");
    	                    $("#modal-body").html("Connection Error<p>Your Request Could Not Be Processed. Please Try Again Later</p>");
    	                }
    	            },
    	            error: function (data, textStatus, errorThrown) {
    	                $(".loading").css("visibility","hidden");
    	                if(textStatus=="timeout"){
    	                	$("#modal-body").html("Connection Error<p>Your Request Has Timed-Out. Please Try Again Later</p>");
    	                }else{
    	                	$("#modal-body").html("Connection Error<p>"+ textStatus+"</p>");  
    	                }
    	            },
    	            url: "inventoryDeviceDelete",
    	            data: sendvalue
    	        }; 
    	        $.ajax(opts);
    	        return false;

    	}else{
    		return false;
    	}}
    }
    	 
   
</script>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
             
              <div class="box-header with-border">
                <h3 class="box-title">Device List</h3>
                <div class="box-tools">
                <a class="btn btn-block btn-primary btn-sm"><i class="fa fa-filter"></i> Filters</a>
                  <strong>
                                    <c:if test="${Name!=''&&Name!=null&&Name!='A'}"> Model Name:<c:out value="${Name}"/><input type="hidden" id="Namee" value='<c:out value="${Name}"/>'/></c:if>
                                    <c:if test="${SrNo!=''&&SrNo!=null&&SrNo!='A'}"> || Serial No:<c:out value="${SrNo}"/><input type="hidden" id="srNoo" value='<c:out value="${SrNo}"/>'/></c:if>
                                    <c:if test="${Status!=''&&Status!=null&&Status!='A'}">  || Status:<c:out value="${Status}"/><input type="hidden" id="Statuss" value='<c:out value="${Status}"/>'/></c:if>
								  </strong>
                </div>
              </div>
              
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table table-bordered">
                  <thead>
                    <tr>
                   								<th>Model Name</th>
                                              	<th>Serial No</th>
                                              	<th>Merchant Name</th>
                                              	<th>Status</th>
												<th class=" no-link last"><span class="nobr">Action</span></th>       
                  </tr>
                  </thead>
                  <tbody>
                  <?php 
                  for ($x = 0; $x <= 8; $x++) {?>
                    <c:forEach var="allRowData" items="${deviceList}">											
                                        	<tr class="even pointer">
                                            	<td class=" "><c:out value="${allRowData['modelName']}"/></td>
                                            	<td class=" "><c:out value="${allRowData['serialNo']}"/></td>  
                                            	<td class=" "><a href="merchantdetails?MerchantId=${allRowData.mid}" target="_blank" /><u><c:out value="${allRowData['merchantName']}"/></u></a></td>                                          		
												<td class=" "><c:out value="${allRowData['status']}"/></td>
												<td class=" ">
													<button type="submit" class="btn btn-success btn-xs" data-toggle="modal" data-target=".update_device_popup" onclick='setDeviceDetails("${allRowData.id}","${allRowData.modelName}","${allRowData.serialNo}","${allRowData.status}","${allRowData.batrySerialNo}","${allRowData.adapterSerialNo}","${allRowData.dsaList}");' <c:if test="${empRole == '12'}">style="display:none;"</c:if>><i class="fa fa-fw fa-eye"></i>Update</button>
													<button type="submit" class="btn btn-danger btn-xs" onclick='return deleteDeviceConfirm("${allRowData.status}","${allRowData.id}")'<c:if test="${allRowData.empRole != '1'}">style="display:none;" </c:if>><i class="fa fa-fw fa-remove"></i>Delete</button>
												</td>
											</tr>
											</c:forEach>
                  <?php } ?>
                  </tbody>
                </table>
              </div>
              
              <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#">�</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">�</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>

  <!-- For Update -->
<div class="modal fade" id="deleteConfirm">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Are you sure you want to remove the merchant.<br> You can't undo this action.</h4>
      </div>
      <div class="modal-footer">
        <form id="id2DelFrm" method="GET">
          <input type="hidden" class="form-control" id="id2Delete" name="id2Delete" value="${empList['id']}">
          <button type="button" class="btn btn-default" data-dismiss="modal">Keep It</button>
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove" onclick="return deleteEmp('${empList['id']}');"></i>Delete</button>
        </form>
      </div>
    </div>
  </div>
</div>
<div class="modal fade update_device_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">�</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Device</h4>
					Device Details
				</div>
				<div class="modal-body1">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="id" name="id" value="">
						<div class="x_panel">
							<div class="x_title">
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								 <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="modelName">Model Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<select data-clear-btn="true" name="modelName" id="modelName" required="true" class="form-control input-lg">
                                            	<option <c:if test="${modelName == 'WizarPosQ1'}">Selected="Selected"</c:if> value="WizarPosQ1">WizarPos Q1</option>
                                            	<option <c:if test="${modelName == 'NewlandN910'}">Selected="Selected"</c:if> value="NewlandN910">Newland N910</option>
                                            	<option <c:if test="${modelName == 'PaxA920'}">Selected="Selected"</c:if> value="PaxA920">Pax A920</option>
                                            	<option <c:if test="${modelName == 'PaxD200'}">Selected="Selected"</c:if> value="PaxD200">Pax D200</option>
                                            	<option <c:if test="${modelName == 'NewlandME51'}">Selected="Selected"</c:if> value="NewlandME51">Newland ME51</option>
                     								<option value="A920"> A920</option>
                     							</select>
                                            </div>
                                        </div>                                                            
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Serial No<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control input-lg" data-clear-btn="true" name="serialNo" id="serialNo" required="true" minlength="8" maxlength="17" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" />
                                           </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Battery Serial No<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control input-lg"" data-clear-btn="true" name="batterySerialNo" id="batterySerialNo" required="true" minlength="8" maxlength="17" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" />
                                           </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Adapter Serial No<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control input-lg"" data-clear-btn="true" name="adaptorSerialNo" id="adaptorSerialNo" required="true" minlength="8" maxlength="17" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" />
                                           </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">DSA List<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                           <select data-clear-btn="true" name="dsaList"
											id="dsaList" required="true" class="form-control input-lg">
											<option <c:if test="${dsaList == '1'}">Selected="Selected"</c:if> value="1">Company Owned</option>
                                            <option <c:if test="${dsaList == '2'}">Selected="Selected"</c:if> value="2">Channel Partner</option>
                                            <option <c:if test="${dsaList == '3'}">Selected="Selected"</c:if> value="3">DSA</option>
                                            </select> </div>
                                        </div>
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Status<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="status"
											id="status" required="true" class="form-control input-lg">
											<option value="Available"> Available</option>
											<option value="Allotted"> Allotted</option>
											<option value="Defected">Defected</option>   
											</select>                                              
                                            </div>
                                        </div>                              
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-cancel" data-dismiss="modal">Close</button>	
					<button type="button" class="btn-submit"
										data-toggle="modal" data-target=".bs-example-modal-sm"
										onclick="return updDeviceDetails();" id="UpdDeviceDetails"
										name="UpdDeviceDetails">Update Device</button>	
					
				</div>
			</div>
		</div>
	</div>

                
                
<!---------------------------------------------- Small modal ------------------------------------------------------------->
	<div class="modal fade filter-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel22">Set Filters</h4>
				</div>
					<div id="modal-body2" class="modal-body">
<input type="text" style="height: 30px;" maxlength="40" placeholder="Enter Name" id="Name" value='<c:out value="${Name}"/>' class="form-control" onkeypress="return isAlphaNumericWithoutSpace(event);" /><br/>
<input type="text" style="height: 30px;" minlength="8" maxlength="17" placeholder="Enter Serial No" id="SrNo" value='<c:out value="${SrNo}"/>' class="form-control" onkeypress='return isNumberKey(event)' digits="true"/><br/>
<!-- <input type="text" style="height: 30px;" maxlength="20" placeholder="Enter Status" id="Status" value='<c:out value="${Status}"/>' class="form-control" /><br/>	 -->
<select data-clear-btn="true" name="Status" id="Status" value='<c:out value="${Status}"/>' class="form-control">
 <option value="" <c:if test="${Status == ''}">Selected</c:if>>Select Status</option>
 <option <c:if test="${Status == 'Available'}">Selected</c:if> value="Available"> Available</option>  
 <option <c:if test="${Status == 'Unavailable'}">Selected</c:if> value="Unavailable"> Unavailable</option>
 <option <c:if test="${Status == 'Damaged'}">Selected</c:if> value="Damaged"> Damaged</option>
 <option <c:if test="${Status == 'Internaluse'}">Selected</c:if> value="Internaluse">Internaluse</option>
 <option <c:if test="${Status == 'Inuse'}">Selected</c:if> value="Inuse"> Inuse</option>
</select><br/>
<button type="button" class="btn btn-primary btn-xs" onclick="return searchClickedTns();">Search</button>
<button type="button" class="btn btn-primary btn-xs" onclick="return clearAllFillter();">Clear All Filter</button>	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
				</div>
				</div>
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
                         <!---------------------------------------------- Small modal ------------------------------------------------------------->
 <div class="modal fade download-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<!--  <span aria-hidden="true">�</span> -->
					</button>
					<h4 class="modal-title" id="myModalLabel21">Download File</h4>
				</div>
				<div id="modal-body" class="modal-body">
					<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter From Date" class="date-picker form-control" id="fromDate1"><br/>
					<input type="text" style="height: 30px;" maxlength="30" readonly="readonly" placeholder="Enter To Date" class="date-picker form-control"  id="toDate1"><br/>				
				    <button type="button" class="btn-submit" onclick="return downloadFile();">Search</button>
			        <button type="button" class="btn-cancel" onclick="return closeModel();">Close</button>			
				</div>
				<div class="modal-footer">
					<!--  <button type="button" class="btn btn-default" id="close" >Close</button>-->
				</div>
			</div>
		</div>                              
 </div>

<!--Delete confirmation Popup Begin -->

<!--Delete confirmation Popup End -->

      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<jsp:include page="/jsp/footer.jsp" />
