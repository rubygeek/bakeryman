require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/index.html.erb" do
  include CustomersHelper
  
  before do
    customer_98 = mock_model(Customer)
    customer_98.should_receive(:first).and_return("Bob")
    customer_98.should_receive(:last).and_return("Jones")
    customer_98.should_receive(:home_phone).and_return("815.123.4565")
    customer_98.should_receive(:work_phone).and_return("815.234.3456")
    customer_98.should_receive(:cell_phone).and_return("815.452.5325")    
    customer_98.should_receive(:bozo).and_return(false)

    
    customer_99 = mock_model(Customer)
    customer_99.should_receive(:first).and_return("MyString")
    customer_99.should_receive(:last).and_return("MyString")
    customer_99.should_receive(:home_phone).and_return("MyString")    
    customer_99.should_receive(:cell_phone).and_return("MyString")
    customer_99.should_receive(:work_phone).and_return("MyString")

    customer_99.should_receive(:bozo).and_return(false)

    assigns[:customers] = [customer_98, customer_99]
  end

  it "should render list of customers" do
    render("/customers/index.html.erb")
    response.should have_tag("tr>td", "Bob", 2)
    response.should have_tag("tr>td", "Jones", 2)
    response.should have_tag("tr>td", "815.123.4565", 2)
    response.should have_tag("tr>td", "815.234.3456", 2)    
    response.should have_tag("tr>td", "815.452.5325", 2)
  end
end

