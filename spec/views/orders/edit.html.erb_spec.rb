require File.dirname(__FILE__) + '/../../spec_helper'

describe "/orders/edit.html.erb" do
  include OrdersHelper
  
  before do
    @order = mock_model(Order)
    @order.stub!(:customer).and_return(mock_model(Customer, :name => 'Bob Jones'))
    @order.stub!(:customer_id).and_return("1")
    @order.stub!(:pickup_at).and_return(Time.now)
    @order.stub!(:decorations).and_return("MyText")
    @order.stub!(:details).and_return("MyText")
    assigns[:order] = @order
  end

  it "should render edit form" do
    render "/orders/edit.html.erb"
    
    response.should have_tag("form[action=#{order_path(@order)}][method=post]") do
      with_tag('textarea#order_decorations[name=?]', "order[decorations]")
      with_tag('textarea#order_details[name=?]', "order[details]")
    end
  end
end


