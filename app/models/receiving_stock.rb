class ReceivingStock < ApplicationRecord
  
  has_one_attached :image
  belongs_to :genre
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :order_name, -> {order(name: :desc)}
  has_many :issues, dependent: :destroy
  
  
  
  # validates :image, presence: true
  validates :name, presence: true
  # validates :conpany_name, presence: true
  validates :purchase_price, presence: true
  validates :explanation, presence: true
  validates :stock, presence: true
  
end
