require 'parsedate'

class OrderNumber < ActiveRecord::Base
  
  # week is monday through sunday
  def self.get_next(date)
    year  = self.get_year(date)
    week_number = self.get_week_number(date)
    #puts "#{date} #{week_number}"
    order_number = self.find(:first, 
                             :conditions => {:week_number => week_number,
                                             :year => year})
    if order_number.nil?
      order_number = self.create(:last_order_number => 1, :year => year, :week_number => week_number)
    else
      order_number.last_order_number += 1     
    end
    
    order_number.save   
    order_number.last_order_number
  end
  
private
  def self.get_year(date)
    Time.parse(date).to_date.year    
  end
  def self.get_week_number(date)
    Time.parse(date).to_date.cweek
  end
end
