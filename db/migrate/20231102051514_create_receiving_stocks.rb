class CreateReceivingStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :receiving_stocks do |t|

      t.bigint :genre_id
      t.string :name
      t.boolean :sales_status, default: true
      t.string :conpany_name
      t.integer :purchase_price
      t.text :explanation
      t.integer :stock
      
      t.timestamps
    end
  end
end
