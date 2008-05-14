require File.dirname(__FILE__) + '/../test_helper'

class OrderTest < Test::Unit::TestCase
  fixtures :orders

  def setup
	  @o = Order.new
  end
  
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_parsing_pickup_timestamp_parts
  	day = "May 29, 1977"
  	time = "5:00 pm"
  	@o.pickup_day = day
  	@o.pickup_time = time
  	pickup_parts = @o.pickup_timestamp_parts
  	assert_equal 1977, pickup_parts[0], "Year is correct"
  	assert_equal 5, pickup_parts[1], "Month is correct"
  	assert_equal 29, pickup_parts[2], "Day is correct"
  	assert_equal 17, pickup_parts[3], "Hour is correct"
  	assert_equal 0, pickup_parts[4], "Minutes are correct"
  end
  
  def test_pickup_timestamp
  	day = "August 1, 2007"
  	time = "1:00 pm"
  	@o.pickup_day = day
  	@o.pickup_time = time
  	pickup_parts = @o.pickup_timestamp_parts
  	assert_equal '2007-08-01 13:00:00', @o.pickup_timestamp, "timestamp is correct"  	
  end

  def test_pickup_timestamp_with_no_year
  	day = "August 1"
  	time = "1:00 pm"
  	@o.pickup_day = day
	  @o.pickup_time = time
  	pickup_parts = @o.pickup_timestamp_parts
  	assert_equal '2007-08-01 13:00:00', @o.pickup_timestamp, "timestamp is correct"  	
  end

  def test_pickup_timestamp_with_no_year
  	day = "August 1"
  	time = "1pm"
  	@o.pickup_day = day
	@o.pickup_time = time
  	pickup_parts = @o.pickup_timestamp_parts
  	puts @o.pickup_timestamp
  	assert_equal '2007-08-01 13:00:00', @o.pickup_timestamp, "timestamp is correct"  	
  end

  def test_find_any_should_find_one
    o = Order.find_any("dora")
    assert_equal 1, o[0].id, "It found order of ID = 1"
  end
end
