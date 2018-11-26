<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add Terminal</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
            		<div class="form-group">
                      <div class="col-md-2">
                       <input type="checkbox" style="margin: 0 !important; position: relative !important" id="rechargeServiceEnable" name="rechargeServiceEnable" onclick="return setRechargeServiceStatus();">Recharge Service Enable
						</div>
						
                                             
                                              <div class="col-md-2">
									           <input type="checkbox" style="margin: 0 !important; position: relative !important" id="dmtServiceEnable" name="dmtServiceEnable">DMT Service Enable
									        </div>
									       
									                                            
									           <div class="col-md-2">
									           <input type="checkbox" style="margin: 0 !important; position: relative !important" id="ppcServiceEnable" name="ppcServiceEnable">PPC Service Enable
									        </div>
									         
									          <div class="col-md-2"> <input type="checkbox" style="margin: 0 !important; position: relative !important" id="dthMobileServiceEnable" name="dthMobileServiceEnable">DTH/Mobile Service Enable
									        </div>
									        
									        
									          
									          <div class="col-md-2">
									           <input type="checkbox" style="margin: 0 !important; position: relative !important" id="userType" name="userType" onchange="return onchangeUserType();">Credit/Debit Service Enable
									            </div>
                    </div>
                  </div>
                  
            <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="phone">Merchant Name</label>
                       <select name="merchantId" id="merchantId" class="form-control input-lg" onchange="return getorg();">
                                                       <option value="">select</option>
														 <c:forEach var="RowData" items="${merchantList}">
														 <option value="<c:out value="${RowData['merchantId']}"/>" <c:if test="${RowData['merchantId'] == param.merchantId}">selected="selected"</c:if> ><c:out														
														value="${RowData['merchantName']}"/></option> 
							</c:forEach>        
                      </select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                 <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Store Name</label>
                      <select name="orgId" id="orgId" class="form-control input-lg">
													  <option value="">select</option>
														 <c:forEach var="RowData" items="${orgList}">
														 <option value="<c:out value="${RowData['orgId']}"/>" <c:if test="${RowData['orgId'] == param.orgId}">selected="selected"</c:if>><c:out value="${RowData['orgName']}"/></option> 
														 </c:forEach>
					 </select> 
                    </div>
                  </div>
                 <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_SerialNo" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Serial No</label>
                     <select data-clear-btn="true" name="SerialNo" id="SerialNo" required="true" class="form-control input-lg" >
                                            		<option value="">Select</option>
                     </select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_bankTid" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Bank Tid</label>
                     <input type="text" class="form-control input-lg" data-clear-btn="true" name="BankTid" id="BankTid" placeholder="Enter Tid" required="true" minlength="0" maxlength="8"  onPaste="return false"/> 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Terminal Id</label>
                     <input type="number" class="form-control input-lg" data-clear-btn="true" name="LoginId" placeholder="Enter Terminal No" id="LoginId" required="true" minlength="0" maxlength="8"  onPaste="return false"/> 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1"><input type="checkbox" style="margin:0 !important;position:relative !important" id="sameUserId" name="sameUserId" onchange="onOffSamePhone();" /> RMN Same As LoginId RMN</label>
                        <input type="number" class="form-control input-lg" data-clear-btn="true" placeholder="Enter Rmn" name="rmn" id="rmn" required="true" minlength="10" maxlength="10" digits="true" onPaste="return false"/>
                                 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Email Id</label>
                      <input type="email" class="form-control input-lg" data-clear-btn="true" name="UserEmailId" placeholder="Enter Email" id="UserEmailId" required="true" minlength="10" maxlength="10" digits="true" onPaste="return false"  />
                        
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Name Of User</label>
                      <input type="password" class="form-control input-lg" id="Name" placeholder="Enter Name">
                    </div>
                  </div>
                 <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Valid till Date</label>
                           <input type="text" class="date-picker form-control input-lg" placeholder="Enter Valid Till Date" data-role="date" data-clear-btn="true" name="validTil" id="validTil" onkeypress='return false;' readonly='true'/>
                                            
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Rent</label>
                         <input type="number" class="form-control input-lg" placeholder="Enter Rent" data-clear-btn="true" name="Rent" id="Rent" required="true" minlength="1" maxlength="8" number="true" onPaste="return false"/>
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Payment Mode</label>
                   		<select name="PaymentMode" id="PaymentMode" required="true" class="form-control input-lg">
                                            <option value="">select</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="quaterly">Quaterly</option>
                                            <option value="halfyearly">HalfYearly</option>
                                            <option value="yearly">Yearly</option>
                        </select></div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Pending Rent</label>
                      <input type="number" class="form-control input-lg" id="pendingRent" placeholder="Enter Pending Rent">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Penalty Amount</label>
                      <input type="number" class="form-control input-lg" id="penaltyAmount" placeholder="Enter Penalty Amount">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Penalty Reason</label>
                      <input type="text" class="form-control input-lg" id="Name" placeholder="Enter Penalty Reason">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Discount</label>
                      <input type="number" class="form-control input-lg" id="Name" placeholder="Enter Discount">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Discount Reason</label>
                      <input type="text" class="form-control input-lg" id="discountReason" placeholder="Enter Discount Reason">
                    </div>
                  </div>
                 <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Avg Txn Amt</label>
                      <input type="text" class="form-control input-lg" id="avgTxnAmount" placeholder="Enter Avg Txn Amt">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_MdrDebit0" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Mdr Debit <1000</label>
                      <input type="number" class="form-control input-lg" id="MdrDebit0" placeholder="Enter Mdr Debit <1000">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_MdrDebit1" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Mdr Debit (>1000 & <2000)</label>
                      <input type="number" class="form-control input-lg" id="MdrDebit1" placeholder="Enter Mdr Debit (>1000 & <2000)">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_MdrDebit2" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Mdr Debit >2000</label>
                      <input type="number" class="form-control input-lg" id="MdrDebit2" placeholder="Enter Mdr Debit >2000">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_MdrCreditPre" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Mdr Credit Premium</label>
                      <input type="number" class="form-control input-lg" id="MdrCreditPre" placeholder="Enter Mdr Credit Pre">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_MdrCreditNpre" style="display:none;">
                    <div class="form-group">
                      <label for="Password">Mdr Credit Card Non-Premium</label>
                      <input type="number" class="form-control input-lg" id="MdrCreditNpre" placeholder="Enter MdrvCredit Nonpre">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_Other" style="display:none;">
                    <div class="form-group">
                      <label for="Password">International Card</label>
                      <input type="text" class="form-control input-lg" id="Other" placeholder="Enter International Card Mdr">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" d="div_mdrCashAtPos" style="display:none;">
                    <div class="form-group">
                      <label for="Password">CASH@POS MDR</label>
                      <input type="text" class="form-control input-lg" id="mdrCashAtPos" placeholder="Enter Cash@pos Mdr">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Wallet MDR</label>
                      <input type="text" class="form-control input-lg" id="avgTxnAmount" placeholder="Enter Wallet MDR">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Fixed Settlement Charges</label>
                      <input type="text" class="form-control input-lg" id="settlementCharges" placeholder="Enter settlement Charges">
                    </div>
                  </div>
                <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Bank Account Type</label>
                     <select name="bankAccType" id="bankAccType" class="form-control input-lg">
		                                            <option value="">select</option>
		                                            <option value="current">Current</option>
		                                            <option value="saving">Saving</option>
		                                            <option value="od">OD</option>
	                  </select>
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Bank Account Number</label>
                      <input type="text" class="form-control input-lg" id="bankAccNumber" placeholder="Enter Bank Account Number">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Bank Name</label>
                      <input type="text" class="form-control input-lg" id="bankName" placeholder="Enter Bank Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Beneficiary Name</label>
                      <input type="text" class="form-control input-lg" id="benefName" placeholder="Enter Beneficiary Name">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Bank Branch</label>
                      <input type="text" class="form-control input-lg" id="bankBranch" placeholder="Enter Bank Branch">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Bank IFSC</label>
                      <input type="text" class="form-control input-lg" id="bankIfsc" placeholder="Enter Bank Ifsc">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Bank MICR</label>
                      <input type="text" class="form-control input-lg" id="bankMicr" placeholder="Enter Bank MICR">
                    </div>
                  </div>
                 <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Plan Name</label>
                      <select name="planName" id="planName" class="form-control input-lg">
		                                            <option value="Life-Time">Life-Time</option>
		                                            <option value="Yearly">Yearly</option>
		                                            <option value="Half-Yearly">Half-Yearly</option>
		                                            <option value="Quarterly">Quarterly</option>
		                                            <option value="Monthly">Monthly</option>
	                   </select>
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Fee Mode</label>
                      <select name="feeModel" id="feeModel" class="form-control input-lg">
                                            		<option value="Free">Free</option>
		                                            <option value="Neft">Neft</option>
		                                            <option value="Cheque">Cheque</option>
		                                            <option value="Cash">Cash</option>                                
	                                            </select>
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Fee Amount</label>
                      <input type="number" class="form-control input-lg" id="feeAmount" placeholder="Enter Fee Amount">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Fee Date</label>
                      <input type="text" class="form-control input-lg" id="feeDate" placeholder="Enter Fee Date" readonly="readonly">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Fee Remarks</label>
                      <input type="text" class="form-control input-lg" id="feeRemarks" placeholder="Enter fee Remarks">
                    </div>
                  </div>
                <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Amex Activated</label>
                      <select name="AmexActivated" id="AmexActivated" onchange="return onChangeAmexActivated();"  class="form-control input-lg">
							<option value="">Select</option>
							<option value="NO">NO</option>
  							<option value="YES">YES</option>          
					  </select> 
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_mdrAmex">
                    <div class="form-group">
                      <label for="Password">Mdr Amex</label>
                      <input type="text" class="form-control input-lg" id="mdrAmex" placeholder="Enter mdr Amex">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_amexTID">
                    <div class="form-group">
                      <label for="Password">Amex Tid</label>
                      <input type="text" class="form-control input-lg" id="amexTID" placeholder="Enter Amex Tid">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" id="div_amexMID">
                    <div class="form-group">
                      <label for="Password">Amex Mid</label>
                      <input type="text" class="form-control input-lg" id="amexMID" placeholder="Enter Amex Mid">
                    </div>
                  </div>
                <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">MID/TID Entry Date</label>
                      <input type="text" class="form-control input-lg" id="midTidEntryDate" placeholder="Enter midTidEntryDate">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Welcome Letter Send Date</label>
                      <input type="text" class="form-control input-lg" id="wlcmLtrSendDate" placeholder="Enter wlcmLtrSendDate">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div id="div_rechargeServiceDetails" style="display: none">
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Recharge Balance</label>
                      <input type="number" class="form-control input-lg" id="rechargeBal" placeholder="Enter rechargeBal">
                    </div>
                  </div>
                    <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Recharge incentive</label>
                      <input type="number" class="form-control input-lg" id="rechargeIncentive" placeholder="Enter Recharge incentive">
                    </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Recharge Monthly Rental</label>
                      <input type="number" class="form-control input-lg" id="rechargeMonthlyRental" placeholder="Enter Recharge Monthly Rental">
                    </div>
                  </div>
                  </div>
                   <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Integration Key</label>
                      <input type="text" class="form-control input-lg" id="integrationKey" placeholder="Enter integrationKey">
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