<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/header.jsp" />

<script type="text/javascript">
function callMe(){
	var sendvalue={servervalue:'abcde'}
	var opts = {
            type: "POST",
            success: function (data) {
                $(".loading").css("visibility","hidden");
                if (data.status == 0&&data.message=='OK') {
                	$('#todayMerchantCnt').text(''+(data.result.todayMerchantBoarded));
                	$('#monthlyMerchantCnt').text(''+(data.result.monthlyMchntBoarded));
                	$('#totalnoOfMerchant').text(''+(data.result.totalnoOfMerchant));
                }else if (data.status==101&&data.message=='Not Found') {
                	$("#modal-body").html("<h2> "+data.message+"</h2>");
                	//$("#email").val('');
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
            url: "merchantBoarded",
            data: sendvalue
        }; 
        $.ajax(opts);
        return false;
}
function callMeToday(){
	var sendvalue={servervalue:'abcde'}
	var opts = {
    	type: "POST",
        	success: function (data) {
            $(".loading").css("visibility","hidden");
            if (data.status == 0&&data.message=='OK') {
                $('#todayTxnCount').text(''+(data.result.todayTxnCount));
                $('#todaySales').text(''+(data.result.todaySales));
                $('#todayMdr').text(''+(data.result.todayMdr));
                $('#todayCommission').text(''+(data.result.todayCommission));
           	}else if (data.status==101&&data.message=='Not Found') {   	
               	$("#modal-body").html("<h2> "+data.message+"</h2>"); 
               	//$("#email").val('');
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
        url: "todayActivities",
        data: sendvalue
	}; 
        $.ajax(opts);
        return false;
}
function callMeMonthly(){
	var sendvalue={servervalue:'abcde'}
	var opts = {
    	type: "POST",
        	success: function (data) {
            $(".loading").css("visibility","hidden");
            if (data.status == 0&&data.message=='OK') {
            	$('#averageTicketSize').text(''+(data.result.monthlyTxnGMV));
                $('#monthlyTxnCount').text(''+(data.result.monthlyTxnCount));
                $('#monthlyTxnSales').text(''+(data.result.monthlyTxnSales));
                $('#monthlyTxnMdr').text(''+(data.result.monthlyTxnMdr));
                $('#monthlyTxnCommission').text(''+(data.result.monthlyTxnCommission));
           	}else if (data.status==101&&data.message=='Not Found') {   	
               	$("#modal-body").html("<h2> "+data.message+"</h2>"); 
               	//$("#email").val('');
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
        url: "monthlyActivities",
        data: sendvalue
	};
        $.ajax(opts);
        return false;
}
</script>
              <!-- page content -->
            <div class="right_col" role="main">
              <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="dashboard_graph">
                            <div class="row x_title">
                                <div class="col-md-12">
                                    <h3>Monthly Activities<small>(Merchant Boarded)<span style="cursor: pointer; cursor: hand;" onclick="return callMe();"> Refresh</span></small></h3>
                                </div>
                            </div>

                            <div class="col-md-12 col-sm-12 col-xs-12">
                             	<div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
			                        <div class="left"></div>
			                        <div class="right">
	                            		<span class="count_top"><i class="fa fa-user"></i> Average Ticket Size</span>
	                            		<div class="count" id="averageTicketSize">${monthlyTxnGMV}</div>
                          			</div>
                    			</div>
                    			<div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        			<div class="left"></div>
                        			<div class="right">
                            		<span class="count_top"><i class="fa fa-clock-o"></i> No. of Merchants Boarded <small>(Today)</small></span>
                            		<div class="count" id="todayMerchantCnt">${todayMerchantBoarded}</div>
                         	   		</div>
                    			</div>
			                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
			                        <div class="left"></div>
			                        <div class="right">
			                            <span class="count_top"><i class="fa fa-user"></i> No. of Merchants Boarded </span>
			                            <div class="count" id="monthlyMerchantCnt">${monthlyMchntBoarded}</div>
			                            </div>
					            </div>
		                    	 <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
		                       		<div class="left"></div>
		                        	<div class="right">
		                            <span class="count_top"><i class="fa fa-user"></i> Total Merchants Boarded </span>
		                            <div class="count" id="totalnoOfMerchant">${totalnoOfMerchant}</div>
		                            </div>
		                    	</div>
              </div>
                <div class="clearfix"></div>
                        </div>
                    </div>

                </div>
             <br />
  <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="dashboard_graph">

                            <div class="row x_title">
                                <div class="col-md-12">
                                    <h3>Today's Activities<small>(Transaction) <span style="cursor: pointer; cursor: hand;" onclick="return callMeToday();"> Refresh</span></small></h3>
                                </div>
                            </div>

                            <div class="col-md-12 col-sm-12 col-xs-12">

                             <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Transaction Count</span>
                            <div class="count" id="todayTxnCount">${todayTxnCount}</div>
                          
                        </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Transaction Sales</span>
                            <div class="count" id="todaySales"> ${todaySales}</div>
                          </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Transaction MDR </span>
                            <div class="count" id="todayMdr">${todayMdr}</div>
                            </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Transaction Commission</span>
                            <div class="count" id="todayCommission">${todayCommission}</div>
                          </div>
                    </div>   
                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
           <br />
             <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="dashboard_graph">

                            <div class="row x_title">
                                <div class="col-md-12">
                                   <h3>Monthly Activities<small>(Transaction)<span style="cursor: pointer; cursor: hand;" onclick="return callMeMonthly();"> Refresh</span></small></h3>
                                </div>
                            </div>

                            <div class="col-md-12 col-sm-12 col-xs-12">

                             <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Transaction Count</span>
                            <div class="count" id="monthlyTxnCount">${monthlyTxnCount}</div>
                          
                        </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Transaction Sales</span>
                            <div class="count" id="monthlyTxnSales"> ${monthlyTxnSales}</div>
                          </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Transaction MDR </span>
                            <div class="count" id="monthlyTxnMdr">${monthlyTxnMdr}</div>
                            </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Transaction Commission</span>
                            <div class="count" id="monthlyTxnCommission">${monthlyTxnCommission}</div>
                          </div>
                    </div>   
                            </div>
                              <div class="clearfix"></div>
                        </div>
                    </div>

                </div>
                <br />
<jsp:include page="/jsp/footer.jsp" />