class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :title,  presence: true
  validates :good_point,  presence: true
  validates :improvement_point, presence: true
end
