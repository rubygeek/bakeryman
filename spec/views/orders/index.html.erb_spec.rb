require File.dirname(__FILE__) + '/../../spec_helper'

describe "/orders/index.html.erb" do
  include OrdersHelper
  #fixtures :orders, :customers
  
  before do
    bob = mock_model(Customer)
    bob.stub!(:name).and_return("Bob Jones")
    
    order_98 = mock_model(Order)
    order_98.should_receive(:customer).and_return(bob)
    order_98.should_receive(:pickup_at).and_return(Time.now)
    order_98.should_receive(:decorations).and_return("MyText")
    order_98.should_receive(:details).and_return("MyText")
    order_98.should_receive(:created_at).and_return(Time.now)
    order_98.should_receive(:modified_at).and_return(Time.now)
    order_98.should_receive(:order_number).and_return(1)
    order_98.should_receive(:bozo).and_return(1)
        
    order_99 = mock_model(Order) 
    order_99.should_receive(:customer).and_return(bob)
    order_99.should_receive(:customer_id).and_return("1")
    order_99.should_receive(:pickup_at).and_return(Time.now)
    order_99.should_receive(:decorations).and_return("MyText")
    order_99.should_receive(:details).and_return("MyText")
    order_99.should_receive(:created_at).and_return(Time.now)
    order_99.should_receive(:modified_at).and_return(Time.now)
    order_99.should_receive(:order_number).and_return(1)
    order_99.should_receive(:bozo).and_return(1)
        
    assigns[:orders] = [order_98, order_99]
  end

  it "should render list of orders" do
    render "/orders/index.html.erb"
   # response.should have_tag("tr>td>td", Time.now.to_s(:short), 2)
    #response.should have_tag("tr>td", "Mark Smith", 2)
  end
  
end

