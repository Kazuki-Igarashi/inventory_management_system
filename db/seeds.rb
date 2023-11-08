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
    name: "顧客ユーザー#{num + 1}",
    name_kana: "コキャクユーザー#{num + 1}",
    email: "email#{num + 1}@email",
    password: "password#{num + 1}",
    password_confirmation: "password#{num + 1}",
    telephone_number: "password#{num + 1}",
    company_name: "company#{num + 1}",
    company_name_kana: "カンパニー#{num + 1}",
    post_code: "1234567",
    address: "栃木県"
  )
end

genres = [
  "機械",
  "部品",
  "工具"
  ]

genres.each do |genre|
  Genre.create!(
    name: genre
  )
end

receiving_stock = ReceivingStock.create!(
      name: "機械1",
      explanation: "機械の説明。",
      genre_id: 1,
      stock: 500,
      purchase_price: 400,
      conpany_name: "株式会社A社",
      # is_sales: true
      # image: File.open(Rails.root.join("app/assets/images/cake23.jpg"))
    )
receiving_stock.image.attach(io: File.open(Rails.root.join("app/assets/images/cake23.jpg")), filename: "cake23.jpg")

receiving_stock = ReceivingStock.create!(
      name: "機械2",
      explanation: "機械の説明。",
      genre_id: 1,
      stock: 100,
      purchase_price: 4000,
      conpany_name: "株式会社B社",
      # is_sales: true
      # image: File.open(Rails.root.join("app/assets/images/cake23.jpg"))
    )
receiving_stock.image.attach(io: File.open(Rails.root.join("app/assets/images/cake23.jpg")), filename: "cake22.jpg")

 2.times do |n|
    Address.create!(
      name: "test#{n + 1}",
      post_code: "1234567",
      address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
      company_name: "株式会社A",
      customer_id: n+1
    )
  end

# 10.times do |n|
#     Order.create!(
#       customer_id: 1,
#       address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
#       post_code: "1234567",
#       name: "機械2",
#       postage: "800",
#       amount: 2,
#       total_payment: "#{500 + (n * 500) +800}",
#       sales_company_name: "株式会社B社"
#     )
# end

# 10.times do |n|
#     OrderDetail.create!(
#       receiving_stock_id: n + 1,
#       order_id: n + 1,
#       amount: n + 3,
#       tax_price: "#{500 + (n * 500)}"
#     )
#   end