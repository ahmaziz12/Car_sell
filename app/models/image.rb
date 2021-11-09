class Image < ApplicationRecord
  belongs_to :ad

  has_one_attached :image

  validates_associated :ad
end
