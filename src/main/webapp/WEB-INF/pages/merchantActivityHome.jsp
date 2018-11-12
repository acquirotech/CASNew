<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% if(!(session.getAttribute("empRole").equals("1"))&&!(session.getAttribute("empRole").equals("12"))&&!(session.getAttribute("empRole").equals("2"))&&!(session.getAttribute("empRole").equals("3"))&&!(session.getAttribute("empRole").equals("7")&&!(session.getAttribute("empRole").equals("9")))){ 
 response.sendRedirect("welcome");
}%>
<script type="text/javascript">
$(document).ready(function (){
	<c:if var="pg" test="${status!=null&&status!=''}">
		alert('<c:out value="${status}" />');
	</c:if>
});
function getValidate(){
	var date = $("#fromDate").val();
	var todate = $("#toDate").val();
	if(date.length==10&&todate.length==10){
		return ture;
	}else{
		alert("Select From Date and To Date");
		return false;
	}
}
</script>
<!----------------------------------------- page content ------------------------------------------------------------------------------------------>
            <div class="right_col" role="main">
                <div class="">
                   <div class="clearfix"></div>
                    <div class="row">
                    <form method="GET" action="<c:url value='downloadNonTxnMerchant' />" onsubmit="return getValidate();" class="form-horizontal form-label-left"> 
          <div class="col-md-12 col-sm-12 col-xs-12">

<!-- ----------------------------------------------------------------panels start----------------->


  <!--- panel Organization ---------------------------------------------------------->
                            
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Merchant Activity Management</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                      </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                        
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="beneficiaryDate1">Select No Of Days <span class="required">*</span></label>
                                             <div class="col-md-3 col-sm-3 col-xs-12">
                                             <select data-clear-btn="true" name="noOfDays"
										id="noOfMerchantDays" class="form-control">
											<option value="">Choose	option</option>
											<option value="one"> One Day</option>
											<option value="two"> Last Two Days</option>
											<option value="seven"> Last Seven Days</option>
											<option value="ten"> Last Ten Days</option>
											<option value="fifteen"> Last 15 Days</option>
											<option value="thirty"> Last One Month</option>
											<option value="sixty"> Last Two Month</option>
											<option value="ninety"> Last Three Month</option>
											</select>
                                            </div>                                        	
                                            <div class="col-md-3 col-sm-3 col-xs-12">
                                            <button type="Submit" class="btn-submit" id="noOfMerchantDaysButton" name="noOfMerchantDaysButton">Submit</button>                    
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