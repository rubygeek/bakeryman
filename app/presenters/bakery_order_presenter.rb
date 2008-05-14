class BakeryOrderPresenter < Presenter
  def_delegators :customer, :first, :first=, :last, :last=, :cell_phone, :cell_phone=, :home_phone, :home_phone=, :work_phone, :work_phone=, :email, :email=, :bozo, :bozo=, :notes, :notes=, :created_at, :created_at=, :modified_at, :modified_at 

  def_delegators :order, :pickup_at, :pickup_at=, :notes, :notes=, :created_at, :created_at=, :modified_at, :modified_at=
  
  def customer
    @customer ||= Customer.new
  end
  
  def order
    @order ||= Order.new
  end
  
  def pickup_time
  end
  
  def pickup_day
  end
  
  def pickup_time=
  end
  
  def pickup_day=
  end
  
  
  def save
    customer.save && order.save
  end
end
