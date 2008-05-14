require File.dirname(__FILE__) + '/../spec_helper'

describe CustomersController, "#route_for" do

  it "should map { :controller => 'customers', :action => 'index' } to /customers" do
    route_for(:controller => "customers", :action => "index").should == "/customers"
  end
  
  it "should map { :controller => 'customers', :action => 'new' } to /customers/new" do
    route_for(:controller => "customers", :action => "new").should == "/customers/new"
  end
  
  it "should map { :controller => 'customers', :action => 'show', :id => 1 } to /customers/1" do
    route_for(:controller => "customers", :action => "show", :id => 1).should == "/customers/1"
  end
  
  it "should map { :controller => 'customers', :action => 'edit', :id => 1 } to /customers/1/edit" do
    route_for(:controller => "customers", :action => "edit", :id => 1).should == "/customers/1/edit"
  end
  
  it "should map { :controller => 'customers', :action => 'update', :id => 1} to /customers/1" do
    route_for(:controller => "customers", :action => "update", :id => 1).should == "/customers/1"
  end
  
  it "should map { :controller => 'customers', :action => 'destroy', :id => 1} to /customers/1" do
    route_for(:controller => "customers", :action => "destroy", :id => 1).should == "/customers/1"
  end
  
end

describe CustomersController, "handling GET /customers" do

  before do
    @customer = mock_model(Customer)
    Customer.stub!(:find).and_return([@customer])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all customers" do
    Customer.should_receive(:find).with(:all).and_return([@customer])
    do_get
  end
  
  it "should assign the found customers for the view" do
    do_get
    assigns[:customers].should == [@customer]
  end
end

describe CustomersController, "handling GET /customers.xml" do

  before do
    @customer = mock_model(Customer, :to_xml => "XML")
    Customer.stub!(:find).and_return(@customer)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all customers" do
    Customer.should_receive(:find).with(:all).and_return([@customer])
    do_get
  end
  
  it "should render the found customers as xml" do
    @customer.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe CustomersController, "handling GET /customers/1" do

  before do
    @customer = mock_model(Customer)
    Customer.stub!(:find).and_return(@customer)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the customer requested" do
    Customer.should_receive(:find).with("1").and_return(@customer)
    do_get
  end
  
  it "should assign the found customer for the view" do
    do_get
    assigns[:customer].should equal(@customer)
  end
end

describe CustomersController, "handling GET /customers/1.xml" do

  before do
    @customer = mock_model(Customer, :to_xml => "XML")
    Customer.stub!(:find).and_return(@customer)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the customer requested" do
    Customer.should_receive(:find).with("1").and_return(@customer)
    do_get
  end
  
  it "should render the found customer as xml" do
    @customer.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe CustomersController, "handling GET /customers/new" do

  before do
    @customer = mock_model(Customer)
    Customer.stub!(:new).and_return(@customer)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new customer" do
    Customer.should_receive(:new).and_return(@customer)
    do_get
  end
  
  it "should not save the new customer" do
    @customer.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new customer for the view" do
    do_get
    assigns[:customer].should equal(@customer)
  end
end

describe CustomersController, "handling GET /customers/1/edit" do

  before do
    @customer = mock_model(Customer)
    Customer.stub!(:find).and_return(@customer)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the customer requested" do
    Customer.should_receive(:find).and_return(@customer)
    do_get
  end
  
  it "should assign the found Customer for the view" do
    do_get
    assigns[:customer].should equal(@customer)
  end
end

describe CustomersController, "handling POST /customers" do

  before do
    @customer = mock_model(Customer, :to_param => "1")
    Customer.stub!(:new).and_return(@customer)
  end
  
  def post_with_successful_save
    @customer.should_receive(:save).and_return(true)
    post :create, :customer => {}
  end
  
  def post_with_failed_save
    @customer.should_receive(:save).and_return(false)
    post :create, :customer => {}
  end
  
  it "should create a new customer" do
    Customer.should_receive(:new).with({}).and_return(@customer)
    post_with_successful_save
  end

  it "should redirect to the new customer on successful save" do
    post_with_successful_save
    response.should redirect_to(customer_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe CustomersController, "handling PUT /customers/1" do

  before do
    @customer = mock_model(Customer, :to_param => "1")
    Customer.stub!(:find).and_return(@customer)
  end
  
  def put_with_successful_update
    @customer.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @customer.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the customer requested" do
    Customer.should_receive(:find).with("1").and_return(@customer)
    put_with_successful_update
  end

  it "should update the found customer" do
    put_with_successful_update
    assigns(:customer).should equal(@customer)
  end

  it "should assign the found customer for the view" do
    put_with_successful_update
    assigns(:customer).should equal(@customer)
  end

  it "should redirect to the customer on successful update" do
    put_with_successful_update
    response.should redirect_to(customer_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe CustomersController, "handling DELETE /customers/1" do

  before do
    @customer = mock_model(Customer, :destroy => true)
    Customer.stub!(:find).and_return(@customer)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the customer requested" do
    Customer.should_receive(:find).with("1").and_return(@customer)
    do_delete
  end
  
  it "should call destroy on the found customer" do
    @customer.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the customers list" do
    do_delete
    response.should redirect_to(customers_url)
  end
end
