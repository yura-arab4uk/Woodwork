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
	<title>Search</title>
	<script type="text/javascript">
$(document).ready(
		
		function() {
			setActiveCategories();
		});

function chooseCategory(catId) {
	var list=getQueryVariable('list',location.href);
	var url=location.href;
	if (list==false) list=catId;
	else {
		//delete catId if exists
		if (list.indexOf(catId+",")!=-1)  {list=list.replace(catId+",", "");}
	    else if (list.indexOf(","+catId)!=-1) {list=list.replace(","+catId, "");}
	    else if (list.indexOf(catId)!=-1) {list=list.replace(catId, "");}
	    else list+=","+catId;
	}
	url=addParameter(url,'list',list);
	if (list=='') url=url.replace("&list=","");
	location.href=url;
}
function setActiveCategories() {
	<c:forEach var="catId" items="${list}">
       $("#cat"+"${catId}").attr("checked",true);
    
</c:forEach>
}
</script>
<style>

body {
background:#dbdbdb;
}

.categories {
text-align:center;
color:white;
padding-top:15px;
height:50px;
background:#ffffd0;
border: 1px solid white;
margin-bottom:10px;
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
<jsp:include page="include/header.jsp" />
<h1>
	Products!  
</h1>



<div id="wrap">
<jsp:include page="include/filters.jsp"/>
<div class="row">
<div class="col-sm-3">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<c:if test="${not empty categories}">
<div class="categories" style="color:white;background: grey;">Categories</div>
<div style="padding:10px;background:#f2f2f2;">
<c:forEach items="${categories}" var="category">

<div class="[ form-group ]">
            <input onchange="chooseCategory(${category.id})" type="checkbox" name="fancy-checkbox-success" id="cat${category.id}" autocomplete="off" />
            <div class="[ btn-group ]">
                <label for="cat${category.id}" class="[ btn btn-success ]">
                    <span class="[ glyphicon glyphicon-ok ]"></span>
                    <span> </span>
                </label>
                <label for="fancy-checkbox-success" class="[ btn btn-default active ]">
                    <c:out value="${category.name}" />
                </label>
            </div>
        </div>


</c:forEach>
</div>
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
