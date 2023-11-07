class Issue < ApplicationRecord
  
  has_one_attached :image
  belongs_to :receiving_stock
  belongs_to :customer
  
  before_validation :stocks_update
  
  private
  
  def stocks_update
    if self.receiving_stock.stock >= self.stock
      self.receiving_stock.update!(stock: self.receiving_stock.stock - self.stock)
    else
      errors.add(:stock, "在庫が足りません")
    end
  end
end


