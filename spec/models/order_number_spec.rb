require File.dirname(__FILE__) + '/../spec_helper'

describe OrderNumber do
  before(:each) do
    OrderNumber.destroy_all
  end

  it "should return a week number given a date" do
    #this gets around private methods, not sure if this will hold up in future version of ruby or not
    OrderNumber.send(:get_week_number, "Jan 1, 2008 12pm").should == 1
    OrderNumber.send(:get_year, "Jan 1, 2008 12pm").should == 2008

    OrderNumber.send(:get_week_number, "Jan 1, 2009 12pm").should == 1
    OrderNumber.send(:get_year, "Jan 1, 2009 12pm").should == 2009

    
    OrderNumber.send(:get_week_number, "Jan 2, 2008 12pm").should == 1
    OrderNumber.send(:get_year, "Jan 2, 2008 12pm").should == 2008
        
    OrderNumber.send(:get_week_number, "Jan 3, 2008 12pm").should == 1        
    OrderNumber.send(:get_year, "Jan 3, 2008 12pm").should == 2008
    
    OrderNumber.send(:get_week_number, "Jan 1, 2008 12pm").should_not == 52

    #last day of 52 week
    OrderNumber.send(:get_week_number, "Dec 28, 2008").should == 52

    # Dec 29 is a monday, starts new week
    OrderNumber.send(:get_week_number, "Dec 29, 2008").should == 1
    OrderNumber.send(:get_week_number, "Dec 29, 2008").should == 1    
  end
  
  it "should should return 1 for the first time, 2 for second, 3 for third" do
    first_order_number = OrderNumber.get_next("Jan 1, 2008 12pm")
    first_order_number.should == 1
    OrderNumber.find_by_week_number(1).last_order_number.should == 1
    
    second_order_number = OrderNumber.get_next("Jan 2, 2008 12pm")
    second_order_number.should == 2
    OrderNumber.find_by_week_number(1).last_order_number.should == 2    
    
    third_order_number = OrderNumber.get_next("Jan 3, 2008 12pm")
    third_order_number.should == 3
    OrderNumber.find_by_week_number(1).last_order_number.should == 3
  end
  
  it "should return 1 first order of one week" do
    first_order_number = OrderNumber.get_next("Jan 1, 2008 12pm")
    first_order_number.should == 1
    OrderNumber.find_by_week_number(1).last_order_number.should == 1
  end
  
  it "should return 1 for another week" do
        
    another_first_order_number = OrderNumber.get_next("Dec 28, 2008 12pm")
    another_first_order_number.should == 1
    OrderNumber.find_by_week_number(52).last_order_number.should == 1        

    another_second_order_number = OrderNumber.get_next("Dec 29, 2008 12pm")
    another_second_order_number.should == 1
    OrderNumber.find_by_week_number(1).last_order_number.should == 1

    yet_another_second_order_number = OrderNumber.get_next("Dec 30, 2008 12pm")
    yet_another_second_order_number.should == 2
    OrderNumber.find_by_week_number(1).last_order_number.should == 2

    first_order_number = OrderNumber.get_next("Jan 1, 2008 12pm")
    first_order_number.should == 3
    OrderNumber.find_by_week_number(1).last_order_number.should == 3

  end
end
