class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.bigint :customer_id
      t.string :post_code
      t.string :address
      t.string :name
      t.integer :postage
      t.integer :total_payment
      
      
      t.timestamps
    end
  end
end
