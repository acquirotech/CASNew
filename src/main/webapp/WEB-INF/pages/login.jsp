<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<c:if test="${pageContext.request.userPrincipal.name != null}">
  <% response.sendRedirect("welcome");%>
</c:if>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Acquiro-Central Acquiring System </title>

    <!-- Bootstrap core CSS -->

    <link href="resources/css/bootstrap.min.css" rel="stylesheet">

    <link href="resources/fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="resources/css/animate.min.css" rel="stylesheet">

    <!-- Custom styling plus plugins -->
    <link href="resources/css/custom.min.css" rel="stylesheet">
    <link href="resources/css/icheck/flat/green.css" rel="stylesheet">
   <script src="resources/js/jquery.min.js"></script>
   <script type="text/javascript">
$(document).ready(function (){
	<c:if var="msg1" test="${status!=null}">
		alert('<c:out value="${status}" />');
	</c:if>
	<c:if var="msg1" test="${status!=null&&status=='Not Found'}">
	alert('Admin not found');
</c:if>

$("#changePassword").click(function () {
	document.body.innerHTML += '<form id="firstForm" action="<c:url value='changeAdminPassword' />"></form>';
	document.getElementById("firstForm").submit();	
});
$( "#loginForm" ).submit(function( event ) {
	  var username = $("#username").val();
		var password = $("#password").val();
	    if(username==null||username==""){
	    	alert('Enter User Name');
			return false;
		}else if(username.length<2||username.length>60){
			alert('Enter Correct User Name');
			return false;
		}
		else if(password==null||password==""){
			alert('Enter Password');
			return false;
		}else if(password.length<2||password.length>60){
			alert('Enter Correct Password');
			return false;
		}
	});
});
</script>
</head>
<body class="login"> 
    <div class="">
        <a class="hiddenanchor" id="tologin"></a>      
  <div class="login_wrapper">
      
        <div class="animate form login_form">
          <section class="login_content">
                	<c:if test="${not empty error}">
            			<div class="alert alert-danger alert-dismissible fade in" role="alert"> ${error} </div>
        			</c:if>
			        <c:if test="${not empty msg}">
			            <div class="msg">${msg}</div>
			        </c:if>
                   <form name='loginForm' id="loginForm"  action="<c:url value='j_spring_security_check' />" method='POST'>
                         <img src="resources/images/acquiro-logo.png" alt="" class="login-logo">
                        <div>
                            <input type="text" class="form-control u-name" placeholder="Username" name="username" id="username" />              
                        </div>
                        <div>
                            <input type="password" class="form-control login-password" placeholder="Password" name="password" id="password"  />
                            
                        </div>                       
                        <div>
                           <input name="submit" class="btn btn-default submit" type="submit" value="submit" />
                           <input name="button" class="reset_pass" id="changePassword" style="display: none;" value="Forgot Password" />
                         </div>
                        <div class="clearfix"></div>
                     <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />   
                    </form>
                    <!-- form -->
                </section>
                <!-- content -->
            </div>
          
        </div>
        <div class="copyright">
           ©2018 Acquiro Payments. All Rights Reserved
              
            </div>
    </div>

</body>

</html>