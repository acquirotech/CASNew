<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3"))){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------------------js function -------------------- -->

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
	$("#modal-body").html("<h2>In Process</h2>");
	var cardNo=$("#cardNo").val();
	var cardType=$("#cardType").val();
	var kitNo=$("#kitNo").val();
	var status=$("#status").val();
	var id=$("#id").val();	
	if(status=='Inuse'){
		alert("Prepaid Card Alerady In Use, Can't Update");
		location.reload();
		return false;
	}
	if(cardNo==null||cardNo==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter card No</p>');
		return false;
	}else if(cardNo.length<2||cardNo.length>40){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct No.</p></n>Length should be min 2 and max 40 char');
		return false;
	}else if(cardType==null||cardType==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Card Type</p>');
		return false;
	}else if(status==null||status==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Status</p>');
		return false;
	}
	var sendvalue={kitNo:kitNo,
			id:id,
			cardNo:cardNo,
			cardType:cardType,
			status:status}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
               	if (data.status==0&&data.message=='OK'){                   	                   	
                    $("#modal-body").html("<h2>Prepaid Inventory Updated Successfully</h2>");  
                    location.reload(); 
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
            url: "prepaidInventoryUpdateDevice",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}

var deviceSerialNo;
function setDeviceDetails(id,cardNo,cardType,kitNo,status){
	$("#id").val(id);
	$("#cardNo").val(cardNo);
	$("#cardType").val(cardType);
	$("#kitNo").val(kitNo);
	$("#status").val(status);	
	var status2 = $("#status").val();
	$('#status').on('change', function() {
		var status1= $('#status').val();
	  	if(status2=="Inuse"){
	  		if ( $('#status').val() == "Available" || $('#status').val() == "Unavailable" || $('#status').val() == "Internaluse") {
	          	alert ( 'Card Already in Use');
	          	$("#status").val(status2);
	          	return false;
	     	}else{
	   			return true;
	      	}
	  	}
	 });
}


function deleteDeviceConfirm(status,id){
	if(status=="Inuse"){
		 alert("Device is in use, Can't delete");
		 return false;
	}else{

		
	if (confirm("Do you want to delete Prepaid details ?") == true) {
		var sendvalue={deviceId:id}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Prepaid Inventory Deleted Successfully</h2>"); 
	                    location.reload(); 
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
	            url: "inventoryPrepaidDelete",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;

	}else{
		return false;
	}}
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
	 
$(document).ready(function (){
	
	<c:if var="msg" test="${message!=null}">	
		alert('<c:out value="${message}" />');
	</c:if>
	<c:if var="pg" test="${page!=null&&page!=''}">
		$("#pageNo").val('<c:out value="${page}" />');
	</c:if>
	<c:if var="searchtx" test="${searchText!=null&&searchText!=''}">
		$("#searchAll").val('<c:out value="${searchText}" />');
	</c:if>
	
	<c:if var="lct" test="${location!=null&&location!=''}">	
		$("#storeLocation").val('<c:out value="${location}" />');
	</c:if>

	<c:if var="lct" test="${totalRows!=null&&totalRows!=''}">		
		$("#totRows").val('<c:out value="${totalRows}" />');
	</c:if>

	<c:if test="${fromDate != null&&fromDate!=''}"> 
		$("#dateUp").hide();
		$("#dateDown").show();
		$("#fromDate").show();
		$("#fromDate").val('<c:out value="${fromDate}" />');
	</c:if><c:if test="${toDate != null&&toDate!=''}"> 
	$("#toDate").show();
	$("#toDate").val('<c:out value="${toDate}" />');
	</c:if>
	
	var Namee = $("#Namee").val();
	var Statuss=$("#Statuss").val();
	var srNoo=$("#srNoo").val();
	
	if(Namee==undefined)
		Namee='%41';
	if(Statuss==undefined)
		Statuss='%41';
	if(srNoo==undefined)
		srNoo='%41';
	
	$("#pageNo").change(function(){
		var pageNo = $("#pageNo").val();
				
		if(pageNo!=null&&pageNo!=""){
			document.body.innerHTML += '<form id="pageForm" action="<c:url value='prepaidInventoryList' />"><input type="hidden" name="page" value='+pageNo+' /><input type="hidden" name="modelName" value='+Namee+' /><input type="hidden" name="status" value='+Statuss+' /><input type="hidden" name="serialNo" value='+srNoo+' /></form>';
			document.getElementById("pageForm").submit();
		}
	});	
	$("#first").click(function () {
		var page=1;
		$("#pageNo").val(page);
		var location = $("#storeLocation").val();
		document.body.innerHTML += '<form id="firstForm" action="<c:url value='prepaidInventoryList' />"><input type="hidden" name="page" value="1" /><input type="hidden" name="modelName" value='+Namee+' /><input type="hidden" name="status" value='+Statuss+' /><input type="hidden" name="serialNo" value='+srNoo+' /></form>';
		document.getElementById("firstForm").submit();	
	});
	$("#previous").click(function () {
		var page=$("#pageNo").val();
		if(page>1){
			$("#pageNo").val(page-1);
		}
		var previousPage=$("#pageNo").val();
	
		document.body.innerHTML += '<form id="previousForm" action="<c:url value='prepaidInventoryList' />"><input type="hidden" name="page" value='+previousPage+' /><input type="hidden" name="modelName" value='+Namee+' /><input type="hidden" name="status" value='+Statuss+' /><input type="hidden" name="serialNo" value='+srNoo+' /></form>';
		document.getElementById("previousForm").submit();		
	});
	$("#next").click(function () {
		var page=parseInt($("#pageNo").val());
		var lastPage=$("#totRows").val();
		if(page<lastPage){
			$("#pageNo").val(page+1);
		}
		var nextPage=parseInt($("#pageNo").val());		
		document.body.innerHTML += '<form id="nextForm" action="<c:url value='prepaidInventoryList' />"><input type="hidden" name="page" value='+nextPage+' /><input type="hidden" name="modelName" value='+Namee+' /><input type="hidden" name="status" value='+Statuss+' /><input type="hidden" name="serialNo" value='+srNoo+' /></form>';
		document.getElementById("nextForm").submit();
		
	});
	$("#last").click(function () {
		var lastPage=$("#totRows").val();
		document.body.innerHTML += '<form id="lastForm" action="<c:url value='prepaidInventoryList' />"><input type="hidden" name="page" value='+lastPage+' /><input type="hidden" name="modelName" value='+Namee+' /><input type="hidden" name="status" value='+Statuss+' /><input type="hidden" name="serialNo" value='+srNoo+' /></form>';
		document.getElementById("lastForm").submit();
	});

	$("#buttonClass").click(function() {
	    getValueUsingClass();
	});	
	
});

</script>
	 <!-- page content -->
            <div class="right_col" role="main">
                <div class="">                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Prepaid Inventory List</h2>
                                   
                                    <div class="clearfix"></div>
                                  <strong>
                                    <c:if test="${Name!=''&&Name!=null&&Name!='A'}"> Model Name:<c:out value="${Name}"/><input type="hidden" id="Namee" value='<c:out value="${Name}"/>'/></c:if>
                                    <c:if test="${SrNo!=''&&SrNo!=null&&SrNo!='A'}"> || Serial No:<c:out value="${SrNo}"/><input type="hidden" id="srNoo" value='<c:out value="${SrNo}"/>'/></c:if>
                                    <c:if test="${Status!=''&&Status!=null&&Status!='A'}">  || Status:<c:out value="${Status}"/><input type="hidden" id="Statuss" value='<c:out value="${Status}"/>'/></c:if>
								  </strong>
                                <div class="clearfix"></div>
                                </div>
                                <div>
                                    <table class="table table-striped responsive-utilities jambo_table bulk_action">
                                        <thead>
                                            <tr class="headings">
                                            	<th class="column-title">Card Type</th>
                                              	<th class="column-title">Card No.</th>
                                              	<th class="column-title">Kit No.</th>
                                              	<th class="column-title">Status</th>
												<th class=" no-link last"><span class="nobr">Action</span></th></th>
                                            </tr>
                                        </thead>
                                    <tbody>
                                    	<c:forEach var="allRowData" items="${deviceList}">											
                                        	<tr class="even pointer">
                                            	<td class=" "><c:out value="${allRowData['cardType']}"/></td>
                                            	<td class=" "><c:out value="${allRowData['cardNo']}"/></td>                                            		
												<td class=" "><c:out value="${allRowData['kitNo']}"/></td>
												<td class=" "><c:out value="${allRowData['status']}"/></td>
												<td class=" ">
													<button type="submit" class="btn btn-success btn-xs" data-toggle="modal" data-target=".update_device_popup" onclick='setDeviceDetails("${allRowData.id}","${allRowData.cardNo}","${allRowData.cardTypeNumber}","${allRowData.kitNo}","${allRowData.status}");' <c:if test="${empRole == '12'}">style="display:none;"</c:if>>Update</button>
													<button type="submit" class="btn btn-danger btn-xs" onclick='return deleteDeviceConfirm("${allRowData.status}","${allRowData.id}")'<c:if test="${allRowData.empRole != '1'}">style="display:none;" </c:if>>Delete</button>
												</td>
											</tr>
											</c:forEach>
											<tr id="pagingTd">
											<td colspan="9" align="right"><a href="#" id="first">First</a>&nbsp;
												<a style="cursor: pointer;" id="previous">Previous</a>&nbsp;
												<input type="text" size="1.5" id="pageNo" style="height:20px;" maxlength="5" name="pageNo" onkeypress='return isNumberKey(event)' />&nbsp;
												<a style="cursor: pointer;" id="next">Next</a>&nbsp;
												<a style="cursor: pointer;" id="last">Last</a><input type="hidden" id="totRows"/>
												</td>
											</tr>
									</tbody>										
                                    </table>
                                </div>
                            </div>
                        </div>
						  <br />
                        <br />
                        <br />
                    </div>
                </div>
 <!-------------------------------------- /page content --------------------------------------------------------->	
 <div class="modal fade update_device_popup" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">�</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Prepaid Inventory</h4>
				</div>
				<div class="modal-body1">
					<form class="form-horizontal form-label-left">
					<input type="hidden" id="id" name="id" value="">
						<div class="x_panel">
							<div class="x_title">
								<h2>Prepaid Inventory Details</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
								 <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="kitNo">Kit No.<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="kitNo" id="kitNo" required="true" minlength="8" maxlength="20" onkeypress='return isNumberKey(event)' digits="true" />
                                           </div>
                                        </div>
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cardNo">Card No.<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="cardNo" id="cardNo" required="true" minlength="8" maxlength="20" onkeypress='return isNumberKey(event)' digits="true" />
                                           </div>
                                        </div>	
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cardType">Card Type<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<select data-clear-btn="true" name="cardType" id="cardType" required="true" class="form-control">
            										<option <c:if test="${cardType == '0'}">Selected="Selected"</c:if> value="0">Select CardType</option>
            										<option <c:if test="${cardType == '1'}">Selected="Selected"</c:if> value="1">NFC/CHIP&MAG CARD</option>
            										<option <c:if test="${cardType == '2'}">Selected="Selected"</c:if> value="2">CHIP CARD</option>
            										<option <c:if test="${cardType == '3'}">Selected="Selected"</c:if> value="3">MAG CARD</option>
            										<option <c:if test="${cardType == '4'}">Selected="Selected"</c:if> value="4">OTHERS</option>
            									</select>
                                            </div>
                                        </div> 
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="status">Status<span class="required">*</span> </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select data-clear-btn="true" name="status"
											id="status" required="true" class="form-control">
											<option value="Active"> Active</option>
											<option value="Unavailable"> Unavailable</option>
											<option value="Damaged">Damaged</option>
											<option value="Internaluse">Internal Use</option>
											<option value="Activated"> Activated</option></select>                                                    
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
										name="UpdDeviceDetails">Update Inventory</button>	
					
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
<!---------------------------------- /modals ------------------------------------------------------>
	<jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->