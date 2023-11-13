class Contractor < ApplicationRecord
  
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :telephone_number, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :company_name, presence: true
  validates :company_name_kana, presence: true
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end
