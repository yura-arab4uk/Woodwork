<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<script type="text/javascript">
$(document).ready(
		
		function() {
			fillNavbar();
});

function fillNavbar() {
	var data =${categories};
	var level=1;
	$.each(data,function(parentsStr,categories) {
		var parents=JSON.parse(parentsStr);
elementsToMenus(parents,level);
appendCreateElements(categories,level);
level++;
});
}

function appendCreateElements(categories,level) {
	$.each(categories,function(index,category) {
		if (level==1) createAppendLiTo($('#cNav'),category);
	else createAppendLiTo($('#c'+category.parent).children('ul'),category);
	
});
}

function elementsToMenus(parents,level) {
	$.each(parents,function(index,parent) {
		var $parLi=$('#c'+parent);
		if (level==2) {
		$parLi.addClass('drop');
		$parLi.append('<ul class="dropdown-menu multi-level"></ul>');
		$parLi.children('a').append('<b class="caret"></b>');
		}
		if (level>2) {
		$parLi.addClass('dropdown-submenu');
		$parLi.append('<ul class="dropdown-menu"></ul>');
		}
		
	});
}

function createAppendLiTo($element,category) {
	var $li=$('<li><a href="#"></a></li>');
	$li.attr('id','c'+category.id).children('a').text(category.name).attr(
	'href','${pageContext.request.contextPath}/showProducts/'+category.id);
	$element.append($li);
}

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
 
</script>
<style>
body {
	background: #dbdbdb;
}

.prod {
	height: 300px;
	background: #f2f2f2;
	text-align:center;
	cursor:pointer;
}

.prod:hover {
	background: grey;
}

.menu {
	background: white;
}
</style>
</head>
<body>
	<jsp:include page="include/header.jsp" />
	<h1>Hot deals!</h1>
	<div id="wrap">
	<jsp:include page="include/navbar.jsp" />
	<div id="secondpane" class="row">
		<c:forEach items="${products}" var="product">
			<div class="col-sm-3 prod"
				onclick="return location.href = '${pageContext.request.contextPath}/showProduct/${product.id}'">
				<p>
					<c:out value="${product.name}" />
				</p>
				<p>
					<c:out value="${product.price}" />
					грн.
				</p>
				<img
					src="<%=request.getContextPath()%>/resources/img/<c:out value="${product.image}" />"
					alt="oops" width="80%" height="80%">
			</div>
		</c:forEach>
	</div>

	<jsp:include page="include/pagination.jsp" />
	</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
