<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>Cart</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {
			
			loadCartContent();
});

function loadCartContent() {
	$(".cartcontent").load("${pageContext.request.contextPath}/cart/cartContent"+location.search);
}

function addOrder(id,glyph){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url : "${pageContext.request.contextPath}/cart/addOrder",
		type : "POST",
		data:{
			prodId:id
		},
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
			removeDivOrder(glyph);
		}
	}); 
}

function canselOrder(id,glyph){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url : "${pageContext.request.contextPath}/cart/processCart",
		data:{
			id:id
		},
		type : "POST",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
			removeDivOrder(glyph);
		}
	}); 
}

function removeDivOrder(glyph) {
	var div=$(glyph).parent().parent().parent();
	var hr=$(div).next();
	$(div).hide('fast');
	$(hr).hide('fast',function(){
		loadCartContent();
	});
}
</script>
<style>

body {
background:#dbdbdb;
}

.cartcontent {
background:#f2f2f2;
border: 1px solid white;
padding:5%;
font-size:18px;
margin-bottom:50px;
}

.cartrow {
padding-top:19px;
height:70px;
}

span {
font-size:35px;
}
span:hover {
cursor:pointer;
}
hr.soften {
  height: 1px;
  background-image: -webkit-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:    -moz-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:     -ms-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:      -o-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  border: 0;
}
</style>
</head>
<body>
<jsp:include page="include/header.jsp" />
<h1>
	CART!  
</h1>
<div id="wrap">
<div class='row cartcontent'>

</div>
</div>
<jsp:include page="include/footer.jsp" />

</body>
</html>
