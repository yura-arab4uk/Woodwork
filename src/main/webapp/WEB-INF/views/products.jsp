<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>


<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.3.0/css/bootstrap-slider.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.3.0/bootstrap-slider.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Products</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {
			
			
		});


</script>
<style>

body {
background:#dbdbdb;
}

.subCats {
text-align:center;
padding-top:15px;
height:50px;
background:#f2f2f2;
border: 1px solid white;
}
</style>
</head>
<body>
<jsp:include page="include/header.jsp" />
<h1>
	Products!  
</h1>
<div id="wrap">
<jsp:include page="include/breadcrumb.jsp"/>
<jsp:include page="include/filters.jsp"/>
<div class="row">
<div class="col-sm-3">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<c:if test="${not empty subCategories}">
<div class="subCats" style="color:white;background: grey;">SubCategories</div>
<c:forEach items="${subCategories}" var="category">
<div  class="subCats"><a href = "${pageContext.request.contextPath}/showProducts/${category.id}">
<c:out value="${category.name}" />
</a>
</div>
</c:forEach>
</c:if>

</div>
</div>
</div>

<jsp:include page="include/content.jsp"/>
</div>
<jsp:include page="include/pagination.jsp"/>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
