require File.dirname(__FILE__) + '/../../spec_helper'

describe "/orders/show.html.erb" do
  include OrdersHelper
  
  before do
    @order = mock_model(Order)
    @order.stub!(:customer).and_return(mock_model(Customer, :name => "Bob Jones"))
    @order.stub!(:pickup_at).and_return(Time.now)
    @order.stub!(:decorations).and_return("MyText")
    @order.stub!(:details).and_return("MyText")
    @order.stub!(:created_at).and_return(Time.now)
    @order.stub!(:updated_at).and_return(Time.now)
    assigns[:order] = @order
  end

  it "should render attributes in <p>" do
    render "/orders/show.html.erb"
    response.should have_text(/MyText/)
    response.should have_text(/MyText/)
  end
end

