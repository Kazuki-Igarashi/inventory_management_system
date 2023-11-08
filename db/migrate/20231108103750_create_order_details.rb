class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      
      t.integer "order_id", null: false
      t.integer "issue_id", null: false
      # t.integer "amount", null: false
      # t.integer "tax_price", null: false
      
      t.timestamps
    end
  end
end
