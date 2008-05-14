class CreateOrderNumbers < ActiveRecord::Migration
  def self.up
    create_table :order_numbers do |t|
      t.integer :year
      t.integer :week_number
      t.integer :last_order_number

      t.timestamps 
    end
  end

  def self.down
    drop_table :order_numbers
  end
end
