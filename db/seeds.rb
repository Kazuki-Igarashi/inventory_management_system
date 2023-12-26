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

companys = [
  "株式会社A",
  "株式会社B",
  "株式会社C",
  "株式会社D",
  "株式会社E"
  ]

companys.each do |company|
  Company.create!(
    name: company
  )
end

receiving_stock = ReceivingStock.create!(
      name: "旋盤機械",
      explanation: "旋盤機械です。物に対して穴をあけることが出来ます",
      genre_id: 1,
      stock: 40,
      purchase_price: 50000,
      conpany_name: "株式会社A社",
      # is_sales: true
      image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kikai1.jpg")), filename: "kikai1.jpg")
    )

receiving_stock = ReceivingStock.create!(
      name: "電動のこぎり",
      explanation: "電動のこぎりです。木材を加工するために使用します。",
      genre_id: 1,
      stock: 10,
      purchase_price: 100000,
      conpany_name: "株式会社B社",
      # is_sales: true
      image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kikai3.jpg")), filename: "kikai3.jpg")
    )


receiving_stock = ReceivingStock.create!(
      name: "工具一式",
      explanation: "工具一式です。様々な場面で使用します",
      genre_id: 3,
      stock: 100,
      purchase_price: 15000,
      conpany_name: "株式会社C社",
      # is_sales: true
      image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kougu2.jpg")), filename: "kougu2.jpg")
    )

receiving_stock = ReceivingStock.create!(
      name: "手動万力",
      explanation: "手動万力です。物を強く挟む際に使用します。",
      genre_id: 3,
      stock: 50,
      purchase_price: 50000,
      conpany_name: "株式会社C社",
      # is_sales: true
      image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kougu4.jpg")), filename: "kougu4.jpg")
    )
    
receiving_stock = ReceivingStock.create!(
      name: "精密用切削部品",
      explanation: "切削用の部品です。摩耗するため交換が可能です。",
      genre_id: 2,
      stock: 100,
      purchase_price: 20000,
      conpany_name: "株式会社D社",
      # is_sales: true
      image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/buhin1.jpg")), filename: "buhin1.jpg")
    )

receiving_stock = ReceivingStock.create!(
      name: "精密用切削部品",
      explanation: "切削用の部品です。摩耗するため交換が可能です。",
      genre_id: 2,
      stock: 200,
      purchase_price: 25000,
      conpany_name: "株式会社D社",
      # is_sales: true
      image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/buhin6.jpg")), filename: "buhin6.jpg")
    )

 10.times do |n|
    Address.create!(
      name: "test#{n + 1}",
      post_code: "1234567",
      address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
      # company_name: "株式会社A",
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