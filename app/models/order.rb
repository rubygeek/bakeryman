# == Schema Information
# Schema version: 2
#
# Table name: orders
#
#  id          :integer(11)   not null, primary key
#  customer_id :integer(11)   
#  pickup_at   :datetime      
#  decorations :text          
#  details     :text          
#  created_at  :datetime      
#  modified_at :datetime      
#  updated_at  :datetime      
#

require 'parsedate'

class Order < ActiveRecord::Base
  belongs_to :customer
  validates_presence_of :details, :pickup_time, :pickup_day
  
  attr_accessor :pickup_time, :pickup_day
 
  def before_save
    old_pickup_at = self.pickup_at
    self.pickup_at    = Time.parse("#{self.pickup_day} #{self.pickup_time}")
    #if no number, then set
    if self.order_number.nil?
      self.order_number = OrderNumber.get_next("#{self.pickup_day} #{self.pickup_time}")
    elsif old_pickup_at.to_date.cweek != self.pickup_at.to_date.cweek   
      #update order number if the order was moved to another week
      self.order_number = OrderNumber.get_next("#{self.pickup_day} #{self.pickup_time}")
    end
  end
 
  def self.find_any(value)
     value = "%" << value << "%"
     Order.find(:all, 
               :conditions => ["decorations like ? OR details like ?", value, value],:order => "pickup_at" )      
  end

  def self.find_by_pickup_at(pickup_str)
    pickup = Time.parse(pickup_str)
    self.find_by_date_range(pickup, pickup)
  end

  def self.find_by_date_range(from_date, to_date)
     from_date_str = from_date.at_beginning_of_day.to_s(:db)
     to_date_str   = to_date.at_midnight.to_s(:db)
     Order.find(:all,
                :conditions => ["pickup_at BETWEEN ? AND ?",
                                 from_date_str, to_date_str],
                :order => "pickup_at")
  end

end
