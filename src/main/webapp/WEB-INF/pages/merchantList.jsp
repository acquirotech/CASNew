<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script type="text/javascript"> 
function empProfile(profileid,user,email,phone,status,date,role){
	document.body.innerHTML += '<form id="dynForm" action="<c:url value='empProfile' />" method="post"><input type="hidden" name="empId" value='+profileid+' /></form>';
	document.getElementById("dynForm").submit();
}
/* $(document).ready(function (){
	<c:if var="pg" test="${page!=null&&page!=''}">
		$("#pageNo").val('<c:out value="${page}" />');
	</c:if>
	<c:if var="lct" test="${totalRows!=null&&totalRows!=''}">		
	$("#totRows").val('<c:out value="${totalRows}" />');
	</c:if>

	$("#pageNo").change(function(){
		var pageNo = $("#pageNo").val();
		if(pageNo!=null&&pageNo!=""){
			document.body.innerHTML += '<form id="pageForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+pageNo+' /></form>';
			document.getElementById("pageForm").submit();
		}
	});	
	$("#first").click(function () {
		var page=1;
		$("#pageNo").val(page);
		document.body.innerHTML += '<form id="firstForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value="1" /></form>';
		document.getElementById("firstForm").submit();	
	});
	$("#previous").click(function () {
		var page=$("#pageNo").val();
		if(page>1){
			$("#pageNo").val(page-1);
		}
		var previousPage=$("#pageNo").val();
		document.body.innerHTML += '<form id="previousForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+previousPage+' /></form>';
		document.getElementById("previousForm").submit();	
	});
	$("#next").click(function () {
		var page=parseInt($("#pageNo").val());
		var lastPage=$("#totRows").val();
		if(page<lastPage){
			$("#pageNo").val(page+1);
		}
		var nextPage=parseInt($("#pageNo").val());
		document.body.innerHTML += '<form id="nextForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+nextPage+' /></form>';
		document.getElementById("nextForm").submit();
	});
	$("#last").click(function () {
		var lastPage=$("#totRows").val();
		document.body.innerHTML += '<form id="lastForm" action="<c:url value='list' />"><input type="hidden" name="txn" value="123" /><input type="hidden" name="page" value='+lastPage+' /></form>';
		document.getElementById("lastForm").submit();
	});
	}); */

function deleteEmp(empId){
	if (confirm("Do you want to delete Employee ?") == true) {
		var sendvalue={dummyUser:empId}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Employee Deleted Successfully</h2>"); 
	                     window.location.href="empList";
	                } else if (data.status==111) {
	                    $("body").attr("onload","noBack();");
	                    $("body").attr("onpageshow","if (e00vent.persisted) noBack();");
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
	            url: "deleteEmployee",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;

	}else{
		return false;
	}
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
                <h3 class="box-title">Pre-Merchant Boarded</h3>
                <div class="box-tools">
                <a class="btn btn-block btn-primary btn-sm"><i class="fa fa-filter" data-toggle="modal" data-target=".filter-detail-popup" <c:if test="${empRole == '12'}">style="display:none;"</c:if>></i> Filters</a>
                                  	<strong>
	                                     <c:if test="${merchantName!=''&&merchantName!=null}"> || Merchant Name:<c:out value="${merchantName}"/><input type="hidden" id="merchantName1" value='<c:out value="${merchantName}"/>'/></c:if>
	                                     <c:if test="${marketingName!=''&&marketingName!=null}"> || Marketing Name:<c:out value="${marketingName}"/><input type="hidden" id="marketingName1" value='<c:out value="${marketingName}"/>'/></c:if>
	                                     <c:if test="${verificationstatus!=''&&verificationstatus!=null}"> || Verification Status:<c:out value="${verificationstatus}"/><input type="hidden" id="verificationStatus1" value='<c:out value="${verificationstatus}"/>'/></c:if>
	                                     <c:if test="${executiveName!=''&&executiveName!=null}"> || Executive Name:<c:out value="${executiveName}"/><input type="hidden" id="executiveName1" value='<c:out value="${executiveName}"/>'/></c:if>                                                
                                    </strong>
                </div>
              </div>
              
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table table-bordered">
                  <thead>
                    <tr>
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
                  <?php 
                  for ($x = 0; $x <= 8; $x++) {?>
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
                                                               <button type="submit" class="btn btn-success btn-xs" ><i class="fa fa-fw fa-eye"></i>View Details</button>
		                                         </form>
                                                       
                                                       <a onclick="return isGenerateFile();" href=<c:url value='gnrtExcelSheet?signImage=${allRowData.applicationNo}'/>><button type="button" class="btn-submit"  <c:if test="${allRowData.empRole != '2'}">style="display:none;"</c:if>>Download</button></a>
                                                        <button type="button" class="btn btn-danger btn-xs" onclick='return deleteDeviceConfirm("${allRowData.applicationNo}")' <c:if test="${allRowData.empRole != '1'}">style="display:none;"</c:if>><i class="fa fa-fw fa-remove"></i>Delete</button>                                             
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
                  <?php } ?>
                  </tbody>
                </table>
              </div>
              
             <!--  <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#">«</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">»</a></li>
              </ul>
            </div> -->
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


<!--Delete confirmation Popup Begin -->

<!--Delete confirmation Popup End -->

      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<jsp:include page="/jsp/footer.jsp" />
