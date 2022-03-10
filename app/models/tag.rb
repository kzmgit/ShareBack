class Tag < ApplicationRecord
  has_many :tag_maps
  has_many :products, through: :tag_maps
end
