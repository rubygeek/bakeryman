require File.dirname(__FILE__) + '/../../spec_helper'

describe "/orders/new.html.erb" do
  include OrdersHelper
  
  before do

    @order = mock_model(Order)
    @order.stub!(:new_record?).and_return(true)
    @order.stub!(:customer).and_return(mock_model(Customer, :first => 'Bob', :last => 'jones', :bozo => 1))
    @order.stub!(:pickup_at).and_return(Time.now)
    @order.stub!(:decorations).and_return("MyText")
    @order.stub!(:details).and_return("MyText")
    
    assigns[:order] = @order
  end

  it "should render new form" do
    render "/orders/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", orders_path) do
      with_tag("textarea#order_decorations[name=?]", "order[decorations]")
      with_tag("textarea#order_details[name=?]", "order[details]")
    end
  end
end


