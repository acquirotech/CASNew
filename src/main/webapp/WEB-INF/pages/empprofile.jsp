<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
<script type="text/javascript">
	
function getaddEmp(){
	$("#modal-body").html("<h2>In Process</h2>");
	var name=$("#name").val();
	var email=$("#email").val();
	var phone=$("#phone").val();
	var password=$("#password").val();
	var emprole=$("#emprole").val();
	var empid =$("#empid").val();
	var manager =$("#reportManager").val();
	var regex ="^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\\s).{8,20}$";

	 if(name==null||name==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Employee Name</p></n>Length should be min 2 and max 30 char');
		return false;
	}else if(name.length<=2||name.length>30){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Employee Name Correct Format</p></n>Length should be min 3 and max 60 char');
		return false;
	}else if(email==null||email==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Email</p></n>Length should be min 4 and max 100 char');
		return false;
	}else if(phone==null||phone==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Emplyoee Phone</p></n>Length should be 10 digits');
		return false;
	}else if(phone.length<10||phone.length>10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Employee PhoneNo</p></n>Length should be 10 digits');
		return false;
	}else if(password==null||password==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Password</p>');
		return false;
	}else if(password.length<8||password.length>20){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Password.Length should be min 8 digits max 20 digits</p>');
		return false;
	}else if(password.match(regex) == null){
		$("#modal-body").html('<h2>Validation Error</h2><p>Password must be contain atleast 1 uppercase Char 1 lowercase Char 1 digit and one special char</p>');
		return false;
	}else if(emprole==null||emprole==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Employee Role</p>');
		return false;
	}
	
	var sendvalue={employeeName:name,empEmailId:email,phone:phone,empPassword:password,empRole:emprole,empid:empid,reportManager:manager}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>Employee Added Successfully</h2>");  
                    $("#name").val('');
                    $("#email").val('');
                    $("#phone").val('');
                    $("#password").val('');
                    $("#emprole").val('');
                    window.location.reload();
                }else if (data.status==100&&data.message=='EmailId already in use') {                	
                	$("#modal-body").html("<h2>"+data.message+"</h2>"); 
                	$("#email").val('');
                }else if (data.status==111) {
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
            url: "empChangePassword",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}
</script>


    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title"> Employee Details</h3>
            </div>
            <form role="form">
             <input type="hidden" value="${empId}" name="empid" id="empid" /> 
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="name">Employee Name</label>
                      <input type="text" class="form-control input-lg" id="name" value="${empName}" placeholder="Enter Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="email">EmailId</label>
                      <input type="email" class="form-control input-lg" id="email" value="${empEmailId}" placeholder="Enter email">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Phone</label>
                      <input type="text" class="form-control input-lg" id="phone" value="${empPhone}" placeholder="Enter Phone">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Password</label>
                      <input type="password" class="form-control input-lg" id="password" placeholder="Enter Password">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                   <div class="col-md-5">
                  <div class="form-group">
                                            <label for="createdOn">Last Updated On</label>
                                             <input type="text" class="form-control input-lg" name="createdOn" id="createdOn" value="${empCreatedOn}" required="true"  readonly="readonly" />
                                        </div>
                                        </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="emprole">Employee Role</label>
                      <input type="text" class="form-control input-lg" data-clear-btn="true" name="emprole" id="emprole" value="${empRole}" digits="true" readonly="readonly"/>
                    </div>
                  </div>
                
                <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="emprole">Report Manager </label>
                    <select name="reportManager" id="reportManager" class="form-control input-lg">
								  	  <c:if test="${reportManager==''}">
								  	     <option value="NA">select</option> 	
									  </c:if>
									  <c:forEach var="RowData" items="${empList}">
									  <option <c:if test="${RowData['executiveId'] == reportManager}">selected</c:if> value="<c:out value="${RowData['executiveId']}"/>">
									  <c:out value="${RowData['executiveName']}"/>
									  </option> 									  
								  	  </c:forEach>
								   </select></div>
                  </div>
                  </div>
                </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" data-target=".bs-example-modal-sm" class="btn btn-info pull-right" data-toggle="modal" onclick="return getaddEmp();">Submit</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  
  
  <!-- Small modal -->
  <div class="modal fade bs-example-modal-sm" id="deleteConfirm">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Your Request Status</h4>
      </div>
       <div id="modal-body" class="modal-body">
                                                
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
  
	<!-- Small modal -->
                                
                    
<jsp:include page="/jsp/footer.jsp" />