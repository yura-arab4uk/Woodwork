<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>Product</title>
<script>
$(document).ready(function(){
	createButtonCart();
});

function createButtonCart() {
	var button=$('<button style="display:none" id="del" onclick="processCart()" class="btn btn-success change">Delete from cart</button>');
	$('.div-btn').append(button);
	button=$(button).clone();
	$(button).attr('id','add').text('Add to cart');
	$('.div-btn').append(button);
	var visibleB;
	if ("${cart[product.id]}"!='') visibleB=$('#del');
	else visibleB=$('#add');
	$(visibleB).css('display','block');
}

function processCart() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$('button.change:visible').text('Processing...');
	$.ajax({
		url : "${pageContext.request.contextPath}/cart/processCart",
		data:{
			id:"${product.id}",
			name:"${product.name}",
			price:"${product.price}",
			image:"${product.image}"
		},
		type : "POST",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
			var del=$('#del');
			var add=$('#add');
			$(del).text('Delete from cart');
			$(add).text('Add to cart');
			if ($(del).css('display')=='none') 
				{
				$(del).css('display','block');
				$(add).css('display','none');
				}
			else {
				$(del).css('display','none');
				$(add).css('display','block');
			}
				
			
		}
	}); 
}
</script>
<style>
body {
background: #dbdbdb;
}

.image {
height:300px;
}

hr.vertical {
  height: 250px;
  width:1px;
  background-image: -webkit-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:    -moz-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:     -ms-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:      -o-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  border: 0;
}

.name {
font-size:20px;
background:#f2f2f2;
margin-bottom:30px;
}

hr.soften {
  height: 1px;
  background-image: -webkit-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:    -moz-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:     -ms-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  background-image:      -o-linear-gradient(left, rgba(0,0,0,0), rgba(0,0,0,.8), rgba(0,0,0,0));
  border: 0;
}

.div-btn {
margin-top:30px;
}
</style>
</head>
<body>
<jsp:include page="include/header.jsp"/>
<h1>
	PRODUCT  
</h1>
<jsp:include page="include/breadcrumb.jsp"/>
<div id="wrap">
<div style="font-size:17px;margin-top:100px;" class="container">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<div class="col-sm-4 image">
<img src="<%=request.getContextPath()%>/resources/img/<c:out value="${product.image}" />"
					alt="oops" width="100%" height="100%">
</div>
<div class="col-sm-1">
<hr class="vertical">
</div>
<div class="col-sm-7 content">
<div class="row name"><c:out value="${product.name}" /></div>
<div class="row">
<div class="col-sm-3">Price:</div>
<div class="col-sm-9 text-right"><c:out value="${product.price}" /></div>
</div>
<hr class="soften">
<div class="row">
<div class="col-sm-3">Condition:</div>
<div class="col-sm-9 text-right"><c:out value="${product.condition}" /></div>
</div>
<c:forEach items="${product.listPPI}" var="PPI">
<hr class="soften">
<div class="row">
<div class="col-sm-3"><c:out value="${PPI.property.name}"/>:</div>
<div class="col-sm-9 text-right"><c:out value="${PPI.value_as_string}"/></div>
</div>
</c:forEach>
 <sec:authorize access="isAuthenticated()">
<div class="row div-btn pull-right"></div>
 </sec:authorize>
</div>
</div>
</div>
<div style="margin-top:40px;" class="row">
<div style="border: 1px solid grey;" class="col-sm-10 col-sm-offset-1">
<div style="background:#f2f2f2" class="row text-center">Description</div>
<div style="background:white;padding:5px;" class="row">${product.description}</div>
</div>
</div>
</div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>