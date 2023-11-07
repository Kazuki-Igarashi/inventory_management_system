class ReceivingStock < ApplicationRecord
  
  has_one_attached :image
  belongs_to :genre
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :order_name, -> {order(name: :desc)}
  
  has_many :issues, dependent: :destroy
  
end
