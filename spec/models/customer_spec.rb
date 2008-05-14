require File.dirname(__FILE__) + '/../spec_helper'

describe Customer do
  before(:each) do
    @customer = Customer.new(:first => "bob", :last => 'smith')
  end

  it "should strip out non numbers from phone" do
    @customer.cell_phone = "123-123-1231"
    @customer.work_phone = "(123) 933 0902"
    @customer.home_phone = nil
    @customer.save
  
    @customer.cell_phone.should == '1231231231'
    @customer.work_phone.should == '1239330902'
    @customer.home_phone.should be_blank
  end

  it "should add default when just one number" do
    @customer.cell_phone = "1231231"
    @customer.save
    @customer.cell_phone.should == "8151231231"  
  end
  
  it "should add default areacode when all need it" do
    @customer.cell_phone = "1231231"
    @customer.save
    @customer.cell_phone.should == "8151231231"
    
    @customer.home_phone = "1231231"
    @customer.save
    @customer.home_phone.should == "8151231231"
    
    @customer.work_phone = "1231231"
    @customer.save
    @customer.work_phone.should == "8151231231"    
  end

  it "should have at least one phone number" do
    @customer.save
    @customer.errors.should have(3).errors
    @customer.should have(1).errors_on(:home_phone)
    @customer.should have(1).errors_on(:work_phone)
    @customer.should have(1).errors_on(:cell_phone)
    @customer.home_phone = "1231231231"
    @customer.save
    @customer.errors.should have(0).errors
    @customer.should have(0).errors_on(:phone)
  end

  it "should be valid if have a cell phone" do
    @customer.cell_phone = "1231231"    
    @customer.save
    @customer.errors.should have(0).errors
  end
  
  it "should be valid if have a work_phone" do  
    @customer.work_phone = "1231231"    
    @customer.save
    @customer.errors.should have(0).errors
  end
    
  it "should be valid if have a home_phone" do  
    @customer.home_phone = "1231231"    
    @customer.save
    @customer.errors.should have(0).errors
  end  

  it "should be valid if have a home_phone and cell_phone" do  
    @customer.cell_phone = "1231231"  
    @customer.home_phone = "1231231"    
    @customer.save
    @customer.errors.should have(0).errors
  end

  it "should require first and last names" do
    @customer.first = ''
    @customer.last = ''
    @customer.home_phone = "1231231"      
    @customer.save
    @customer.errors.should have(2).errors
    @customer.should have(1).error_on(:first)
    @customer.should have(1).error_on(:last)
  end

  it "should generate fullname from first and last" do
    @customer.first = "Bob"
    @customer.last = "Jones"
    @customer.name.should == "Bob Jones"
  end

  it "should find a record by any field" do
    customer1 = Customer.create( :first => 'Sally', :last => 'Jones', :cell_phone => '1231231233',
                                 :work_phone => '3450982344', :home_phone => '4562349877')
    customer2 = Customer.create( :first => 'Mark', :last => 'Smith', :cell_phone => '4563451231',
                                 :work_phone => '4563456788', :home_phone => '2341236784')
    customer3 = Customer.create( :first => 'Sam', :last => 'Tyler', :cell_phone => '4568451231',
                                 :work_phone => '4562340983', :home_phone => '2341896784')
    found_customer = Customer.find_any('jones')
    found_customer[0].first.should == 'Sally'    
    found_customer[0].cell_phone.should ==  '1231231233'
    
    found_customer = Customer.find_any('4562340983')    
    found_customer[0].first.should == 'Sam'    
    found_customer[0].cell_phone.should ==  '4568451231'                                                                                          
  end
end
