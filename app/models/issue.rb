class Issue < ApplicationRecord
  
  has_one_attached :image
  belongs_to :receiving_stock
  belongs_to :customer
  # belongs_to :order
  before_validation :stocks_update
  # バリデーション
  validates :selling_price, presence: true
  validates :stock, presence: true
  validates :sales_company_name, presence: true
  
  # 検索
  def self.ransackable_attributes(auth_object = nil)
     %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
     []
  end
  
   # 消費税
  def add_tax_cost
    (selling_price * 1.10).round
  end
  # 小計
  def subtotal
    self.add_tax_cost * stock
  end
  private
  
  def stocks_update
    if self.stock == nil
      errors.add(:stock, "please set a number") and return 
    end
    if self.receiving_stock.stock >= self.stock
      self.receiving_stock.update!(stock: self.receiving_stock.stock - self.stock)
    else
      errors.add(:stock, "在庫が足りません")
    end
  end
end


