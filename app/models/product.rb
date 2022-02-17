class Product < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  has_one_attached :image

  # 画像が存在しない場合にデフォルト画像をActiveStorageに格納する&サイズ調整。
  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_app_image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg')
  end
  image.variant(resize_to_limit: [width, height]).processed
  end

  with_options presence: true do
  validates :title
  validates :url
  validates :overview
  validates :body
  validates :features
  validates :technology
  end

end
