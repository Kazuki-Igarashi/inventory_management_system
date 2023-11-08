class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  # has_many :address_types, dependent: :destroy
end
