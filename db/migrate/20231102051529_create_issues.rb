class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|

      t.bigint :receiving_stock_id, null: false, foreign_key: true
      t.bigint :customer_id, null: false, foreign_key: true
      t.string :name
      t.integer :selling_price
      t.text :explanation
      t.integer :stock
      t.string :sales_company_name

      t.timestamps
    end
  end
end
