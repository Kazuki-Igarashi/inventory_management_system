class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.bigint :customer_id
      t.bigint :address_id
      # t.bigint :issue_id
      # t.string :post_code
      # t.string :address
      # t.string :name
      # t.integer :postage
      # t.integer :total_payment
      # t.integer :amount
      # t.string :sales_company_name
      
      t.timestamps
    end
  end
end
