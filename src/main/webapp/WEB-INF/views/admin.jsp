<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/checkbox-x.min.css" media="all" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/checkbox-x.min.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Admin</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {
			onClickNavPills();
			loadEditUser();
			
});
var adminUrl;


function checkBox() {
	$(".input-20a").checkboxX({
	    //enclosedLabel: true,
	    iconChecked: "<b>&check;</b>",
	    iconUnchecked: "<b>X</b>",
	});
}

function onClickNavPills() {
	$('li[role=presentation]').on( "click", function() {
		$(".admcontent").html('');
		$('li[role=presentation]').removeClass('active');
		  $( this ).addClass('active');
	
});
}

function loadAdmContent(){
$(".admcontent").load(adminUrl);
}

function loadEditUser(){
adminUrl ='${pageContext.request.contextPath}/admin/editUserView';
loadAdmContent();
}

function loadEditCategory(){
adminUrl ='${pageContext.request.contextPath}/admin/editCategoryView';
loadAdmContent();
}

function loadEditProperty(){
adminUrl ='${pageContext.request.contextPath}/admin/editPropertyView';
loadAdmContent();
}

function loadAddProduct(){
adminUrl ='${pageContext.request.contextPath}/admin/addProductView';
loadAdmContent();
}
</script>
<style>

body {
background:#dbdbdb;
}

.head,.admcontent {
background:#f2f2f2;
border: 1px solid white;
}

</style>
</head>
<body>
<jsp:include page="include/header.jsp" />
<h1>
	ADMIN PROFILE!  
</h1>
<div id="wrap">
<div class='container'>
<div class='row'>
<div class='row head'>
<div class='col-sm-6'>
<div class='col-sm-offset-1'>
<ul class="nav nav-pills">
  <li role="presentation" class="active"><a onclick='loadEditUser()' href="javascript:void(0)">Edit user</a></li>
  <li role="presentation"><a onclick='loadEditCategory()' href="javascript:void(0)">Edit category</a></li>
  <li role="presentation"><a onclick='loadEditProperty()' href="javascript:void(0)">Edit property</a></li>
  <li role="presentation"><a onclick='loadAddProduct()' href="javascript:void(0)">Add item</a></li>
</ul>
</div>
</div>
</div>
<div class='row admcontent'>

</div>
</div>
</div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
