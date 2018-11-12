$(document).ready(function($) {
	
	$("#UpdateMerchantDetails").click(function(event) {
		alert("api call for update");

	});

	$("#AddOrgSub").click(function(event) {
		alert("api call for add org for "+$("#AddOrgMid").val());
		$("#DivOrg").append('<div class="ui-corner-all custom-corners" style="margin-bottom:1%"><div class="ui-bar ui-bar-a"><h3>Organisation 2</h3></div><div class="ui-body ui-body-a"><div data-demo-html="true"><div data-role="tabs" id="tabssssssssss"><div data-role="navbar"><ul><li><a href="#onesss" data-ajax="false" class="ui-link ui-btn ui-tabs-anchor ui-btn-active">Devices</a></li><li><a href="#twosssss" data-ajax="false">Details</a></li></ul> </div><div id="onesss"> <div data-demo-html="true" data-demo-css="true"> <br><table data-role="table" id="movie-table-custom" data-mode="reflow" class="movie-list ui-responsive"> <thead> <tr> <th data-priority="1">Serial No</th> <th style="width:40%">Mac Address</th> <th data-priority="2">TID</th> <th data-priority="3">User</th> <th data-priority="4">Rent</th> <th data-priority="4">Action</th> </tr></thead> <tbody> </tbody> </table> <div class="ui-grid-c"> <div class="ui-block-a"><a href="#" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b ui-first-child">Add New Device </a></div><div class="ui-block-b"></div><div class="ui-block-c"></div></div></div></div><div id="twosssss" class="ui-body-d ui-content"> <div data-demo-html="true"> <form> <div class="ui-grid-solo ui-bar ui-bar-a"> <label for="text-3">Labels</label> <input type="text" data-clear-btn="true" name="text-3" id="text-3" value="dsdffsdf"> </div><div class="ui-grid-solo ui-bar"> <label for="text-3">Labels</label> <input type="text" data-clear-btn="true" name="text-3" id="text-3" value=""> </div><div class="ui-grid-solo ui-bar ui-bar-a"> <label for="text-3">Labels</label> <input type="text" data-clear-btn="true" name="text-3" id="text-3" value=""> </div><div class="ui-grid-solo ui-bar"> <label for="text-3">Labels</label> <input type="text" data-clear-btn="true" name="text-3" id="text-3" value=""> </div><div class="ui-grid-solo ui-bar ui-bar-a"> <label for="text-3">Labels</label> <input type="text" data-clear-btn="true" name="text-3" id="text-3" value=""> </div><div class="ui-grid-solo ui-bar"> <label for="text-3">Labels</label> <input type="text" data-clear-btn="true" name="text-3" id="text-3" value=""> </div><div class="ui-grid-solo ui-bar"> <button type="submit" class="ui-btn ui-corner-all ui-shadow ui-btn-b ui-btn-icon-left ui-icon-check">Add</button> </div></form> </div></div></div></div></div></div>');
		$('#DivOrg').listview('refresh');
		return false;


	});



});