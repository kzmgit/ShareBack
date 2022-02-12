class Product < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
  validates :title
  validates :overview
  validates :body
  validates :features
  validates :technology
  end

end
