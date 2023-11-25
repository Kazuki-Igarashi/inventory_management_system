class CreateContractors < ActiveRecord::Migration[6.1]
  def change
    create_table :contractors do |t|
      t.boolean "is_menber", default: false
      t.timestamps
    end
  end
end
