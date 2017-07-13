<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/limittext.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>Sign up</title>
<script>
$(document).ready(function(){
(function() {
		
	    var app = {
	         
	        initialize : function () {
	            this.setUpListeners();
	        },
	 
	        setUpListeners: function () {
	            $('form').on('click','input[type="submit"]', app.submitForm);
	            $('form').on('input', '.check', app.removeError);
	            $('form').on('focus', '[type=password]', app.removeErrorPass);
	            $('form').on('keydown', 'input[name="phone_number"]', app.onlydigits);
	            $('form').on('blur', 'input[name="email"]', app.validateemail);
	            $('form').on('blur', 'input[name="login"]', app.validatelogin);
	            $('form').on('blur', 'input[type="password"]', app.matchPasswords);
	        },
	        
	        submitForm: function (e) {
	            var form = $(this).parent().parent();
	            form.children().children('input[name="firstname"]').focus();
	            if( app.validateForm(form) === false )  return false;
	            form.submit();
	        },
	 
	        validateForm: function (form){
	        	
	        	 var valid = true;
	        	 var email=form.children().children('input[name="email"]');
	        	 var login=form.children().children('input[name="login"]');
	        	 if (email.hasClass('has-error')||login.hasClass('has-error')) valid=false;
	        	 var inputs = form.find('.check');
	                $.each(inputs, function(index, val) {
	                    var input = $(val);
	                        val = input.val();
	                        var message="Заповніть поле "+$("label[for='"+$(input).attr('name')+"']").text().toLowerCase().slice(0,-1);
	                    if(val.length === 0){
	                    	input.addClass('has-error').removeClass('has-success');
	                    	$(input).parents('.data').next('.error').html(message);
	                    	valid = false;
	                    }else{
	                    	if(input.hasClass('has-error')==true) ;
	                    	else input.addClass('has-success').removeClass('has-error');
	                    }
	                });
	            return valid;
	        },
	       
	        removeErrorPass: function () {
	        	$('input[type=password]').removeClass('has-error').removeClass('has-success').parents('.data').next('.error').html('');
	        },
	       
	        removeError: function () {
	        	$(this).removeClass('has-error');
	        	$(this).parents('.data').next('.error').html('');
	        },
	        
	        onlydigits: function(e) {
	    		var key = e.charCode || e.keyCode || 0;
	    		return ((    key == 8 || 
		                key == 9 ||
		                key == 46 ||
		                key == 107 ||
		                key == 187 ||
		                (key >= 37 && key <= 40)) ||
		               ( (key >= 48 && key <= 57) ||
		                (key >= 96 && key <= 105)));
	    	},
	    	
	    	validateemail: function(){
                 var email=$(this);
                 var emailval=email.val();
	        	 if (emailval.length>0)
        		 {
	    		var pattern = /^(([a-zA-Z0-9]|[!#$%\*\/\?\|^\{\}`~&'\+=-_])+\.)*([a-zA-Z0-9]|[!#$%\*\/\?\|^\{\}`~&'\+=-_])+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9-]+$/;
	            if(pattern.test($(email).val())) app.thesameemail(email);
	            	else 
	            		{
	            		email.removeClass('has-success').addClass('has-error').parents('.data').next('.error').html("Невірна електронна пошта");
	            		return;
	            		}
        		 }
	         },
	         
	         thesameemail: function(email){
	        	 var emailval=email.val();
	        		 	        		 
	        	 var token = $("meta[name='_csrf']").attr("content");
	        		var header = $("meta[name='_csrf_header']").attr("content");
	        			$
	        					.ajax({
	        						url : 'isEmailFree',
	        						type : "POST",
	        						data : {
	        							email : emailval,
	        						},
	        						async:false,
	        						dataType : "json",
	        						cache : false,
	        						beforeSend : function(xhr) {
	        							xhr.setRequestHeader(header, token);
	        						},
	        						success : function(jsonstring) {
	        							if (jsonstring.status) email.removeClass('has-success').addClass('has-error').parents('.data').next('.error').html("Така електронна пошта вже існує");
	        						}
	        					});
	                  
	        	 
	        	 
	         },
	         
	         validatelogin: function(){
	        	 var login=$(this);
	        	 var loginval=login.val();
	        		 	        		 
	        	 var token = $("meta[name='_csrf']").attr("content");
	        		var header = $("meta[name='_csrf_header']").attr("content");
	        			$
	        					.ajax({
	        						url : 'isLoginFree',
	        						type : "POST",
	        						data : {
	        							login : loginval,
	        						},
	        						async:false,
	        						dataType : "json",
	        						cache : false,
	        						beforeSend : function(xhr) {
	        							xhr.setRequestHeader(header, token);
	        						},
	        						success : function(jsonstring) {
	        							if (jsonstring.status) login.removeClass('has-success').addClass('has-error').parents('.data').next('.error').html("Такий логін вже існує");
	        						}
	        					});
	                  
	        	 
	        	 
	         },
	         
	         matchPasswords: function () {
		        	var pass1=$('input[name=password1]').val();
		        	var pass2=$('input[name=password]').val();
		        	if (pass1.length>0&&pass2.length>0) {
		        		if (pass1!==pass2) {
		        			$('input[type=password]').removeClass('has-success').addClass('has-error').parents('.data').next('.error').html("Пароль не співпадає");
		        		}
		        	}
		        },
	         
	    }

	    app.initialize();
	 
	}());
});
</script>
<style>

body {
    background-color: #eee;
}

.error {
	display:block;
	//padding: 8px;
	margin-top:-10px;
	//margin-bottom: 8px;
	//border: 1px solid transparent;
	border-radius: 4px;
	color: #d94442;
	background-color: #f2dede;
	//border-color: #ebccd1;
	text-align:center;
}  
.has-success {
	background-color:#D9FFC9;
	border-color: #b1e98d;
}

.has-error {
	background-color:#FFD9D1;
	border-color: #ef8383;
}
</style>
</head>
<body>
		<jsp:include page="include/header.jsp"/>
		

				<c:url value="/registration" var="regUrl" />
<div id="wrap">	
<div class="row">	
<h1 class="text-center">Введіть необхідні дані для реєстрації:</h1>
<br/>
		<div class="col-sm-4 col-sm-offset-4">
	<form:form id="form1" class="form" action="register" method="POST"
						commandName="user">
						
						<div class="form-group data">
							<label class="control-label" for="firstname">First name:</label>
							<form:input  class="form-control check" path="firstname" oninput="limittext(this,45)"/>
						</div>
						<div class="error">
							<form:errors path="firstname"/>
						</div>
						
						<div class="form-group data">
							<label class="control-label" for="lastname">Last name:</label>
							<form:input class="form-control check" path="lastname" oninput="limittext(this,45)"/>
						</div>
						<div class="error">
							<form:errors path="lastname"/>
						</div>
						
						<div class="form-group data">
							<label class="control-label" for="login">Login:</label>
							<form:input class="form-control check" path="login" oninput="limittext(this,45)"/>
						</div>
						<div class="error">
							<form:errors path="login"/>
						</div>
						
						<div class="form-group data">
							<label class="control-label" for="email">Email:</label>
							<form:input class="form-control check" path="email" oninput="limittext(this,45)"/>
						</div>
						<div class="error">
							<form:errors path="email"/>
						</div>	
						
						<div class="form-group data">					
							<label class="control-label" for="password1">Password:</label>
							<input type="password" class="form-control check" name="password1" oninput="limittext(this,45)"/>
						</div>
						<div class="error">
						</div>						
						
						<div class="form-group data">
							<label class="control-label" for="password">Password again:</label>
							<form:input type="password" class="form-control check" path="password" oninput="limittext(this,45)"/>
						</div>
						<div class="error">
							<form:errors path="password"/>
						</div>
						
						<div class="form-group data">
							<label class="control-label" for="phone_number">Phone number:</label>
							<form:input autocomplete="false" class="form-control check" path="phone_number" placeholder="0XXXXXXXXX" oninput="limittext(this,10)"/>
						</div>
						<div class="error">
							<form:errors path="phone_number"/>
						</div>	
											
						<div class="form-group pull-right">
							<input class="btn btn-success" type="submit" value="Registration" />
						</div>
					</form:form>
</div>
</div>	
</div>	
<jsp:include page="include/footer.jsp" />
</body>
</html>