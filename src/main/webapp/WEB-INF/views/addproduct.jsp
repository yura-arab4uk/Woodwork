<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>
$(document).ready(
		
		function() {
			fillPropSelect()
});

var properties;
function fillPropSelect() {
	var selCat=$('.selCat');
	$('.selProp').fadeOut('fast',function() {
	    $(this).remove();
	  });
	var catId=$(selCat).val();
	 $.ajax({
		url : "admin/getProperties",
		data:{
			catId:catId
		},
		type : "GET",
		success : function(data) {
			properties=data;
		}
	});  
}

function addFields() {
	if (properties!='')
		{
	var div=$('<div style="display:none" class="form-group text-center selProp"></div>');
	var div1;
	div1=div.clone();
	var label=$('<label class="control-label" for="pro">Property:</label>');
	var select=$('<select name="propIds" id="pro" class="form-control"></select>');
	$.each(properties,function(index,property) {
		var option=$('<option value="'+property.id+'">'+property.name+'</option>');
		select.append(option);
	});
	
	
	div1.append(label);
	div1.append(select);
	$('#last').before(div1);
	div1.fadeIn('fast');
	div1=div.clone();
	var input=$('<input class="form-control" id="sVa" name="sValues" placeholder="Description"/>') ;
	div1.append(input);
	$('#last').before(div1);
	div1.fadeIn('fast');
} else alert('This category does not have any properties');
}

function saveProd() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");	
	var data = new FormData(document.getElementById("formProd")); // your form ID
	$.ajax({
		url : "admin/addProduct?"+$('#formProd').serialize(),
		type : "POST",
		data:data,
		 enctype: 'multipart/form-data',
		    processData: false,  // tell jQuery not to process the data
		    contentType: false,
		    beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
		success : function(result) {
			console.log(result.status);
			$('.col-sm-4').fadeOut('fast',function(){
				$(this).html('').addClass('text-success').css('font-size','30px').
				text('ADDED SUCCESSFULLY').fadeIn('fast',function(){
					$(this).fadeOut(3000);
					setTimeout(function(){
						loadAddProduct();
						
					},3000);
				});
			});
			
		}
	}); 
}

</script>
<style>

.newuser {
padding:4%;
}
</style>
<div class="row newuser">

<div class="col-sm-4 col-sm-offset-4">
	<form id="formProd" method="post">
		<div class="form-group text-center">
		<label class="control-label" for="nam">Product name:</label>
		<input class="form-control" id="nam" name="name"/>
		</div>
		<div class="form-group text-center">
		<label class="control-label" for="cat">Category:</label>
		<select onchange="fillPropSelect()" id="cat" name="category_id" class="form-control selCat">
		<c:forEach items="${categories}" var="c">
		<option value="${c.id}">${c.name}</option>
		</c:forEach>
		</select>
		</div>
		<div class="form-group text-center">
		<label class="control-label" for="des">Description:</label>
    	<textarea class="form-control" placeholder="Product description" name="description" id="des"></textarea>
    	</div>
    	<div class="form-group text-center">
		<label class="control-label" for="con">Condition:</label>
		<select id="con" name="condition" class="form-control">
		<option value="new">New</option>
		<option value="used">Used</option>
		</select>
		</div>
		<div class="form-group text-center">
		<label class="control-label" for="pri">Price:</label>
		<input class="form-control" id="pri" name="price"/>
		</div>
		<div class="form-group text-center">
		<label class="control-label" for="fil">Image:</label>
		<input type="file" class="btn btn-primary" id="fil" name="file" value="Add"/>
		</div>
		<div id="last" class="form-group text-right">
		<input onclick="addFields()" type="button" class="btn btn-primary" id="las" name="lastname" value="Add property"/>
		</div>
		<div class="form-group text-center">
		<input onclick="saveProd()" type="button" class="btn btn-default" value="Save product"/>
		</div>
</form>
</div>
</div>