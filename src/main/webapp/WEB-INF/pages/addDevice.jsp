<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script type="text/javascript">
function submitDevice(){
	$("#modal-body").html("<h2>In Process</h2>");

	var modelName=$("#modelName").val();
	var serialNo=$("#serialNo").val();
	var status=$("#status").val();
	

	if(modelName==null||modelName==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Model Name</p>');
		return false;
	}else if(modelName.length<2||modelName.length>40){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Name</p></n>Length should be min 2 and max 40 char');
		return false;
	}else if(serialNo==null||serialNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Serial No</p></n>Length should be min 8 and max 17 char');
		return false;
	}else if(serialNo.length<8||serialNo.length>17){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Serial No</p></n>Length should be min 8 and max 17 char');
		return false;
	}
	else if(status==null||status==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Status</p>');
		return false;
	}
	var sendvalue={
			modelName:modelName,
			inventorySerialNo:serialNo,
			status:status
			
			 }
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>Inventory Terminal Added Successfully</h2>");  
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
            url: "inventoryAddDevice",
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
              <h3 class="box-title">Add Inventory</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Model Name</label>
                      <select data-clear-btn="true" name="modelName" id="modelName" required="true" class="form-control input-lg">
            										<option value="WizarPosQ1"> WizarPos Q1</option>
            										<option value="NewlandN910"> Newland N910</option>
            										<option value="PaxA920"> Pax A920</option>
            										<option value="PaxD200"> Pax D200</option>
            										<option value="NewlandME51"> Newland ME51</option>
            										<option value="P1000">Smart Peak P1000</option>
            										<option value="P500">Smart Peak P500</option>
            		  </select>
            		</div>
                  </div>
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Serial No</label>
                      <input type="text" class="form-control input-lg" id="serialNo" placeholder="Enter serialNo">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Status</label>
                    <select data-clear-btn="true" name="status"
											id="status" required="true" class="form-control input-lg">
											<option value="Available"> Available</option>
											<option value="Unavailable"> Unavailable</option>
											<option value="Damaged">Damaged</option>
											<option value="Internaluse">Internal Use</option>
											<option value="Inuse">Activated</option>
											</select>  </div>
                  </div>
                  
                </div>
              </div>
              <div class="box-footer">
                <button type="submit" class="btn btn-default">Cancel</button>
                <button type="submit" class="btn btn-info pull-right" data-target=".bs-example-modal-sm" onclick="return submitDevice();">Sign in</button>
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
