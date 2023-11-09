class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  belongs_to :address
  # belongs_to :issue,  dependent: :destroy
  # accepts_nested_attributes_for :issues
  # has_many :address_types, dependent: :destroy
end
