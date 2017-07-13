<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>
$(document).ready(
		
		function() {
			createPropertyTable();
			checkBox();
});

function enabledProperty(enabled) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var en=$(enabled).val();
	var propId=$(enabled).parent().parent().parent().children('input').val();
	  $.ajax({
		url : "admin/activateProperty?id=" + propId + "&enabled=" + en,
		type : "PUT",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
		}
	});  
}

function createPropertyTable() {
	var properties=${properties};
	
	   $.each(properties,function(index,property){
		var div = $('<div class="row"></div>');
		 $.each(property,function(index,value){
			
			if (index=='id') $(div).append('<input type="hidden" value="'+value+'">');
			else {
				var divcol=$('<div class="col-sm-4 propertyrow"></div>');
				if (index=='enabled') $(divcol).append('<input onchange="enabledProperty(this)" type="checkbox" checked=true class="input-20a" value="'+value+'" data-three-state="false" size="lg">');
			else $(divcol).text(value);
			}
			$(div).append(divcol);
		}); 
		
		$('#properties').append(div);
	}); 
}

function addProperty() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	 $.ajax({
		url : "admin/addProperty?"+$('#formAddProp').serialize(),
		type : "PUT",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
			loadEditProperty();
		}
	});   
}	  
	


</script>
<style>

#properties {
padding:4%;
padding-left:26%;
}

.propertyrow {
padding-top:15px;
height:50px;
}
</style>
<div class="row text-center">
<form id="formAddProp" class="form-inline" method="GET">
        <div class="form-group">
          <label class="control-label" for="nam">Property name:</label>
          <input id="nam" name="name" type="text" class="form-control" placeholder="Type name">
        </div>
<select name="type" class="form-control">
<option value="Integer">Integer</option>
<option value="String">String</option>
</select>
<select name="catId" class="form-control">
<c:forEach items="${categories}" var="c">
<option value="${c.id}">${c.name}</option>
</c:forEach>
</select>
        <button onclick="addProperty()" type="button" class="btn btn-default">Add</button>
      </form>
      </div>
<div class="row" id="properties">

      
<div class="row">

<div class="col-sm-4">
<b>Property name</b>
</div>
<div class="col-sm-4">
<b>Type</b>
</div>
<div class="col-sm-4">
<b>Active status</b>
</div>
</div>
</div>
<jsp:include page="include/pagination.jsp"></jsp:include>