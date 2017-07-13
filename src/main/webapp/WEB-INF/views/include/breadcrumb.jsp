<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<ul class="breadcrumb">
<li><a href="${pageContext.request.contextPath}">Home</a></li>
<c:forEach items="${parentCategories}" var="category" varStatus="status">

<c:if test="${not status.last}">   
<li><a href="${pageContext.request.contextPath}/showProducts/${category.id}">
<c:out value="${category.name}" ></c:out>
</a></li>
</c:if>

<c:if test="${status.last}">        
<li class="active">
<c:out value="${category.name}" ></c:out>
</li>
</c:if>

 </c:forEach>
</ul>