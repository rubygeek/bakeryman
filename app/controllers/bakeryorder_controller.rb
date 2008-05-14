class BakeryorderController < ApplicationController
  
  def index
  	@bakeryorders = Order.find(:all)
  end
  
  def new

  end
  
  	
  def create
#RAILS_DEFAULT_LOGGER.info(params[:bakery_order].to_yaml)  	
    #@order = Order.new(params[:order])  #OLD, before presenters
    @bakeryorder = BakeryOrderPresenter.new(params[:bakeryorder])
    
  #  respond_to do |format|
      if @bakeryorder.save
        flash[:notice] = 'Order was successfully created.'
        render :action => :index  
    #    format.html { redirect_to( :index ) }
   #     format.xml  { render :xml => @order, :status => :created, :location => @order }
    #  else
     #   format.html { render :action => "new" }
      #  format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
     # end
    end
  end	
	
end
