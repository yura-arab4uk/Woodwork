<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>
$(document).ready(
		
		function() {
			createUserTable();
			checkBox();
			setSearchUForm();
			onEnterUForm();
});

function setSearchUForm() {
	var q="${q}";
	var order="${order}";
	$("#formSUser div input[name=q]").val(q);
	$("#formSUser select [value="+order+"]").attr("selected","selected");
}

function onEnterUForm() {
	$('#formSUser div input[name=q]').keypress(function (e) {
		  if (e.which == 13) {
			  searchUser();
		    return false;    //<---- Add this line
		  }
		});
}

function enabledUser(enabled) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var en=$(enabled).val();
	var editId=$(enabled).parent().parent().parent().next().children('button').attr('id');
	var posOfUserInArr=editId.substring(4);
	var users=${users};
	var userId=users[posOfUserInArr].id;
	 $.ajax({
		url : "admin/activateUser?id=" + userId + "&enabled=" + en,
		type : "PUT",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
		}
	}); 
}

function createUserTable() {
	var users=${users};
	var fields = ['email', 'login', 'phone_number', 'firstname', 'lastname','enabled'];
	
	var i=0;
	   $.each(users,function(index,user){
		var div = $('<div class="row"></div>');
		var	divcol=$('<div class="col-sm-10"></div>');
		$(div).append(divcol);
		for (var k of fields) {
			var divcol1=$('<div class="col-sm-2 userrow"></div>');
			if (k=='enabled') $(divcol1).append('<input onchange="enabledUser(this)" type="checkbox" checked=true class="input-20a" value="'+user[k]+'" data-three-state="false" size="lg">');
			else if (k!='phone_number') $(divcol1).text(user[k]);
			else $(divcol1).text('+380 '+user[k]);
			$(divcol).append(divcol1);
		}
		
		divcol=$('<div class="col-sm-1  userrow"></div>')
		$(divcol).append('<button onclick="fillEditForm(this)" id=user'+i+' type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">Edit</button>');
		$(div).append(divcol);
		$('#users').append(div);
		i++;
	}); 
	
	  
	
}

function editSubmit() {
		$('#formUser').submit();
}

function searchUser() {
	var $sInput=$("#formSUser div input[name=q]");
	var q=$sInput.val();
	var order=$('#formSUser select[name=order]').val();
	if (q!='') {
		adminUrl = addParameter(adminUrl,'q',q);
		adminUrl = addParameter(adminUrl,'order',order);
		loadAdmContent();
	}
	else $sInput.focus();
	
	
}

function fillEditForm(userButton) {
	var users=${users};
	var index=$(userButton).attr('id').substring(4);
	var user=users[index];
	$('#id').attr("value",user.id);
	$('#ema').attr("value",user.email);
	$('#log').attr("value",user.login);
	$('#pho').attr("value",user.phone_number);
	$('#fir').attr("value",user.firstname);
	$('#las').attr("value",user.lastname);
}

</script>
<style>

#users {
padding-top:3%;
padding-left:3%;
padding-bottom:3%;
}
.userrow {
padding-top:15px;
height:50px;
}
</style>
<div class="text-center">
<form id="formSUser" class="form-inline" method="GET">
        <div class="form-group">
          <input name="q" type="text" class="form-control" placeholder="Search">
        </div>
        <select name="order" class="form-control">
<option value="firstname">by first name</option>
<option value="lastname">by last name</option>
<option value="login">by login</option>
</select>
<button onclick="searchUser()" type="button" class="btn btn-default">GO</button>
      </form>
</div> 
<div class="row" id="users">
<c:if test="${not empty users}">
<div class="row">
<div class="col-sm-10">
<div class="col-sm-2">
<b>Email</b>
</div>
<div class="col-sm-2">
<b>Login</b>
</div>
<div class="col-sm-2">
<b>Phone number</b>
</div>
<div class="col-sm-2">
<b>First name</b>
</div>
<div class="col-sm-2">
<b>Last name</b>
</div>
<div class="col-sm-2">
<b>Active status</b>
</div>
</div>
</div>
</c:if>

</div>



<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Edit user</h4>
        </div>
        <div class="modal-body">
   
        <form id="formUser" action="admin/editUser" method="post">
							<input id="id" type="hidden" class="form-control" name="id"/>
						    <label class="control-label" for="ema">Email:</label>
							<input class="form-control" id="ema" name="email"/>
							<label class="control-label" for="log">Login:</label>
							<input class="form-control" id="log" name="login"/>
							<label class="control-label" for="pho">Phone number:</label>
							<input class="form-control" id="pho" name="phone_number"/>
							<label class="control-label" for="fir">First name:</label>
							<input class="form-control" id="fir" name="firstname"/>
							<label class="control-label" for="las">Last name:</label>
							<input class="form-control" id="las" name="lastname"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
        </div>
        <div class="modal-footer">
          <button onclick="editSubmit()" type="button" class="btn btn-default" data-dismiss="modal">Save</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
<jsp:include page="include/pagination.jsp"></jsp:include>