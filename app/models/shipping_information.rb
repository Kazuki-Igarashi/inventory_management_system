class ShippingInformation < ApplicationRecord

  belongs_to :customer
  belongs_to :issue
  # 消費税
  def add_tax_cost
    (cost * 1.10).round
  end
  # 小計
  def subtotal
    selling_price.add_tax_cost * stock
  end

end
