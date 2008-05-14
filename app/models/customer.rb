# == Schema Information
# Schema version: 2
#
# Table name: customers
#
#  id          :integer(11)   not null, primary key
#  first       :string(255)   
#  last        :string(255)   
#  cell_phone  :string(255)   
#  home_phone  :string(255)   
#  work_phone  :string(255)   
#  email       :string(255)   
#  bozo        :boolean(1)    
#  notes       :text          
#  created_at  :datetime      
#  modified_at :datetime      
#  updated_at  :datetime      
#

class Customer < ActiveRecord::Base
   has_many :orders
   #validates_presence_of :first_name, :last_name
   
  # validates_presence_of :cell_phone, 
  #                       :if => :validate_at_least_one_phone,
  #                      :message => 'must have at least one phone!'
                         
  def validate
    if self.cell_phone.blank? and self.work_phone.blank? and self.home_phone.blank?  
      errors.add(:cell_phone, "must have at least one phone") 
      errors.add(:home_phone, "must have at least one phone") 
      errors.add(:work_phone, "must have at least one phone")       
    end
    errors.add(:first, 'name cannot be blank') if self.first.blank?
    errors.add(:last, 'name cannot be blank') if self.last.blank?
  end
  
  def name
    "#{self.first} #{self.last}"
  end
  
  def self.find_any(value)
     value = "%" << value << "%"
     Customer.find(:all, 
               :conditions => ["first like ? OR last like ? OR home_phone like ? OR work_phone like ? OR cell_phone like ?", value, value, value, value, value] )
  end

  def before_save
     self.remove_punct_from_numbers
     self.add_default_areacode
  end
  
  def remove_punct_from_numbers
    self.cell_phone.gsub!(/\D/,'') unless self.cell_phone.blank? 
    self.work_phone.gsub!(/\D/,'') unless self.work_phone.blank? 
    self.home_phone.gsub!(/\D/,'') unless self.home_phone.blank?
  end
  
  def add_default_areacode
    if self.cell_phone and self.cell_phone.size == 7 
      self.cell_phone = "815" + self.cell_phone
    end
    if self.home_phone and self.home_phone.size == 7 
      self.home_phone = "815" + self.home_phone
    end
    if self.work_phone and self.work_phone.size == 7 
      self.work_phone = "815" + self.work_phone
    end        
  end
end
