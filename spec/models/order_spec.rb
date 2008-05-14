require File.dirname(__FILE__) + '/../spec_helper'

module OrderSpecHelper 
  
  def valid_order_attributes 
    {
    :customer_id => 1, 
    :decorations => "Dora", 
    :details => "white, 7x11", 
    :pickup_day => "May 29, 2007", 
    :pickup_time => "5pm"
    }
  end
  
end

#--------------------------------------


describe Order, 'should require ' do
  include OrderSpecHelper
  
  before(:all) do
    @order = Order.create(valid_order_attributes)
  end

  it "decorations" do
    @order.decorations.should eql("Dora")  
  end
  
  it "cake details" do
    @order.details.should eql("white, 7x11")  
  end
  
  it "all fields" do 
    @order.should be_valid  
  end

  after(:all) do
    Order.destroy_all
  end  

end

 
describe Order, 'should have error on' do  
  include OrderSpecHelper
  
  before(:each) do
    @order = Order.new
  end
    
  it "no day" do
    @order.attributes = valid_order_attributes.with(:pickup_day => nil)
    @order.save
    @order.should have(1).error_on(:pickup_day)
  end

  it "no time" do
    @order.attributes = valid_order_attributes.with(:pickup_time => nil)
    @order.save
    @order.should have(1).error_on(:pickup_time)
  end

  it "no details" do
    @order.attributes = valid_order_attributes.with(:details => nil)
    @order.should have(1).error_on(:details)
  end
  
  after(:all) do
    Order.destroy_all
  end
end
  

describe Order, 'should find' do    
  include OrderSpecHelper
  
  before(:each) do
    @order = Order.create(valid_order_attributes.with(:pickup_day => "August 5", :pickup_time => "5pm"))
  end
  
  it "1 order when usind find_any and searching for 'Dora' (which is in the cake decoration field)" do
    order = Order.find_any("Dora")  
    order[0].id.should eql(@order.id)    
  end
  
  it "1 order when searching for find_by_pickup(date)" do
    order = Order.find_by_pickup_at("August 5")
    order[0].id.should eql(@order.id)  
  end

  it "2 orders when searching for find_by_pickup(date) for orders today" do
    order2 = Order.create( valid_order_attributes.with(:pickup_day => "August 5", :pickup_time => "5:01pm") )
    orders = Order.find_by_pickup_at("August 5")
    orders[0].id.should eql(@order.id)
    orders[1].id.should eql(order2.id)  
    orders.should have(2).items
  end
  
  it "2 orders when searching for pickup between two dates" do
    order2 = Order.create( valid_order_attributes.with(:pickup_day => "August 5", :pickup_time => "5pm") )
    @order.pickup_at.class.should equal(Time.new.class)
    order2.pickup_at.class.should equal(Time.new.class)
    orders = Order.find_by_date_range(@order.pickup_at, order2.pickup_at)
    orders.should have(2).items    
    orders[0].id.should eql(@order.id)
    orders[1].id.should eql(order2.id)  
  end

  it "2 orders when searching for pickup between two dates (wider range)" do
    order2 = Order.create( valid_order_attributes.with(:pickup_day => "August 5", :pickup_time => "3pm") )
    @order.pickup_at.class.should equal(Time.new.class)
    order2.pickup_at.class.should equal(Time.new.class)
    orders = Order.find_by_date_range(@order.pickup_at, (order2.pickup_at + 2.days) )
    orders.should have(2).items
    orders[0].id.should eql(order2.id)
    orders[1].id.should eql(@order.id)  
  end    
  
  after(:each) do
    Order.destroy_all
  end
  
end


describe Order, 'should generate a valid pickup timedate' do
  include OrderSpecHelper
  
  before(:each) do
    @order = Order.new( valid_order_attributes )
  end
  
  it "given day and time (ie: May 29, 2007  5:00 pm)" do
    @order.pickup_day = "May 29, 2007"
    @order.pickup_time = "5:00 pm"
    @order.save

    @order.pickup_at.to_s(:db).should eql('2007-05-29 17:00:00')
  end
    
  it "given missing year (assume current year)" do
    @order.pickup_day = "August 1, 2007"
    @order.pickup_time = "1:00 pm"
    @order.save
    
    @order.pickup_at.to_s(:db).should == '2007-08-01 13:00:00' 
  end

  it "given time in format like 1pm" do
    @order.pickup_day = "August 1, 2007"
    @order.pickup_time = "1pm"
    @order.save
    
    @order.pickup_at.to_s(:db).should == '2007-08-01 13:00:00'
  end
  
end

describe Order, 'should have order number' do
  include OrderSpecHelper  

  before(:all) do
    OrderNumber.destroy_all
    @order = Order.create( valid_order_attributes )
  end
  
  it "when created" do
    @order.order_number.should == 1
  end
  
  it "when saved again with same date" do
    @order.save
    @order.order_number.should == 1
  end
  
  it "when saved in another week later" do
    #set up a order
    @order2 = Order.create( valid_order_attributes.with(:pickup_day => 'June 6, 2007'))
    
    #change previous order 
    @order.pickup_day = "June 6, 2007"
    @order.save
    @order.order_number.should == 2

    @order3 = Order.create( valid_order_attributes.with(:pickup_day => 'June 7, 2007'))
    @order3.order_number.should == 3
  end
end