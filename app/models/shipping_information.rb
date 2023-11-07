class ShippingInformation < ApplicationRecord

  belongs_to :customer
  belongs_to :issue
  
  def add_tax_cost
    (cost * 1.10).round
  end
  
  def subtotal
    selling_price.add_tax_cost * stock
  end

end
