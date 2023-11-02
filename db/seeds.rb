# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "igarashi@igarashi",
  password: "123456789",
  is_menber: true
)

10.times do |num|
  Customer.create!(
    first_name: "顧客#{num + 1}",
    last_name: "ユーザー#{num + 1}",
    email: "email#{num + 1}@email",
    password: "password#{num + 1}",
    password_confirmation: "password#{num + 1}",
    telephone_number: "password#{num + 1}",
    company_name: "company#{num + 1}",
    post_code: "1234567",
    address: "栃木県"
  )
end