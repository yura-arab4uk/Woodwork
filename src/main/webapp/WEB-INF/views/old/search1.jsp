<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Products</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {
			
			
		});


</script>
<style>
body {
background:#747384;
}

.subCats {
text-align:center;
color:white;
padding-top:15;
height:50;
background:#ffffd0;
border: 1px solid white;
}
.form-group input[type="checkbox"] {
    display: none;
}

.form-group input[type="checkbox"] + .btn-group > label span {
    width: 20px;
}

.form-group input[type="checkbox"] + .btn-group > label span:first-child {
    display: none;
}
.form-group input[type="checkbox"] + .btn-group > label span:last-child {
    display: inline-block;   
}

.form-group input[type="checkbox"]:checked + .btn-group > label span:first-child {
    display: inline-block;
}
.form-group input[type="checkbox"]:checked + .btn-group > label span:last-child {
    display: none;   
}
</style>
</head>
<body>
<%-- <jsp:include page="header.jsp" /> --%>
<h1>
	Products!  
</h1>


<div class="[ form-group ]">
            <input type="checkbox" name="fancy-checkbox-default" id="fancy-checkbox-default" autocomplete="off" />
            <div class="[ btn-group ]">
                <label for="fancy-checkbox-default" class="[ btn btn-default ]">
                    <span class="[ glyphicon glyphicon-ok ]"></span>
                    <span> </span>
                </label>
                <label for="fancy-checkbox-default" class="[ btn btn-default active ]">
                    Default Checkbox
                </label>
            </div>
        </div>
<div class="row">
<div class="col-sm-3">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<c:if test="${not empty subCategories}">
<div class="subCats" style="background: blue;height:50;">SubCategories</div>
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
<%-- <jsp:include page="content.jsp"/> --%>
</div>
<%-- <jsp:include page="pagination.jsp"/> --%>
</body>
</html>
