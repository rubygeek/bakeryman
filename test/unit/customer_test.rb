require File.dirname(__FILE__) + '/../test_helper'

class CustomerTest < Test::Unit::TestCase
  fixtures :customers

  def test_fixtures
     assert "John", customers(:one).first 
  end

  # Replace this with your real tests.
  def test_lookup_with_name
    one = customers(:one)
    my_customers = Customer.lookup(one.first)
    assert my_customers[0].first, one.first 
    assert my_customers[0].id, one.id 
  end

  def test_lookup_with_number
    one = customers(:one)
    my_customers = Customer.lookup(one.home_phone)
    assert my_customers[0].home_phone, one.home_phone 
    assert my_customers[0].id, one.id
  end
  
end
