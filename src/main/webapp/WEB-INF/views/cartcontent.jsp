<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="color:blue" class="row">
<div class="col-sm-3"><b>Photo</b></div>
<div class="col-sm-3"><b>Name</b></div>
<div class="col-sm-3"><b>Price</b></div>
</div>
<hr class="soften" />
<c:forEach items="${pCart}" var="product">
<div class="row">
<div style="padding:0px;" class="col-sm-3 cartrow"><img src="${pageContext.request.contextPath}/resources/img/<c:out value="${product.image}" ></c:out>" width="30%" height="100%"/></div>
<div class="col-sm-3 cartrow">${product.name}</div>
<div class="col-sm-3 cartrow">${product.price}</div>
<div class="col-sm-3 cartrow">
<div class="col-sm-6">
<span onclick="addOrder('${product.id}',this)" style="color:green" class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span>
</div>
<div class="col-sm-6">
<span onclick="canselOrder('${product.id}',this)" style="color:red" class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span>
</div>
</div>
</div>
<hr class="soften" />
</c:forEach>
<jsp:include page="include/pagination.jsp"></jsp:include>
