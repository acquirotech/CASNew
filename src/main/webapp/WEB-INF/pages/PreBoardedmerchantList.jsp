<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("2")||session.getAttribute("empRole").equals("5")||session.getAttribute("empRole").equals("4")||session.getAttribute("empRole").equals("6")||session.getAttribute("empRole").equals("7")||session.getAttribute("empRole").equals("9")||session.getAttribute("empRole").equals("10"))){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------------------js function -------------------- -->
<script type="text/javascript">
function searchClickedTns(){
	var merchantname = $("#merchantName").val();
	var verificationstatus = $("#verificationstatus").val();
	var marketingname = $("#marketingName").val();
	var executiveName = $("#executiveName").val();
	
	var appendMe="";

	if(executiveName!=null&&executiveName!=""){
		appendMe=appendMe.concat("&modelName="+executiveName+"");
	}
	if(merchantname!=null&&merchantname!=""){
		appendMe=appendMe.concat("&merchantName="+merchantname+"");
	}
	if(marketingname!=null&&marketingname!=""){
		appendMe=appendMe.concat("&marketingName="+marketingname+"");
	}
	if(verificationstatus!=null&&verificationstatus!=""){
		appendMe=appendMe.concat("&verificationstatus="+verificationstatus+"");
	}
	document.location.href = "?txn=123"+appendMe;
}
function clearAllFillter(){
	$("#merchantName").val('');
	$("#marketingName").val('');
	$("#verificationstatus").val('');
	$("#executiveName").val('');
	document.location.href = "?page=1";
}

$(document).ready(function (){
<c:if var="pg" test="${page!=null&&page!=''}">
	$("#pageNo").val('<c:out value="${page}" />');
</c:if>
<c:if var="lct" test="${totalRows!=null&&totalRows!=''}">		
$("#totRows").val('<c:out value="${totalRows}" />');
</c:if>

var executiveName1 = $("#executiveName1").val();
var verificationstatus1 = $("#verificationStatus1").val();
var marketingName1 = $("#marketingName1").val();
var merchantName1 = $("#merchantName1").val();

if(verificationstatus1==undefined)
	verificationstatus1='%41';

if(executiveName1==undefined){
	executiveName1='%41';
}else{
	executiveName1 = encodeURI(executiveName1)
}
if(marketingName1==undefined){
	marketingName1='%41';
}else{
	marketingName1 = encodeURI(marketingName1)
}
if(merchantName1==undefined){
	merchantName1='%41';
}else{
	merchantName1 = encodeURI(merchantName1)
}
$("#pageNo").change(function(){
	var pageNo = $("#pageNo").val();
	if(pageNoj!=null&&pageNo!=""){
		document.body.innerHTML += '<form id="pageForm" action="<c:url value='PreBoardedMerchantlist' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+pageNo+' /><input type="hidden" name="merchantName" value='+merchantName1+' /><input type="hidden" name="marketingName" value='+marketingName1+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /></form>';
		document.getElementById("pageForm").submit();
	}
});	
$("#first").click(function () {
	var page=1;
	$("#pageNo").val(page);
	document.body.innerHTML += '<form id="firstForm" action="<c:url value='PreBoardedMerchantlist' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value="1" /><input type="hidden" name="merchantName" value='+merchantName1+' /><input type="hidden" name="marketingName" value='+marketingName1+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /></form>';
	document.getElementById("firstForm").submit();	
});
$("#previous").click(function () {
	var page=$("#pageNo").val();
	if(page>1){
		$("#pageNo").val(page-1);
	}
	var previousPage=$("#pageNo").val();
	document.body.innerHTML += '<form id="previousForm" action="<c:url value='PreBoardedMerchantlist' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+previousPage+' /><input type="hidden" name="merchantName" value='+merchantName1+' /><input type="hidden" name="marketingName" value='+marketingName1+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /></form>';
	document.getElementById("previousForm").submit();	
});
$("#next").click(function () {
	var page=parseInt($("#pageNo").val());
	var lastPage=$("#totRows").val();
	if(page<lastPage){
		$("#pageNo").val(page+1);
	}
	var nextPage=parseInt($("#pageNo").val());
	document.body.innerHTML += '<form id="nextForm" action="<c:url value='PreBoardedMerchantlist' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+nextPage+' /><input type="hidden" name="merchantName" value='+merchantName1+' /><input type="hidden" name="marketingName" value='+marketingName1+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /></form>';
	document.getElementById("nextForm").submit();
});
$("#last").click(function () {
	var lastPage=$("#totRows").val();
	document.body.innerHTML += '<form id="lastForm" action="<c:url value='PreBoardedMerchantlist' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+lastPage+' /><input type="hidden" name="merchantName" value='+merchantName1+' /><input type="hidden" name="marketingName" value='+marketingName1+' /><input type="hidden" name="modelName" value='+executiveName1+' /><input type="hidden" name="verificationstatus" value='+verificationstatus1+' /></form>';
	document.getElementById("lastForm").submit();
});
});

</script>
  <!-------------------------------------------------------- page content ----------------------------->
       <!-- page content -->
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Pre-Merchant Boarded</h2>  
                                    <button type="button" class="btn-filter nav navbar-right panel_toolbox"  data-toggle="modal" data-target=".filter-detail-popup" <c:if test="${empRole == '12'}">style="display:none;"</c:if>> <i class="fa fa-filter" aria-hidden="true"></i>Filters</button>                                    
                                   <div class="clearfix"></div>
                       				<strong>
	                                     <c:if test="${merchantName!=''&&merchantName!=null}"> || Merchant Name:<c:out value="${merchantName}"/><input type="hidden" id="merchantName1" value='<c:out value="${merchantName}"/>'/></c:if>
	                                     <c:if test="${marketingName!=''&&marketingName!=null}"> || Marketing Name:<c:out value="${marketingName}"/><input type="hidden" id="marketingName1" value='<c:out value="${marketingName}"/>'/></c:if>
	                                     <c:if test="${verificationstatus!=''&&verificationstatus!=null}"> || Verification Status:<c:out value="${verificationstatus}"/><input type="hidden" id="verificationStatus1" value='<c:out value="${verificationstatus}"/>'/></c:if>
	                                     <c:if test="${executiveName!=''&&executiveName!=null}"> || Executive Name:<c:out value="${executiveName}"/><input type="hidden" id="executiveName1" value='<c:out value="${executiveName}"/>'/></c:if>                                                
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
                                                <th>Location </th>
                                                <th>Verification Status </th>
                                                <th class=" no-link last"><span class="nobr">Action</span></th>
                                            </tr>
                                        </thead>
                                    <tbody>
                                            <c:forEach var="allRowData" items="${basicMerchantDetails}">
                                                <c:set value="${allRowData['count']}" var="counter"></c:set>
                                                <c:set value="${allRowData['merchantName']}" var="merchantvar"></c:set> 
                                                <c:if test="${not empty merchantvar}">
                                                
                                                    <tr class="even pointer">
                                                        <td class=" "> <b><c:out value="${allRowData['applicationNo']}"/></b></td>
                                                        <td class=" ">Merchant Name: <b><c:out value="${allRowData['merchantName']}"/></b><br>Marketing Name: <b><c:out value="${allRowData['marketingName']}"/></b></td>
                                                        <td class=" "> <b><c:out value="${allRowData['phoneNo']}"/></b></td>
                                                        <td class=" "><b><c:out value="${allRowData['location']}"/></b></td>
                                                        <td class=" "> <b><c:out value="${allRowData['varificationStatus']}"/></b></td>
                                                        <td class=" ">
                                                        <div data-role="controlgroup" data-type="horizontal" data-mini="true">                      
                                                        <form id="ShowMerchantDetails" action="<c:url value='PreBoardedmerchantdetails' />"  method='GET' >
                                                        <input type="hidden" name="MerchantId" id="MerchantId" value='<c:out value="${allRowData['applicationNo']}"/>' />
                                                        <button type="submit" class="btn-submit" <c:if test="${allRowData.empRole == '12'}">style="display:none;"</c:if>>More</button>
                                                        </form>
                                                        </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            <tr id="pagingTd">
											<td colspan="7" align="right"><a href="#" id="first">First</a>&nbsp;
												<a style="cursor: pointer;" id="previous">Previous</a>&nbsp;
												<input type="text" size="1.5" id="pageNo" style="height:20px;" maxlength="5" name="pageNo" onkeypress="return isNumber(event)" />&nbsp;
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
                <!-- /page content -->
 <div class="modal fade filter-detail-popup" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel22">Set Filters</h4>
				</div>
				<div id="modal-body2" class="modal-body">
					<input type="text" style="height: 30px;" maxlength="45" placeholder="Enter Merchant Name" id="merchantName" value='<c:out value="${merchantName}"/>' class="form-control" /><br/>
					<input type="text" style="height: 30px;" maxlength="45" placeholder="Enter Marketing Name" id="marketingName" value='<c:out value="${marketingName}"/>' class="form-control" /><br/>
					<input type="text" style="height: 30px;" maxlength="45" placeholder="Enter Executive Name" id="executiveName" value='<c:out value="${executiveName}"/>' class="form-control" /><br/>					                        
					<select data-clear-btn="true" name="verificationstatus" id="verificationstatus"  value='<c:out value="${verificationstatus}"/>' class="form-control">
					<option value="" <c:if test="${verificationstatus == ''}">Selected</c:if>>Select</option>
					 <option <c:if test="${verificationstatus == 'Pending'}">Selected</c:if> value="Pending">Pending</option>
					 <option <c:if test="${verificationstatus == 'oktoboard'}">Selected</c:if> value="oktoboard">Ok To Board</option>
					 <option <c:if test="${verificationstatus == 'rejected'}">Selected</c:if> value="rejected">Rejected</option>
					</select><br/>
					<button type="button" class="btn btn-primary btn-xs" onclick="return searchClickedTns();">Search</button>
					<button type="button" class="btn btn-primary btn-xs" onclick="return clearAllFillter();">Clear All Filter</button>				
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