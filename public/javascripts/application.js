function validate_time() { 
 if ($('order_pickup_time').value.match("am|pm") == null) {
   $('order_pickup_time').style.border = "1px inset red"
   $('time_help').style.color = 'red'
 } else {
   $('order_pickup_time').style.border = "1px inset black"
   $('time_help').style.color = 'black'
 } 
}

function validate_day() { 
 if ($('order_pickup_day').value.match(/jan|feb|mar|apr|may|june|july|aug|sept|pct|nov|dec|jun|jul|january|feburary|march|april|august|september|october|november|december/i) == null) {
   $('order_pickup_day').style.border = "1px inset red"
   $('day_help').style.color = 'red'
   return false;
 } else {
   $('order_pickup_day').style.border = "1px inset black"
   $('day_help').style.color = 'black'
   return true;
 } 
}

function validate_form() {
  name = $('customer_first').value;
  id = $('order_customer_id').value;
  if ( $('order_pickup_day').value == "" ) {
	alert("Please enter the day");
    return false;
  } else if ( $('order_pickup_time').value == "" ) {
	alert("Please enter the day");
    return false;
  } else if ( $('order_decorations').value == "" ) {
	alert("Please enter decoration info");
    return false;
  } else if ((id == "") && (name == "")) {
	alert("Please enter name or select existing customer");
	return false;
  } else {
    if (validate_day()) {
	   return true;
	} else {
		alert("Invalid date");
		return false;
	}
  }

}

