<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <script type="text/javascript"> 
function empProfile(profileid,user,email,phone,status,date,role){
	document.body.innerHTML += '<form id="dynForm" action="<c:url value='empProfile' />" method="post"><input type="hidden" name="empId" value='+profileid+' /></form>';
	document.getElementById("dynForm").submit();
}

function deleteDeviceConfirm(empId){
	if (confirm("Do you want to delete PreBoard Merchant ?") == true) {
		var sendvalue={id:empId}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>PreMerchant Deleted Successfully</h2>"); 
	                     window.location.href="PreBoardedMerchantlist";
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
	            url: "deletePreBoard",
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
                                                <th>PreBoard Id </th>
                                                <th>Merchant Name</th>
                                                <th>Contact Details </th>
                                                <th>Location </th>
                                                <th>Verification Status </th>
                                                <th>Action</th>           
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
                                                         <button type="submit" class="btn btn-success btn-xs" ><i class="fa fa-fw fa-eye"></i>View Details</button>
		                                          </form>
		                                          	<button type="submit" class="btn btn-danger btn-xs" onclick='return deleteDeviceConfirm("${allRowData.applicationNo}")'<c:if test="${allRowData.empRole != '1'}">style="display:none;" </c:if>><i class="fa fa-fw fa-remove"></i>Delete</button>
												
                                                        </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                
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
