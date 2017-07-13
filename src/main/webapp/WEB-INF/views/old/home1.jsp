<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Home</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {

			$.ajax({
				url : 'ajax/categories',
				type : "POST",
				//	contentType: "application/json; charset=UTF-8",
				data : {
					
				},
				dataType : "json",
				cache : false,
				
				success : function(dataJson) {
					alert(dataJson);
					
				}
				
			});
			
		});

function loadData() {
	$('#secondpane :first').remove();
	//$('.lots :first').html('');
	//$('.lots :first').empty();
	$.ajax({
		url : '/Woodwork/home1',
		type : "GET",
		//	contentType: "application/json; charset=UTF-8",
		
		
		cache : false,
		
		success : function(data) {
			
			window.location.reload();
		}
	});
}
</script>
<style>
body {
background: #a7e085;
}
.menu_head {
color:white;
background: #308040;
margin-left:-3px;
    font-size:20px;
    display:inline-block;
    height: 100px;
    width: 140px;
    cursor:pointer; 
    transition: 300ms;
}
.menu_head:hover {
background: #bdd;
    color:blue;
}
p {
font-size:20px;
}
.list1 {
text-align:center;
}
.list2 {
margin-top:100px;
}
.lots {
color:white;
background: #808040;
margin-left:-3px;
    font-size:20px;
    display:inline-block;
    height: 300px;
    width: 300px;
    cursor:pointer; 
    transition: 300ms;
}


.lots:hover
{
    background: #fff;
    color:#527881;
}
</style>
</head>
<body>
<h1>
	Hot deals!  
</h1>
<input onclick="loadData()" type="button" value="supertest"/>
<div style="color:red;" id="firstpane" class="list1">
<c:forEach items="${mainCategories}" var="category">
<div class="menu_head"	onclick="return location.href = '${pageContext.request.contextPath}/showLots/${category.id}'"><c:out value="${category.name}" />
							<br />
						</div>
						<c:forEach items="${category.subCategories}" var="sub">
						<ul>
						<li><a href="#">${sub.name}</a></li>
						</ul>
						</c:forEach>
 </c:forEach>
 </div>

<div style="color:green;" id="secondpane" class="list2">
<c:forEach items="${allProducts}" var="lot">
<div class="lots"	onclick="return location.href = '${pageContext.request.contextPath}/showLot/${lot.id}'">
							<p><c:out value="${lot.name}" /></p>
							<p><c:out value="${lot.price}" /> грн.</p>
							<br />
						</div>
 </c:forEach>
 </div>


</body>
</html>
