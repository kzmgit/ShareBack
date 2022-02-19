# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  User.create!(
    name: "テストユーザー#{n+1}",
    email: "test@#{n+1}",
    password: "password",
    password_confirmation: "password"
  )
end

5.times do |n|
  Product.create!(
    user_id: n+1,
    title: "ShareBack#{n+1}",
    url: "https://www.google.com/",
    overview: "自身の成果物のフィードバックがもらえるサービスです",
    background: "作成背景が入ります。作成背景が入ります。作成背景が入ります。作成背景が入ります。作成背景が入ります。",
    usage: "使い方が入ります。使い方が入ります。使い方が入ります。使い方が入ります。使い方が入ります。使い方が入ります。",
    ingenuity: "オリジナリティ、工夫点が入ります。オリジナリティ、工夫点が入ります。オリジナリティ、工夫点が入ります。オリジナリティ、工夫点が入ります。",
    other: "その他、自由記入欄が入ります。その他、自由記入欄が入ります。その他、自由記入欄が入ります。その他、自由記入欄が入ります。その他、自由記入欄が入ります。",
    features: "機能一覧が入ります。",
    technology: "使用技術が入ります。"
  )
end