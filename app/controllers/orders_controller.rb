#require "#{RAILS_ROOT}/app/presenters/bakery_order_presenter.rb"

class OrdersController < ApplicationController
  layout 'application'
  
  
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new
    @customer = Customer.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
#    render :text => params.to_yaml
#    return
    
    new_customer = params[:order][:customer_id].blank? ? true : false
    
    if new_customer
      @customer = Customer.create(params[:customer]) 
      if @customer.valid?
        @customer.orders.create(params[:order])        
        flash[:notice] = 'New customer was added and order was created successfully' 
        redirect_to orders_url
      else
        flash[:notice] = 'Please fill in all required fields'
        render :action => 'new'
      end
    else
      @customer = Customer.find params[:order][:customer_id] 
      @order = @customer.orders.create(params[:order])
      if @order.valid?
        flash[:notice] = 'Order was successfully created.'
        redirect_to orders_url        
      else
        flash[:notice] = 'Please fill in all required fields'
        #render :text => @customer.to_yaml
        render :action => 'new'
      end
    end

      
    #validate order    format.html { render :action => "new" }
  
   
  end

  # PUT /orders/1 
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to(@order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    unless params[:search] or params[:search_pickup] 
      render :text => "Error processing your query"
      return
    end
    if params[:search] then
      @orders = Order.find_any(params[:search])
    elsif params[:search_pickup] then
      @orders = Order.find_by_pickup_at(params[:search_pickup])
    end

    respond_to do |format|
      format.html do 
        render :partial => 'order_table.html.erb', :layout => false  
      end
      format.xml  { render :xml => @orders }
    end
  end
end
