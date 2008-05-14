require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/edit.html.erb" do
  include CustomersHelper
  
  before do
    @customer = mock_model(Customer)
    @customer.stub!(:first).and_return("MyString")
    @customer.stub!(:last).and_return("MyString")
    @customer.stub!(:cell_phone).and_return("MyString")
    @customer.stub!(:work_phone).and_return("MyString")
    @customer.stub!(:home_phone).and_return("MyString")
    @customer.stub!(:email).and_return("MyString")
    @customer.stub!(:bozo).and_return(false)
    @customer.stub!(:created_at).and_return(Time.now)
    @customer.stub!(:modified_at).and_return(Time.now)
    assigns[:customer] = @customer
  end

  it "should render edit form" do
    render "/customers/edit.html.erb"
    
    response.should have_tag("form[action=#{customer_path(@customer)}][method=post]") do
      with_tag('input#customer_first[name=?]', "customer[first]")
      with_tag('input#customer_last[name=?]', "customer[last]")
      with_tag('input#customer_cell_phone[name=?]', "customer[cell_phone]")
      with_tag('input#customer_home_phone[name=?]', "customer[home_phone]")
      with_tag('input#customer_work_phone[name=?]', "customer[work_phone]")
      with_tag('input#customer_email[name=?]', "customer[email]")
      with_tag('input#customer_bozo[name=?]', "customer[bozo]")

    end
  end
end


