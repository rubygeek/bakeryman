class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :order_number
      t.datetime :pickup_at
      t.text :decorations
      t.text :details
      t.datetime :created_at
      t.datetime :modified_at
      t.timestamps 
    end
  end

  def self.down
    drop_table :orders
  end
end
