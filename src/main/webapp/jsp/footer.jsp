<footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.0
    </div>
    <strong>Copyright &copy; 2016-2018 <a href="#">Acquiro</a>.</strong> All rights
    reserved.
  </footer>
</div>   

<!-- Started in sidebar <div class="wrapper"> -->

<script src="resources/bower_components/jquery/dist/jquery.min.js"></script>
<script src="resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="resources/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="resources/bower_components/chart.js/Chart.js"></script>
<script src="resources/dist/js/homepagecharts.js"></script>
<script src="resources/dist/js/adminlte.min.js"></script>
<script src="resources/dist/js/custom.js"></script>
<!-- 
<script>
 $(document).ready(function () {
	<c:if var="msg" test="${message!=null}">
		alert('<c:out value="${message}" />');
	</c:if>
	<c:if var="pg" test="${page!=null&&page!=''}">
		$("#pageNo").val('<c:out value="${page}" />');
	</c:if>
	<c:if var="searchtx" test="${searchText!=null&&searchText!=''}">
		$("#searchAll").val('<c:out value="${searchText}" />');
	</c:if>
	
	<c:if var="lct" test="${location!=null&&location!=''}">	
		$("#storeLocation").val('<c:out value="${location}" />');
	</c:if>

	<c:if var="lct" test="${totalRows!=null&&totalRows!=''}">		
		$("#totRows").val('<c:out value="${totalRows}" />');
	</c:if>
	
	$("#pageNo").change(function(){
		var pageNo = $("#pageNo").val();
		if(pageNo!=null&&pageNo!=""){
			document.body.innerHTML += '<form id="pageForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+pageNo+' /></form>';
			document.getElementById("pageForm").submit();
		}
	});	
	$("#first").click(function () {
		var page=1;
		$("#pageNo").val(page);
		var location = $("#storeLocation").val();	
		document.body.innerHTML += '<form id="firstForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value="1" /></form>';
		document.getElementById("firstForm").submit();	
	});
	$("#previous").click(function () {
		var page=$("#pageNo").val();
		if(page>1){
			$("#pageNo").val(page-1);
		}
		var previousPage=$("#pageNo").val();
	
		document.body.innerHTML += '<form id="previousForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+previousPage+' /></form>';
		document.getElementById("previousForm").submit();		
	});
	$("#next").click(function () {
		var page=parseInt($("#pageNo").val());
		var lastPage=$("#totRows").val();
		if(page<lastPage){
			$("#pageNo").val(page+1);
		}
		var nextPage=parseInt($("#pageNo").val());		
		document.body.innerHTML += '<form id="nextForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+nextPage+' /></form>';
		document.getElementById("nextForm").submit();
		
	});
	$("#last").click(function () {
		var lastPage=$("#totRows").val();
		/*if(page=100){
			$("#pageNo").val(page);
		}
		var lastPage=parseInt($("#pageNo").val());	*/
		document.body.innerHTML += '<form id="lastForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+lastPage+' /></form>';
				
		//document.body.innerHTML += '<form id="lastForm" action="<c:url value='walletList' />"><input type="hidden" name="page" value='+lastPage+' /></form>';
		document.getElementById("lastForm").submit();
	});

	$("#buttonClass").click(function() {
	    getValueUsingClass();
	});
		
});
</script> -->
</body>
</html>