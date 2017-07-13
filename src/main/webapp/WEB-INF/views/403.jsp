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
<title>Access denied</title>
</head>
<body>
<jsp:include page="include/header.jsp"/>
<div style="text-shadow: 1px 1px 1px #000;color:#d2d2e2;" id="wrap" class="text-center row">
	<h1>HTTP Status 403 - Access is denied</h1>

	<c:choose>
		<c:when test="${empty username}">
			<h2>Ви не маєте прав на перегляд цієї сторінки!</h2>
		</c:when>
		<c:otherwise>
			<h2>Шановний : ${username}! <br/>Ви не маєте прав на перегляд цієї сторінки!</h2>
		</c:otherwise>
	</c:choose>
</div>
<jsp:include page="include/footer.jsp"/>
</body>
</html>