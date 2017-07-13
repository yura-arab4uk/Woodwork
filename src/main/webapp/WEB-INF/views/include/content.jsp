<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.head,.content {
height:80px;
background:#f2f2f2;
border: 1px solid white;
text-align:center;
}


.head {
color:white;
height:50px;
background:grey;
padding-top:15px;
}
</style>
<div class="col-sm-8">
<div class="row">
<div class="col-sm-3 head">Photo</div>
<div class="col-sm-3 head">Name</div>
<div class="col-sm-3 head">Condition</div>
<div class="col-sm-3 head">Price</div>
</div>
<c:forEach items="${products}" var="product">
<div style="cursor:pointer;" class="row" onclick="return location.href='${pageContext.request.contextPath}/showProduct/${product.id}'">
<div class="col-sm-3 content"><img src="${pageContext.request.contextPath}/resources/img/<c:out value="${product.image}" ></c:out>" width="40%" height="90%"/></div>
<div class="col-sm-3 content">${product.name}</div>
<div class="col-sm-3 content">${product.condition}</div>
<div class="col-sm-3 content">${product.price}</div>
</div>
</c:forEach>
</div>
