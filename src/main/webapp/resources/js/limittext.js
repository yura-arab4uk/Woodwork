function limittext (input,amount) {
	 var value = input.value;
	     if (value.length>amount) {
	         value = value.slice(0,amount);
	         input.value = value;
	};
}