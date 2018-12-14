<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script type="text/javascript">
function submitDevice(){
	$("#modal-body").html("<h2>In Process</h2>");

	var deviceRental=$("#deviceRental").val();
	var name=$("#name").val();
	var cashAtPosIncentive=$("#cashAtPosIncentive").val();
	var MdrDebit0=$("#MdrDebit0").val();
	var MdrDebit1=$("#MdrDebit1").val();
	var MdrDebit2=$("#MdrDebit2").val();
	var MdrCreditPre=$("#MdrCreditPre").val();
	var MdrCreditNpre=$("#MdrCreditNpre").val();
	var Other=$("#Other").val();
	var mdrCashAtPos=$("#mdrCashAtPos").val();
	var walletMdr=$("#walletMdr").val();
	var address=$("#address").val();
	
	if(name==null||name==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Model Name</p>');
		return false;
	}else if(name.length<2||name.length>40){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 2 and max 40 char');
		return false;
	}else if(deviceRental==null||deviceRental==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal deviceRental</p></n>Length should be min 8 and max 17 char');
		return false;
	}else if(deviceRental.length>17){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal deviceRental</p></n>Length should be min 8 and max 17 char');
		return false;
	}
	
	var sendvalue={
			walletMdr:walletMdr,
			mdrCashAtpos:mdrCashAtPos,
			Other:Other,
			MdrCreditNpre:MdrCreditNpre,
			MdrCreditPre:MdrCreditPre,
			MdrDebit2:MdrDebit2,
			MdrDebit1:MdrDebit1,
			cashAtPosIncentive:cashAtPosIncentive,
			Name:name,
			deviceRent:deviceRental,
			address:address,
			MdrDebit0:MdrDebit0
			
			 }
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>DSA Added Successfully</h2>");  
                    $("#modelName").val('');$("#serialNo").val('');
                    $("#tid").val('');$("#status").val("Available");
                } else if (data.status==111) {
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
            url: "addDsaDetails",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}
</script>
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add DSA</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1"> Name</label>
                     <input type="text" class="form-control input-lg" id="name" placeholder="Enter name">
            		</div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Device Rental</label>
                      <input type="text" class="form-control input-lg" id="deviceRental" placeholder="Enter Rental">
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Mdr Debit <1000</label>
                      <input type="number" class="form-control input-lg" id="MdrDebit0" placeholder="Enter Mdr Debit <1000">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Mdr Debit (>1000 & <2000)</label>
                      <input type="number" class="form-control input-lg" id="MdrDebit1" placeholder="Enter Mdr Debit (>1000 & <2000)">
                    </div>
                  </div>
                  </div>
                  <div class="row">
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Mdr Debit >2000</label>
                      <input type="number" class="form-control input-lg" id="MdrDebit2" placeholder="Enter Mdr Debit >2000">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Mdr Credit Premium</label>
                      <input type="number" class="form-control input-lg" id="MdrCreditPre" placeholder="Enter Mdr Credit Pre">
                    </div>
                  </div>
                  </div>
                  <div class="row">
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">Mdr Credit Card Non-Premium</label>
                      <input type="number" class="form-control input-lg" id="MdrCreditNpre" placeholder="Enter MdrCredit Nonpre">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">International Card</label>
                      <input type="text" class="form-control input-lg" id="Other" placeholder="Enter International Card Mdr">
                    </div>
                  </div>
                  </div>
                  <div class="row">
                  <div class="col-md-5" >
                    <div class="form-group">
                      <label for="Password">CASH@POS MDR</label>
                      <input type="text" class="form-control input-lg" id="mdrCashAtPos" placeholder="Enter Cash@pos Mdr">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Wallet MDR</label>
                      <input type="text" class="form-control input-lg" id="walletMdr" placeholder="Enter Wallet MDR">
                    </div>
                  </div>
                  </div>
                  <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Cash@Pos Incentive</label>
                      <input type="text" class="form-control input-lg" id="cashAtPosIncentive" placeholder="Enter cashAtPos Incentive">
                    </div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="Password">Address</label>
                      <input type="text" class="form-control input-lg" id="address" placeholder="Enter Address">
                    </div>
                  </div>
                  </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" data-toggle="modal" data-target=".bs-example-modal-sm" onclick="return submitDevice();">Submit</button>
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
  
<jsp:include page="/jsp/footer.jsp" />
