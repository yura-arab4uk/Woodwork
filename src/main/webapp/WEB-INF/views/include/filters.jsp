
<script type="text/javascript">
$(document).ready(
		
		function() {
			setPriceSlider();
			setCondition();
			$("#price").slider({});
		});

function filter() {
	var url=location.href;
	var prices=$('#price').val();
	var condition=$('#condition').val();
	url=addParameter(url,'p','1');
	url=addParameter(url,'prices',prices);
	url=addParameter(url,'condition',condition);
	//при фільтруванні видалити активні категорії
	
	url=addParameter(url,'list','');
	url=url.replace("&list=","");
		
	location.href=url;
}

/* function condition(){
	location.href=location.href.replace(/&?prices=([^&]$|[^&]*)/i, "");
	 
} */

function setPriceSlider() {
	var bp="${bottomPrice}";
	var tp="${topPrice}";
	var min="${minPrice}";
	var max="${maxPrice}";
	var str;
	if (bp!=='') {
		str="["+bp+","+tp+"]";
	}
	else {
		str="["+min+","+max+"]";
	}
	$('#price').attr("data-slider-value",str);
	$('#price').attr("data-slider-min",min);
	$('#price').attr("data-slider-max",max);
	
}


function setCondition() {
	
	$("#condition [value='${condition}']").attr("selected","selected");
}

function resetF() {
	var q=getQueryVariable('q',location.href);
	if (q!=false) location.href=window.location.pathname+'?q='+q;
	else location.href=window.location.pathname;
}
</script>

<div class="row" style="margin-bottom:15px;">
<div class="col-sm-2 col-sm-offset-4">
<select style="display: inline-block" class="form-control" id="condition">
<option value="all">All conditions</option>
<option value="new">new</option>
<option value="used">used</option>
</select>
</div>
<div class="col-sm-6">
<b>&#x20B4; ${minPrice}&emsp;</b>
<input id="price" type="text" class="span2" value="" data-slider-step="5"/>
<b>&emsp;&#x20B4; ${maxPrice}</b>
<button type="button" onclick="filter()" class="btn btn-default">Filter</button>
<button type="button" onclick="resetF()" class="btn btn-primary">Reset filters</button>
</div>
</div>
