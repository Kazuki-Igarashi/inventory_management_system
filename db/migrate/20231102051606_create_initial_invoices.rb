class CreateInitialInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :initial_invoices do |t|

      t.bigint :isuue_id
      t.bigint :customer_id
      t.bigint :address_id
      t.boolean :mailer, default: false
      t.boolean :send_mailer_flag, default: false

      t.timestamps
    end
  end
end
