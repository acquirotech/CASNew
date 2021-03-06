<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <script type="text/javascript"> 

    function deleteEmp(empId){
    	if (confirm("Do you want to delete Caller ?") == true) {
    		var sendvalue={dummyUser:empId}
    		var opts = {
    	            type: "POST",
    	            success: function (data) {
    	                $(".loading").css("visibility","hidden");
    	                if (data.status == 0&&data.message=='OK') {
    	                    $("#modal-body").html("<h2>Caller Deleted Successfully</h2>"); 
    	                     window.location.href="teleCustomerList";
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
    	            url: "deleteTeleCaller",
    	            data: sendvalue
    	        }; 
    	        $.ajax(opts);
    	        return false;

    	}else{
    		return false;
    	}
    }
    function isGenerateFile(){
    	var strconfirm = confirm("Do You Want Download Merchant Detail?");
    	if (strconfirm == true) {
    		return true;
    	}else
    		return false;
    }
    function isNumberKey(evt){
    	 evt = (evt) ? evt : window.event;
    	 var charCode = (evt.which) ? evt.which : evt.keyCode;
    	 if (!( (charCode >= 48 && charCode <= 57) || charCode==8 || charCode==37 || charCode==39)){
    	  return false;
    	 }
    	}
    function searchClickedTns(){
    	var applicationno = $("#applicationNo").val();
    	var merchantname = $("#merchantName").val();
    	var verificationstatus = $("#verificationstatus").val();
    	var custPhone = $("#custPhone").val();
    	var marketingname = $("#marketingName").val();
    	var city = $("#city").val();
    	var state = $("#state").val();
    	var executiveName = $("#executiveName").val();
    	var dateCreated = $("#dateCreated").val();
    	var fromDateTime = $("#fromDateTime").val();
    	var toDateTime = $("#toDateTime").val();
    	var acquirerStatus = $("#acquirerStatus").val();
    	var bankMid = $("#bankMid").val();
    	var appendMe="";

    	if(acquirerStatus!=null&&acquirerStatus!=""){
    		appendMe=appendMe.concat("&acquirerStatus="+acquirerStatus+"")
    	}
    	if(dateCreated!=null&&dateCreated!=""){
    		appendMe=appendMe.concat("&dateTime="+dateCreated+"")
    	}
    	if(executiveName!=null&&executiveName!=""){
    		appendMe=appendMe.concat("&modelName="+executiveName+"")
    	}
    	if(city!=null&&city!=""){
    		appendMe=appendMe.concat("&city="+city+"")
    	}
    	if(state!=null&&state!=""){
    		appendMe=appendMe.concat("&state="+state+"")
    	}
    	
    	if(custPhone!=null&&custPhone!=""){
    		appendMe=appendMe.concat("&custPhone="+custPhone+"")
    	}
    	if(applicationno!=null&&applicationno!=""){
    		appendMe=appendMe.concat("&applicationNo="+applicationno+"")
    	}
    	if(merchantname!=null&&merchantname!=""){
    		appendMe=appendMe.concat("&merchantName="+merchantname+"")
    	}
    	if(marketingname!=null&&marketingname!=""){
    		appendMe=appendMe.concat("&marketingName="+marketingname+"")
    	}
    	if(bankMid!=null&&bankMid!=""){
    		appendMe=appendMe.concat("&bankMid="+bankMid+"")
    	}
    	if(verificationstatus!=null&&verificationstatus!=""){
    		appendMe=appendMe.concat("&verificationstatus="+verificationstatus+"");
    	}if(fromDateTime!=null&&fromDateTime!=""&&fromDateTime.length==10){
    		appendMe=appendMe.concat("&fromDateTime="+fromDateTime+"");
    	}if(toDateTime!=null&&toDateTime!=""&&toDateTime.length==10){
    		if(fromDateTime==null||fromDateTime==""||fromDateTime.length!=10){
    			$("#fromDateTime").val('');
    			$("#toDateTime").val('');
    			alert("Please Select From Date");
    			return false;
    		}
    		appendMe=appendMe.concat("&toDateTime="+toDateTime+"");
    	}
    	document.location.href = "?txn=123"+appendMe;
    }
    function clearAllFillter(){
    	var applicationNo = $("#applicationNo").val('');
    	var merchantName = $("#merchantName").val('');
    	var marketingName = $("#marketingName").val('');
    	var verificationstatus = $("#verificationstatus").val('');
    	var custPhone = $("#custPhone").val('');
    	$("#city").val('');
    	$("#state").val('');
    	$("#executiveName").val('');
    	$("#dateCreated").val('');
    	$("#fromDateTime").val('');
    	$("#toDateTime").val('');
    	$("#acquirerStatus").val('');
    	$("#bankMid").val('');
    	
    	document.location.href = "?page=1"
    }

    function downloadMerchantConfirm(applicationNo){
    	if (confirm("Do you want to download merchant details ?") == true) {
    		var sendvalue={merchantId:applicationNo}
    		var opts = {
    	    	type: "POST",
    	        	success: function (data) {
    	            $(".loading").css("visibility","hidden");
    	            if (data.status == 0&&data.message=='OK') {
    	            	location.reload();
    	           	} else if (data.status==111) {
    	            	//onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload=""
    	                $("body").attr("onload","noBack();");
    	                $("body").attr("onpageshow","if (event.persisted) noBack();");
    	                $("body").attr("onunload","");
    	                window.location.href="logout.jsp";
    	            }else if (data.status==100) {
    	            } else {
    	            	$(".loading").css("visibility", "hidden");
    	            }
    	      	},
    	        error: function (data, textStatus, errorThrown) {
    	        	$(".loading").css("visibility","hidden");	            
    	        },
    	        url: "downloadMerchantDtls",
    	        data: sendvalue
    	   };
    	   $.ajax(opts);
    	   return false;
    	}else{
    		return false;
    	}
    }

    $(document).ready(function (){
    <c:if var="pg" test="${page!=null&&page!=''}">
    	$("#pageNo").val('<c:out value="${page}" />');
    </c:if>
    <c:if var="lct" test="${totalRows!=null&&totalRows!=''}">		
    $("#totRows").val('<c:out value="${totalRows}" />');
    </c:if>

    var executiveName1 = $("#executiveName1").val();
    var state1=$("#state1").val();
    var city1=$("#city1").val();
    var dateCreated1=$("#dateCreated1").val();
    var fromDateTime1=$("#fromDateTime1").val();
    var toDateTime1=$("#toDateTime1").val();

    var applicationno1 = $("#applicationno1").val();
    var merchantname1 = $("#merchantname1").val();
    var marketingname1 = $("#marketingname1").val();
    var verificationstatus1 = $("#verificationstatus1").val();
    var bankMid1 = $("#bankMid1").val();
    var custPhone1 = $("#custPhone1").val();
    var acquirerStatus1 = $("#acquirerStatus1").val();

    if(acquirerStatus1==undefined){
    	acquirerStatus1='%41';
    }
    if(bankMid1==undefined){
    	bankMid1='%41';
    }
    if(custPhone1==undefined){
    	custPhone1='%41';
    }if(applicationno1==undefined){
    	applicationno1='%41';
    }if(merchantname1==undefined){
    	merchantname1='%41';
    }else{
    	merchantname1 = encodeURI(merchantname1)
    }if(marketingname1==undefined){
    	marketingname1='%41';
    }else{
    	marketingname1 = encodeURI(marketingname1)
    }if(verificationstatus1==undefined){
    	verificationstatus1='%41';
    }else{
    	verificationstatus1 = encodeURI(verificationstatus1)
    }




    if(fromDateTime1==undefined){
    	fromDateTime1='%41';
    }
    if(toDateTime1==undefined){
    	toDateTime1='%41';
    }
    if(dateCreated1==undefined){
    	dateCreated1='%41';
    }
    if(city1==undefined){
    	city1='%41';
    }else{
    	city1 = encodeURI(city1)
    }
    if(state1==undefined){
    	state1='%41';
    }else{
    	state1 = encodeURI(state1)
    }
    if(executiveName1==undefined){
    	executiveName1='%41';
    }else{
    	executiveName1 = encodeURI(executiveName1)
    }

    $("#pageNo").change(function(){
    	var pageNo = $("#pageNo").val();
    	if(pageNo!=null&&pageNo!=""){
    		document.body.innerHTML += '<form id="pageForm" action="<c:url value='teleCustomerList' />"></form>';
    		document.getElementById("pageForm").submit();
    	}
    });	
    $("#first").click(function () {
    	var page=1;
    	$("#pageNo").val(page);
    	document.body.innerHTML += '<form id="firstForm" action="<c:url value='teleCustomerList' />"></form>';
    	document.getElementById("firstForm").submit();	
    });
    $("#previous").click(function () {
    	var page=$("#pageNo").val();
    	if(page>1){
    		$("#pageNo").val(page-1);
    	}
    	var previousPage=$("#pageNo").val();
    	document.body.innerHTML += '<form id="previousForm" action="<c:url value='teleCustomerList' />"></form>';
    	document.getElementById("previousForm").submit();	
    });
    $("#next").click(function () {
    	var page=parseInt($("#pageNo").val());
    	var lastPage=$("#totRows").val();
    	if(page<lastPage){
    		$("#pageNo").val(page+1);
    	}
    	var nextPage=parseInt($("#pageNo").val());
    	document.body.innerHTML += '<form id="nextForm" action="<c:url value='teleCustomerList' />"></form>';
    	document.getElementById("nextForm").submit();
    });
    $("#last").click(function () {
    	var lastPage=$("#totRows").val();
    	document.body.innerHTML += '<form id="lastForm" action="<c:url value='teleCustomerList' />"></form>';
    	document.getElementById("lastForm").submit();
    });
    });


    function deleteDeviceConfirm(merchantId){
    	if (confirm("Do you want to delete Merchant details ?") == true) {
    		var sendvalue={merchantId:merchantId}
    		var opts = {
    	            type: "POST",
    	            success: function (data) {
    	                $(".loading").css("visibility","hidden");
    	                if (data.status == 0&&data.message=='OK') {
    	                   location.reload(); 
    	                } else if (data.status==111) {
    	                    //onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload=""
    	                    $("body").attr("onload","noBack();");
    	                    $("body").attr("onpageshow","if (event.persisted) noBack();");
    	                    $("body").attr("onunload","");
    	                    window.location.href="logout.jsp";
    	                }else if (data.status==100) {
    	                    } else {
    	                    $(".loading").css("visibility", "hidden");
    	                    }
    	            },
    	            error: function (data, textStatus, errorThrown) {
    	                $(".loading").css("visibility","hidden");
    	                if(textStatus=="timeout"){
    	                	 }else{
    	                	}
    	            },
    	            url: "merchantDelete",
    	            data: sendvalue
    	        }; 
    	        $.ajax(opts);
    	        return false;

    	}else{
    		return false;
    	}
    }
</script>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
             
              <div class="box-header with-border">
                <h3 class="box-title">Complaint Log List</h3>
                <div class="box-tools">
                <a class="btn btn-block btn-primary btn-sm"><i class="fa fa-filter"></i> Filters</a>
                  <strong>
                                   <c:if test="${applicationno!=''&&applicationno!=null}"> Application No:<c:out value="${applicationno}"/><input type="hidden" id="applicationno1" value='<c:out value="${applicationno}"/>'/></c:if>
                                     <c:if test="${merchantname!=''&&merchantname!=null}"> || Merchant Name:<c:out value="${merchantname}"/><input type="hidden" id="merchantname1" value='<c:out value="${merchantname}"/>'/></c:if>
                                     <c:if test="${marketingname!=''&&marketingname!=null}"> || Marketing Name:<c:out value="${marketingname}"/><input type="hidden" id="marketingname1" value='<c:out value="${marketingname}"/>'/></c:if>
                                     <c:if test="${verificationstatus!=''&&verificationstatus!=null}"> || Verification Status:<c:out value="${verificationstatus}"/><input type="hidden" id="verificationstatus1" value='<c:out value="${verificationstatus}"/>'/></c:if>
                                     <c:if test="${custPhone!=''&&custPhone!=null}"> || Phone No:<c:out value="${custPhone}"/><input type="hidden" id="custPhone1" value='<c:out value="${custPhone}"/>'/></c:if>
                                     <c:if test="${city!=''&&city!=null}"> || City:<c:out value="${city}"/><input type="hidden" id="city1" value='<c:out value="${city}"/>'/></c:if>
                        			 <c:if test="${state!=''&&state!=null}"> || State:<c:out value="${state}"/><input type="hidden" id="state1" value='<c:out value="${state}"/>'/></c:if>
                                     <c:if test="${executiveName!=''&&executiveName!=null}"> || Executive Name:<c:out value="${executiveName}"/><input type="hidden" id="executiveName1" value='<c:out value="${executiveName}"/>'/></c:if>                                                
                                  	 <c:if test="${dateCreated!=''&&dateCreated!=null}"> || Boarding Date:<c:out value="${dateCreated}"/><input type="hidden" id="dateCreated1" value='<c:out value="${dateCreated}"/>'/></c:if>
                                  	 <c:if test="${fromDateTime!=''&&fromDateTime!=null}"> || From Date:<c:out value="${fromDateTime}"/><input type="hidden" id="fromDateTime1" value='<c:out value="${fromDateTime}"/>'/></c:if>
                                  	 <c:if test="${toDateTime!=''&&toDateTime!=null}"> || To Date:<c:out value="${toDateTime}"/><input type="hidden" id="toDateTime1" value='<c:out value="${toDateTime}"/>'/></c:if>                                                
                                  	 <c:if test="${acquirerStatus!=''&&acquirerStatus!=null}"> || Acquirer Status:<c:out value="${acquirerStatus}"/><input type="hidden" id="acquirerStatus1" value='<c:out value="${acquirerStatus}"/>'/></c:if>                                                
                                  <c:if test="${bankMid!=''&&bankMid!=null}"> || Bank Mid:<c:out value="${bankMid}"/><input type="hidden" id="bankMid1" value='<c:out value="${bankMid}"/>'/></c:if>                                                
                                   </strong>
                </div>
              </div>
              
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table table-bordered">
                  <thead>
                    <tr>
                   								 <th>Sr No </th>
                                                <th>Call Type</th>
                                                <th>Caller Purpose </th>
                                                <th>Caller Name </th>
                                                <th>Merchant Name </th>
                                                <th>Date and Time </th>
                                    			<th>User</th>
                                    			<th>Action</th>      
                  </tr>
                  </thead>
                  <tbody>
                  <?php 
                  for ($x = 0; $x <= 8; $x++) {?>
                     <c:forEach var="allRowData" items="${basicMerchantDetails}">
                                                <c:set value="${allRowData['count']}" var="counter"></c:set>
                                                <c:set value="${allRowData['merchantName']}" var="merchantvar"></c:set> 
                                                <c:if test="${not empty merchantvar}">
                                                									
                                        	<tr class="even pointer">
                                            	  <td class=" "> <span class="td-details"><c:out value="${allRowData['id']}"/></span></td>
                                                       <td class=" "> <span class="td-details"><c:out value="${allRowData['callType']}"/></span></td>
                                                       <td class=" "> <span class="td-details"><c:out value="${allRowData['callPurpose']}"/></span></td>
                                                       <td class=" "> <span class="td-details"><c:out value="${allRowData['callerName']}"/></span></td>
                                                       <td class=" "> <span class="td-details"><c:out value="${allRowData['merchantName']}"/></span></td>
                                                       <td class=" "> <span class="td-details"><c:out value="${allRowData['dateTime']}"/></span></td>
                                                       <td class=" "> <span class="td-details"><c:out value="${allRowData['userName']}"/></span></td>
                                                       <td class=" ">
                                                        <form id="ShowMerchantDetails" action="<c:url value='callerDetails' />"  method='GET' >
                                                        <input type="hidden" name="callerId" id="callerId" value='<c:out value="${allRowData['id']}"/>' />
													<button type="submit" class="btn btn-success btn-xs" data-toggle="modal"><i class="fa fa-fw fa-eye"></i>More</button>
													<button type="submit" class="btn btn-danger btn-xs" onclick='return deleteEmp("${allRowData.id}")' >Delete</button>
													 </form>
												</td>
											</tr>
											 </c:if>
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
					<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Application No" id="applicationNo" value='<c:out value="${applicationno}"/>' class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/><br/>
					<input type="text" style="height: 30px;" maxlength="30" placeholder="Enter Merchant Name" id="merchantName" value='<c:out value="${merchantname}"/>' class="form-control" /><br/>
					<input type="text" style="height: 30px;" maxlength="30" placeholder="Enter Marketing Name" id="marketingName" value='<c:out value="${marketingname}"/>' class="form-control" /><br/>
					<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter Executive Name" id="executiveName" value='<c:out value="${executiveName}"/>' class="form-control" /><br/>
					<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter State Name" id="state" value='<c:out value="${state}"/>' class="form-control" /><br/>
					<input type="text" style="height: 30px;" maxlength="100" placeholder="Enter City Name" id="city" value='<c:out value="${city}"/>' class="form-control" /><br/>
                    <input type="text" style="height: 30px;" maxlength="100" placeholder="Enter Boarding Date" name="dateCreated" id="dateCreated" value='<c:out value="${dateCreated}"/>' class="date-picker form-control" data-role="date" data-clear-btn="true" readonly="readonly"/><br/>
                    <input type="text" style="height: 30px;" maxlength="100" placeholder="Enter From Date" name="fromDateTime" id="fromDateTime" value='<c:out value="${fromDateTime}"/>' class="date-picker form-control" data-role="date" data-clear-btn="true" readonly="readonly"/><br/>
                    <input type="text" style="height: 30px;" maxlength="100" placeholder="Enter To Date" name="toDateTime" id="toDateTime" value='<c:out value="${toDateTime}"/>' class="date-picker form-control" data-role="date" data-clear-btn="true" readonly="readonly"/><br/>
                                       
					<select data-clear-btn="true" name="verificationstatus" id="verificationstatus"  value='<c:out value="${verificationstatus}"/>' class="form-control">
					<option value="" <c:if test="${verificationstatus == ''}">Selected</c:if>>Select</option>
					<option <c:if test="${verificationstatus == 'File Sent To Bank'}">Selected</c:if> value="File Sent To Bank"> File Sent To Bank</option>
					<option <c:if test="${verificationstatus == 'MID-TID Received'}">Selected</c:if> value="MID-TID Received"> MID-TID Received</option>
					<option <c:if test="${verificationstatus == 'Mapping In-Process'}">Selected</c:if> value="Mapping In-Process"> Mapping In-Process</option>
					<option <c:if test="${verificationstatus == 'In Quality Check'}">Selected</c:if> value="In Quality Check"> In Quality Check</option>
					<option <c:if test="${verificationstatus == 'Activated'}">Selected</c:if> value="Activated"> Activated</option>
					<option <c:if test="${verificationstatus == 'Deactivated'}">Selected</c:if> value="Deactivated"> Deactivated</option>
					
					
					</select><br/>
					<select data-clear-btn="true" name="acquirerStatus" id="acquirerStatus"  value='<c:out value="${acquirerStatus}"/>' class="form-control">
					<option value="" <c:if test="${acquirerStatus == ''}">Selected</c:if>>Select</option>
					<option <c:if test="${acquirerStatus == 'acquiro'}">Selected</c:if> value="acquiro"> acquiro</option>
					<option <c:if test="${acquirerStatus == 'Softronix'}">Selected</c:if> value="Softronix"> Softronix</option>
					<option <c:if test="${acquirerStatus == 'Pax'}">Selected</c:if> value="Pax"> Pax</option>
					<option <c:if test="${acquirerStatus == 'RealCash'}">Selected</c:if> value="RealCash"> RealCash</option>
					</select><br/>
					<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Phone No" id="custPhone" value='<c:out value="${custPhone}"/>' class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/><br/>
					<input type="text" style="height: 30px;" maxlength="25" placeholder="Enter Bank Mid" id="bankMid" value='<c:out value="${bankMid}"/>' class="form-control" /><br/>
					
					<button type="button" class="btn-submit" onclick="return searchClickedTns();">Search</button>
					<button type="button" class="btn-cancel" onclick="return clearAllFillter();">Clear All Filter</button>				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>                              
 </div>
 <div class="modal fade Transaction-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">Merchant Details</h4>
				</div>
				<div id="modal-body" class="modal-body">
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>                              
 </div> 
 <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
  aria-hidden="true">
  <div class="modal-dialog modal-sm">
   <div class="modal-content">
    <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal"
      aria-label="Close">
      <span aria-hidden="true">�</span>
     </button>
     <h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
    </div>
    <div id="modal-body" class="modal-body"></div>
    <div class="modal-footer">
     <button type="button" class="btn-cancel" data-dismiss="modal">Close</button>
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
