require File.dirname(__FILE__) + '/../spec_helper'

describe OrdersController, "#route_for" do

  it "should map { :controller => 'orders', :action => 'index' } to /orders" do
    route_for(:controller => "orders", :action => "index").should == "/orders"
  end
  
  it "should map { :controller => 'orders', :action => 'new' } to /orders/new" do
    route_for(:controller => "orders", :action => "new").should == "/orders/new"
  end
  
  it "should map { :controller => 'orders', :action => 'show', :id => 1 } to /orders/1" do
    route_for(:controller => "orders", :action => "show", :id => 1).should == "/orders/1"
  end
  
  it "should map { :controller => 'orders', :action => 'edit', :id => 1 } to /orders/1/edit" do
    route_for(:controller => "orders", :action => "edit", :id => 1).should == "/orders/1/edit"
  end
  
  it "should map { :controller => 'orders', :action => 'update', :id => 1} to /orders/1" do
    route_for(:controller => "orders", :action => "update", :id => 1).should == "/orders/1"
  end
  
  it "should map { :controller => 'orders', :action => 'destroy', :id => 1} to /orders/1" do
    route_for(:controller => "orders", :action => "destroy", :id => 1).should == "/orders/1"
  end
  
end

describe OrdersController, "handling GET /orders" do

  before do
    @order = mock_model(Order)
    Order.stub!(:find).and_return([@order])
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
  
  it "should find all orders" do
    Order.should_receive(:find).with(:all).and_return([@order])
    do_get
  end
  
  it "should assign the found orders for the view" do
    do_get
    assigns[:orders].should == [@order]
  end
end

describe OrdersController, "handling GET /orders.xml" do

  before do
    @order = mock_model(Order, :to_xml => "XML")
    Order.stub!(:find).and_return(@order)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all orders" do
    Order.should_receive(:find).with(:all).and_return([@order])
    do_get
  end
  
  it "should render the found orders as xml" do
    @order.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe OrdersController, "handling GET /orders/1" do

  before do
    @order = mock_model(Order)
    Order.stub!(:find).and_return(@order)
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
  
  it "should find the order requested" do
    Order.should_receive(:find).with("1").and_return(@order)
    do_get
  end
  
  it "should assign the found order for the view" do
    do_get
    assigns[:order].should equal(@order)
  end
end

describe OrdersController, "handling GET /orders/1.xml" do

  before do
    @order = mock_model(Order, :to_xml => "XML")
    Order.stub!(:find).and_return(@order)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the order requested" do
    Order.should_receive(:find).with("1").and_return(@order)
    do_get
  end
  
  it "should render the found order as xml" do
    @order.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe OrdersController, "handling GET /orders/new" do

  before do
    @order = mock_model(Order)
    Order.stub!(:new).and_return(@order)
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
  
  it "should create an new order" do
    Order.should_receive(:new).and_return(@order)
    do_get
  end
  
  it "should not save the new order" do
    @order.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new order for the view" do
    do_get
    assigns[:order].should equal(@order)
  end
end

describe OrdersController, "handling GET /orders/1/edit" do

  before do
    @order = mock_model(Order)
    Order.stub!(:find).and_return(@order)
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
  
  it "should find the order requested" do
    Order.should_receive(:find).and_return(@order)
    do_get
  end
  
  it "should assign the found Order for the view" do
    do_get
    assigns[:order].should equal(@order)
  end
end

describe OrdersController, "handling POST /orders with an existing customer" do

  before do
    @order = mock_model(Order, :to_param => "1", :id => 1)
    @customer = mock_model(Customer, :to_param => "1", :id => 1)
    @params = {:customer_id => 1}
    Customer.should_receive(:find).with(1).and_return(@customer)    
  end
  
  def post_with_successful_save
    @customer.should_receive(:create_order).with(anything())    
    post :create, :order => @params
  end
  
  def post_with_failed_save
    post :create, :order => @params
  end
  
  it "should create a new order" do
    post_with_successful_save
  end

  it "should redirect to the new order on successful save" do
    post_with_successful_save
    response.should redirect_to(orders_url)
  end

end

describe OrdersController, "handling POST /orders with a new customer" do

  before do
    @order = mock_model(Order, :to_param => "1")
    
    Order.stub!(:create).and_return(@order)
    
    @params = {:customer_id => nil} 
    
    @customer = mock_model(Customer, :to_param => "1")
    @customer.stub!(:orders).and_return(Order)
    Customer.stub!(:create).and_return(@customer)
  end
  
  def post_with_successful_save
    @customer.should_receive(:valid?).and_return(true)
    post :create, :order => @params
  end
  
  def post_with_failed_save
    @customer.should_receive(:valid?).and_return(false)
    post :create, :order => @params
  end

  it "should create a new customer" do
    Customer.should_receive(:create).with(anything()).and_return(@customer)   
    post_with_successful_save
  end

  
  it "should create a new order" do
    Order.should_receive(:create).with(anything()).and_return(@order)  
    post_with_successful_save
  end

  it "should redirect to the new order on successful save" do
    post_with_successful_save
    response.should redirect_to(orders_url)
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end


describe OrdersController, "handling PUT /orders/1" do

  before do
    @order = mock_model(Order, :to_param => "1")
    Order.stub!(:find).and_return(@order)
  end
  
  def put_with_successful_update
    @order.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @order.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the order requested" do
    Order.should_receive(:find).with("1").and_return(@order)
    put_with_successful_update
  end

  it "should update the found order" do
    put_with_successful_update
    assigns(:order).should equal(@order)
  end

  it "should assign the found order for the view" do
    put_with_successful_update
    assigns(:order).should equal(@order)
  end

  it "should redirect to the order on successful update" do
    put_with_successful_update
    response.should redirect_to(order_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe OrdersController, "handling DELETE /orders/1" do

  before do
    @order = mock_model(Order, :destroy => true)
    Order.stub!(:find).and_return(@order)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the order requested" do
    Order.should_receive(:find).with("1").and_return(@order)
    do_delete
  end
  
  it "should call destroy on the found order" do
    @order.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the orders list" do
    do_delete
    response.should redirect_to(orders_url)
  end
end
