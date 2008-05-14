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
 if ($('order_pickup_day').value.match("jan|feb|mar|apr|may|june|july|aug|sept|pct|nov|dec|jun|jul|january|feburary|march|april|august|september|october|november|december") == null) {
   $('order_pickup_day').style.border = "1px inset red"
   $('day_help').style.color = 'red'
 } else {
   $('order_pickup_day').style.border = "1px inset black"
   $('day_help').style.color = 'black'
 } 
}

funtion check_dates() {
  if ($('order_pickup_day').value == "") or 
     ($('order_pickup_time').value == "") {
	alert("Please enter the date");
    return false;
  } else {
    return true;
  }
}

