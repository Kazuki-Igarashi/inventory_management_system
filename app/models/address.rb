class Address < ApplicationRecord

  belongs_to :customer

  validates :post_code, presence: true, length: { is: 7 }, numericality: true
  validates :address, presence: true
  validates :name, presence: true

  def post_code_in_address
    "〒" + post_code + "  " + address
  end

end
