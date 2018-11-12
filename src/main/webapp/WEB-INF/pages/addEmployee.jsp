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
	
	var sendvalue={employeeName:name,empEmailId:email,empPhone:phone,empPassword:password,empRole:emprole}
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
            url: "addEmployee",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}
</script>


<script type="text/javascript">

function isAlphaNumeric(event) {	
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58 || charCode==32|| charCode==46|| charCode==40|| charCode==41||charCode==45||charCode==46||charCode==47||charCode==58||charCode==44||charCode==95)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}

function passwordValidations(event){
	try {
   		if (window.event) {
    	   	var charCode = window.event.keyCode;
    	}else if (e) {
    	     var charCode = e.which;
    	}else { return true; }
    	        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode>47&&charCode<58||charCode==33||charCode==35||charCode==36||charCode==64||charCode==95)
    	            return true;
    	        else
    	            return false;
    }
    catch (err) {
    	alert(err.Description);
   	}
}

function onlyAlphabets(e, t) {
    try {
        if (window.event) {
            var charCode = window.event.keyCode;
        }
        else if (e) {
            var charCode = e.which;
        }
        else { return true; }
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123 || charCode == 32))
            return true;
        else
            return false;
    }
    catch (err) {
        alert(err.Description);
    }
}

</script>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add New Employee Details</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="name">Employee Name</label>
                      <input type="text" class="form-control input-lg" id="name" placeholder="Enter Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="email">EmailId</label>
                      <input type="email" class="form-control input-lg" id="email" placeholder="Enter email">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Phone</label>
                      <input type="number" class="form-control input-lg" id="phone" placeholder="Enter Phone">
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
                      <label for="emprole">Employee Role</label>
                      <select data-clear-btn="true" name="emprole" id="emprole" required="true" class="form-control input-lg"">
											<option value="">Choose	option</option>
											<option value="2">Boarding</option>
											<option value="3">Billing</option>
											<option value="4">Support</option>
											<option value="5">Sales</option>
											<option value="9">Sales Coordinator</option>
											<option value="6">PreBoarding</option>
											<option value="7">Senior Support</option>
											<option value="8">HR </option>
											<option value="10">CUB</option>
											<option value="11">TeleCaller</option>
						</select>  
                    </div>
                  </div>
                </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" data-target=".bs-example-modal-sm" class="btn btn-info pull-right" onclick="return getaddEmp();">Submit</button>
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
        <form id="id2DelFrm" method="GET">
          <input type="hidden" class="form-control" id="id2Delete" name="id2Delete">
          <button type="submit" class="btn btn-danger"><i class="fa fa-fw fa-remove"></i>Close</button>
        </form>
      </div>
    </div>
  </div>
</div>
  
	<!-- Small modal -->
                                
                    
<jsp:include page="/jsp/footer.jsp" />