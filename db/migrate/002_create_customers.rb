class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :first
      t.string :last
      t.string :cell_phone
      t.string :home_phone
      t.string :work_phone
      t.string :email
      t.boolean :bozo
      t.text :notes
      t.timestamps 
    end
  end

  def self.down
    drop_table :customers
  end
end
