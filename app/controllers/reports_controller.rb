class ReportsController < ApplicationController
  layout 'application'

	def index
	end
	
	def customer_orders
	  @customer = Customer.find(params[:id])
	  @orders = @customer.orders
	end


  def daily
    @display_decorations = true
    @display_baking = true    
    self.check_filter
    @from_date = Time.now
    @to_date = Time.now.tomorrow
    @orders = Order.find_by_date_range(@from_date, @to_date)

    #@label = @to_date.strftime("%A %B, %d")
    @label = @from_date.strftime("%A %B, %d %H") << "-" << @to_date.strftime("%A %B, %d %H")    
    render :partial => "orders/order_table.html.erb", :layout => 'application'
  end

  def weekly
    @display_decorations = true
    @display_baking = true
    self.check_filter
    @from_date = (Time.now.wday).days.ago
    @to_date = (6 - Time.now.wday).days.from_now
    @orders = Order.find_by_date_range(@from_date, @to_date)
    @label = @from_date.strftime("%A %B, %d") << "-" << @to_date.strftime("%A %B, %d")
    render :partial => "orders/order_table.html.erb", :layout => 'application'
  end

  def weeklytags
    @display_decorations = true
    @display_baking = true    
    @from_date = (Time.now.wday).days.ago
    @to_date = (7 - Time.now.wday).days.from_now
    @orders = Order.find_by_date_range(@from_date, @to_date)
    @label = @from_date.strftime("%A %B, %d") << "-" << @to_date.strftime("%A %B, %d")
    render :partial => "orders/tags.html.erb"
  end


  def check_filter
    display = params[:type] || false
    if display
      if display == "decorations"
        @display_baking = false
      elsif display == "baking"
        @display_decorations = false
      end
    end
  end
  
end
