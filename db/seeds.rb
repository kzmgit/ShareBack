# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
5.times do |n|
  User.create!(
    name: "テストユーザー#{n+1}",
    email: "test@#{n+1}",
    password: "password",
    password_confirmation: "password"
  )
end

# Tag
tag_names = ["Ruby","Rails","Python","AWS","JavaScript","React","PHP","Laravel","Docker","Go","Vue.js","Java"]
# url_word作成用
def create_url_word(tag_name)
  if tag_name.index('.')
    tag_name = tag_name.gsub('.','-')
  end
  tag_name = tag_name.downcase
end

# Product
5.times do |n|
  product = Product.create!(
    user_id: n+1,
    title: "ShareBack#{n+1}",
    url: "https://www.google.com/",
    overview: "成果物のフィードバックがもらえるサービスです",
    background: "作成背景が入ります。作成背景が入ります。作成背景が入ります。作成背景が入ります。作成背景が入ります。",
    usage: "使い方が入ります。使い方が入ります。使い方が入ります。使い方が入ります。使い方が入ります。使い方が入ります。",
    ingenuity: "オリジナリティ、工夫点が入ります。オリジナリティ、工夫点が入ります。オリジナリティ、工夫点が入ります。オリジナリティ、工夫点が入ります。",
    other: "その他、自由記入欄が入ります。その他、自由記入欄が入ります。その他、自由記入欄が入ります。その他、自由記入欄が入ります。その他、自由記入欄が入ります。",
    features: "機能一覧が入ります。",
    technology: "使用技術が入ります。"
  )

  # プロダクトにタグをランダムに3つ付与する
  new_tags = tag_names.sample(3)
  new_tags.each do |new|
    new_tag = Tag.find_or_create_by(name: new, url_word: create_url_word(new))
    product.tags << new_tag
  end
end