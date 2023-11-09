class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      
      t.integer "order_id", null: false
      # t.integer "issue_id", null: false
      t.string :issue_name
      t.integer :stock
      t.string :sales_company_name
      t.integer :price
      t.integer :total_amount
      # t.integer "amount", null: false
      # t.integer "tax_price", null: false
      
      t.timestamps
    end
  end
end
