<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script src="<c:url value="resources/js/acqcitystate.js" />"></script>
  <div class="content-wrapper">
<!-- Content Header (Page header) -->

<!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">PreBoard Merchant</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Sales Executive Name/DSA/Channel Partner</label>
                      <select name="executiveName" id="executiveName" class="form-control input-lg">
										    	<option value="">select</option>
										 			<c:forEach var="RowData" items="${executiveList}">
										 				<option value="<c:out value="${RowData['executiveEmail']}"/>" <c:if test="${RowData['executiveEmail'] == param.executiveEmail}">selected="selected"</c:if> ><c:out value="${RowData['executiveName']}"/></option> 
										 			</c:forEach>
											</select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Merchant name/Client Name/Director Name</label>
                      <input type="text" class="form-control input-lg" id="Name" placeholder="Enter Name">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="PhoneNo">Phone No</label>
                      <input type="number" class="form-control input-lg" id="PhoneNo" placeholder="Enter Phone">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Marketing/Firm's Name</label>
                      <input type="email" class="form-control input-lg" id="MarketingName" placeholder="Enter Marketing Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Merchant Location</label>
                      <select onchange="print_businesscity('businesscity', selectedIndex);" id="businessstate" name ="businessstate" class="form-control input-lg">
					                             <option value="">STATE</option>
					                            </select>
                                                  </div>
                                        
                                        <div class="form-group percent-50" style="display: none;">
                                            <label for="BusinessCity">Business City</span></label>
                                            <script language="javascript">print_businessstate("businessstate");</script>
                                            <select id="businesscity" name ="businesscity" class="form-control">
					                             <option value="">CITY</option>
					                            </select>
                                                  
                                  </div> </div>
                  
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Rental Amount</label>
                      <input type="number" class="form-control input-lg" id="amount" placeholder="Enter Rental Amount">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">Cheque No/NEFT No/Swipe No.</label>
                      <input type="text" class="form-control input-lg" id="chequeNo" placeholder="Enter Cheque No">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">NACH Number</label>
                      <input type="number" class="form-control input-lg" id="nashNumber" placeholder="Enter Nach Number">
                    </div>
                  </div>
                  
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">NACH Bank Name</label>
                      <input type="text" class="form-control input-lg" id="nashBankNAme" placeholder="Enter Bank Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="MarketingName">NACH Date</label>
                      <input type="datetime" class=" date-picker form-control input-lg" id="neftDate" placeholder="Enter Date">
                    </div>
                  </div>
                 </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right">Sign in</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<jsp:include page="/jsp/footer.jsp" />
