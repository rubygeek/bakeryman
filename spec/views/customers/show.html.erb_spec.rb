require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/show.html.erb" do
  include CustomersHelper
  
  before do
    @customer = mock_model(Customer)
    @customer.stub!(:name).and_return("MyString")
    @customer.stub!(:home_phone).and_return("MyString")
    @customer.stub!(:cell_phone).and_return("MyString")
    @customer.stub!(:work_phone).and_return("MyString")
    @customer.stub!(:email).and_return("MyString")
    @customer.stub!(:bozo).and_return(false)
    @customer.stub!(:notes).and_return("MyText")
    @customer.stub!(:created_at).and_return(Time.now)
    @customer.stub!(:updated_at).and_return(Time.now)

    assigns[:customer] = @customer
  end

  it "should render attributes in <p>" do
    render "/customers/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
    response.should have_text(/MyText/)
  end
end

