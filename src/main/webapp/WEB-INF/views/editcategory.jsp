<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>
$(document).ready(
		
		function() {
			createCategoryTree();
});

function createCategoryTree() {
	var data =${categories};
	var level=1;
	$.each(data,function(parentsStr,categories) {
		var parents=JSON.parse(parentsStr);
		$.each(parents,function(index,parent) {
			if (level>1) {
			var $parLi=$('#cat'+parent);
			$parLi.append('<ul></ul>');
			}
		});
		
		$.each(categories,function(index,category) {
			if (level==1) createAppendLiTo($('#catUl'),category);
		else createAppendLiTo($('#cat'+category.parent).children('ul'),category);
		});
level++;
});
}

function createAppendLiTo($element,category) {
	var $li=$('<li></li>');
	$li.attr('id','cat'+category.id).append('<span>'+category.name+'</span>');
	$li.append('&emsp;<button onclick="addCategoryId(this)" type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus green" aria-hidden="true"></span></button>');
	$li.append('<button onclick="removeCat(this)" type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-trash red" aria-hidden="true"></span></button>');
	$element.append($li);
}


function addCategoryId(addButton) {
	var parentId=getCatId(addButton);
	$('#id').attr("value",parentId);
}

function getCatId(element){
	var $li=$(element).parent()
	var parentId=$li.attr('id').substring(3);
	return parentId;
}

function addCat() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url : "admin/addCategory?"+$('#formCat').serialize(),
		type : "PUT",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			console.log(result.status);
			loadEditCategory();
			$('body').removeClass('modal-open');
			$('body').css('padding-right','0px');
		}
	});  
}

function removeCat(removeButton) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var result = confirm("Do you really want to do this? It will also delete evetything that is related to this category!!!");
	if (result) {
	var catId=getCatId(removeButton);
	  $.ajax({
		url : "admin/removeCategory?id="+catId,
		type : "DELETE",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			loadEditCategory();
			console.log('removed');
		}
	});  
	}
}
</script>
<style>

.red {
  color: red;
}
.green {
  color: green;
}
</style>
<div style="padding:3%;" class="row">
<ul id="catUl"  style = "font-size:20px;">
</ul>
</div>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Add category</h4>
        </div>
        <div class="modal-body">
        
        <form id="formCat">
							<input id="id" type="hidden" class="form-control" name="parent"/>
						    <label class="control-label" for="name">Category name:</label>
							<input class="form-control" id="name" name="name"/>
					</form>
        </div>
        <div class="modal-footer">
          <button onclick="addCat()" type="button" class="btn btn-default" data-dismiss="modal">Save</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>