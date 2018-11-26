<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("3")||session.getAttribute("empRole").equals("4")||session.getAttribute("empRole").equals("7")||session.getAttribute("empRole").equals("9")||session.getAttribute("empRole").equals("10"))){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------------------js function -------------------- -->
<script type="text/javascript">
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
	var bankMid = $("#bankMid").val();
	var appendMe="";

	
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
		document.body.innerHTML += '<form id="pageForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+pageNo+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="state" value='+state1+' /><input type="hidden" name="city" value='+city1+' /><input type="hidden" name="dateTime" value='+dateCreated1+' /><input type="hidden" name="fromDateTime" value='+fromDateTime1+' /><input type="hidden" name="toDateTime" value='+toDateTime1+' /><input type="hidden" name="custPhone" value='+custPhone1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /><input type="hidden" name="applicationNo" value='+applicationno1+' /><input type="hidden" name="merchantName" value='+merchantname1+' /><input type="hidden" name="marketingName" value='+marketingname1+' /><input type="hidden" name="bankMid" value='+bankMid1+' /></form>';
		document.getElementById("pageForm").submit();
	}
});	
$("#first").click(function () {
	var page=1;
	$("#pageNo").val(page);
	document.body.innerHTML += '<form id="firstForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value="1" /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="state" value='+state1+' /><input type="hidden" name="city" value='+city1+' /><input type="hidden" name="dateTime" value='+dateCreated1+' /><input type="hidden" name="fromDateTime" value='+fromDateTime1+' /><input type="hidden" name="toDateTime" value='+toDateTime1+' /><input type="hidden" name="custPhone" value='+custPhone1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /><input type="hidden" name="applicationNo" value='+applicationno1+' /><input type="hidden" name="merchantName" value='+merchantname1+' /><input type="hidden" name="marketingName" value='+marketingname1+' /><input type="hidden" name="bankMid" value='+bankMid1+' /></form>';
	document.getElementById("firstForm").submit();	
});
$("#previous").click(function () {
	var page=$("#pageNo").val();
	if(page>1){
		$("#pageNo").val(page-1);
	}
	var previousPage=$("#pageNo").val();
	document.body.innerHTML += '<form id="previousForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+previousPage+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="state" value='+state1+' /><input type="hidden" name="city" value='+city1+' /><input type="hidden" name="dateTime" value='+dateCreated1+' /><input type="hidden" name="fromDateTime" value='+fromDateTime1+' /><input type="hidden" name="toDateTime" value='+toDateTime1+' /><input type="hidden" name="custPhone" value='+custPhone1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /><input type="hidden" name="applicationNo" value='+applicationno1+' /><input type="hidden" name="merchantName" value='+merchantname1+' /><input type="hidden" name="marketingName" value='+marketingname1+' /><input type="hidden" name="bankMid" value='+bankMid1+' /></form>';
	document.getElementById("previousForm").submit();	
});
$("#next").click(function () {
	var page=parseInt($("#pageNo").val());
	var lastPage=$("#totRows").val();
	if(page<lastPage){
		$("#pageNo").val(page+1);
	}
	var nextPage=parseInt($("#pageNo").val());
	document.body.innerHTML += '<form id="nextForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+nextPage+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="state" value='+state1+' /><input type="hidden" name="city" value='+city1+' /><input type="hidden" name="dateTime" value='+dateCreated1+' /><input type="hidden" name="fromDateTime" value='+fromDateTime1+' /><input type="hidden" name="toDateTime" value='+toDateTime1+' /><input type="hidden" name="custPhone" value='+custPhone1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /><input type="hidden" name="applicationNo" value='+applicationno1+' /><input type="hidden" name="merchantName" value='+merchantname1+' /><input type="hidden" name="marketingName" value='+marketingname1+' /><input type="hidden" name="bankMid" value='+bankMid1+' /></form>';
	document.getElementById("nextForm").submit();
});
$("#last").click(function () {
	var lastPage=$("#totRows").val();
	document.body.innerHTML += '<form id="lastForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+lastPage+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="state" value='+state1+' /><input type="hidden" name="city" value='+city1+' /><input type="hidden" name="dateTime" value='+dateCreated1+' /><input type="hidden" name="fromDateTime" value='+fromDateTime1+' /><input type="hidden" name="toDateTime" value='+toDateTime1+' /><input type="hidden" name="custPhone" value='+custPhone1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /><input type="hidden" name="applicationNo" value='+applicationno1+' /><input type="hidden" name="merchantName" value='+merchantname1+' /><input type="hidden" name="marketingName" value='+marketingname1+' /><input type="hidden" name="bankMid" value='+bankMid1+' /></form>';
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
  <!-------------------------------------------------------- page content ----------------------------->
       <!-- page content -->
            <div class="right_col" role="main">
                <div class="">
                     <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Merchant Boarded</h2>   
                                    <button type="button" class="btn-filter nav navbar-right panel_toolbox" data-toggle="modal" data-target=".filter-detail-popup" <c:if test="${empRole == '12'}">style="display:none;"</c:if>><i class="fa fa-filter" aria-hidden="true"></i>Filters</button>                                    
                                    <div class="clearfix"></div>
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
                                  <c:if test="${bankMid!=''&&bankMid!=null}"> || Bank Mid:<c:out value="${bankMid}"/><input type="hidden" id="bankMid1" value='<c:out value="${bankMid}"/>'/></c:if>                                                
                                  
                                  </strong>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                <table class="table table-striped responsive-utilities jambo_table bulk_action">
                                        <thead>
                                           <tr class="headings">
                                                <th>Application No </th>
                                                <th>Merchant Name</th>
                                                <th>Contact Details </th>
                                                <th>Billing Details </th>
                                                <th>Verification Status </th>
                                                <th>Tax Details </th>
                                    <!--        <th>Created Date</th>   -->
                                    			 <th class=" no-link last"><span class="nobr">Action</span></th>
                                            </tr>
                                        </thead>
                                    <tbody>
                                            <c:forEach var="allRowData" items="${basicMerchantDetails}">
                                                <c:set value="${allRowData['count']}" var="counter"></c:set>
                                                <c:set value="${allRowData['merchantName']}" var="merchantvar"></c:set> 
                                                <c:if test="${not empty merchantvar}">
                                                
                                                    <tr class="even pointer">
                                                        <td class=" "> <span class="td-details"><c:out value="${allRowData['applicationNo']}"/></span></td>
                                                        <td class=" "><span class="td-heading">Merchant Name: </span><span class="td-details"><c:out value="${allRowData['merchantName']}"/></span><span class="td-heading">Marketing Name: </span><span class="td-details"><c:out value="${allRowData['marketingName']}"/></span></td>
                                                        <td class=" "><span class="td-heading">Director Name: </span><span class="td-details"><c:out value="${allRowData['directorName']}"/></span><span class="td-heading">Phone No: </span><span class="td-details"><c:out value="${allRowData['phoneNo']}"/></span><span class="td-heading">Email: </span><span class="td-details"><c:out value="${allRowData['emailId']}"/></span></td>
                                                        <td class=" "><span class="td-heading">Address1: </span><span class="td-details"><c:out value="${allRowData['address1']}"/></span><span class="td-heading">Address2: </span><span class="td-details"><c:out value="${allRowData['address2']}"/></span><span class="td-heading">City: </span><span class="td-details"><c:out value="${allRowData['city']}"/></span><span class="td-heading">State: </span><span class="td-details"><c:out value="${allRowData['state']}"/></span><span class="td-heading">Pincode: </span><span class="td-details"><c:out value="${allRowData['pincode']}"/></span></td>
                                                        <td class=" "> <span class="td-details"><c:out value="${allRowData['varificationStatus']}"/></span></td>
                                                        <td class=" "><span class="td-heading">Tin No: </span><span class="td-details"><c:out value="${allRowData['tinNo']}"/></span><span class="td-heading">Service Tax No: </span><span class="td-details"><c:out value="${allRowData['serviceTaxNo']}"/></span><span class="td-details"><c:if test="${allRowData['bankMid']!=''}"></span><span class="td-heading">Mid: </span><span class="td-details"><c:out value="${allRowData['bankMid']}"/></span></c:if></td>
                                                        <td class=" ">
                                                        <div data-role="controlgroup" data-type="horizontal" data-mini="true">                      
                                                        <form id="ShowMerchantDetails" action="<c:url value='merchantdetails' />"  method='GET' >
                                                        <input type="hidden" name="MerchantId" id="MerchantId" value='<c:out value="${allRowData['applicationNo']}"/>' />
                                                        <button type="submit" class="btn-submit" >More</button>
                                                        </form>
                                                       
                                                       <a onclick="return isGenerateFile();" href=<c:url value='gnrtExcelSheet?signImage=${allRowData.applicationNo}'/>><button type="button" class="btn-submit"  <c:if test="${allRowData.empRole != '2'}">style="display:none;"</c:if>>Download</button></a>
                                                        <button type="button" class="btn-delete" onclick='return deleteDeviceConfirm("${allRowData.applicationNo}")' <c:if test="${allRowData.empRole != '1'}">style="display:none;"</c:if>>Delete</button>                                             
                                                        </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            <tr id="pagingTd">
											<td colspan="9" align="right"><a href="#" id="first">First</a>&nbsp;
												<a style="cursor: pointer;" id="previous">Previous</a>&nbsp;
												<input type="text" size="1.5" id="pageNo" style="height:20px;" maxlength="5" name="pageNo" onkeypress="return isNumber(event)" />
												&nbsp;<a style="cursor: pointer;" id="next">Next</a>
												&nbsp;<a style="cursor: pointer;" id="last">Last</a><input type="hidden" id="totRows"/>
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
                <!-- /page content -->
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
					<input type="text" style="height: 30px;" maxlength="10" placeholder="Enter Phone No" id="custPhone" value='<c:out value="${custPhone}"/>' class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/><br/>
					<input type="text" style="height: 30px;" maxlength="25" placeholder="Enter Bank Mid" id="bankMid" value='<c:out value="${bankMid}"/>' class="form-control" /><br/>
					
					<button type="button" class="btn-submit" onclick="return searchClickedTns();">Search</button>
					<button type="button" class="btn-cancel" onclick="return clearAllFillter();">Clear All Filter</button>				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>                              
 </div>
 <div class="modal fade Transaction-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">Merchant Details</h4>
				</div>
				<div id="modal-body" class="modal-body">
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
      <span aria-hidden="true">×</span>
     </button>
     <h4 class="modal-title" id="myModalLabel2">Your Request Status</h4>
    </div>
    <div id="modal-body" class="modal-body"></div>
    <div class="modal-footer">
     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
   </div>
  </div>
 </div>           
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->