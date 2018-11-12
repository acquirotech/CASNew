<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12")||session.getAttribute("empRole").equals("8"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">

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
	            url: "deleteEmployee",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;

	}else{
		return false;
	}
}
function getemplock(){
	$("#modal-body").html("<h2>In Process</h2>");  
	var empid = $("#empid").val();
	var name = $("#name").val();
	var email = $("#email").val();
	var phone = $("#phone").val();
	var enabled = $("#enabled").val();
	var createdOn = $("#createdOn").val();
	var emprole = $("#emprole").val();
	var password=$("#password").val();
	var regex ="^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\\s).{8,20}$";

	if(password!=null&&password!=''){
	 if(password.length<8||password.length>20){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Password.Length should be min 8 digits max 20 digits</p>');
		return false;
	}else if(password.match(regex) == null){
		$("#modal-body").html('<h2>Validation Error</h2><p>Password must be contain atleast 1 uppercase Char 1 lowercase Char 1 digit and one special char</p>');
		return false;
	}
	}else if(name==null||name==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Name</p></n>Length should be min 2 and max 30 char');
		return false;
	}else if(name.length<2||name.length>30){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Name</p></n>Length should be min 2 and max 30 char');
		return false;
	}else if(phone==null||phone==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Phone No</p></n>Length should be 10 digits');
		return false;
	}else if(phone.length<10||phone.length>10){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Phone No</p></n>Length should be 10 digits');
		return false;
	}
		var sendvalue={empid:empid,name:name,email:email,phone:phone,enabled:enabled,createdOn:createdOn,emprole:emprole,password:password}
		var opts = {
	            type: "POST",
	            success: function (data) {
	                $(".loading").css("visibility","hidden");
	                if (data.status == 0&&data.message=='OK') {
	                    $("#modal-body").html("<h2>Employee Updated Successfully</h2>"); 
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
	                    $("#modal-body").html("<h2>Connection Error</h2><p>"+data.message+"</p>");
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
	            url: "empChangeProfile",
	            data: sendvalue
	        }; 
	        $.ajax(opts);
	        return false;
	}	
</script>
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                    <form class="form-horizontal form-label-left"> 
                     <input type="hidden" value="${empId}" name="empid" id="empid" /> 
	     			 <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->


  <!------------------------- panel employee ---------------------------------------------------------->
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Employee Details</h2>
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
                                                <input type="text" class="form-control" data-clear-btn="true" name="name" id="name" value="${empName}" required="true" minlength="2" maxlength="30" />
                                            </div>
                                        </div>
                                     <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">EmailId<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" class="form-control" data-clear-btn="true" name="email" id="email" value="${empEmailId}" required="true" minlength="2" maxlength=100  readonly="readonly"/>
                                            </div>
                                        </div>
                                    	<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="phone">Phone<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <input type="text" class="form-control" data-clear-btn="true" name="phone" id="phone" value="${empPhone}" required="true" onkeypress='return event.charCode >= 48 && event.charCode <= 57' digits="true" maxlength="10"  />
                                          </div>
                                        </div>
                                        <div class="form-group" <c:if test="${empRole == 'Admin'}">style="display:none;"</c:if>>
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="enabled">Enabled<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select data-clear-btn="true" name="enabled" id="enabled" required="true" class="form-control">
                                            	<option value="" <c:if test="${empEnabled == ''}">Selected</c:if>>Choose option</option>
												<option <c:if test="${empEnabled == '1'}">Selected</c:if> value="1"> UnLock</option>
												<option <c:if test="${empEnabled == '0'}">Selected</c:if> value="0"> Lock</option>
											</select>
                                        </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="createdOn">Last Updated On<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <input type="text" class="form-control" data-clear-btn="true" name="createdOn" id="createdOn" value="${empCreatedOn}" required="true"  readonly="readonly" />
                                            </div>
                                        </div>
                                    	<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="password">Password</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                             <input type="password" class="form-control" data-clear-btn="true" name="password" id="password" maxlength="20"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12"for="emprole">Employee Role<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                               <input type="text" class="form-control" data-clear-btn="true" name="emprole" id="emprole" value="${empRole}" digits="true" readonly="readonly"/>
                                               </div>
                                        </div>
                                        <div class="form-group">
                                        	<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                            	<a href="<c:url value='empList' />" class="btn-cancel">Cancel</a>
                                                <button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-submit" onclick="return getemplock();" class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="AddOrgSub" name="AddOrgSub"<c:if test="${empRole == '12'}">style="display:none;"</c:if>>Update</button>
                                            	<button type="button" data-toggle="modal" data-target=".bs-example-modal-sm" class="btn-delete" onclick='return deleteEmp("${empId}")' class="ui-btn ui-icon-check ui-btn-icon-left ui-shadow-icon ui-btn-b ui-corner-all" id="deleteEmployee" <c:if test="${empRole == 'Admin'}">style="display:none;"</c:if> name="AddOrgSub">Delete</button>
                                            </div>
                                        </div>                                       
                                </div>
                            </div>                            
<!----------------------------------------------------------panels end--------------------------------------------------------->
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
                                                <button type="button" class="btn-cancel" data-dismiss="modal" >Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /modals -->
                    
                <!-- /page content -->

<!-- footer content -->
            <jsp:include page="/jsp/footer.jsp" />
                <!-- /footer content -->