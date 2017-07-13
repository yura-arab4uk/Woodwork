<script type="text/javascript">
$(document).ready(
		
		function() {
			setPAmount();
			createPageTabs();
			
		});
function pageUrl(pageTab){
	 page = $(pageTab).text();
	 
	 location.href='?p='+page+'&pAmount='+getPAmount()+'';
}

function pageBack() {
		var page = $('.pageTabTabbed').text()-1;
		location.href='?p='+page+'';
	}

function pageForward() {
		var page = $('.pageTabTabbed').text()-0+1;
		location.href='?p='+page+'';
	}

function createPageTabs() {
	var page="${page}";
	//var page=1;
	//if (page=='') page=1;
	//alert(window.location.href);
	$('#paging').html('');
	var numOfPages = "${numOfPages}";
	//var numOfPages = 5;
	var startPageTab = 1;
	var maxPageTab = numOfPages;
	var $div=null;
	if (numOfPages > 5) {
		// натиснули на одну з перших трьох вкладок
		if (page <= 3) {
			startPageTab = 1;
			maxPageTab = 5;
			// натиснули на одну з останніх двох
		} else if (page > numOfPages - 2) {
			startPageTab = numOfPages - 4;
			maxPageTab = numOfPages;
			// натиснули на будь-які інші
		} else {
			startPageTab = page - 2;
			maxPageTab = page-0 + 2;
		}
	}
	if (page>1)
	{	
	$div = $('<div onclick="pageBack()" class="pageTab">\<</div>');
	}
	else
	{	
		$div = $('<div class="pageTab">\<</div>');
	}	
	$('#paging').append($div);
	for (var i=startPageTab;i<=maxPageTab;i++){
		 
		if (i==page) $div = $('<div class="pageTabTabbed"></div>');
		else {
		$div = $('<div onclick="pageUrl(this)" class="pageTab"></div>');
		}
		$div.text(i);
		$('#paging').append($div);
	}
	
	if (page<numOfPages)
	{	
	$div = $('<div onclick="pageForward()" class="pageTab">\></div>');
	}
	else
	{	
		$div = $('<div class="pageTab">\></div>');
	}
	$('#paging').append($div);
}

function getPAmount(){
	return $('#pAmount').children('option:selected').val();
}

function pAmountUrl(){
	var pAmount = getPAmount();
	location.href='?pAmount='+pAmount+'';
}

function setPAmount(){
	$("#pAmount [value='${pAmount}']").attr("selected", "selected");
}
</script>
<style>
.pageTab, .pageTabTabbed {
display: inline-block;
	text-align: center;
	background: white;
	margin-left: -3px;
	padding-top: 10px;
	font-size: 20px;
	height: 45px;
	width: 60px;
	color: black;
	cursor: pointer;
}

.pageTab:hover {
background: black;
color: white;
}

.pageTabTabbed {
background: #785493;
color: white;
}

</style>

<div style="margin-top:200px;margin-bottom:50px;">
<div class="row">

<div class="col-sm-10 col-sm-offset-1 text-right">
<div id="paging"></div>
</div>

<div class="col-sm-1">
<div class="row">
<div class="col-sm-12">
<select class="form-control" onchange="pAmountUrl()" id="pAmount">
<option value="5">5</option>
<option value="10">10</option>
<option value="20">20</option>
<option value="50">50</option>
</select>
</div>
</div>
</div>

</div>
</div>
