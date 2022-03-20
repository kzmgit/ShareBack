class Product < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :image
  MAX_TAGS_COUNT = 5

  with_options presence: true do
  validates :title
  validates :url
  validates :overview
  validates :background
  validates :usage
  validates :ingenuity
  validates :features
  validates :technology
  end
  validates :overview, length: { maximum: 50 }

  # 画像が存在しない場合にデフォルト画像をActiveStorageに格納する&サイズ調整。
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_app_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # いいねしているかどうか
  def favorited_by?(user)
    if !user
      return false
    end
    favorites.exists?(user_id: user.id)
  end

  # url用に文字列を生成する
  def create_url_word(tag_name)
    if tag_name.index('.')
      tag_name = tag_name.gsub('.','-')
    end
    tag_name = tag_name.downcase
  end

  #タグ機能
  def save_tags(sent_tags)
    # すでに付与されているタグを取得
    current_tags = self.tags.pluck(:name)
    # 付与されているタグから送信されたタグを除いたものをoldとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから付与されているタグを除いたものをnewとする
    new_tags = sent_tags - current_tags
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new, url_word: create_url_word(new))
      self.tags << new_post_tag
    end
  end

  #タグ数の上限を設定
  def max_tags(tags_count)
    if tags_count > MAX_TAGS_COUNT
      self.errors.add(:base, "タグは#{MAX_TAGS_COUNT}つ以内で指定してください")
      return false
    else
      return true
    end
  end

end
