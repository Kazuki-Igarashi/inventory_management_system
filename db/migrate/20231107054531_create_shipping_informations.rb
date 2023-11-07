class CreateShippingInformations < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_informations do |t|
    
      t.integer :issue_id, null: false
      t.integer :customer_id, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
