<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1")||session.getAttribute("empRole").equals("12"))){	
	response.sendRedirect("welcome");
}%>
 <script src="<c:url value="resources/js/Acqcitystate.js" />"></script>
<!-- ----------------------------------js functions---------------------------------------------------- -->
<script type="text/javascript">
$(document).ready(function (){
$("#empId").change(function(){
	var empId = $("#empId").val();
	if(empId!=null&&empId!=""){
		document.body.innerHTML += '<form id="pageForm" action="<c:url value='empProfile' />"><input type="hidden" name="empId" value='+empId+' /></form>';
		document.getElementById("pageForm").submit();
	}
});
});
</script>
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                    <div class="row">
                    <form class="form-horizontal form-label-left"> 
                     <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->


  <!--- panel Organization ---------------------------------------------------------->
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Employee Management</h2>
                                   <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                   
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                   <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="merchantId">Employee Name</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                 <select name="empId" id="empId" class="form-control">
                                                    <option value="">Employee Name</option>
                                                     <c:forEach var="RowData" items="${empList}">
														<option value="<c:out value="${RowData['id']}"/>">
														<c:out value="${RowData['name']}"/></option> 
										 			 </c:forEach>        
                                                  </select>
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
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">X</span>
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