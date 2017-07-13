<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Home</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {
			
			
		});

function getDataNavBar() {
	$.ajax({
		url : 'ajax/categories',
		type : "POST",
		data : {
			
		},
		dataType : "json",
		cache : false,
		
		success : function(dataJson) {
			//alert(dataJson);
			
		}
		
	});
}

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
background:#747384;
}

.prod {
height:300px;
background:#ddf987;
}

.prod:hover {
background:grey;
}

.menu {
background:white;
}
.dropdown:hover >.dropdown-menu {
display: block;
}




</style>
</head>
<body>
<%-- <jsp:include page="header.jsp" /> --%>
<h1>
	Hot deals!  
</h1>
<div class="menu">
 <div class="collapse navbar-collapse" id="collapse">
          <ul class="nav navbar-nav">
          <c:forEach items="${categories}" var="category">
          <c:if test="${not empty category.subCategories}">
      <li class="dropdown"><a href="${pageContext.request.contextPath}/showProducts/${category.id}"><c:out value="${category.name}"></c:out><span class="caret"></span></a>
   
   <ul class="dropdown-menu">
   <c:forEach items="${category.subCategories}" var="sub">
                         <li><a href="${pageContext.request.contextPath}/showProducts/${sub.id}"><c:out value="${sub.name}"></c:out></a></li>
   
   </c:forEach>
                        </ul>
   
   </li>
   </c:if>
   <c:if test="${empty category.subCategories}">
   <li><a href="${pageContext.request.contextPath}/showProducts/${category.id}"><c:out value="${category.name}"></c:out></a>
  </li>
   </c:if>
   </c:forEach>
             </ul>
         </div>
</div>
<input onclick="loadData()" type="button" value="supertest"/>
<div style="color:green;" id="secondpane" class="row">
<c:forEach items="${products}" var="product">
<div class="col-sm-3 prod"	onclick="return location.href = '${pageContext.request.contextPath}/showProduct/${product.id}'">
							<p><c:out value="${product.name}" /></p>
							<p><c:out value="${product.price}" /> грн.</p>
							<img src="<%=request.getContextPath()%>/resources/img/<c:out value="${product.image}" />" alt="oops" width="80%" height="80%">
						</div>
 </c:forEach>
 </div>
 
<%-- <jsp:include page="pagination.jsp"/> --%>

</body>
</html>
