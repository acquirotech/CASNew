<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
  
    <!-- Content Header (Page header) -->
    <script type="text/javascript"> 
    function setDeviceDetails(dsaid,name,deviceRental,cashatPosIncentive,mdr0,mdr1,address,mdr2,mdrCre,mdrNonPre,other,walletMdr,address){
    	$("#updateId").val(dsaid);
    	$("#name").val(name);
    	$("#deviceRental").val(deviceRental);
    	$("#cashatPosIncentive").val(cashatPosIncentive);	
    	$("#mdr0").val(mdr0);
    	$("#mdr1").val(mdr1);
    	$("#mdr2").val(mdr2);
    	$("#mdrCre").val(mdrCre);
    	$("#mdrNonPre").val(mdrNonPre);
    	$("#other").val(other);
    	$("#walletMdr").val(walletMdr);
    	$("#address").val(address);
    } 

    function updDeviceDetails(){
    	$("#modal-body").html("<h2>In Process</h2>");
    	var updateId=$("#updateId").val();
    	var deviceRental=$("#deviceRental").val();
    	var name=$("#name").val();
    	var cashAtPosIncentive=$("#cashAtPosIncentive").val();
    	var MdrDebit0=$("#MdrDebit0").val();
    	var MdrDebit1=$("#MdrDebit1").val();
    	var MdrDebit2=$("#MdrDebit2").val();
    	var MdrCreditPre=$("#MdrCreditPre").val();
    	var MdrCreditNpre=$("#MdrCreditNpre").val();
    	var Other=$("#Other").val();
    	var mdrCashAtPos=$("#mdrCashAtPos").val();
    	var walletMdr=$("#walletMdr").val();
    	var address=$("#address").val();
    	
    	if(name==null||name==""){
    		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Model Name</p>');
    		return false;
    	}else if(name.length<2||name.length>40){
    		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 2 and max 40 char');
    		return false;
    	}else if(deviceRental==null||deviceRental==''){
    		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal deviceRental</p></n>Length should be min 8 and max 17 char');
    		return false;
    	}else if(deviceRental.length>17){
    		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal deviceRental</p></n>Length should be min 8 and max 17 char');
    		return false;
    	}
    	
    	var sendvalue={
    			updateId:updateId,
    			walletMdr:walletMdr,
    			mdrCashAtpos:mdrCashAtPos,
    			Other:Other,
    			MdrCreditNpre:MdrCreditNpre,
    			MdrCreditPre:MdrCreditPre,
    			MdrDebit2:MdrDebit2,
    			MdrDebit1:MdrDebit1,
    			cashAtPosIncentive:cashAtPosIncentive,
    			Name:name,
    			deviceRent:deviceRental,
    			address:address,
    			MdrDebit0:MdrDebit0
    			
    			 }
    	var opts = {
                type: "POST",
                success: function (data) {
                    $(".loading").css("visibility","hidden");
                    if (data.status == 0&&data.message=='OK') {
                        $("#modal-body").html("<h2>DSA Added Successfully</h2>");  
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
                url: "updateDSA",
                data: sendvalue
            }; 
            $.ajax(opts);
            return false;
    }
   

   
 
</script>
    <!-- Main content -->
    <div class="content-wrapper">
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
             
              <div class="box-header with-border">
                <h3 class="box-title">DSA List</h3>
                <div class="box-tools">
                <a class="btn btn-block btn-primary btn-sm"><i class="fa fa-filter"></i> Filters</a>
                  
                </div>
              </div>
              
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table table-bordered">
                  <thead>
                    <tr>
                   								<th >Name</th>
                                              	<th>Device Rental</th>
                                              	<th>Address</th>
												<th class=" no-link last"><span class="nobr">Action</span></th>       
                  </tr>
                  </thead>
                  <tbody>
                  <?php 
                  for ($x = 0; $x <= 8; $x++) {?>
                    <c:forEach var="allRowData" items="${empList}">											
                                        	<tr class="even pointer">
                                            	<td class=" "><c:out value="${allRowData['name']}"/></td>
                                            	<td class=" "><c:out value="${allRowData['deviceRental']}"/></td>                                            		
												<td class=" "><c:out value="${allRowData['address']}"/></td>
												<td class=" ">
													<button type="submit" class="btn btn-success btn-xs" data-toggle="modal" data-target=".update_device_popup" onclick='setDeviceDetails("${allRowData.dsaid}","${allRowData.name}","${allRowData.deviceRental}","${allRowData.cashatPosIncentive}","${allRowData.mdr0}","${allRowData.mdr1}","${allRowData.address}","${allRowData.mdr2}","${allRowData.mdrCre}","${allRowData.mdrNonPre}","${allRowData.other}","${allRowData.walletMdr}");'><i class="fa fa-fw fa-eye"></i>Update</button>
													<!-- <button type="submit" class="btn btn-danger btn-xs"><i class="fa fa-fw fa-remove"></i>Delete</button> -->
												</td>
											</tr>
											</c:forEach>
                  <?php } ?>
                  </tbody>
                </table>
              </div>
              
              <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#">«</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">»</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>

  <!-- For Update -->
 <%-- <div class="modal fade" id="deleteConfirm">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Are you sure you want to remove the merchant.<br> You can't undo this action.</h4>
      </div>
      <div class="modal-footer">
        <form id="id2DelFrm" method="GET">
          <input type="hidden" class="form-control" id="dsaid2Delete" name="dsaid2Delete" value="${empList['dsaid']}">
          <button type="button" class="btn btn-default" data-dismiss="modal">Keep It</button>
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove" onclick="return deleteEmp('${empList['dsaid']}');"></i>Delete</button>
        </form>
      </div>
    </div>
  </div>
</div>  --%>
<div class="modal fade update_device_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update DSA</h4>
					  Details
				</div>
				<div class="modal-body1">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="updateId" name="updateId" >
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
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="modelName"> Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	    <input type="text" class="form-control" data-clear-btn="true" name="name" id="name" required="true" />
                                           
                                            </div>
                                        </div>                                                            
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="serialNo">Device Rental<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="deviceRental" id="deviceRental" required="true"  />
                                           </div>
                                        </div>
                                        
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Cash@pos Inventive<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="cashatPosIncentive" id="cashatPosIncentive" required="true"  />
                                                                                             
                                            </div>
                                            
                                        </div>    
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">MDR <1000<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="mdr0" id="mdr0" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">MDR (1000><2000)<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="mdr1" id="mdr1" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">MR >2000<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="mdr2" id="mdr2" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Address<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="address" id="address" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">mdrCredit Premium<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="mdrCre" id="mdrCre" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                            
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">mdr CreditNonPremium<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="mdrNonPre" id="mdrNonPre" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Other<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="other" id="other" required="true"  />
                                                                                             
                                            </div>
                                        </div> 
                                          
                                          <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Wallet Mdr<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <input type="text" class="form-control" data-clear-btn="true" name="walletMdr" id="walletMdr" required="true"  />
                                                                                             
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
						<!--  <span aria-hidden="true">×</span> -->
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
