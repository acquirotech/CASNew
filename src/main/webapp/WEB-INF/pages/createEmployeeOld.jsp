<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("8"))){	
	response.sendRedirect("welcome");
}%>
<!-- ----------------------------------js functions---------------------------------------------------- -->
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
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                    <form class="form-horizontal form-label-left"> 
                   <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->


  <!------------------------ panel Organization-------------------------->
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Add New Employee Details</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                   
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                    <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Employee Name<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="name" id="name" required="true" minlength="2" maxlength=30 onkeypress="return isAlphaNumeric(event);" />
                                            </div>
                                        </div>
                                     <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">EmailId<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="email" class="form-control" data-clear-btn="true" name="email" id="email" required="true" minlength="2" maxlength=100 />
                                            </div>
                                        </div>
                                    	<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="phone">Phone<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="phone" id="phone" required="true" maxlength="10" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true"/>
                                          </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="password">Password<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <input type="password" class="form-control" data-clear-btn="true" name="password" id="password" minlength="8" maxlength="20" required="true" onkeypress="return passwordValidations(event);" />
                                            </div>
                                        </div>
                                    
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="emprole">Employee Role<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="emprole" id="emprole" required="true" class="form-control"">
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
                                         <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                               <a href="<c:url value='welcome' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return getaddEmp();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="addEmp" name="addEmp">Submit</button>
                                            </div>
                                        </div>                                         
                                </div>
                            </div>                                     
<!-- ----------------------------------------------------------------panels end----------------->
                        </div>
                    </form>
                    </div>
				</div>
				
								<!-- Small modal -->
                                <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">X</span>
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
                                <!-- /modals -->
                    
                <!-- /page content -->

<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->