class User < ApplicationRecord
  has_secure_password
  has_many :products
  has_one_attached :image

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
