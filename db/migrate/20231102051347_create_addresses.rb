class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.bigint :customer_id
      t.string :post_code
      t.string :address
      t.string :name
      t.string :company_name
      t.timestamps
    end
  end
end
