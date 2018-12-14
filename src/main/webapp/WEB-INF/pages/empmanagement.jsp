<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <script type="text/javascript"> 
function empProfile(profileid,user,email,phone,status,date,role,manager){
	document.body.innerHTML += '<form id="dynForm" action="<c:url value='empProfile' />" method="post"><input type="hidden" name="empId" value='+profileid+' /></form>';
	document.getElementById("dynForm").submit();
}

</script>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
             
              <div class="box-header with-border">
                <h3 class="box-title">Employee List</h3>
                <div class="box-tools">
                <a class="btn btn-block btn-primary btn-sm"><i class="fa fa-filter"></i> Filters</a>
                </div>
              </div>
              
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table table-bordered">
                  <thead>
                    <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>EmailId</th>
                    <th>PhoneNo</th>
                    <th>ActiveStatus</th>
                    <th>Date</th>
                    <th>Role</th>  
                    <th>Action</th>            
                  </tr>
                  </thead>
                  <tbody>
                 
                    <c:forEach var="allRowData" items="${empList}">											
                                        	   <tr class="even pointer">
                                            		<td><c:out value="${allRowData['id']}"/></td>
		                                            <td><c:out value="${allRowData['name']}"/></td>
		                                            <td><c:out value="${allRowData['emailId']}"/></td>
		                                            <td><c:out value="${allRowData['phone']}"/></td>
		                                            <td><c:out value="${allRowData['enabled']}"/></td>
		                                            <td><c:out value="${allRowData['dateTime']}"/></td>
		                                            <td><c:out value="${allRowData['empRole']}"/></td>
		                                           <td><button type="button" class="btn btn-success btn-xs" onclick='return empProfile("${allRowData.id}","${allRowData.name}","${allRowData.emailId}","${allRowData.phone}","${allRowData.enabled}","${allRowData.dateTime}","${allRowData.empRole}","${allRowData.reportManager}")'><i class="fa fa-fw fa-eye"></i>View Details</button>
		                                           <button type="button" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#deleteConfirm" data-id2del="${allRowData.id}"><i class="fa fa-fw fa-remove"></i>Delete</button>
		                                           </td>											
												</tr>	
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
        <form id="id2DelFrm" action="<c:url value='deleteEmployee'/>" method="POST">
          <input type="hidden" class="form-control" id="id2Delete" name="id2Delete" >
          <button type="button" class="btn btn-default" data-dismiss="modal">Keep It</button>
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove" ></i>Delete</button>
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
