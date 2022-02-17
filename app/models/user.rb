class User < ApplicationRecord
  has_secure_password
  has_many :products, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_one_attached :image

  # 画像が存在しない場合にデフォルト画像をActiveStorageに格納する&サイズ調整。
  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_user_image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg')
  end
  image.variant(resize_to_limit: [width, height]).processed
  end

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
