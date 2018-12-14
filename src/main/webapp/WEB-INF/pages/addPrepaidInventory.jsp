<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<script type="text/javascript">
function submitDevice(){
	$("#modal-body").html("<h2>In Process</h2>");

	var kitNo=$("#kitNo").val();
	var cardNo=$("#cardNo").val();
	var cardType=$("#cardType").val();
	var status=$("#status").val();
	

	if(kitNo==null||kitNo==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter kit No</p>');
		return false;
	}else if(kitNo.length<2||kitNo.length>40){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Kit No</p></n>Length should be min 2 and max 40 char');
		return false;
	}else if(cardNo==null||cardNo==''){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Terminal Card No</p></n>Length should be min 8 and max 17 char');
		return false;
	}else if(cardNo.length<8||cardNo.length>20){
		$("#modal-body").html('<h2>Validation Error</h2><p>Enter Correct Terminal Card No</p></n>Length should be min 8 and max 17 char');
		return false;
	}
	else if(cardType==null||cardType==""){
		$("#modal-body").html('<h2>Validation Error</h2><p>Select Status</p>');
		return false;
	}
	var sendvalue={
			kitNo:kitNo,
			cardNo:cardNo,
			cardType:cardType,
			status:status
			
			 }
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                    $("#modal-body").html("<h2>Prepaid Inventory Added Successfully</h2>");  
                    $("#kitNo").val('');$("#cardNo").val('');
                    $("#tid").val('');$("#cardType").val("Available");
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
            url: "addPrepaidInventory",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}



function getorg(){
    	 var merchantId = $("#merchantId").val();
    	 document.location.href = "?merchantId="+merchantId+"";
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
              <h3 class="box-title">Add Prepaid Inventory</h3>
            </div>
            <form role="form">
              <div class="box-body">
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Card No.</label>
                      <input type="text" class="form-control input-lg" id="cardNo" placeholder="Enter Card No">
                    </div>
                  </div> 
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Kit No</label>
                      <input type="text" class="form-control input-lg" id="kitNo" placeholder="Enter kitNo">
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Card Type</label>
                      <select data-clear-btn="true" name="cardType" id="cardType" required="true" class="form-control input-lg">
            										<option value="0"> Select</option>
            										<option value="1"> NFC/CHIP&MAG CARD</option>
            										<option value="2"> CHIP CARD</option>
            										<option value="3"> MAG CARD</option>
            										<option value="4"> OTHERS</option>
            		  </select>
            		</div>
                  </div>
                 
                  <div class="col-md-1">&nbsp;</div>
                  <div class="col-md-5">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Status</label>
                       <select data-clear-btn="true" name="status"
											id="status" required="true" class="form-control input-lg">
											<option value="Active"> Active</option>
											<option value="Unavailable"> Unavailable</option>
											<option value="Damaged">Damaged</option>
											<option value="Internaluse">Internal Use</option>
											<option value="Activated">Activated</option>
											</select>  
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
