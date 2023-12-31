class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
   has_many :cart_items, dependent: :destroy
  # has_many :items, through: :cart_items (← customerでitemの情報を使いたいとき)
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :shipping_informations, dependent: :destroy
  
  # validates :name, presence: true
  # validates :name_kana, presence: true
  # validates :email, presence: true
  # validates :encrypted_password, presence: true
  # validates :telephone_number, presence: true
  # validates :post_code, presence: true
  # validates :address, presence: true
  # validates :company_name, presence: true
  # validates :company_name_kana, presence: true
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end
